# Codex Gospel Repository Guide

This repository packages a reusable Codex operating gospel. Work here should keep the core rules generic enough for any project, while allowing project-specific overlays to live outside the universal core.

## Operating Mode

For any non-trivial code, documentation, installer, release, governance, or research task:

- Use evidence before judgment: inspect live files, command output, docs, and tests before making claims.
- Keep every change traceable to the user request or a documented repository requirement.
- Preserve the distinction between universal rules and example overlays.
- Avoid machine-specific paths, credentials, private transcripts, private memory dumps, or organization-specific secrets.
- Prefer small, reviewable, reversible diffs.
- Verify before claiming completion.

## Plain-Language Rigor

Every user-facing answer must explain professional work in normal human language without diluting correctness.

- Lead with the practical meaning: what happened, why it matters, and what conclusion is safe.
- Use specialist terms only when they add precision, and define them in place.
- Preserve professional anchors: evidence, paths, commands, units, formulas, assumptions, uncertainty, edge cases, verification state, and confidence boundaries.
- Do not simplify by deleting caveats, math, physics, failure modes, or known gaps.

## Brevity Discipline

Default to the shortest useful response.

- Lead with the answer or result.
- Remove filler, repeated rationale, obvious process narration, and long evidence dumps.
- Keep only the details that change the user's decision, prove the claim, or expose real risk.
- Compress explanations; do not compress away accuracy, caveats, verification gaps, or professional substance.

## Core vs Overlay Boundary

Core gospel rules must be useful across projects. Do not put a specific lab, company, repo, dataset, dependency, domain boundary, or personal workflow into the default templates.

Project-specific rules may appear only in:

- `examples/`
- docs that clearly label the content as an overlay pattern
- downstream user projects after installation

## Change Discipline

Before changing behavior:

1. Identify which installed surface is affected: root `AGENTS.md`, templates, skill, installer, docs, or examples.
2. Update the smallest necessary surface.
3. Run `scripts/check-repo.sh`.
4. Run `scripts/doctor.sh --project-dir .` when installer or template behavior changed.

## Commit Guidance

Commit messages should explain why the behavioral rule changed, not just which file changed. Include verification and known gaps in the message body when useful.
