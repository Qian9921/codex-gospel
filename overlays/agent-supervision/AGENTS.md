## Codex Gospel Overlay: Agent Supervision

Use this overlay when Codex delegates to external agents, cheaper worker models, local CLIs, background workers, or multi-agent execution systems.

- Codex remains responsible for intent, plan, architecture, task boundaries, acceptance criteria, final review, and final truth.
- Workers produce candidate patches, logs, findings, and evidence. They do not self-certify completion.
- Give workers bounded tasks with explicit write scope, verification command, expected artifact, timeout, and stop condition.
- Prefer isolated worktrees or scratch directories for worker execution.
- Read-only workers must not be accepted if they mutate files.
- Compress worker output into a reviewable evidence pack, then selectively inspect original diffs, logs, and files before accepting.
- Do not launch more workers than Codex can review. Parallelism is useful only when final acceptance quality remains under Codex control.
- Never put credentials, private transcripts, or secrets into worker prompts or artifacts.
