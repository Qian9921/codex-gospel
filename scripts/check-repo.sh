#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

required_files=(
  "README.md"
  "AGENTS.md"
  "LICENSE"
  "codex/skills/codex-gospel/SKILL.md"
  "templates/snippets/AGENTS-gospel-block.md"
  "templates/global/AGENTS.md"
  "templates/project/AGENTS.md"
  "scripts/install.sh"
  "scripts/doctor.sh"
)

for path in "${required_files[@]}"; do
  [[ -f "$path" ]] || {
    echo "missing required file: $path" >&2
    exit 1
  }
done

grep -Fq "name: codex-gospel" codex/skills/codex-gospel/SKILL.md || {
  echo "skill metadata missing name: codex-gospel" >&2
  exit 1
}

for path in templates/snippets/AGENTS-gospel-block.md templates/global/AGENTS.md templates/project/AGENTS.md; do
  grep -Fq "<!-- CODEX-GOSPEL:START -->" "$path" || {
    echo "missing start marker in $path" >&2
    exit 1
  }
  grep -Fq "<!-- CODEX-GOSPEL:END -->" "$path" || {
    echo "missing end marker in $path" >&2
    exit 1
  }
done

for path in scripts/install.sh scripts/doctor.sh scripts/check-repo.sh; do
  [[ -x "$path" ]] || {
    echo "script is not executable: $path" >&2
    exit 1
  }
done

if grep -RInE '(/home/martin|qmohsu|locavate|Locavate|Fusion|\.cac|CLAUDE|Claude)' \
  --exclude-dir=.git \
  --exclude='check-repo.sh' \
  --exclude='*.bak*' \
  .; then
  echo "private or project-specific source string found in universal package" >&2
  exit 1
fi

echo "ok: repository package check passed"
