# Checks whether the current directory contains all expected project files and returns a structured report with the 
# result.

# Files that should be present in the project.
let expected_paths = [
    "README.md"
    "LICENSE"
    "CODE_OF_CONDUCT.md"
]

# `ls` produces records describing the directory entries. We extract their paths with `get name`, then keep only the 
# final file name with `path basename`.
let present_paths = (
    ls
    | get name
    | path basename
)

# Keep only the expected files that are not present in the directory.
let missing_paths = (
    $expected_paths
    | where {|expected| $expected not-in $present_paths}
)

# Build a record that keeps the result as structured data. `complete` is `true` only when no expected files are 
# missing.
{
    project: "powerslave"
    complete: ($missing_paths | is-empty)
    missing: $missing_paths
}