# Security

Codex Gospel is a prompt and workflow package. The main security risk is accidentally publishing private context or weakening agent review boundaries.

## Do Not Commit

- credentials, tokens, keys, cookies, or session files
- private transcripts, private memories, or local cache dumps
- machine-specific absolute paths
- organization-only infrastructure details
- worker artifacts that include unrelated repository context

## Reporting A Problem

If you find a leak or unsafe rule in this repository:

1. Stop reusing the leaked content.
2. Open a private report through the repository owner if available.
3. Include the path, commit, and why the content is sensitive.
4. Do not paste secrets into public issues or pull requests.

## Maintainer Response

For sensitive leaks, maintainers should:

- remove the content from the current tree;
- rotate any exposed credential outside this repository;
- check whether examples, docs, overlays, or skills copied the same content;
- add a regression check when a simple pattern can catch repeats;
- record the decision without repeating the sensitive material.

## Agent Safety Boundary

Companion tools and worker agents must not receive credentials or unrelated private context. Codex remains responsible for final review, verification, and public claims.
