# Installation

Codex Gospel can be installed globally, per project, or both.

## Global Install

Global install adds a reusable `AGENTS.md` block under your home directory and installs the `codex-gospel` skill under `${CODEX_HOME:-$HOME/.codex}`.

```bash
scripts/install.sh --scope user
```

Use global install when you want the gospel available across many projects.

## Project Install

Project install adds a marker-bounded gospel block to a project's `AGENTS.md`.

```bash
scripts/install.sh --scope project --project-dir /path/to/project
```

Use project install when a repo should carry the rules for everyone who clones it.

## Both

```bash
scripts/install.sh --scope both --project-dir /path/to/project
```

## Verification

```bash
scripts/doctor.sh --project-dir /path/to/project
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

Existing files are backed up before modification.
