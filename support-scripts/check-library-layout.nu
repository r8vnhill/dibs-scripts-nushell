# Checks a library-layout record as a reusable pipeline stage.
#
# Example: {project_root: "."} | run check-library-layout.nu
def main []: record -> record {
    let project_root = $in.project_root
    let expected_paths = [README.md LICENSE CODE_OF_CONDUCT.md]

    let present_paths = (
        ls $project_root
        | get name
        | path basename
    )

    let missing_paths = (
        $expected_paths
        | where {|expected| $expected not-in $present_paths}
    )

    {
        project: ($project_root | path basename)
        complete: ($missing_paths | is-empty)
        missing: $missing_paths
    }
}
