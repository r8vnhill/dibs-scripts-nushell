## Pipeline-oriented helpers backed by the shared companion fixture.
#
# This module is designed as a small, reusable reference for common pipeline transformations in Nushell. The commands 
# intentionally demonstrate how to:
#
# - load structured data from a shared fixture;
# - filter records without losing table shape;
# - project columns for narrower downstream views;
# - reshape output into lists or display-oriented strings;
# - rename columns to adapt a schema for other consumers; and
# - derive enriched views from existing fields.
#
# Unless a command explicitly states that it returns a plain list of values or strings, it preserves structured tabular 
# output so the result can continue flowing through later pipeline stages.
#
# The fixture path is resolved relative to this module so the commands remain portable when imported from other 
# locations.
const default_companions_path = path self ../resources/companions.json

## Load the shared companion fixture.
#
# Returns the full dataset as a table-like list of records read from `companions.json`. This is the canonical entry 
# point for the rest of the module, so all higher-level helpers stay aligned with the same source data and schema.
#
# Use this command when you want the complete fixture without any filtering, projection, or reshaping.
export def load-companions [] {
    open $default_companions_path
}

## Return only companions who are currently on the quest.
#
# This helper filters the full fixture to records whose `on_the_quest` field is truthy. It preserves the original 
# record structure so callers can continue selecting, renaming, sorting, or enriching columns in later pipeline stages.
#
# Use this as the main filtered base when building quest-specific views.
export def get-quest-companions [] {
    load-companions | where on_the_quest
}

## Return a compact quest roster ordered by companion name.
#
# The resulting table keeps only the `name`, `kind`, and `role` columns, making it suitable for concise summaries, 
# previews, or examples where the full fixture would be unnecessarily wide.
#
# The output is sorted by `name` to keep the result deterministic and easier to compare in notes, tests, and examples. 
# The `limit` parameter truncates the sorted result to the requested number of rows.
export def get-quest-roster [
    # Maximum number of rows to keep from the sorted roster.
    --limit (-l): int = 10
] {
    get-quest-companions |
        select name kind role |
        sort-by name |
        first $limit
}

## Return quest companions as display-oriented heading strings.
#
# Unlike most commands in this module, this helper intentionally converts structured records into a plain list of 
# formatted strings. Each entry follows the pattern:
#
#   "<name> the <kind>"
#
# This is useful for headings, menus, lightweight reports, or examples where a textual label is more useful than a 
# table.
export def get-quest-headings [] {
    get-quest-companions |
        sort-by name |
        each {|companion| $"($companion.name) the ($companion.kind)" }
}

## Return the ordered companion names as a plain list.
#
# This helper is a narrower projection than `get-quest-roster`: it keeps only the `name` field and returns it as a 
# value list instead of a table. The result is sorted by `name` so callers receive a stable ordering.
#
# Use this when another command expects a list of scalar values rather than a record-based structure.
export def get-quest-names [] {
    get-quest-companions |
        sort-by name |
        get name
}

## Return the quest roster with an adapted schema.
#
# This helper selects the `name` and `role` columns and then renames them to `companion` and `quest_role`. It is useful 
# when the original fixture names are too domain-specific or when another consumer expects a different schema.
#
# The result remains a structured table, making it suitable for further transformations or export.
export def get-renamed-quest-roster [] {
    get-quest-companions |
        sort-by name |
        select name role |
        rename companion quest_role
}

## Return an enriched quest report with normalized and derived fields.
#
# This helper produces a presentation-ready table by applying two transformations to the quest companions:
#
# - `role` is normalized to uppercase to make the values visually consistent in reports or examples;
# - `summary` is derived from existing fields to provide a compact, human-readable description.
#
# The final output is sorted by `name` and reduced to the columns most relevant for reporting: `name`, `kind`, `role`, 
# and `summary`.
export def get-quest-report [] {
    get-quest-companions |
        update role {|companion| $companion.role | str upcase } |
        insert summary {|companion| $"($companion.name) from ($companion.homeland)" } |
        sort-by name |
        select name kind role summary
}
