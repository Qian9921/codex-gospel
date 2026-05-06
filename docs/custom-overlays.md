# Custom Overlays

Codex Gospel is intentionally generic. Real projects should add their own overlays.

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
