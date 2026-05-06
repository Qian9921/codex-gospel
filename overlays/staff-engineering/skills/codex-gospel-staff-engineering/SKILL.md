---
name: codex-gospel-staff-engineering
description: "Use when work needs Staff+/principal engineering quality with explicit problem framing, small reviewable changes, large-scale code-health review, high-assurance testing, strong CL descriptions, and durable engineering judgment."
---

# Codex Gospel: Staff Engineering

Use this skill when "works" is not enough. The bar is code health, reviewability, reversibility, and evidence that the changed behavior is actually protected.

## Operating Posture

- Start from the problem, not the patch.
- State constraints, interfaces, tradeoffs, and rollback path before broad implementation.
- Keep work in coherent review units.
- Prefer boring proven mechanisms over clever new machinery.
- Make reasoning visible enough for the next maintainer to audit.

## Change Packaging

Before a commit or PR-style closeout, check:

1. One coherent purpose.
2. Reviewer can tell what changed and why.
3. Mechanical edits are separated or clearly justified.
4. Verification commands are named, not waved at.
5. Risks and non-goals are explicit when they matter.

## Review Bar

Review design, correctness, readability, tests, naming, comments, maintainability, and code health. A passing test suite is evidence, not approval by itself.

Good review comments state the issue, impact, and desired direction. If a concern is subjective, say so. If evidence disproves the concern, update the position.

## High-Assurance Testing

Use the relevant minimum:

- Pure logic or data transform: focused unit tests plus edge cases.
- Bug fix: regression test plus targeted unit or integration check.
- Formula, metric, score, ranking, loss, or normalization: known-answer test plus tolerance-aware edge cases.
- Multi-step workflow: integration test through the real composition path.
- Thin wrapper: indirect integration coverage is acceptable when behavior is trivial.

Edge cases to consider: empty, zero, one-element, negative, extreme boundary, invalid or malformed input, NaN/inf, shape mismatch, precision tolerance, ordering, duplicates, and determinism.

## Closeout

State the result, verification, risk, and anything intentionally out of scope. Keep it short unless the evidence is complex enough to change the decision.
