# Google-Practice Responsible AI

Use this reference for AI/ML features, dataset work, model evaluation, user-impact analysis, and research claims.

## Practical Checklist

Before making strong AI or data claims, ask:

- Who are the users, affected people, and operators?
- What could go wrong if the system is confidently wrong?
- What sensitive data, privacy, or security risk exists?
- Which groups or conditions could see worse performance?
- What human oversight exists?
- What monitoring catches drift, misuse, or degraded performance?
- What should a model card or data card disclose?

## Model Transparency

A useful model summary should include:

- intended use and out-of-scope use
- training/evaluation data at the right abstraction level
- metrics and known limitations
- fairness, safety, privacy, and security considerations
- operational monitoring and update expectations

## Dataset Transparency

A useful dataset summary should include:

- collection source and consent/rights assumptions
- preprocessing and filtering
- missingness and known bias
- label source and uncertainty
- recommended and discouraged uses
- retention, access, and privacy constraints

## Codex Application

- Do not turn responsible AI into a ceremonial paragraph.
- Tie each risk to an actual data path, model behavior, user workflow, or deployment decision.
- If evidence is missing, say exactly what measurement or review would reduce uncertainty.

Sources: Google AI Principles, People + AI Guidebook, Model Cards, and Data Cards Playbook.
