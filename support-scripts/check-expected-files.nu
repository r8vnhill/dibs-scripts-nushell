let expected_paths = [
    "README.md"
    "LICENSE"
    "CODE_OF_CONDUCT.md"
]

let present_paths = (
    ls
    | get name
    | path basename
)

let missing_paths = (
    $expected_paths
    | where {|expected| $expected not-in $present_paths}
)

{
    project: "powerslave"
    complete: ($missing_paths | is-empty)
    missing: $missing_paths
}
