# Source Inventory

This package is a public-safe Codex-native version of a broader engineering and research gospel. It preserves the reusable discipline without copying private memories, local paths, transcripts, credentials, or project-only source dumps.

## Source Families

### Universal Core

Portable rules that apply almost everywhere:

- evidence before claims
- plain-language rigor
- concise answers without hiding truth
- small reversible edits
- verification before completion
- durable decision records
- project rules overriding global defaults

### Agent Discipline

Portable anti-failure rules for coding agents, inspired by public discussion of common LLM coding mistakes:

- surface assumptions and ambiguity
- prefer the smallest sufficient change
- avoid speculative abstractions
- avoid drive-by refactors
- define verifiable goals

The overlay is named `agent-discipline` because the stable concept is agent behavior, not any one person's name.

### Staff Engineering

Portable Staff+/principal engineering habits, grounded in public engineering-practice ideas and high-rigor review norms:

- optimize for code health
- split changes into reviewable units
- apply code-shape alarms for long functions, long files, deep nesting, parameter count, and oversized changes
- write useful change descriptions
- review design, correctness, readability, tests, naming, comments, and maintainability
- add high-assurance tests for logic, formulas, metrics, bugs, and workflows

The overlay is named `staff-engineering` because the stable concept is the operating bar, not a single company.

Public style-guide anchors used for the concrete code-shape defaults:

- [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html): 80-character line length and an about-40-line function-length review trigger.
- [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html): 80-character line length and small focused functions.
- [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html): 100-character column limit and wrapping guidance.

Those anchors are not copied as universal law. Project formatters and local style guides still win.

### Research Audit

Portable research-discipline lessons:

- inspect current state before recommending
- tag fact, inference, assumption, unknown, and risk
- use expected-vs-actual gap analysis
- include strengths in serious audits
- require real evidence for numeric recommendations
- reason about tails as well as means
- keep research decisions in durable project files

### Agent Supervision

Portable delegation discipline:

- Codex owns intent, planning, architecture, acceptance criteria, review, and final truth
- workers produce candidate evidence or patches only
- worker output must be inspected and verified before acceptance
- write scope, verification, artifacts, and stop conditions must be explicit

### Domain Boundaries

Portable source-of-truth discipline from multi-repo and scientific systems:

- one owner for physics, schemas, parsers, constants, labels, units, and frames
- consumers use thin adapters instead of reimplementing domain truth
- broad contract changes need staged migrations
- boundary-first tests protect producer-consumer contracts
- new gates should audit existing artifacts as well as future changes

### Google Practices

Public Google source-backed engineering and research practice, distilled for Codex use:

- code review should improve long-term code health while allowing progress
- small CLs are easier to review, test, merge, and roll back
- style guides are consistency anchors, but local project formatters and rules come first
- tests should be fast, deterministic, scoped, and trusted; flaky tests are defects
- API design should make resources, compatibility, migration, and user-facing errors explicit
- ML work should start with metrics, simple baselines, trustworthy pipelines, and skew/leakage checks
- reliability work should define user-visible SLIs and SLOs before alerting or optimization
- developer docs should be clear, reader-focused, and project-style-aware
- responsible AI work should document stakeholders, limits, risks, evaluation gaps, and monitoring

Public source anchors:

- [Google Style Guides](https://google.github.io/styleguide/)
- [Google Engineering Practices](https://google.github.io/eng-practices/)
- [Software Engineering at Google: Testing Overview](https://abseil.io/resources/swe-book/html/ch11.html)
- [Google API Improvement Proposals](https://google.aip.dev/)
- [Google SRE Book: Service Level Objectives](https://sre.google/sre-book/service-level-objectives/)
- [Google Developer Documentation Style Guide](https://developers.google.com/style)
- [Rules of Machine Learning](https://developers.google.com/machine-learning/guides/rules-of-ml/)
- [Google AI Principles](https://ai.google/principles/)
- [People + AI Guidebook](https://pair.withgoogle.com/guidebook/)
- [Model Cards](https://deepmind.google/models/model-cards/)
- [Data Cards Playbook](https://pair.withgoogle.com/datacardsplaybook/)

The overlay is named `google-practices` because the stable value is public-source provenance. It remains progressive-disclosure: only the short overlay block is always visible, while detailed guidance lives under the skill's `references/` folder.

## What Is Deliberately Not Included

- Private chat logs, transcripts, memories, or credential files.
- Machine-specific absolute paths.
- Repo-specific rules that reveal private infrastructure.
- Domain constants or data contracts that only make sense inside one closed system.

If a team needs project-specific rules, install the core and overlays first, then add a project `AGENTS.md` section below the marker blocks.
