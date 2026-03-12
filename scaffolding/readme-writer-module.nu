use ./readme-template-module.nu [new-readme]

def ensure-output-dir [dir: string] {
    if not ($dir | path exists) {
        error make {
            msg: "The output directory does not exist."
        }
    }

    if (($dir | path type) != "dir") {
        error make {
            msg: "The output path must be a directory."
        }
    }

    $dir
}

export def write-readme [
    name: string,
    --out-dir (-o): path = "."
] {
    let out_dir = ensure-output-dir $out_dir
    let readme_content = new-readme $name
    $readme_content | save ($out_dir | path join "README.md")
}
