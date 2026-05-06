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

## Code Shape Standards

Project-local formatters, linters, and style guides win. If the repo does not define a standard, use these as review alarms:

- Function around 40 logical lines: consider whether a split would clarify the code.
- Function around 80 logical lines: split or give a concrete reason not to.
- Function around 150 logical lines: treat as a serious design smell unless it is generated, table-driven, parser-like, or otherwise intentionally shaped.
- File around 400 lines: check whether it still has one clear responsibility.
- File around 800 lines: split or document why it must stay together.
- File around 1200 lines: treat as a refactor candidate unless generated, vendor, fixture, or deliberately monolithic.
- More than 3 meaningful nesting levels: simplify with guards, helpers, or table-driven logic when it improves clarity.
- More than 5 parameters: check the API contract. More than 7 usually needs a clearer boundary or structured input.
- More than 400 non-generated changed lines: split the change or explain why one review unit is safer.

Do not enforce one-function-per-file as a universal rule. Prefer one file per cohesive concept, ownership boundary, module, command, adapter, model, or test subject. Keep private helpers near their only caller unless moving them improves reuse or comprehension.

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
