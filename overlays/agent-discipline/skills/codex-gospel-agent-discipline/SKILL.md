---
name: codex-gospel-agent-discipline
description: "Use for non-trivial coding-agent work that needs assumption surfacing, AI-assisted development control, simplicity, surgical edits, goal-driven verification, or protection against overengineering and drive-by changes."
---

# Codex Gospel: Agent Discipline

This skill keeps agent work boring in the best way: clear target, small change, no hidden assumptions, no unnecessary machinery, and a fast generation-verification loop that proves the claim.

## First Move

Before editing or recommending:

1. Name the user's actual target.
2. Name any ambiguity that would change the implementation.
3. Pick the smallest safe interpretation when the evidence supports it.
4. Define what would prove the task complete.

## Discipline Rules

- Do not silently choose among materially different interpretations.
- Do not add features, configuration, extensibility, fallback layers, or abstractions that were not requested.
- Do not refactor adjacent code just because you noticed it.
- Do not rewrite comments, formatting, or structure outside the changed surface.
- Do match local style even when another style is personally preferred.
- Do remove only the unused code created by your own change.
- Do use regression tests, targeted checks, or concrete reproduction commands when behavior changes.
- Treat model output as a draft. Understand it before accepting it.
- Keep autonomy proportional to verification. The more expensive or ambiguous the check, the smaller the agent step should be.
- Prefer ask/review/then-edit for risky work: get the approach clear before letting code change.

## AI-Assisted Workflow

Use this loop for code that matters:

1. Context: gather the smallest file/doc/test set that proves the current state.
2. Intent: write one concrete outcome and the stop condition.
3. Approach: decide the path before broad edits when risk is non-trivial.
4. Patch: make one coherent change.
5. Review: inspect the diff for unrelated churn, invented APIs, hidden behavior change, and local-style drift.
6. Verify: run the narrowest command that proves the claim, then broaden if the blast radius requires it.
7. Record: commit, doc, or final report should preserve the reason and evidence.

## Reference Routing

Load only what the task needs:

- Source provenance and why this overlay is not named after a person: `references/source-map.md`
- AI-assisted coding workflow and generation-verification loop: `references/ai-assisted-workflow.md`
- Context packaging, prompt hygiene, and agent-readable repos: `references/context-and-spec.md`
- Partial autonomy, autonomy sliders, and vibe-coding boundaries: `references/autonomy-and-verification.md`

## Red Flags

- "While I am here, I can clean this up."
- "This might be useful later."
- "The function is small, so it probably does not need a test."
- "Tests pass, so review is done."
- "The code explains itself, so intent does not need to be recorded."
- "The agent generated it, so it is probably fine."
- "It works in the demo, so the code does not matter."
- "The diff is too large to inspect, but the feature works."

## Completion

Report the practical result, the verification that proves it, and any remaining uncertainty. Keep the answer concise; do not dump the entire process unless the user asks or the risk requires it.
