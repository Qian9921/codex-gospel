# Companion Tools

Codex Gospel is the policy layer. Companion tools are optional execution engines that can work with the gospel without becoming part of the core install.

## Compatibility Contract

A companion tool should:

- stay optional; core gospel users must not need it;
- keep its own repository, installer, docs, tests, and release notes;
- make Codex the supervisor for intent, planning, review, verification, and final claims;
- treat worker output as candidate evidence or candidate patches, not truth;
- require explicit write scopes for mutating worker lanes;
- preserve reviewable artifacts such as plans, patches, logs, verification output, or evidence packs;
- avoid sending credentials, private transcripts, or unrelated local context into worker prompts;
- offer a doctor or capability check so Codex can verify the tool before relying on it.

## Current Companion

| Tool | Repository | Use |
| --- | --- | --- |
| `dsteam` | <https://github.com/Qian9921/dsteam> | Optional Codex-supervised external worker orchestration with guarded patch acceptance and evidence packing. |

Use `dsteam` when parallel worker lanes are worth the review overhead: bounded scouting, mechanical implementation, test running, log triage, or evidence packaging.

Do not use a companion tool when the task is faster or safer to do directly, when the write scope is unclear, when credentials are involved, or when Codex cannot independently review the result.

## Boundary With The Core Gospel

The core gospel says how Codex should think, verify, explain, and accept work. A companion tool may help execute bounded labor, but it must not weaken these rules:

- evidence before claims;
- small reversible changes;
- no worker self-certification;
- no fake completion;
- concise closeout with verification and residual risk.
