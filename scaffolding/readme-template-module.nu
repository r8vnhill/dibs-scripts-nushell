use ./readme-heading-module.nu [render-readme-heading]

export def new-readme [
    name: string
    --verbose (-v)
] {

    if $verbose {
        print $"Creating README.md for project '($name)'"
    }

    let timestamp = (date now | format date "%Y-%m-%d %H:%M:%S")

    let heading = if $verbose {
        render-readme-heading $name --verbose
    } else {
        render-readme-heading $name
    }

    $"($heading)

Project initialized on ($timestamp).

Learn more about READMEs at https://www.makeareadme.com/.
"
}
