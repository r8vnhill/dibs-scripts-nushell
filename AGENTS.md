# AI Agent Guide

Context and essential rules for agents working in this subproject.

## Decision Protocol

- Never make product, architecture, pedagogy, content-order, or style-policy decisions on your own.
- When a choice is required, present viable alternatives with their tradeoffs and wait for confirmation from the user.
- You may proceed with low-risk mechanical changes only when the existing repository pattern makes the decision unambiguous.
- If an instruction conflicts with project patterns, stop and ask before changing direction.

## Project Shape

- This is the Nushell companion repository for DIBS scripting lessons.
- `scaffolding/` contains README-generation modules split by responsibility.
- `structured-output/` demonstrates typed records and list-of-record outputs.
- `pipelines/` uses `resources/companions.json` to demonstrate filtering, projection, ordering, limiting, and transformation.

## Workflow

- Run examples directly with `nu -c`.
- Example validation command: `nu -c "use ./scaffolding/readme-template-module.nu *; new-readme 'Sample App' --verbose"`.
- Keep modules narrow and lesson-focused; avoid introducing a larger project framework unless requested.
- Do not modify changelogs unless the user explicitly asks for changelog updates.

## Code Conventions

- Prefer small exported commands with typed parameters.
- Keep content generation separate from filesystem writes.
- Use explicit validation when signatures are not enough.
- Favor composable commands and structured records/tables over plain text parsing.
- Preserve the local JSON fixture shape in `resources/companions.json` unless the lesson is being intentionally changed.
- Follow the inclusive documentation guidance from `../astro-website/src/pages/notes/software-libraries/api-design/documentation/index.astro`: prefer precise, clear, respectful terminology over loaded metaphors or unnecessarily punitive wording.
- Avoid terms such as `violation` or `violations` in new command names, messages, docs, tests, and record fields when a more descriptive alternative works. Prefer `finding`, `issue`, `not allowed`, `policy mismatch`, or a domain-specific name.
- Do not rename exported commands, record fields, or lesson-facing examples mechanically. If compatibility or lesson continuity is involved, propose aliases, deprecation notes, or a migration path first.
