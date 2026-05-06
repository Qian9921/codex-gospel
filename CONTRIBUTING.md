# Contributing

Codex Gospel changes affect agent behavior, so treat them like production-facing changes.

## Before Editing

Identify the surface you are changing:

- core prompt block in `templates/`
- installable skill in `codex/skills/`
- optional overlay in `overlays/`
- installer, doctor, smoke test, or CI behavior in `scripts/` and `.github/`
- human-readable docs in `docs/`

Keep the core generic. Project-specific rules belong in downstream project `AGENTS.md` files or clearly labeled examples.

## Change Rules

- Prefer small, reversible diffs.
- Do not add private paths, credentials, transcripts, memory dumps, or organization-only details.
- Keep optional execution engines outside the core repo and link them as companion tools.
- If a rule increases prompt size, decide whether it belongs in a skill reference instead of an always-visible block.
- Explain professional rules in normal language without losing technical precision.

## Required Checks

Run:

```bash
scripts/check-repo.sh
scripts/smoke-install.sh
```

When install or prompt visibility behavior changes, also run:

```bash
scripts/doctor.sh --project-dir . --all-overlays --package-mode
```

If `codex` is available, verify model-visible surfaces:

```bash
codex -C . debug prompt-input
```

Search that output for the relevant marker, skill name, or overlay name.

## Commit Notes

Commit messages should explain why the rule changed, what was rejected, what was tested, and what risk remains. A good commit is a decision record, not just a label on a diff.
