# Context And Spec Discipline

Use this when the task is getting fuzzy, the agent is guessing, or the workspace needs to be easier for future agents.

## Context Bundle

A good agent context bundle contains:

- goal in one or two sentences
- relevant files and why they matter
- known commands and expected output
- current failure text or reproduction
- constraints and non-goals
- acceptance criteria
- risks that need human or reviewer attention

Leave out:

- unrelated logs
- old failed theories unless they prevent repeated mistakes
- huge pasted files when paths and search terms are enough
- style opinions not grounded in the repo

## Spec Quality

Before implementation, check:

- Can a reviewer tell what "done" means?
- Are important nouns defined in repo terms?
- Are inputs, outputs, units, formats, and ownership clear?
- Is the rollback path obvious?
- Is there a command or artifact that proves success?

## Agent-Readable Repos

Make future agent work easier by keeping:

- README or docs with exact setup and verification commands
- short architecture notes for non-obvious boundaries
- stable file names and directory ownership
- comments for invariants, not obvious code
- test names that explain behavior
- commit messages that preserve why, not only what

## Prompt Hygiene

- Give one concrete task per prompt when possible.
- Put constraints before implementation requests.
- Prefer "inspect then patch" over "rewrite this whole thing."
- If the agent starts drifting, shrink the task and re-anchor with files plus checks.
