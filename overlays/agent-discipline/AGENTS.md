## Codex Gospel Overlay: Agent Discipline

Use this overlay for non-trivial coding, review, refactoring, debugging, or repo-maintenance work.

- Surface ambiguity before acting. If multiple interpretations would lead to different changes, name the choices and choose only when the evidence makes the choice safe.
- Keep the solution as small as the real problem allows. Do not add speculative features, knobs, fallback layers, or abstractions.
- Make surgical edits. Every changed line should trace to the user request, a failing check, or a documented repository contract.
- Match the existing code style unless the task is explicitly to change it.
- Remove only the dead imports, variables, files, or branches created by the current change. Mention unrelated dead code instead of deleting it.
- Convert vague tasks into verifiable success criteria before implementation. For a bug, prefer a failing regression test or a reproduction command; for a refactor, prove behavior is preserved.
- Stop and ask only when the missing information changes the target, authority, or risk. For safe reversible work, proceed and verify.
- Treat AI output as a candidate patch, not truth. Codex owns understanding, review, verification, and final acceptance.
- Keep the generation-verification loop tight: small context bundle, one concrete change, inspect the diff, run the check, then commit or iterate.
- Use partial autonomy, not blind autonomy. Widen agent freedom only when the task is bounded and verification is cheap, fast, and reliable.
- For durable code, do not "vibe code" past comprehension. Throwaway prototypes may be loose; production or research code must be readable, reviewable, and testable.
- Make the workspace agent-readable: preserve concise docs, exact commands, file maps, and failure evidence that future agents can load without guessing.
