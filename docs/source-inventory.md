# Source Inventory

This package is a public-safe Codex-native version of a broader engineering and research gospel. It preserves the reusable discipline without copying private memories, local paths, transcripts, credentials, or project-only source dumps.

## Source Families

### Universal Core

Portable rules that apply almost everywhere:

- evidence before claims
- plain-language rigor
- concise answers without hiding truth
- small reversible edits
- verification before completion
- durable decision records
- project rules overriding global defaults

### Agent Discipline

Portable anti-failure rules for coding agents, inspired by public discussion of common LLM coding mistakes:

- surface assumptions and ambiguity
- prefer the smallest sufficient change
- avoid speculative abstractions
- avoid drive-by refactors
- define verifiable goals

The overlay is named `agent-discipline` because the stable concept is agent behavior, not any one person's name.

### Staff Engineering

Portable Staff+/principal engineering habits, grounded in public engineering-practice ideas and high-rigor review norms:

- optimize for code health
- split changes into reviewable units
- write useful change descriptions
- review design, correctness, readability, tests, naming, comments, and maintainability
- add high-assurance tests for logic, formulas, metrics, bugs, and workflows

The overlay is named `staff-engineering` because the stable concept is the operating bar, not a single company.

### Research Audit

Portable research-discipline lessons:

- inspect current state before recommending
- tag fact, inference, assumption, unknown, and risk
- use expected-vs-actual gap analysis
- include strengths in serious audits
- require real evidence for numeric recommendations
- reason about tails as well as means
- keep research decisions in durable project files

### Agent Supervision

Portable delegation discipline:

- Codex owns intent, planning, architecture, acceptance criteria, review, and final truth
- workers produce candidate evidence or patches only
- worker output must be inspected and verified before acceptance
- write scope, verification, artifacts, and stop conditions must be explicit

### Domain Boundaries

Portable source-of-truth discipline from multi-repo and scientific systems:

- one owner for physics, schemas, parsers, constants, labels, units, and frames
- consumers use thin adapters instead of reimplementing domain truth
- broad contract changes need staged migrations
- boundary-first tests protect producer-consumer contracts
- new gates should audit existing artifacts as well as future changes

## What Is Deliberately Not Included

- Private chat logs, transcripts, memories, or credential files.
- Machine-specific absolute paths.
- Repo-specific rules that reveal private infrastructure.
- Domain constants or data contracts that only make sense inside one closed system.

If a team needs project-specific rules, install the core and overlays first, then add a project `AGENTS.md` section below the marker blocks.
