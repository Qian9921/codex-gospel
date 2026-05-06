# Google-Practice Style And Code Shape

Use this reference when a repo lacks explicit local style or when code shape is blocking readability.

## Authority Order

1. Project formatter, linter, type checker, and local AGENTS rules.
2. Existing local style in nearby code.
3. Public Google style guides for the relevant language.
4. General readability and maintainability judgment.

Do not override a working repo formatter just to mimic Google defaults.

## Review Alarms

These are alarms, not absolute laws:

- Python and C++ style families: 80 columns unless local tools say otherwise.
- Java style family: 100 columns unless local tools say otherwise.
- Python functions around 40 logical lines deserve a readability check.
- Around 80 logical lines in one function needs split-or-justify.
- Around 150 logical lines is usually a serious smell unless parser-like, generated, table-driven, or intentionally cohesive.
- Around 400 file lines triggers a one-responsibility check.
- Around 800 file lines needs split-or-justify.
- Around 1200 file lines is a refactor candidate unless generated/vendor/fixture.
- More than 3 meaningful nesting levels: prefer guards, extraction, table-driven logic, or clearer branching.
- More than 5 parameters: check whether the API is hiding a concept. More than 7 usually needs a structured input or boundary rethink.

## Human Meaning

- One function should usually do one named thing at one abstraction level.
- One file should usually own one cohesive concept, adapter, command, module, model, or test subject.
- Do not enforce one-function-per-file. That scatters context and fights most language ecosystems.
- Keep private helpers near the only caller unless moving them improves comprehension or reuse.
- Prefer names that reveal domain meaning, units, coordinate frames, side effects, and lifecycle.
- Comments should preserve why, invariants, contracts, caveats, and source links. Avoid narrating obvious statements.

Sources: Google Style Guides, especially Python, C++, Java, and general Google Engineering Practices readability norms.
