#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(pwd)"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
RUN_CODEX_CHECK="auto"

usage() {
  cat <<'USAGE'
Usage:
  scripts/doctor.sh [--project-dir /path/to/project] [--codex-home PATH] [--no-codex-check]

Checks:
  - repository package files
  - installed codex-gospel skill
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
  ok "codex-gospel skill installed"
else
  warn "codex-gospel skill not installed under $CODEX_HOME_DIR"
fi

if [[ "$RUN_CODEX_CHECK" != "no" ]]; then
  if command -v codex >/dev/null 2>&1; then
    tmp="$(mktemp)"
    if codex -C "$PROJECT_DIR" debug prompt-input > "$tmp" 2>/dev/null; then
      if grep -Eq "CODEX-GOSPEL|codex-gospel|Plain-language rigor|plain-language rigor" "$tmp"; then
        ok "codex prompt input contains gospel markers or skill metadata"
      else
        warn "codex prompt input did not show gospel markers; project AGENTS may override global body"
      fi
    else
      warn "codex debug prompt-input failed"
    fi
    rm -f "$tmp"
  else
    warn "codex command not found; skipped prompt visibility check"
  fi
fi

ok "doctor completed"
