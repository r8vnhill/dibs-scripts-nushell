# Checks whether a project follows the expected library layout.
#
# The command receives a record through pipeline input. The record must contain a `project_root` field with the path 
# to the project directory.
#
# It returns a record with:
# - `project`: the project directory name;
# - `complete`: whether every expected file is present;
# - `missing`: the expected files that were not found.
#
# Example:
#   {project_root: "."} | run check-library-layout.nu
def main []: record -> record {
    # Read the project directory from the pipeline input.
    let project_root = $in.project_root

    # Files required by the expected library layout.
    let expected_paths = [
        README.md
        LICENSE
        CODE_OF_CONDUCT.md
    ]

    # List the project directory and keep only the final name of each entry.
    let present_paths = (
        ls $project_root
        | get name
        | path basename
    )

    # Keep only the expected files that are not present in the project.
    let missing_paths = (
        $expected_paths
        | where {|expected| $expected not-in $present_paths}
    )

    # Return the result as structured data so another pipeline stage can continue processing it.
    {
        project: ($project_root | path basename)
        complete: ($missing_paths | is-empty)
        missing: $missing_paths
    }
}
