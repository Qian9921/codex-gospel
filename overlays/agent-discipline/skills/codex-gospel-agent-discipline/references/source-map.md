# Agent Discipline Source Map

This overlay absorbed the useful parts of the original "Karpathy" idea family without making the skill depend on a person's name.

## Public Source Family

- Andrej Karpathy, "Software 2.0": software can be expressed not only as hand-written code, but also as learned parameters and data-shaped behavior.
  Source: https://karpathy.medium.com/software-2-0-a64152b37c35
- Andrej Karpathy, "Software Is Changing (Again)": LLMs make natural language a programming interface, but they remain fallible and need human-in-the-loop partial autonomy.
  Source: https://www.youtube.com/watch?v=LCEmiRjPEtQ
- Y Combinator/Rosetta transcript of "Software Is Changing (Again)": useful searchable transcript for the public talk; captions may contain minor errors, so treat as secondary to the video.
  Source: https://rosetta.to/u/ycombinator/andrej-karpathy-software-is-changing-again
- Public "vibe coding" discussion: natural-language coding can be great for exploration and throwaway prototypes, but durable work still needs review, tests, and comprehension.

## Stable Translation Into Codex Rules

- "LLMs are programmable in English" becomes: prompts/specs are part of the engineering surface and must be precise, reviewable, and versioned when important.
- "Generation-verification loop" becomes: small patch, inspect diff, run proof, iterate.
- "Partial autonomy" becomes: give agents only the freedom that the verification loop can safely absorb.
- "Vibe coding" becomes: acceptable for exploration when labeled as such; not acceptable as a substitute for professional review on durable code.
- "Build for agents" becomes: keep docs, commands, file maps, and failure evidence easy for future agents to load.

## Naming Decision

The overlay is named `agent-discipline` because the durable idea is disciplined AI-assisted development, not personal branding. Source provenance stays here so the origin is not lost.
