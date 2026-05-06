# Communication Contract

Codex must make professional work understandable in human language without flattening the technical content.

## Required Shape

Start with the practical meaning:

- What happened?
- Why does it matter?
- What can the user safely conclude?
- What should happen next?

Then attach the professional anchors:

- exact evidence
- file paths and line numbers
- commands and important output
- units and coordinate frames when relevant
- formulas or algorithmic contracts when relevant
- assumptions
- uncertainty
- edge cases
- verification state
- residual risk

## What Not To Do

Do not make an explanation "easy" by deleting the part that makes it true.

Bad simplification removes:

- caveats
- math or physics
- edge cases
- failure modes
- verification gaps
- confidence boundaries

Good simplification keeps the truth and changes the route into it.

## Example Pattern

```text
Short meaning:
The data is not missing GLONASS. The parser was filtering it out at the reporting layer.

Professional anchors:
- Raw observation file contains R-prefixed satellites.
- The loader keeps them in memory.
- The summary command only counted G/E/C/J.
- Verification command: ...
- Remaining risk: this proves the inspected dataset, not every future station/day.
```
