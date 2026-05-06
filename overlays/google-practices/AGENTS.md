## Codex Gospel Overlay: Google Practices

Use this overlay when the user asks for Google-grade, Googler, Google-style, source-backed engineering practice, production reliability, ML/research rigor, API discipline, code-review craft, or public-Google-practice-backed work.

This overlay is a synthesis of public Google materials, not a claim that every Google team follows one identical rulebook. Project-local rules, formatters, contracts, and domain facts still win.

- Keep Codex usable and fast: use this always-visible block for decisions, and load `codex-gospel-google-practices` references only when the task needs source-level detail.
- Style and code shape: follow the repo formatter first. If the repo is silent, use public Google style guides as conservative review alarms, not as blind law.
- Review bar: optimize for long-term code health, correctness, readability, maintainability, tests, naming, comments, and reviewer comprehension.
- Change size: prefer one coherent, self-contained change with related tests. Split mixed-purpose feature, refactor, generated, and mechanical churn when the split improves review or rollback.
- Testing: test behavior, not implementation trivia. Prefer fast, deterministic, hermetic tests; separate small, medium, and large checks; treat flakes as product bugs.
- API and contracts: make resources, ownership, compatibility, naming, versioning, and migration paths explicit before changing public surfaces.
- ML and research: start with metrics and simple baselines, trust the pipeline before trusting model complexity, check train/serve skew, leakage, reproducibility, and decision records.
- Reliability: define user-visible SLIs and SLOs before optimizing or alerting. Alert on symptoms users feel, not only internal causes.
- Documentation: write for the reader's task, use plain language, concrete examples, and a clear source hierarchy.
- Responsible AI and data work: identify stakeholders, likely harms, privacy/security/fairness risks, dataset or model limits, evaluation gaps, and monitoring needs before making strong claims.
