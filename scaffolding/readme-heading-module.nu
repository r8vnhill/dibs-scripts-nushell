export def render-readme-heading [
    name: string,
    --verbose (-v)
] {
    if $verbose {
        print $"Preparing README heading for '($name)'"
    }

    $"# ($name)"
}
