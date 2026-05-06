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
  "docs/audit-format.md"
  "docs/overlay-system.md"
  "docs/source-inventory.md"
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

overlay_count=0
for overlay_dir in overlays/*; do
  [[ -d "$overlay_dir" ]] || continue
  overlay_count=$((overlay_count + 1))
  [[ -f "$overlay_dir/manifest.env" ]] || {
    echo "missing overlay manifest: $overlay_dir/manifest.env" >&2
    exit 1
  }
  [[ -f "$overlay_dir/AGENTS.md" ]] || {
    echo "missing overlay AGENTS block: $overlay_dir/AGENTS.md" >&2
    exit 1
  }
  grep -Eq '^OVERLAY_ID=[a-z0-9][a-z0-9-]*$' "$overlay_dir/manifest.env" || {
    echo "invalid overlay id in $overlay_dir/manifest.env" >&2
    exit 1
  }
  for skill in "$overlay_dir"/skills/*/SKILL.md; do
    [[ -f "$skill" ]] || continue
    grep -Fq "name: $(basename "$(dirname "$skill")")" "$skill" || {
      echo "skill metadata name does not match directory: $skill" >&2
      exit 1
    }
  done
done

if grep -RInE "^description: [^\"'][^#]*: " codex/skills overlays; then
  echo "skill description with an unquoted colon can break Codex skill discovery" >&2
  exit 1
fi

if [[ "$overlay_count" -lt 5 ]]; then
  echo "expected at least 5 bundled overlays, found $overlay_count" >&2
  exit 1
fi

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

for path in scripts/install.sh scripts/doctor.sh scripts/check-repo.sh; do
  bash -n "$path" || {
    echo "shell syntax check failed: $path" >&2
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
