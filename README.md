# Codex Gospel

Reusable operating rules for Codex: evidence-first work, plain-language rigor, small reversible changes, explicit verification, and durable project memory.

This repository is meant to be cloned into any machine or project where a team wants Codex to behave with the same professional discipline every time.

## What This Gives You

Codex Gospel installs two core surfaces:

1. A reusable `AGENTS.md` block that Codex sees automatically when working in a directory.
2. A `codex-gospel` skill that can be loaded when the work needs stricter review, research, debugging, planning, or implementation discipline.

It also ships optional overlays for the full public-safe gospel:

| Overlay | What It Adds |
| --- | --- |
| `agent-discipline` | Assumption surfacing, simplicity, surgical edits, and verifiable goals. |
| `staff-engineering` | Staff+/principal engineering judgment, code-shape standards, code-health review, and high-assurance testing. |
| `research-audit` | A-grade research analysis, numeric-evidence discipline, audit format, and durable research memory. |
| `agent-supervision` | Codex-as-supervisor rules for worker agents and external model lanes. |
| `domain-boundaries` | Source-of-truth rules for schemas, parsers, physics, units, frames, and producer/consumer contracts. |
| `google-practices` | Public Google engineering and research-practice synthesis: code review, style, testing, APIs, SRE, docs, ML, and responsible AI. |

The practical result: Codex should stop acting like a vague chatbot and start acting like a careful engineering/research partner. It must inspect live state, separate facts from inference, explain professional details in normal language, verify before claiming completion, and load sharper overlays when the task needs them.

## Optional Companion Tools

Codex Gospel stays lightweight by design. Execution engines that are useful but not universal live in separate repos.

| Tool | Repo | Relationship |
| --- | --- | --- |
| `dsteam` | <https://github.com/Qian9921/dsteam> | Optional Codex-supervised external worker orchestration. Compatible with this gospel, but not required by it. |

Use `dsteam` only when you want external worker lanes for bounded scouting, implementation, testing, review, or evidence packing. Codex Gospel remains the supervisor policy; `dsteam` is an optional execution engine users can choose to install or ignore.

## Core Contract

- **Evidence beats reassurance.** Inspect the actual files, commands, logs, data, docs, or external references before making claims.
- **Plain-language rigor.** Explain the human meaning first, then attach the professional anchors: paths, commands, units, formulas, assumptions, uncertainty, edge cases, and verification status.
- **Concise by default.** Use the shortest answer that still carries the truth. Cut repetition, filler, process narration, and evidence dumps; keep the evidence, caveats, and next action that change the decision.
- **Small reversible changes.** Every diff should trace back to the user request and have a rollback path.
- **No fake completion.** Do not say done, fixed, passing, or complete until the relevant verification has run and the result is known.
- **Durable decisions.** Important decisions, pivots, negative results, and operating rules belong in repo docs, not only in chat.
- **Project rules win.** The universal gospel is a floor. A project can add stricter overlays for its own domain.

## Quick Start

Clone this repository:

```bash
git clone https://github.com/Qian9921/codex-gospel.git
cd codex-gospel
```

Install globally for the current user:

```bash
scripts/install.sh --scope user
```

Install the full public-safe gospel globally:

```bash
scripts/install.sh --scope user --all-overlays
```

Install into a specific project:

```bash
scripts/install.sh --scope project --project-dir /path/to/project
```

Install both:

```bash
scripts/install.sh --scope both --project-dir /path/to/project
```

Install selected overlays:

```bash
scripts/install.sh --scope both --project-dir /path/to/project \
  --overlay agent-discipline \
  --overlay staff-engineering \
  --overlay research-audit
```

Verify:

```bash
scripts/doctor.sh --project-dir /path/to/project
scripts/doctor.sh --project-dir /path/to/project --all-overlays --strict
```

If `codex` is installed, the doctor also checks whether `codex debug prompt-input` can see the installed rules.

Uninstall marker blocks and installed skills when you need a clean rollback:

```bash
scripts/uninstall.sh --scope both --project-dir /path/to/project --all-overlays
```

## Repository Layout

```text
AGENTS.md                         # Rules for working on this repo itself
codex/skills/codex-gospel/         # Installable Codex skill
docs/                              # Human-readable gospel reference
examples/                          # Example project AGENTS files
overlays/                          # Optional public-safe gospel overlays
scripts/install.sh                 # Safe installer with marker-based updates
scripts/uninstall.sh               # Marker/skill rollback helper
scripts/doctor.sh                  # Local verification
scripts/check-repo.sh              # CI/package sanity checks
scripts/smoke-install.sh           # Install/reinstall/uninstall smoke test
templates/global/AGENTS.md         # Full global user-level AGENTS template
templates/project/AGENTS.md        # Full project-level AGENTS template
templates/snippets/                # Marker blocks inserted by installer
```

## Safety Model

The installer is designed to be additive:

- It creates backups before changing an existing `AGENTS.md`.
- It keeps skill backups outside active `skills/` directories so Codex does not load old backup skills.
- It updates only marker-bounded gospel blocks.
- It installs user skills under `${CODEX_HOME:-$HOME/.codex}/skills/`.
- It installs project skills under `<project>/.codex/skills/` for project-scoped installs.
- It writes overlays into separate marker-bounded blocks.
- It does not copy private memories, credentials, transcripts, or machine-specific paths.

## Recommended Adoption

For an individual:

1. Install `codex-gospel` globally.
2. Add `--all-overlays` if you want the full public-safe gospel everywhere.
3. Add the project block to active repositories.
4. Keep project-specific rules in the project `AGENTS.md`, below the universal gospel and overlay blocks.

For a team:

1. Commit the project `AGENTS.md` block.
2. Install only the overlays the team actually wants.
3. Make verification commands explicit.
4. Review changes to `AGENTS.md` like production code, because it changes agent behavior.
5. Keep private or project-specific rules below the public-safe gospel blocks.

## Remote Publishing

Forks can publish their own copy with:

```bash
git remote add origin git@github.com:YOUR_ORG/codex-gospel.git
git push -u origin main
```

If you prefer GitHub CLI:

```bash
gh repo create YOUR_ORG/codex-gospel --public --source . --remote origin --push
```

Use `--private` instead of `--public` if the repo should not be visible to everyone yet.

## More Docs

- [Overlay system](docs/overlay-system.md)
- [Google practices overlay](docs/google-practices.md)
- [Engineering standards](docs/engineering-standards.md)
- [Companion tools](docs/companion-tools.md)
- [Source inventory](docs/source-inventory.md)
- [Audit format](docs/audit-format.md)
- [Installation](docs/installation.md)
