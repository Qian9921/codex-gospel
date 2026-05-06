# Installation

Codex Gospel can be installed globally, per project, or both. By default it installs the universal core. Add overlays when you want the fuller public-safe gospel.

## Global Install

Global install adds a reusable `AGENTS.md` block under your home directory and installs the `codex-gospel` skill under `${CODEX_HOME:-$HOME/.codex}`.

```bash
scripts/install.sh --scope user
```

Use global install when you want the gospel available across many projects.

Full public-safe global install:

```bash
scripts/install.sh --scope user --all-overlays
```

## Project Install

Project install adds a marker-bounded gospel block to a project's `AGENTS.md`.

```bash
scripts/install.sh --scope project --project-dir /path/to/project
```

Use project install when a repo should carry the rules for everyone who clones it. Project install also places skills under `<project>/.codex/skills/` so the repo can carry its own Codex skill surface.

Project install with selected overlays:

```bash
scripts/install.sh --scope project --project-dir /path/to/project \
  --overlay agent-discipline \
  --overlay staff-engineering
```

## Both

```bash
scripts/install.sh --scope both --project-dir /path/to/project
```

Full public-safe install into both user and project surfaces:

```bash
scripts/install.sh --scope both --project-dir /path/to/project --all-overlays
```

## Overlay Selection

List overlays:

```bash
scripts/install.sh --list-overlays
```

Install one or more overlays:

```bash
scripts/install.sh --scope user --overlay research-audit --overlay agent-supervision
```

Bundled overlays:

- `agent-discipline`
- `staff-engineering`
- `research-audit`
- `agent-supervision`
- `domain-boundaries`

## Verification

```bash
scripts/doctor.sh --project-dir /path/to/project
```

Verify overlays:

```bash
scripts/doctor.sh --project-dir /path/to/project --overlay research-audit
scripts/doctor.sh --project-dir /path/to/project --all-overlays
```

If `codex` is available, the doctor checks prompt visibility with:

```bash
codex -C /path/to/project debug prompt-input
```

## Update Model

The installer uses marker blocks:

```text
<!-- CODEX-GOSPEL:START -->
...
<!-- CODEX-GOSPEL:END -->
```

On reinstall, it replaces only that marker block and leaves the rest of the file alone.

Overlays use separate marker blocks:

```text
<!-- CODEX-GOSPEL:OVERLAY:<overlay-id>:START -->
...
<!-- CODEX-GOSPEL:OVERLAY:<overlay-id>:END -->
```

Existing files are backed up before modification.
