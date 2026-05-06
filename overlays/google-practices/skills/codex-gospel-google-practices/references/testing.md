# Google-Practice Testing

Use this reference for test strategy, flake triage, CI gates, and verification planning.

## Testing Purpose

Tests are executable evidence. They help maintainers trust the code, review changes faster, and preserve behavior when requirements move.

For Codex:

- Test the behavior the user cares about.
- Prefer the smallest test that proves the contract.
- Add regression tests for bug fixes when practical.
- Do not claim completion before reading the test output.

## Size And Scope

Google's public testing material emphasizes speed and determinism. Translate that into:

- Small tests: fast, deterministic, usually single process, no network, no sleeps, no real external services.
- Medium tests: multiple components or processes, still controlled and reasonably deterministic.
- Large tests: full-system or end-to-end checks, used sparingly because they are slower and more fragile.

Scope guidance:

- Most business logic should be covered by narrow tests.
- Integration tests protect component boundaries.
- End-to-end tests protect critical workflows and configuration, not every branch.

## Flakes

Treat flaky tests as real defects. Common causes:

- wall-clock timing and sleeps
- network or external services
- order dependence
- shared mutable state
- random seeds
- concurrency races
- resource leaks
- test pollution across cases

Fix flakes by removing nondeterminism or isolating state, not by rerunning until green.

## Verification Matrix

- Pure function: unit tests with boundary cases.
- Parser/schema/adapter: golden inputs, malformed inputs, compatibility cases.
- Numerical code: known-answer tests, tolerances, NaN/inf/shape cases.
- Bug fix: red test or reproduction first, then green verification.
- Workflow/orchestration: integration path through real composition.
- UI or docs: visual/manual review plus link/build check when available.

Sources: Software Engineering at Google, Testing Overview, and Google Engineering Practices small CL guidance.
