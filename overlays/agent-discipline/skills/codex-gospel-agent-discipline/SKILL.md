---
name: codex-gospel-agent-discipline
description: Use for non-trivial coding-agent work that needs assumption surfacing, simplicity, surgical edits, and goal-driven verification. This is the portable anti-overengineering and anti-drive-by overlay inspired by well-known LLM coding failure modes.
---

# Codex Gospel: Agent Discipline

This skill keeps agent work boring in the best way: clear target, small change, no hidden assumptions, no unnecessary machinery, and a verification loop that proves the claim.

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

## Red Flags

- "While I am here, I can clean this up."
- "This might be useful later."
- "The function is small, so it probably does not need a test."
- "Tests pass, so review is done."
- "The code explains itself, so intent does not need to be recorded."

## Completion

Report the practical result, the verification that proves it, and any remaining uncertainty. Keep the answer concise; do not dump the entire process unless the user asks or the risk requires it.
