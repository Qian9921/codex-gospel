---
name: codex-gospel-google-practices
description: "Use when Codex should apply public Google engineering, code-review, testing, API, SRE, documentation, ML/research, or responsible-AI practices without bloating the always-visible prompt."
---

# Codex Gospel: Google Practices

Use this skill when the user asks for Google-grade, Googler-style, Google source-backed, production/research rigor, or when a task needs public Google norms translated into local Codex behavior.

This skill is intentionally compact. Load only the reference file that matches the task. Do not paste all references into the answer unless the user asks for a full audit.

## Non-Negotiables

- Public Google sources are anchors, not override authority. Project-local code, tests, formatters, docs, data contracts, and user intent still win.
- Explain the rule in normal language first, then attach the professional anchor: source family, file path, test command, metric, tradeoff, or risk.
- Prefer a small verified change over a broad standard-compliance rewrite.
- Keep output concise: lead with the decision, then the evidence that changes the decision.
- Do not copy long passages from Google docs. Paraphrase and link the source.

## Reference Routing

Load only the relevant file:

- Source provenance or "what Google material did this come from": `references/source-map.md`
- Code review, CL size, CL descriptions, review comments: `references/code-review.md`
- Style guides, code shape, naming, comments, function/file alarms: `references/style-and-code-shape.md`
- Testing strategy, hermeticity, flakes, test sizes: `references/testing.md`
- Public API design, resources, versioning, compatibility: `references/api-design.md`
- ML systems, research experiments, metrics, baselines, skew: `references/ml-research.md`
- SRE, SLIs, SLOs, alerting, reliability tradeoffs: `references/reliability.md`
- Developer docs, plain-language technical writing: `references/documentation.md`
- Responsible AI, People + AI, model cards, data cards: `references/responsible-ai.md`

## Default Decision Rules

- If a change mixes behavior, refactor, generated output, formatting, or migration, split it unless one review unit is clearly safer.
- If a function, file, API, experiment, or model path is large, ask what concept it owns. Raw size is a signal; muddled responsibility is the real defect.
- If a test is slow, flaky, networked, time-dependent, order-dependent, or dependent on external state, lower its trust level until proven otherwise.
- If an ML result is better, ask whether the data, metric, label, serving path, or experiment design changed before crediting the model.
- If a reliability claim is made, ask which user-visible behavior it protects and how it is measured.
- If a responsible-AI claim is made, ask who can be harmed, who benefits, what the model/data card would disclose, and what monitoring catches drift.

## Closeout

Report what was applied, what was verified, what remains uncertain, and which public source families were used. Keep the closeout short unless the user requested a full audit.
