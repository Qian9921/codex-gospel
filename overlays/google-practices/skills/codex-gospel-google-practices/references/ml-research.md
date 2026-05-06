# Google-Practice ML And Research

Use this reference for ML systems, research plans, experiment review, data analysis, and model evaluation.

## Start Simple

Before adding model complexity:

- Define the user or research objective.
- Instrument metrics in the current system.
- Build a simple baseline or heuristic when possible.
- Verify the data pipeline end to end.
- Check that labels mean what the experiment thinks they mean.

In plain language: do not let a fancy model hide a broken pipe.

## Experiment Hygiene

For every serious result, record:

- hypothesis
- dataset version and filtering
- label source and label limitations
- train/validation/test split
- baseline
- metric definitions and confidence intervals when possible
- ablations or negative controls when practical
- random seeds and important environment details
- failure modes and qualitative examples

## Production ML Alarms

- Training-serving skew: features or preprocessing differ between train and serving.
- Data leakage: labels or future information are visible at training time.
- Metric mismatch: offline metric improves while user-visible behavior does not.
- Feedback loops: model output changes the future data it learns from.
- Silent drift: input distribution changes without monitoring.
- Complexity debt: added feature/model complexity slows future releases more than it improves results.

## Codex Behavior

- Separate fact, inference, assumption, and unknown.
- Do not recommend numeric thresholds without measurement, theory, or credible same-domain evidence.
- Prefer one discriminating experiment over a long list of vague experiments.
- Preserve negative results when they prevent repeated dead ends.

Sources: Rules of Machine Learning, Google AI Principles, Model Cards, Data Cards, and Codex Gospel research-audit rules.
