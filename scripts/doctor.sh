#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(pwd)"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
RUN_CODEX_CHECK="auto"
ALL_OVERLAYS=0
REQUESTED_OVERLAYS=()
SELECTED_OVERLAYS=()

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

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
  scripts/doctor.sh [--project-dir /path/to/project] [--codex-home PATH] [--overlay NAME] [--all-overlays] [--no-codex-check]

Checks:
  - repository package files
  - installed codex-gospel skill
  - installed overlay marker blocks and skills when requested
  - user/project AGENTS marker blocks
  - optional Codex prompt visibility via codex debug prompt-input
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project-dir)
      PROJECT_DIR="${2:-}"
      shift 2
      ;;
    --codex-home)
      CODEX_HOME_DIR="${2:-}"
      shift 2
      ;;
    --no-codex-check)
      RUN_CODEX_CHECK="no"
      shift
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

PROJECT_DIR="$(cd "$PROJECT_DIR" && pwd)"

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
    fail "invalid overlay id: $overlay"
  fi
  if [[ ! -d "$overlay_dir" || ! -f "$overlay_dir/manifest.env" || ! -f "$overlay_dir/AGENTS.md" ]]; then
    echo "available overlays:" >&2
    list_available_overlays >&2
    fail "unknown or incomplete overlay: $overlay"
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

ok() {
  echo "ok: $*"
}

warn() {
  echo "warn: $*" >&2
}

fail() {
  echo "fail: $*" >&2
  exit 1
}

contains() {
  local file="$1"
  local pattern="$2"
  [[ -f "$file" ]] && grep -Fq "$pattern" "$file"
}

resolve_overlays

if [[ -f "$HOME/AGENTS.md" ]]; then
  if contains "$HOME/AGENTS.md" "<!-- CODEX-GOSPEL:START -->"; then
    ok "user AGENTS.md has Codex Gospel marker"
  else
    warn "user AGENTS.md exists but does not have Codex Gospel marker"
  fi
else
  warn "user AGENTS.md not found"
fi

if [[ -f "$PROJECT_DIR/AGENTS.md" ]]; then
  if contains "$PROJECT_DIR/AGENTS.md" "<!-- CODEX-GOSPEL:START -->"; then
    ok "project AGENTS.md has Codex Gospel marker"
  else
    warn "project AGENTS.md exists but does not have Codex Gospel marker"
  fi
else
  warn "project AGENTS.md not found: $PROJECT_DIR/AGENTS.md"
fi

if [[ -f "$CODEX_HOME_DIR/skills/codex-gospel/SKILL.md" ]]; then
  ok "user codex-gospel skill installed"
elif [[ -f "$PROJECT_DIR/.codex/skills/codex-gospel/SKILL.md" ]]; then
  ok "project codex-gospel skill installed"
else
  warn "codex-gospel skill not installed under $CODEX_HOME_DIR or project .codex"
fi

check_overlay() {
  local overlay="$1"
  local marker="<!-- CODEX-GOSPEL:OVERLAY:$overlay:START -->"
  local skill_dir
  local skill_name
  local found_skill=0

  if contains "$HOME/AGENTS.md" "$marker"; then
    ok "user AGENTS.md has overlay marker: $overlay"
  elif contains "$PROJECT_DIR/AGENTS.md" "$marker"; then
    ok "project AGENTS.md has overlay marker: $overlay"
  else
    warn "overlay marker not found in user or project AGENTS.md: $overlay"
  fi

  for skill_dir in "$REPO_ROOT/overlays/$overlay"/skills/*; do
    [[ -d "$skill_dir" ]] || continue
    skill_name="$(basename "$skill_dir")"
    if [[ -f "$CODEX_HOME_DIR/skills/$skill_name/SKILL.md" || -f "$PROJECT_DIR/.codex/skills/$skill_name/SKILL.md" ]]; then
      ok "overlay skill installed: $skill_name"
      found_skill=1
    else
      warn "overlay skill not installed: $skill_name"
    fi
  done
  [[ "$found_skill" -eq 1 ]] || warn "overlay has no bundled skill: $overlay"
}

for overlay in "${SELECTED_OVERLAYS[@]}"; do
  check_overlay "$overlay"
done

if [[ "$RUN_CODEX_CHECK" != "no" ]]; then
  if command -v codex >/dev/null 2>&1; then
    tmp="$(mktemp)"
    if codex -C "$PROJECT_DIR" debug prompt-input > "$tmp" 2>/dev/null; then
      if grep -Eq "CODEX-GOSPEL|codex-gospel|Plain-language rigor|plain-language rigor" "$tmp"; then
        ok "codex prompt input contains gospel markers or skill metadata"
      else
        warn "codex prompt input did not show gospel markers; project AGENTS may override global body"
      fi
      for overlay in "${SELECTED_OVERLAYS[@]}"; do
        overlay_visible=0
        if grep -Fq "CODEX-GOSPEL:OVERLAY:$overlay" "$tmp"; then
          overlay_visible=1
        fi
        for skill_dir in "$REPO_ROOT/overlays/$overlay"/skills/*; do
          [[ -d "$skill_dir" ]] || continue
          skill_name="$(basename "$skill_dir")"
          if grep -Fq "$skill_name" "$tmp"; then
            overlay_visible=1
          fi
        done
        if [[ "$overlay_visible" -eq 1 ]]; then
          ok "codex prompt input shows overlay: $overlay"
        else
          warn "codex prompt input did not show overlay: $overlay"
        fi
      done
    else
      warn "codex debug prompt-input failed"
    fi
    rm -f "$tmp"
  else
    warn "codex command not found; skipped prompt visibility check"
  fi
fi

ok "doctor completed"
