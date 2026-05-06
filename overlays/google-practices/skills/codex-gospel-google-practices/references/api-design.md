# Google-Practice API Design

Use this reference for public interfaces, service contracts, schemas, SDKs, CLIs, and data/resource models.

## First Questions

- What resource or concept does the API expose?
- Who owns the source of truth?
- What must remain backward compatible?
- What migration path exists for existing callers?
- What is the rollback path?
- Which errors are user-actionable?
- What observability proves the API works in production?

## Resource And Contract Discipline

Public API design should make concepts stable and operations predictable:

- Prefer names that match the user's domain model.
- Avoid leaking internal implementation details into public names.
- Keep create/read/update/delete/list semantics consistent when the API is resource-like.
- Version when callers need compatibility guarantees.
- Make pagination, filtering, ordering, idempotency, and long-running operations explicit when relevant.
- Document error behavior and partial-success behavior.
- Do not add unused public surface just in case.

## Codex Application

Before editing an API:

1. Find existing callers and tests.
2. Identify producer/consumer ownership.
3. Decide whether the change is additive, breaking, or migration-only.
4. Add tests at the boundary, not only inside the implementation.
5. Update docs or examples in the same review unit when they are part of the contract.

Sources: Google API Improvement Proposals and Google developer documentation guidance.
