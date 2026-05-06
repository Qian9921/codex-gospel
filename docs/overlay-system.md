# Overlay System

Codex Gospel has a small universal core plus optional overlays.

The core should be safe for almost any project. Overlays add sharper behavior for specific work styles, but they are still public-safe and portable. They do not copy private memories, credentials, transcripts, cache paths, or machine-specific source material.

## Available Overlays

| Overlay | Use When | Installs |
| --- | --- | --- |
| `agent-discipline` | Coding-agent work needs less guessing, less overbuilding, tighter edits, and verifiable goals. | AGENTS block + `codex-gospel-agent-discipline` skill |
| `staff-engineering` | Work needs Staff+/principal engineering quality, code-shape standards, high-assurance tests, review craft, or Google-grade code health. | AGENTS block + `codex-gospel-staff-engineering` skill |
| `research-audit` | Work involves research, data, math, algorithms, evaluation, numeric claims, or experiment strategy. | AGENTS block + `codex-gospel-research-audit` skill |
| `agent-supervision` | Codex delegates to external agents, cheaper worker lanes, local CLIs, or multi-agent execution systems. | AGENTS block + `codex-gospel-agent-supervision` skill |
| `domain-boundaries` | A repo has source-of-truth boundaries for schemas, parsers, physics, units, frames, data producers, or consumers. | AGENTS block + `codex-gospel-domain-boundaries` skill |
| `google-practices` | Work should apply public Google engineering and research-practice anchors without bloating the default prompt. | AGENTS block + `codex-gospel-google-practices` skill with references |

## Naming Rules

Overlay names describe the stable job they do, not a person, employer, or local project.

- `agent-discipline`, not a celebrity name: the durable concept is disciplined agent behavior. Karpathy-derived provenance lives in the skill references, not in the overlay id.
- `staff-engineering`, not an employer name: the durable concept is Staff+/principal engineering quality.
- `research-audit`, not a lab-specific label: the durable concept is evidence-first research judgment.
- `agent-supervision`, not one vendor or model: the durable concept is Codex owning final truth while workers do bounded labor.
- `domain-boundaries`, not one domain project: the durable concept is one source of truth per domain contract.
- `google-practices` is the exception that names a public source family on purpose: provenance is the feature, and the details live in references instead of the core prompt.

## Install Examples

Install core only:

```bash
scripts/install.sh --scope user
```

Install core plus selected overlays:

```bash
scripts/install.sh --scope user \
  --overlay agent-discipline \
  --overlay staff-engineering \
  --overlay research-audit
```

Install the full public-safe gospel:

```bash
scripts/install.sh --scope both --project-dir /path/to/project --all-overlays
```

List overlays:

```bash
scripts/install.sh --list-overlays
```

Verify selected overlays:

```bash
scripts/doctor.sh --project-dir /path/to/project --overlay staff-engineering
scripts/doctor.sh --project-dir /path/to/project --all-overlays
```

## Safety Model

Each overlay has:

- `manifest.env` for stable id, display name, and summary
- `AGENTS.md` for marker-bounded rule injection
- `skills/<skill-name>/SKILL.md` for Codex skill installation

The installer writes overlays into separate marker blocks:

```text
<!-- CODEX-GOSPEL:OVERLAY:<overlay-id>:START -->
...
<!-- CODEX-GOSPEL:OVERLAY:<overlay-id>:END -->
```

This keeps updates reversible and prevents overlay changes from rewriting unrelated user or project rules.
