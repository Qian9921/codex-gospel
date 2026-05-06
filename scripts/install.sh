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
  scripts/install.sh --scope user
  scripts/install.sh --scope project --project-dir /path/to/project
  scripts/install.sh --scope both --project-dir /path/to/project
  scripts/install.sh --scope user --all-overlays
  scripts/install.sh --scope project --project-dir /path/to/project --overlay staff-engineering

Options:
  --scope user|project|both   Install user rules, project rules, or both.
  --project-dir PATH          Project directory for project/both scope.
  --codex-home PATH           Override CODEX_HOME. Defaults to $CODEX_HOME or ~/.codex.
  --overlay NAME              Install one overlay. May be repeated.
  --all-overlays              Install every bundled public-safe overlay.
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

START_MARKER="<!-- CODEX-GOSPEL:START -->"
END_MARKER="<!-- CODEX-GOSPEL:END -->"
SNIPPET="$REPO_ROOT/templates/snippets/AGENTS-gospel-block.md"
GLOBAL_TEMPLATE="$REPO_ROOT/templates/global/AGENTS.md"
PROJECT_TEMPLATE="$REPO_ROOT/templates/project/AGENTS.md"
CORE_SKILL_DIR="$REPO_ROOT/codex/skills/codex-gospel"

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
  if [[ ! -d "$overlay_dir" || ! -f "$overlay_dir/manifest.env" || ! -f "$overlay_dir/AGENTS.md" ]]; then
    echo "unknown or incomplete overlay: $overlay" >&2
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

upsert_marker_block() {
  local target="$1"
  local block_file="$2"
  local template_if_missing="$3"
  local start_marker="${4:-$START_MARKER}"
  local end_marker="${5:-$END_MARKER}"
  local target_dir
  local tmp

  target_dir="$(dirname "$target")"
  mkdir -p "$target_dir"

  if [[ ! -f "$target" ]]; then
    cp "$template_if_missing" "$target"
    echo "created $target"
    return 0
  fi

  backup_path "$target"
  tmp="$(mktemp)"

  if grep -Fxq "$start_marker" "$target" || grep -Fxq "$end_marker" "$target"; then
    if ! grep -Fxq "$start_marker" "$target" || ! grep -Fxq "$end_marker" "$target"; then
      echo "marker pair is incomplete in $target: $start_marker / $end_marker" >&2
      rm -f "$tmp"
      exit 1
    fi
    awk -v start="$start_marker" -v end="$end_marker" -v block_file="$block_file" '
      BEGIN {
        while ((getline line < block_file) > 0) {
          block = block line ORS
        }
      }
      $0 == start {
        printf "%s", block
        skip = 1
        next
      }
      $0 == end {
        skip = 0
        next
      }
      skip != 1 { print }
    ' "$target" > "$tmp"
  else
    cat "$target" > "$tmp"
    printf "\n" >> "$tmp"
    cat "$block_file" >> "$tmp"
  fi

  mv "$tmp" "$target"
  echo "updated $target"
}

install_skill_dir() {
  local source_dir="$1"
  local skills_root="$2"
  local skill_name
  local target_dir

  skill_name="$(basename "$source_dir")"
  target_dir="$skills_root/$skill_name"

  mkdir -p "$skills_root"
  if [[ -e "$target_dir" ]]; then
    backup_skill_dir "$target_dir" "$skills_root"
    rm -rf "$target_dir"
  fi
  mkdir -p "$target_dir"
  cp -R "$source_dir/." "$target_dir/"
  echo "installed skill $target_dir"
}

install_core_skill() {
  local skills_root="$1"
  install_skill_dir "$CORE_SKILL_DIR" "$skills_root"
}

install_overlay_agents() {
  local target="$1"
  local template_if_missing="$2"
  local overlay
  local overlay_dir
  local start_marker
  local end_marker
  local tmp_block

  for overlay in "${SELECTED_OVERLAYS[@]}"; do
    overlay_dir="$REPO_ROOT/overlays/$overlay"
    start_marker="<!-- CODEX-GOSPEL:OVERLAY:$overlay:START -->"
    end_marker="<!-- CODEX-GOSPEL:OVERLAY:$overlay:END -->"
    tmp_block="$(mktemp)"
    {
      printf "%s\n" "$start_marker"
      cat "$overlay_dir/AGENTS.md"
      printf "%s\n" "$end_marker"
    } > "$tmp_block"
    upsert_marker_block "$target" "$tmp_block" "$template_if_missing" "$start_marker" "$end_marker"
    rm -f "$tmp_block"
  done
}

install_overlay_skills() {
  local skills_root="$1"
  local overlay
  local skill_dir

  for overlay in "${SELECTED_OVERLAYS[@]}"; do
    for skill_dir in "$REPO_ROOT/overlays/$overlay"/skills/*; do
      [[ -d "$skill_dir" ]] || continue
      install_skill_dir "$skill_dir" "$skills_root"
    done
  done
}

install_user() {
  upsert_marker_block "$HOME/AGENTS.md" "$SNIPPET" "$GLOBAL_TEMPLATE"
  install_overlay_agents "$HOME/AGENTS.md" "$GLOBAL_TEMPLATE"
  install_core_skill "$CODEX_HOME_DIR/skills"
  install_overlay_skills "$CODEX_HOME_DIR/skills"
}

install_project() {
  upsert_marker_block "$PROJECT_DIR/AGENTS.md" "$SNIPPET" "$PROJECT_TEMPLATE"
  install_overlay_agents "$PROJECT_DIR/AGENTS.md" "$PROJECT_TEMPLATE"
  install_core_skill "$PROJECT_DIR/.codex/skills"
  install_overlay_skills "$PROJECT_DIR/.codex/skills"
}

resolve_overlays

case "$SCOPE" in
  user)
    install_user
    ;;
  project)
    install_project
    ;;
  both)
    install_user
    install_project
    ;;
esac

echo "Codex Gospel install complete."
if [[ "${#SELECTED_OVERLAYS[@]}" -gt 0 ]]; then
  printf "Installed overlays: %s\n" "${SELECTED_OVERLAYS[*]}"
fi
