---
name: codex-gospel-agent-supervision
description: Use when Codex supervises external worker agents, cheaper model lanes, local CLIs, or multi-agent execution. Keeps Codex responsible for planning, review, verification, and final acceptance while workers do bounded dirty work.
---

# Codex Gospel: Agent Supervision

Use this skill when delegation can save time without lowering truth quality.

## Role Contract

- Codex owns the problem definition, task split, architecture, acceptance criteria, final review, and final claim.
- Workers own bounded execution only: scouting, mechanical edits, tests, log triage, candidate patches, or evidence packs.
- A worker report is not completion. Completion requires Codex review and verification.

## Worker Task Spec

Every delegated task should state:

1. Goal.
2. Allowed read scope.
3. Allowed write scope.
4. Required verification command or artifact.
5. What counts as failure.
6. What the worker must report back.

## Acceptance Gate

Before accepting worker output:

- Inspect changed files and diffstat.
- Check scope violations.
- Read verification output, not just status labels.
- Re-run or independently validate the smallest command that proves the claim.
- Reject read-only lanes that mutated files.
- Preserve provenance for accepted evidence.

## When Not To Delegate

Keep work local when the task is ambiguous, tightly coupled, security-sensitive, credential-sensitive, or faster to do directly than to specify and review.
