# Custom Overlays

Codex Gospel is intentionally generic. Real projects should add their own overlays.

For bundled public-safe overlays, see [overlay-system.md](overlay-system.md). This page explains how downstream projects should add their own local rules after installing the core or bundled overlays.

## What Belongs In Core

Core rules should apply almost everywhere:

- evidence before claims
- plain-language rigor
- small reversible changes
- verification before completion
- durable decisions
- no secrets or private transcripts

## What Belongs In A Project Overlay

Project overlays should describe local truth:

- build and test commands
- language versions
- architecture boundaries
- data-governance rules
- domain-specific units and conventions
- release process
- deployment restrictions
- security rules
- research artifact policy

## Where To Put Project Rules

Keep public-safe bundled overlays in the marker blocks created by `scripts/install.sh`. Put private, local, or domain-specific rules below those blocks in the project `AGENTS.md`, or in project docs referenced by that `AGENTS.md`.

Do not fork the universal core just to add a project rule. The universal core is the floor; project overlays are the local truth.

## Overlay Template

```markdown
## Project Overlay

- Authoritative docs:
  - `docs/architecture.md`
  - `docs/testing.md`
- Build:
  - `npm test`
  - `npm run lint`
- Boundaries:
  - Frontend owns UI state.
  - Backend owns persistence and authorization.
- Verification floor:
  - Run tests before claiming completion.
  - For UI changes, inspect screenshots at desktop and mobile widths.
```

The universal gospel should never guess these details. The project should state them.
