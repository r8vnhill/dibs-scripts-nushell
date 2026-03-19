# DIBS Nushell Scripts — Course Companion

[![Nushell](https://img.shields.io/badge/Nushell-latest-4E9A06?logo=gnu-bash&logoColor=white)](https://www.nushell.sh/)
[![GitLab](https://img.shields.io/badge/GitLab-mirror-FC6D26?logo=gitlab&logoColor=white)](https://gitlab.com/r8vnhill/dibs-scripts-nushell)
[![GitHub](https://img.shields.io/badge/GitHub-mirror-181717?logo=github&logoColor=white)](https://github.com/r8vnhill/dibs-scripts-nushell)

Companion repository for the course "Diseno e Implementacion de Bibliotecas de Software (DIBS)".
The lessons are published in Spanish, while the source code and this repository are written in English for broader reach.

## Table of Contents

- [DIBS Nushell Scripts — Course Companion](#dibs-nushell-scripts--course-companion)
  - [Table of Contents](#table-of-contents)
  - [What you'll find in this repo](#what-youll-find-in-this-repo)
  - [Lessons at a glance](#lessons-at-a-glance)
  - [Requirements and setup](#requirements-and-setup)
  - [Quick start](#quick-start)
  - [Key files and patterns](#key-files-and-patterns)
  - [Development](#development)
  - [Roadmap](#roadmap)

## What you'll find in this repo

- A small Nushell workspace used to support introductory DIBS scripting lessons.
- Minimal examples that favor readability, typed signatures, and explicit responsibilities.
- A focused `scaffolding/` area for README generation examples:
  - `readme-heading-module.nu` renders a heading.
  - `readme-template-module.nu` builds README content as text.
  - `readme-writer-module.nu` validates an output directory and writes the file.
- A `structured-output/` lesson example showing how a Nushell command can return
  a typed record for downstream field access and inspection.

## Lessons at a glance

| Lesson       | Topic                                  | Resources |
| ------------ | -------------------------------------- | --------- |
| **Lesson 1** | Introduction to Nushell                | [Notes](https://dibs.ravenhill.cl/notes/software-libraries/scripting/nushell/) |
| **Lesson 2** | First script, modules, and validation  | [Notes](https://dibs.ravenhill.cl/notes/software-libraries/scripting/first-script/nushell/) • `scaffolding/readme-heading-module.nu`, `scaffolding/readme-template-module.nu`, `scaffolding/readme-writer-module.nu` |
| **Lesson 3** | Structured output                      | [Notes](https://dibs.ravenhill.cl/notes/software-libraries/scripting/structured-output/nushell/) • `structured-output/sighting-module.nu`, `structured-output/exploration-module.nu` |

## Requirements and setup

- **Nushell** installed and available as `nu`
- **VS Code** or another editor with Nushell support
- A local clone of this repository

## Quick start

1. **Clone and open the repository:**
   ```powershell
   git clone https://gitlab.com/r8vnhill/dibs-scripts-nushell.git
   cd dibs-scripts-nushell
   code .
   ```

2. **Load a module and preview a generated README:**
   ```powershell
   nu -c "use ./scaffolding/readme-template-module.nu [new-readme]; new-readme 'My Project'"
   ```

3. **Write a README to the current directory:**
   ```powershell
   nu -c "use ./scaffolding/readme-writer-module.nu [write-readme]; write-readme 'My Project'"
   ```

## Key files and patterns

- `scaffolding/readme-heading-module.nu` builds one small, reusable piece of output.
- `scaffolding/readme-template-module.nu` composes content without touching the filesystem.
- `scaffolding/readme-writer-module.nu` performs validation and handles the side effect of saving the file.
- `structured-output/sighting-module.nu` returns a typed sighting record that can
  be queried by field instead of converted to plain text.
- `structured-output/exploration-module.nu` returns a list of records that can be
  filtered, projected, or displayed as a table without extra parsing.

**Script conventions:**

- Prefer small exported commands with typed parameters.
- Keep content generation separate from file writes.
- Use explicit validation logic when type signatures are not enough.
- Favor composable commands over monolithic scripts.

## Development

Run commands directly with `nu -c` while the repository is still small and focused:

```powershell
nu -c "use ./scaffolding/readme-template-module.nu *; new-readme 'Sample App' --verbose"
```

When extending the repository, keep modules narrow in scope and place reusable commands under `scaffolding/` only while they remain part of the README-focused lesson sequence.

## Roadmap

- Expand the repository as new Nushell lessons are published in the DIBS notes.
- Add more examples around pipelines and script validation.
