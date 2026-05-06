## Codex Gospel Overlay: Domain Boundaries

Use this overlay for multi-repo systems, data pipelines, robotics, mapping, GNSS/INS, hardware logs, scientific software, schema migrations, or any project with a strong source of truth.

- Identify the owner for each domain truth: physics, schema, parser, constants, coordinate frame, unit convention, labels, and generated artifacts.
- Do not reimplement a domain truth in a consumer repo. Prefer a thin adapter to the owner.
- Make producer and consumer contracts explicit. If a schema or output format changes, update both sides or provide a staged compatibility path.
- Encode units and frames in names or schemas where mistakes would be expensive.
- Treat sentinel values, unknown enum variants, clock domains, and coordinate frames as validation concerns, not comments.
- Boundary-first testing comes before internal convenience code when a module consumes another subsystem's output.
- Generated or runtime artifacts belong in documented output directories and should not pollute source trees.
- When adding a new gate, audit existing data and code for the same violation. A gate that only protects the future can leave old corruption alive.
