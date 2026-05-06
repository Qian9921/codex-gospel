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
- `google-practices`

## Verification

```bash
scripts/doctor.sh --project-dir /path/to/project
```

Verify overlays, and use `--strict` when a warning should fail CI or an install gate:

```bash
scripts/doctor.sh --project-dir /path/to/project --overlay research-audit
scripts/doctor.sh --project-dir /path/to/project --all-overlays --strict
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

Skill backups are stored outside active `skills/` directories:

```text
${CODEX_HOME:-$HOME/.codex}/backups/codex-gospel/skills/
<project>/.codex/backups/codex-gospel/skills/
```

This prevents Codex from loading old backup skills as if they were current.

## Uninstall And Rollback

Remove the user-level core install:

```bash
scripts/uninstall.sh --scope user
```

Remove project-level core plus every bundled overlay:

```bash
scripts/uninstall.sh --scope project --project-dir /path/to/project --all-overlays
```

Remove both user and project installs:

```bash
scripts/uninstall.sh --scope both --project-dir /path/to/project --all-overlays
```

Uninstall removes marker-bounded blocks and installed skills. It backs up files and skills before removal, using the same backup model as install.

## Smoke Test

For package maintainers, run the install lifecycle smoke test:

```bash
scripts/smoke-install.sh
```

The smoke test installs into temporary user and project directories, reinstalls to catch backup-skill pollution, runs strict doctor, then uninstalls and checks that marker blocks and core skills are gone.
