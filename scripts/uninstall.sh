#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SCOPE="user"
PROJECT_DIR=""
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
ALL_OVERLAYS=0
REQUESTED_OVERLAYS=()
SELECTED_OVERLAYS=()

START_MARKER="<!-- CODEX-GOSPEL:START -->"
END_MARKER="<!-- CODEX-GOSPEL:END -->"

list_available_overlays() {
  local manifest
  for manifest in "$REPO_ROOT"/overlays/*/manifest.env; do
    [[ -f "$manifest" ]] || continue
    OVERLAY_ID=""
    OVERLAY_DISPLAY_NAME=""
    OVERLAY_SUMMARY=""
    # shellcheck disable=SC1090
    source "$manifest"
    printf "%-22s %-24s %s\n" "$OVERLAY_ID" "$OVERLAY_DISPLAY_NAME" "$OVERLAY_SUMMARY"
  done
}

usage() {
  cat <<'USAGE'
Usage:
  scripts/uninstall.sh --scope user
  scripts/uninstall.sh --scope project --project-dir /path/to/project
  scripts/uninstall.sh --scope both --project-dir /path/to/project --all-overlays

Options:
  --scope user|project|both   Remove user rules, project rules, or both.
  --project-dir PATH          Project directory for project/both scope.
  --codex-home PATH           Override CODEX_HOME. Defaults to $CODEX_HOME or ~/.codex.
  --overlay NAME              Remove one overlay. May be repeated.
  --all-overlays              Remove every bundled public-safe overlay.
  --list-overlays             List available overlays.
  -h, --help                  Show this help.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --scope)
      SCOPE="${2:-}"
      shift 2
      ;;
    --project-dir)
      PROJECT_DIR="${2:-}"
      shift 2
      ;;
    --codex-home)
      CODEX_HOME_DIR="${2:-}"
      shift 2
      ;;
    --overlay)
      REQUESTED_OVERLAYS+=("${2:-}")
      shift 2
      ;;
    --all-overlays)
      ALL_OVERLAYS=1
      shift
      ;;
    --list-overlays)
      list_available_overlays
      exit 0
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

case "$SCOPE" in
  user|project|both) ;;
  *)
    echo "--scope must be one of: user, project, both" >&2
    exit 2
    ;;
esac

if [[ "$SCOPE" == "project" || "$SCOPE" == "both" ]]; then
  if [[ -z "$PROJECT_DIR" ]]; then
    echo "--project-dir is required for --scope $SCOPE" >&2
    exit 2
  fi
  PROJECT_DIR="$(cd "$PROJECT_DIR" && pwd)"
fi

timestamp() {
  date +"%Y%m%d-%H%M%S"
}

backup_path() {
  local path="$1"
  if [[ -e "$path" ]]; then
    if [[ -d "$path" ]]; then
      cp -R "$path" "$path.bak.codex-gospel.$(timestamp)"
    else
      cp "$path" "$path.bak.codex-gospel.$(timestamp)"
    fi
  fi
}

backup_skill_dir() {
  local path="$1"
  local skills_root="$2"
  local skill_name
  local backup_root

  skill_name="$(basename "$path")"
  backup_root="$(dirname "$skills_root")/backups/codex-gospel/skills"
  mkdir -p "$backup_root"
  cp -R "$path" "$backup_root/$skill_name.$(timestamp)"
}

has_overlay() {
  local needle="$1"
  local item
  for item in "${SELECTED_OVERLAYS[@]}"; do
    [[ "$item" == "$needle" ]] && return 0
  done
  return 1
}

add_overlay() {
  local overlay="$1"
  local overlay_dir="$REPO_ROOT/overlays/$overlay"

  if [[ ! "$overlay" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
    echo "invalid overlay id: $overlay" >&2
    exit 2
  fi
  if [[ ! -d "$overlay_dir" || ! -f "$overlay_dir/manifest.env" ]]; then
    echo "unknown overlay: $overlay" >&2
    echo "available overlays:" >&2
    list_available_overlays >&2
    exit 2
  fi
  if ! has_overlay "$overlay"; then
    SELECTED_OVERLAYS+=("$overlay")
  fi
}

resolve_overlays() {
  local overlay_dir
  if [[ "$ALL_OVERLAYS" -eq 1 ]]; then
    for overlay_dir in "$REPO_ROOT"/overlays/*; do
      [[ -d "$overlay_dir" ]] || continue
      add_overlay "$(basename "$overlay_dir")"
    done
  fi

  local overlay
  for overlay in "${REQUESTED_OVERLAYS[@]}"; do
    add_overlay "$overlay"
  done
}

remove_marker_block() {
  local target="$1"
  local start_marker="$2"
  local end_marker="$3"
  local tmp

  [[ -f "$target" ]] || {
    echo "not found: $target"
    return 0
  }

  if ! grep -Fxq "$start_marker" "$target" && ! grep -Fxq "$end_marker" "$target"; then
    echo "marker not found in $target: $start_marker"
    return 0
  fi

  if ! grep -Fxq "$start_marker" "$target" || ! grep -Fxq "$end_marker" "$target"; then
    echo "marker pair is incomplete in $target: $start_marker / $end_marker" >&2
    exit 1
  fi

  backup_path "$target"
  tmp="$(mktemp)"
  awk -v start="$start_marker" -v end="$end_marker" '
    $0 == start { skip = 1; next }
    $0 == end { skip = 0; next }
    skip != 1 { print }
  ' "$target" > "$tmp"
  mv "$tmp" "$target"
  echo "removed marker block from $target: $start_marker"
}

remove_skill_dir() {
  local skills_root="$1"
  local skill_name="$2"
  local target_dir="$skills_root/$skill_name"

  [[ -d "$target_dir" ]] || {
    echo "skill not found: $target_dir"
    return 0
  }

  backup_skill_dir "$target_dir" "$skills_root"
  rm -rf "$target_dir"
  echo "removed skill $target_dir"
}

remove_overlay_agents() {
  local target="$1"
  local overlay

  for overlay in "${SELECTED_OVERLAYS[@]}"; do
    remove_marker_block \
      "$target" \
      "<!-- CODEX-GOSPEL:OVERLAY:$overlay:START -->" \
      "<!-- CODEX-GOSPEL:OVERLAY:$overlay:END -->"
  done
}

remove_overlay_skills() {
  local skills_root="$1"
  local overlay
  local skill_dir

  for overlay in "${SELECTED_OVERLAYS[@]}"; do
    for skill_dir in "$REPO_ROOT/overlays/$overlay"/skills/*; do
      [[ -d "$skill_dir" ]] || continue
      remove_skill_dir "$skills_root" "$(basename "$skill_dir")"
    done
  done
}

uninstall_user() {
  remove_overlay_agents "$HOME/AGENTS.md"
  remove_marker_block "$HOME/AGENTS.md" "$START_MARKER" "$END_MARKER"
  remove_overlay_skills "$CODEX_HOME_DIR/skills"
  remove_skill_dir "$CODEX_HOME_DIR/skills" "codex-gospel"
}

uninstall_project() {
  remove_overlay_agents "$PROJECT_DIR/AGENTS.md"
  remove_marker_block "$PROJECT_DIR/AGENTS.md" "$START_MARKER" "$END_MARKER"
  remove_overlay_skills "$PROJECT_DIR/.codex/skills"
  remove_skill_dir "$PROJECT_DIR/.codex/skills" "codex-gospel"
}

resolve_overlays

case "$SCOPE" in
  user)
    uninstall_user
    ;;
  project)
    uninstall_project
    ;;
  both)
    uninstall_user
    uninstall_project
    ;;
esac

echo "Codex Gospel uninstall complete."
