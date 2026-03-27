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
  - [Pipelines lesson walkthrough](#pipelines-lesson-walkthrough)
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
- A `pipelines/` lesson area with a local JSON dataset and commands that model
  filtering, projection, ordering, limiting, and lightweight transformation.

## Lessons at a glance

| Lesson       | Topic                                  | Resources |
| ------------ | -------------------------------------- | --------- |
| **Lesson 1** | Introduction to Nushell                | [Notes](https://dibs.ravenhill.cl/notes/software-libraries/scripting/nushell/) |
| **Lesson 2** | First script, modules, and validation  | [Notes](https://dibs.ravenhill.cl/notes/software-libraries/scripting/first-script/nushell/) • `scaffolding/readme-heading-module.nu`, `scaffolding/readme-template-module.nu`, `scaffolding/readme-writer-module.nu` |
| **Lesson 3** | Structured output                      | [Notes](https://dibs.ravenhill.cl/notes/software-libraries/scripting/structured-output/nushell/) • `structured-output/sighting-module.nu`, `structured-output/exploration-module.nu` |
| **Lesson 4** | Declarative pipelines                  | [Notes](https://dibs.ravenhill.cl/notes/software-libraries/scripting/pipelines/nushell/) • `resources/companions.json`, `pipelines/companion-module.nu` |

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
   ```nu
   use ./scaffolding/readme-template-module.nu [new-readme]
   new-readme 'My Project'
   ```

3. **Write a README to the current directory:**
   ```nu
   use ./scaffolding/readme-writer-module.nu [write-readme]
   write-readme 'My Project'
   ```

4. **Run the companion pipeline flow from the lesson:**
   ```nu
   use ./pipelines/companion-module.nu [get-quest-roster]
   get-quest-roster
   ```

## Key files and patterns

- `scaffolding/readme-heading-module.nu` builds one small, reusable piece of output.
- `scaffolding/readme-template-module.nu` composes content without touching the filesystem.
- `scaffolding/readme-writer-module.nu` performs validation and handles the side effect of saving the file.
- `structured-output/sighting-module.nu` returns a typed sighting record that can
  be queried by field instead of converted to plain text.
- `structured-output/exploration-module.nu` returns a list of records that can be
  filtered, projected, or displayed as a table without extra parsing.
- `resources/companions.json` is the JSON fixture used in the pipelines lesson.
- `pipelines/companion-module.nu` wraps the lesson flow in small composable commands
  that keep the data as records and tables, including extraction and renaming examples.

**Script conventions:**

- Prefer small exported commands with typed parameters.
- Keep content generation separate from file writes.
- Use explicit validation logic when type signatures are not enough.
- Favor composable commands over monolithic scripts.

## Pipelines lesson walkthrough

The lesson at <https://dibs.ravenhill.cl/notes/software-libraries/scripting/pipelines/nushell/>
compares Nushell and PowerShell when the shape of the data stays visible through the pipeline.
This repository now includes a local version of that workflow so students can run it directly.

**Core example from the lesson:**

```nu
open ./resources/companions.json |
  where on_the_quest |
  select name kind role |
  sort-by name |
  first 10
```

**Using the module instead of the raw pipeline:**

```nu
use ./pipelines/companion-module.nu *
get-quest-roster
get-quest-headings
get-quest-report
```

These examples align with the lesson's core operations:

- `where` for filtering rows.
- `select` for projecting only the relevant columns.
- `get` for extracting a concrete column as a simpler list.
- `sort-by` and `first` for ordering and limiting results.
- `each`, `update`, and `insert` for lightweight transformation while keeping structured output.
- `rename` for adapting the output schema between pipeline stages.

```nu
use ./pipelines/companion-module.nu *
get-quest-companions
get-quest-names
get-renamed-quest-roster
```

These variations mirror the lesson's current emphasis on keeping the same dataset and
changing only the last stages of the pipeline depending on whether you want another
table, a plain list, or a renamed shape for downstream processing.

## Development

Run commands directly with `nu -c` while the repository is still small and focused:

```powershell
nu -c "use ./scaffolding/readme-template-module.nu *; new-readme 'Sample App' --verbose"
```

When extending the repository, keep modules narrow in scope and place reusable commands under `scaffolding/` only while they remain part of the README-focused lesson sequence.

## Roadmap

- Expand the repository as new Nushell lessons are published in the DIBS notes.
- Add more examples around pipelines and script validation.
