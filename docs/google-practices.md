# Google Practices Overlay

The `google-practices` overlay adds a public Google source-backed layer to Codex Gospel.

It exists for two reasons:

1. Preserve the useful public Google engineering and research norms in a portable Codex form.
2. Keep local Codex fast and readable by putting only short decision rules in `AGENTS.md` and moving details into a skill with targeted references.

## What It Covers

- code review and CL size
- style guides and code-shape alarms
- test size, determinism, hermeticity, and flakes
- public API design
- ML system and research experiment discipline
- SRE-style SLIs and SLOs
- developer documentation style
- responsible AI, model cards, and data cards

## What It Does Not Do

- It does not copy Google documents into the prompt.
- It does not claim to be Google's internal policy.
- It does not override project formatters, local contracts, or domain source of truth.
- It does not make every Google preference universal law.

## Prompt-Performance Design

The overlay uses progressive disclosure:

- `overlays/google-practices/AGENTS.md` is short and always visible after installation.
- `codex-gospel-google-practices/SKILL.md` routes tasks to focused references.
- `references/*.md` files carry the reusable detail and source links.

This keeps the normal Codex prompt small while still making the deeper standard available when the task calls for it.

## Source Families

The overlay is grounded in public materials from:

- Google Style Guides
- Google Engineering Practices
- Software Engineering at Google
- Google API Improvement Proposals
- Google SRE Book
- Google Developer Documentation Style Guide
- Rules of Machine Learning
- Google AI Principles
- People + AI Guidebook
- Model Cards
- Data Cards Playbook

See `overlays/google-practices/skills/codex-gospel-google-practices/references/source-map.md` for the links and routing map.
