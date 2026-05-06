# Autonomy And Verification

Use this when deciding how much freedom to give an AI coding agent or whether a "vibe coding" style is acceptable.

## Autonomy Slider

Choose the lowest autonomy that still gets useful speed:

- Level 0: Ask only. Use for design, risk review, unfamiliar systems, and irreversible choices.
- Level 1: Suggest patch. Human/Codex applies after review.
- Level 2: Patch bounded files. Agent edits within a clear write scope.
- Level 3: Patch plus tests. Agent can update tests and run checks, but Codex reviews diff and output.
- Level 4: Broad autonomous work. Use only when scope is isolated, rollback is clean, and verification is strong.

Do not use high autonomy when:

- the repo contract is unknown
- data, credentials, production systems, or destructive commands are involved
- the diff would be too large to review
- tests are missing or flaky
- the task changes public APIs, schemas, math, security, or research conclusions

## Vibe Coding Boundary

Loose natural-language coding is useful for:

- throwaway prototypes
- personal demos
- exploring whether an idea has shape
- UI sketches that will be rebuilt

It is not enough for:

- shared libraries
- production code
- research claims
- migrations
- security-sensitive logic
- data contracts
- anything users or teammates will rely on

For durable work, convert the vibe into engineering:

1. freeze the intended behavior
2. inspect the generated code
3. delete accidental complexity
4. add tests or reproduction commands
5. record constraints and known gaps

## Verification Cost Rule

If verification is cheap and precise, agent steps can be larger.

If verification is expensive, fuzzy, or manual, agent steps must be smaller.

The agent's confidence is not evidence. The proof is the diff plus the check.
