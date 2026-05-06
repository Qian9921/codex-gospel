# Codex Gospel

Reusable operating rules for Codex: evidence-first work, plain-language rigor, small reversible changes, explicit verification, and durable project memory.

This repository is meant to be cloned into any machine or project where a team wants Codex to behave with the same professional discipline every time.

## What This Gives You

Codex Gospel installs two surfaces:

1. A reusable `AGENTS.md` block that Codex sees automatically when working in a directory.
2. A `codex-gospel` skill that can be loaded when the work needs stricter review, research, debugging, planning, or implementation discipline.

The practical result: Codex should stop acting like a vague chatbot and start acting like a careful engineering/research partner. It must inspect live state, separate facts from inference, explain professional details in normal language, and verify before claiming completion.

## Core Contract

- **Evidence beats reassurance.** Inspect the actual files, commands, logs, data, docs, or external references before making claims.
- **Plain-language rigor.** Explain the human meaning first, then attach the professional anchors: paths, commands, units, formulas, assumptions, uncertainty, edge cases, and verification status.
- **Small reversible changes.** Every diff should trace back to the user request and have a rollback path.
- **No fake completion.** Do not say done, fixed, passing, or complete until the relevant verification has run and the result is known.
- **Durable decisions.** Important decisions, pivots, negative results, and operating rules belong in repo docs, not only in chat.
- **Project rules win.** The universal gospel is a floor. A project can add stricter overlays for its own domain.

## Quick Start

Clone this repository:

```bash
git clone https://github.com/YOUR_ORG/codex-gospel.git
cd codex-gospel
```

Install globally for the current user:

```bash
scripts/install.sh --scope user
```

Install into a specific project:

```bash
scripts/install.sh --scope project --project-dir /path/to/project
```

Install both:

```bash
scripts/install.sh --scope both --project-dir /path/to/project
```

Verify:

```bash
scripts/doctor.sh --project-dir /path/to/project
```

If `codex` is installed, the doctor also checks whether `codex debug prompt-input` can see the installed rules.

## Repository Layout

```text
AGENTS.md                         # Rules for working on this repo itself
codex/skills/codex-gospel/         # Installable Codex skill
docs/                              # Human-readable gospel reference
examples/                          # Example project AGENTS files
scripts/install.sh                 # Safe installer with marker-based updates
scripts/doctor.sh                  # Local verification
scripts/check-repo.sh              # CI/package sanity checks
templates/global/AGENTS.md         # Full global user-level AGENTS template
templates/project/AGENTS.md        # Full project-level AGENTS template
templates/snippets/                # Marker blocks inserted by installer
```

## Safety Model

The installer is designed to be additive:

- It creates backups before changing an existing `AGENTS.md`.
- It updates only marker-bounded gospel blocks.
- It installs the skill under `${CODEX_HOME:-$HOME/.codex}/skills/codex-gospel`.
- It does not copy private memories, credentials, transcripts, or machine-specific paths.

## Recommended Adoption

For an individual:

1. Install `codex-gospel` globally.
2. Add the project block to active repositories.
3. Keep project-specific rules in the project `AGENTS.md`, below the universal gospel block.

For a team:

1. Commit the project `AGENTS.md` block.
2. Keep domain-specific overlays in repo docs.
3. Make verification commands explicit.
4. Review changes to `AGENTS.md` like production code, because it changes agent behavior.

## Remote Publishing

This local repo is ready to publish. A typical first push is:

```bash
git remote add origin git@github.com:YOUR_ORG/codex-gospel.git
git push -u origin main
```

If you prefer GitHub CLI:

```bash
gh repo create YOUR_ORG/codex-gospel --public --source . --remote origin --push
```

Use `--private` instead of `--public` if the repo should not be visible to everyone yet.
