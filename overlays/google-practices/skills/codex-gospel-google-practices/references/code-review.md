# Google-Practice Code Review

Use this reference for reviews, CL planning, commit/PR descriptions, and patch acceptance.

## Core Standard

The review target is sustained code health. A change does not need to be perfect; it should clearly improve the system or at least not degrade maintainability, readability, correctness, and future work.

Operational rule for Codex:

- Approve or accept only when the change improves the local system under its own constraints.
- Distinguish mandatory issues from optional polish.
- Ground disagreement in facts, tests, style guides, existing code, or design principles.
- Keep consensus durable: record non-obvious decisions in the commit, PR, issue, or project docs.

## What To Look For

Check these before style polish:

- design: correct abstraction, ownership, dependency direction, rollback path
- functionality: user-visible behavior and edge cases
- complexity: avoid cleverness when straightforward code works
- tests: right tests exist, fail for the bug, and run at the right level
- naming: names expose concepts and units instead of implementation accidents
- comments: explain why, not what obvious code does
- consistency: local conventions beat personal preference

## Change Size

Prefer one coherent change that a reviewer can understand in one sitting. Related tests should usually be in the same change.

Review alarms:

- Around 100 changed lines can be a healthy small change.
- Around 400 non-generated changed lines should trigger split-or-justify.
- Around 1000 changed lines is usually too large unless generated, mechanical, or pre-approved.
- A smaller diff across many unrelated files can still be too large conceptually.

Split by:

- refactor before behavior
- generated or mechanical churn separate from semantic changes
- API/schema first, consumers second
- vertical slices when each slice is independently reviewable
- tests that lock existing behavior before risky cleanup

## CL Or Commit Description

A good description says:

- what changed
- why it changed
- what decision or constraint is not obvious from the diff
- what was tested
- what risk remains

Bad descriptions like "fix bug" or "update code" hide the reason future maintainers need.

Sources: Google Engineering Practices code review docs, small CLs, and CL descriptions.
