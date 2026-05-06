# Audit Format

Use this format for serious analysis, code review, research evaluation, architecture review, and strategy work. Keep it concise, but do not drop evidence that changes the decision.

## Minimum Shape

```markdown
## Question
One sentence restating the actual question.

## Verdict
The practical conclusion in plain language.

## Strengths
- What is already correct, protected, or well-designed.

## Findings
| Priority | Finding | Evidence | Expected | Actual | Confidence |
| --- | --- | --- | --- | --- | --- |
| P0/P1/P2/P3 | ... | path:line, command, artifact, or source | ... | ... | High/Medium/Low |

## Inference
- What the evidence implies.
- Why weaker explanations were down-ranked.

## Unknowns
- What was not checked.
- What evidence would reduce uncertainty.

## Verification
- Commands, checks, files read, artifacts inspected.
- Skipped verification and why it was skipped.
```

## Priority Scale

- `P0`: blocker, safety issue, hard boundary violation, broken gate, or claim-invalidating error.
- `P1`: near-term risk, silent drift, missing protection around important behavior.
- `P2`: medium-term maintainability, naming, organization, or test-depth gap.
- `P3`: polish, documentation clarity, or optional improvement.

## Evidence Labels

- `Fact`: directly observed in file, command output, log, dataset, test, or source.
- `Inference`: reasoned from facts.
- `Assumption`: temporarily accepted to move forward.
- `Unknown`: not settled by current evidence.
- `Risk`: what can still go wrong.

You do not need to label every sentence. Label the claims that affect a decision.

## Numeric Recommendations

Do not recommend a number from habit or authority. Use one of:

- measurement from the current system or dataset
- theoretical bound or derivation
- credible same-domain paper, standard, or textbook

If no such evidence exists, say the value is unpinned and propose a measurement path.

## Mean Plus Tail

For reliability-sensitive numbers, averages are not enough. Ask what happens at the p95/p99, hard examples, malformed inputs, high-load cases, or adversarial regimes.

## Strengths Are Required For Serious Audits

Only listing gaps is not a good audit. It can make already-solid areas look suspect and wastes future effort. A good audit says both what should change and what should be preserved.
