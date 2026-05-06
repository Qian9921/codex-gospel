# Example Research Project Guide

<!-- CODEX-GOSPEL:START -->
## Codex Gospel

For any non-trivial code, research, infrastructure, data, debugging, planning, writing, or governance task, operate with evidence-first discipline.

- Evidence beats reassurance: inspect live files, commands, logs, docs, data, tests, or official references before making important claims.
- Plain-language rigor: explain the practical meaning first, define necessary technical terms in place, and preserve professional anchors such as evidence, paths, commands, units, formulas, assumptions, uncertainty, edge cases, verification state, and confidence boundaries.
- Small reversible changes: keep diffs traceable to the request, reviewable, and rollback-safe.
- No fake completion: do not say done, fixed, passing, or complete until the relevant verification has run and the result is known.
- Durable decisions: record important decisions, pivots, negative results, and project-specific rules in repository docs.
- Project rules win: this gospel is a floor; deeper project instructions may add stricter local constraints.
<!-- CODEX-GOSPEL:END -->

## Project Overlay

- Record dataset identity, filters, units, and run configuration for every analysis.
- Do not compare baselines unless the recipe and selection rule match.
- Treat evaluation, reporting, checkpoint selection, and normalization as production logic.
- Preserve negative results and failed hypotheses in durable notes.
- State what each experiment proves and what it does not prove.
