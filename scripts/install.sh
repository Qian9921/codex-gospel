#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SCOPE="user"
PROJECT_DIR=""
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"

usage() {
  cat <<'USAGE'
Usage:
  scripts/install.sh --scope user
  scripts/install.sh --scope project --project-dir /path/to/project
  scripts/install.sh --scope both --project-dir /path/to/project

Options:
  --scope user|project|both   Install user rules, project rules, or both.
  --project-dir PATH          Project directory for project/both scope.
  --codex-home PATH           Override CODEX_HOME. Defaults to $CODEX_HOME or ~/.codex.
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
SKILL_SOURCE="$REPO_ROOT/codex/skills/codex-gospel/SKILL.md"

timestamp() {
  date +"%Y%m%d-%H%M%S"
}

backup_file() {
  local path="$1"
  if [[ -f "$path" ]]; then
    cp "$path" "$path.bak.codex-gospel.$(timestamp)"
  fi
}

upsert_marker_block() {
  local target="$1"
  local block_file="$2"
  local template_if_missing="$3"
  local target_dir
  local tmp

  target_dir="$(dirname "$target")"
  mkdir -p "$target_dir"

  if [[ ! -f "$target" ]]; then
    cp "$template_if_missing" "$target"
    echo "created $target"
    return 0
  fi

  backup_file "$target"
  tmp="$(mktemp)"

  awk -v start="$START_MARKER" -v end="$END_MARKER" '
    $0 == start { skip = 1; next }
    $0 == end { skip = 0; next }
    skip != 1 { print }
  ' "$target" > "$tmp"

  printf "\n" >> "$tmp"
  cat "$block_file" >> "$tmp"
  mv "$tmp" "$target"
  echo "updated $target"
}

install_skill() {
  local skill_dir="$CODEX_HOME_DIR/skills/codex-gospel"
  local target="$skill_dir/SKILL.md"

  mkdir -p "$skill_dir"
  if [[ -f "$target" ]] && ! cmp -s "$SKILL_SOURCE" "$target"; then
    backup_file "$target"
  fi
  cp "$SKILL_SOURCE" "$target"
  echo "installed skill $target"
}

install_user() {
  upsert_marker_block "$HOME/AGENTS.md" "$SNIPPET" "$GLOBAL_TEMPLATE"
  install_skill
}

install_project() {
  upsert_marker_block "$PROJECT_DIR/AGENTS.md" "$SNIPPET" "$PROJECT_TEMPLATE"
}

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
