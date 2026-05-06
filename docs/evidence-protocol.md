# Evidence Protocol

Evidence protocol is the difference between a useful answer and a confident guess.

## Fact vs Inference

Use direct language:

- Fact: observed directly from a file, command, log, dataset, test, or source.
- Inference: reasoned from facts, but not directly observed.
- Assumption: accepted temporarily because the task needs progress.
- Risk: something that can still go wrong.

You do not need to label every sentence, but important claims should make their basis obvious.

## Minimum Evidence By Task Type

Code change:

- inspect relevant code
- edit the smallest necessary surface
- run the smallest verification that proves the changed behavior
- report skipped verification with reasons

Bug investigation:

- reproduce or inspect the reported failure
- identify expected vs actual behavior
- isolate root cause before fixing
- verify the fix addresses the cause, not only the symptom

Research/data analysis:

- record dataset identity and scope
- preserve units and filtering criteria
- distinguish raw observations from derived summaries
- state what the analysis does and does not prove

Infrastructure/config:

- inspect effective live configuration
- identify source of configuration
- avoid system-wide changes unless explicitly authorized
- verify the new config is active

Planning:

- define success criteria
- list constraints
- identify dependencies and irreversible decisions
- choose the smallest safe first step

## Numeric Claims

Numeric recommendations require one of:

- measurement from the current system or dataset
- a theoretical bound or derivation
- a credible same-domain reference

Do not use another agent's confidence, a commit message, or "looks reasonable" as evidence for a numeric claim.
