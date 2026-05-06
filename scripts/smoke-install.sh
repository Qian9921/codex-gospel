#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/codex-gospel-smoke.XXXXXX")"

cleanup() {
  rm -rf "$TMP_ROOT"
}
trap cleanup EXIT

HOME_DIR="$TMP_ROOT/home"
CODEX_HOME_DIR="$TMP_ROOT/codex"
PROJECT_DIR="$TMP_ROOT/project"

mkdir -p "$HOME_DIR" "$CODEX_HOME_DIR" "$PROJECT_DIR"

fail() {
  echo "fail: $*" >&2
  exit 1
}

assert_not_visible_backup_skills() {
  local skills_root="$1"
  if [[ -d "$skills_root" ]] && find "$skills_root" -maxdepth 1 -mindepth 1 -type d -name '*.bak.*' | grep -q .; then
    find "$skills_root" -maxdepth 1 -mindepth 1 -type d -name '*.bak.*' >&2
    fail "Codex-visible backup skills found under $skills_root"
  fi
}

assert_absent() {
  local path="$1"
  [[ ! -e "$path" ]] || fail "expected absent: $path"
}

env HOME="$HOME_DIR" CODEX_HOME="$CODEX_HOME_DIR" \
  "$REPO_ROOT/scripts/install.sh" --scope both --project-dir "$PROJECT_DIR" --all-overlays
env HOME="$HOME_DIR" CODEX_HOME="$CODEX_HOME_DIR" \
  "$REPO_ROOT/scripts/doctor.sh" --project-dir "$PROJECT_DIR" --all-overlays --strict --no-codex-check

env HOME="$HOME_DIR" CODEX_HOME="$CODEX_HOME_DIR" \
  "$REPO_ROOT/scripts/install.sh" --scope both --project-dir "$PROJECT_DIR" --all-overlays
env HOME="$HOME_DIR" CODEX_HOME="$CODEX_HOME_DIR" \
  "$REPO_ROOT/scripts/doctor.sh" --project-dir "$PROJECT_DIR" --all-overlays --strict --no-codex-check

assert_not_visible_backup_skills "$CODEX_HOME_DIR/skills"
assert_not_visible_backup_skills "$PROJECT_DIR/.codex/skills"

env HOME="$HOME_DIR" CODEX_HOME="$CODEX_HOME_DIR" \
  "$REPO_ROOT/scripts/uninstall.sh" --scope both --project-dir "$PROJECT_DIR" --all-overlays

if grep -Fq "<!-- CODEX-GOSPEL:START -->" "$HOME_DIR/AGENTS.md"; then
  fail "user AGENTS.md still has Codex Gospel marker after uninstall"
fi
if grep -Fq "<!-- CODEX-GOSPEL:START -->" "$PROJECT_DIR/AGENTS.md"; then
  fail "project AGENTS.md still has Codex Gospel marker after uninstall"
fi
assert_absent "$CODEX_HOME_DIR/skills/codex-gospel"
assert_absent "$PROJECT_DIR/.codex/skills/codex-gospel"

echo "ok: install/reinstall/uninstall smoke passed"
