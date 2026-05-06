# Engineering Standards

These standards turn the gospel from good intentions into reviewable engineering behavior. They are defaults, not a replacement for a repository's own formatter, linter, architecture guide, or build rules.

## Priority Order

When standards conflict, use this order:

1. Project-local `AGENTS.md`, formatter, linter, type checker, and tests.
2. Language ecosystem standard already used by the repo.
3. Codex Gospel defaults in this document.
4. Agent preference, only when none of the above exists.

Do not "fix" a repo to match this document when the repo already has a clear local standard.

## Code Shape Defaults

Use these as review triggers:

| Surface | Gospel Default | Meaning |
| --- | --- | --- |
| Line length | Follow the project formatter. If absent, prefer 80 for Python/C++-style code and 100 for Java-style code. | Long lines are allowed for URLs, imports, generated text, shell commands meant for copy-paste, and literals that become less readable when split. |
| Function length | Around 40 logical lines is the first review trigger. Around 80 lines needs a split or explicit reason. Around 150 lines is a serious design smell unless generated, table-driven, or parser-like code. | The question is not "can it run"; the question is whether the next maintainer can safely change it. |
| File length | Around 400 lines: check whether the file still has one clear responsibility. Around 800 lines: split or document why it must stay together. Around 1200 lines: treat as a refactor candidate unless generated/vendor/test-fixture code. | File length is weaker than responsibility. A cohesive 700-line parser can be better than ten tiny files that must always be read together. |
| Nesting depth | More than 3 meaningful levels should trigger simplification. | Prefer early returns, guard clauses, helper extraction, or table-driven structure when it improves clarity. |
| Function parameters | More than 5 parameters should trigger a contract check. More than 7 usually needs an options object, data class, or clearer API boundary. | Do not hide unrelated inputs inside a bag just to reduce the count. |
| Branch count | More than 5 business branches in one function should trigger decomposition or table-driven logic. | A switch over a closed enum can be fine; mixed policy branches are riskier. |
| Changed lines | More than about 400 non-generated changed lines should trigger split-or-justify. | Separate mechanical formatting, generated output, cleanup, and semantic behavior changes when practical. |

These numbers are not magic. They are alarms. If an alarm fires, either improve the shape or state why the current shape is the safer choice.

## One Function Per File Is Not A Gospel Rule

"One function per file" is sometimes useful for plugin registries, command handlers, generated entry points, or very small functional pipelines. It is not a universal engineering standard.

Prefer:

- one file per cohesive concept, ownership boundary, module, command, model, adapter, or test subject;
- one public abstraction per file when that makes discovery and review easier;
- private helpers near the code that uses them when they are not reused elsewhere;
- split files when different parts change for different reasons, need different tests, or have different owners.

Do not split a file just to satisfy a count if every reader now has to bounce through five files to understand one behavior.

## Review Checklist

Before accepting non-trivial code, check:

1. Does each file still have one obvious reason to exist?
2. Does each function have one main job?
3. Are inputs, outputs, units, frames, errors, and side effects explicit?
4. Is the happy path readable without mentally simulating every edge case?
5. Are edge cases pinned by tests or clear validation?
6. Are comments explaining intent, invariants, domain rules, or traps instead of narrating syntax?
7. Did the change add knobs, fallback paths, or abstractions before a real second use case?
8. Is generated or mechanical churn separated from semantic behavior?
9. Can the change be reverted without taking unrelated work with it?

## Comment Standards

Good comments explain:

- why the code exists;
- what invariant must stay true;
- what unit, frame, clock, schema, or external contract is being preserved;
- why an obvious-looking alternative is wrong;
- what edge case a future modifier must not break.

Weak comments narrate the line below them. Delete or rewrite those.

## Testing Standards

Use the smallest test that proves the contract:

- Bug fix: reproduction or regression test.
- Pure transform: unit test with representative and edge inputs.
- Formula, score, loss, ranking, normalization, or metric: known-answer or trusted-reference test with tolerance.
- Boundary adapter: producer/consumer contract test.
- Workflow/orchestration: one integration path through the real composition.
- UI or visual behavior: screenshot or browser check when layout or interaction can break.

Passing tests are evidence. They are not a substitute for review.

## External Anchors

These defaults are inspired by public style-guide anchors, but this repository does not claim official endorsement by those projects.

- [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html): line length and function-length review trigger.
- [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html): line length and small focused functions.
- [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html): Java column limit and wrapping guidance.

When a project uses a formatter such as Black, Pyink, clang-format, google-java-format, rustfmt, gofmt, Prettier, or a repo-specific config, the formatter is the local source of truth.
