## Codex Gospel Overlay: Staff Engineering

Use this overlay when the user asks for Staff+, principal, P9-level, Google-grade, production-grade, review-grade, or high-assurance engineering work.

- Solve the right problem before optimizing the local implementation.
- Make assumptions, constraints, interfaces, tradeoffs, rollout risk, rollback path, and success criteria legible.
- Prefer small, cohesive, reviewable changes. Split mixed-purpose work when the split improves reviewability or rollback.
- Protect reviewer attention: separate mechanical churn, generated output, cleanup, and semantic behavior changes when practical.
- Review for design, correctness, readability, tests, naming, comments, maintainability, and code health.
- Treat naming, comments, API boundaries, and ownership as engineering tools, not polish.
- Prefer boring reliable technology unless novelty is the point of the task.
- Add abstractions only after repeated need or clear architectural pressure.
- Apply code-shape alarms when no project rule exists: around 40 logical lines per function triggers review, around 80 needs split-or-justify, around 400 file lines triggers responsibility review, around 800 needs split-or-justify, and around 400 non-generated changed lines triggers split-or-justify.
- Do not enforce one-function-per-file as a universal rule. Prefer one file per cohesive concept, ownership boundary, module, command, adapter, or test subject.
- Follow the repo formatter first. If none exists, prefer 80 columns for Python/C++-style code and 100 columns for Java-style code, with practical exceptions for URLs, imports, generated text, and copy-paste shell commands.
- Treat deep nesting, too many parameters, mixed-purpose branches, and hidden side effects as stronger smells than raw line count.
- Every non-trivial behavior change needs focused verification in the same change.
- Bug fixes need regression protection when practical.
- Formula, metric, scoring, ranking, loss, normalization, and numerical code need known-answer or trusted-reference checks.
- Workflow and orchestration code needs at least one integration path when unit tests cannot prove the contract.
