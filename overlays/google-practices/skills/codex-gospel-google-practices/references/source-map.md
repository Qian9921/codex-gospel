# Google Practices Source Map

This overlay distills public Google material into Codex-operational rules. It is not a full copy of those materials and should not be treated as Google policy for unrelated projects.

## Engineering And Code

- Google Style Guides: language-specific style anchors for Google-originated open-source projects.
  Source: https://google.github.io/styleguide/
- Google Engineering Practices: code review, reviewer standard, small CLs, CL descriptions, and review focus.
  Source: https://google.github.io/eng-practices/
- Software Engineering at Google, Testing Overview: test value, size/scope, determinism, test pyramid, and flake handling.
  Source: https://abseil.io/resources/swe-book/html/ch11.html
- API Improvement Proposals: public API design guidance for resource-oriented APIs and compatibility discipline.
  Source: https://google.aip.dev/
- Google SRE Book, Service Level Objectives: SLIs, SLOs, SLAs, and user-visible reliability measurement.
  Source: https://sre.google/sre-book/service-level-objectives/
- Google Developer Documentation Style Guide: reader-focused technical writing, style hierarchy, clarity, and consistency.
  Source: https://developers.google.com/style

## ML, Research, And Responsible AI

- Rules of Machine Learning: production ML sequencing, metrics, simple baselines, pipeline reliability, and train/serve skew.
  Source: https://developers.google.com/machine-learning/guides/rules-of-ml/
- Google AI Principles: responsible development, safety, security, privacy, human oversight, and evaluation through the lifecycle.
  Source: https://ai.google/principles/
- People + AI Guidebook: human-centered AI product and interaction design.
  Source: https://pair.withgoogle.com/guidebook/
- Model Cards: structured model transparency for design, evaluation, use, and limitations.
  Source: https://deepmind.google/models/model-cards/
- Data Cards Playbook: structured dataset documentation and responsible dataset communication.
  Source: https://pair.withgoogle.com/datacardsplaybook/

## How To Use This Map

- Use source families as evidence anchors, not as cargo-cult rules.
- Prefer the project's current formatter, test runner, API contract, and domain source of truth when they are explicit.
- Add a new reference file only when the detail is too bulky for `SKILL.md` but likely to be reused.
- Keep summaries short enough that Codex can load them without harming prompt performance.
