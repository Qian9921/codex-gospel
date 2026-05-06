---
name: codex-gospel-domain-boundaries
description: Use for systems with domain-owned truth such as schemas, parsers, physics, sensor data, coordinate frames, hardware logs, or cross-repo producer/consumer contracts. Enforces source-of-truth boundaries, unit/frame clarity, staged migrations, and boundary-first tests.
---

# Codex Gospel: Domain Boundaries

This skill keeps a project from growing two sources of truth for the same reality.

## Source Of Truth

Before writing code, identify who owns:

- Parsers and file formats.
- Physical constants and equations.
- Coordinate frames and units.
- Schemas, enums, and sentinel values.
- Labels, ground truth, and generated artifacts.
- Producer and consumer contracts.

If a consumer needs domain logic, prefer a thin adapter to the owner rather than a local reimplementation.

## Boundary Tests

When a module consumes another subsystem's output, first pin the boundary:

1. What format does it consume?
2. Who produces it?
3. Who else consumes it?
4. What breaks if a field, column, enum, unit, or frame changes?
5. Which test catches that break?

## Migrations

For broad contract changes, prefer staged migration:

1. Add the new field or API with compatibility.
2. Switch producers.
3. Migrate consumers in reviewable units.
4. Remove compatibility only after search proves no remaining consumer.

## Retroactive Gates

When adding a validation rule, audit existing files and data for the same bug pattern. Future protection does not fix old bad artifacts.
