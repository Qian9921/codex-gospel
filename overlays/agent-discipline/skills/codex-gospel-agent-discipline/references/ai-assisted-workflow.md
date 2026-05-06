# AI-Assisted Coding Workflow

Use this when Codex, another model, or a coding agent is helping produce a patch.

## The Tight Loop

1. Gather context.
   - Read the files that own the behavior.
   - Find tests, commands, and callers before editing.
   - Do not stuff unrelated context into the task.

2. State one target.
   - One bug, one behavior, one refactor, or one doc outcome.
   - If the target contains multiple outcomes, split or name the coupling.

3. Ask for approach before code when risk is real.
   - Good for architecture, migrations, public APIs, data contracts, security, and numerical code.
   - Skip for tiny obvious edits.

4. Make a small patch.
   - Avoid mixed semantic and mechanical churn.
   - Avoid "while here" cleanup.
   - Keep generated output separate when practical.

5. Inspect the diff.
   - Look for invented APIs, local-style drift, unrelated changes, weakened tests, broad exception handling, and hidden behavior changes.

6. Verify.
   - Reproduction command for a bug.
   - Focused unit/integration tests for behavior.
   - Lint/type/build checks when the changed surface requires them.

7. Record the result.
   - A final answer, commit, PR, or doc note should preserve what changed, why, and what proved it.

## Human Meaning

The bottleneck is no longer only writing code. It is specifying the right thing and verifying that the generated patch actually did it.

## Failure Modes

- Long chat context makes the agent follow stale instructions.
- Large diffs hide regressions.
- The agent satisfies the latest sentence while breaking earlier constraints.
- Tests are added but do not fail for the original bug.
- Refactors change behavior because no preservation test existed.
