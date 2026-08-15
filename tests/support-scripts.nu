# Behavioral tests for the `support-scripts` lesson companions.
#
# Covers `check-expected-files.nu`, `check-library-layout.nu`, and `album-title-module.nu`
# against real temporary directories and the real `resources/album.json` fixture.
#
# Run with: nu tests/support-scripts.nu

use std/assert
use ../support-scripts/album-title-module.nu *

const album_fixture_path = path self ../resources/album.json

def make-scratch-dir []: nothing -> string {
    mktemp -d
}

def touch-file [dir: string, name: string] {
    "" | save ($dir | path join $name)
}

def run-check-expected-files [dir: string]: nothing -> record {
    cd $dir
    source ../support-scripts/check-expected-files.nu
}

def run-check-library-layout [project: record]: nothing -> record {
    $project | run ../support-scripts/check-library-layout.nu
}

# given all expected files exist
# when check-expected-files.nu executes
# then complete is true and missing is empty
def test-all-expected-files-present [] {
    let dir = (make-scratch-dir)
    touch-file $dir "README.md"
    touch-file $dir "LICENSE"
    touch-file $dir "CODE_OF_CONDUCT.md"

    let result = (run-check-expected-files $dir)

    assert equal $result { project: "powerslave", complete: true, missing: [] }
    rm -rf $dir
}

# given one or more expected files are absent
# when check-expected-files.nu executes
# then missing contains exactly those expected paths
def test-some-expected-files-missing [] {
    let dir = (make-scratch-dir)
    touch-file $dir "README.md"

    let result = (run-check-expected-files $dir)

    assert equal $result {
        project: "powerslave"
        complete: false
        missing: ["LICENSE" "CODE_OF_CONDUCT.md"]
    }
    rm -rf $dir
}

# Exhaustive DDT over the finite presence/absence state space for the three expected files.
# Order of `missing` must follow the declaration order in check-expected-files.nu, not
# filesystem enumeration order.
def expected-files-truth-table []: nothing -> table {
    [
        [readme license coc expected_missing];
        [true  true  true  []]
        [true  true  false ["CODE_OF_CONDUCT.md"]]
        [true  false true  ["LICENSE"]]
        [true  false false ["LICENSE" "CODE_OF_CONDUCT.md"]]
        [false true  true  ["README.md"]]
        [false true  false ["README.md" "CODE_OF_CONDUCT.md"]]
        [false false true  ["README.md" "LICENSE"]]
        [false false false ["README.md" "LICENSE" "CODE_OF_CONDUCT.md"]]
    ]
}

# given every combination of README.md, LICENSE, and CODE_OF_CONDUCT.md presence
# when check-expected-files.nu executes
# then missing contains exactly the expected paths, in declaration order
def test-expected-files-truth-table [] {
    for case in (expected-files-truth-table) {
        let dir = (make-scratch-dir)
        if $case.readme { touch-file $dir "README.md" }
        if $case.license { touch-file $dir "LICENSE" }
        if $case.coc { touch-file $dir "CODE_OF_CONDUCT.md" }

        let result = (run-check-expected-files $dir)

        assert equal $result.missing $case.expected_missing
        assert equal $result.complete ($case.expected_missing | is-empty)
        rm -rf $dir
    }
}

# given a project with a known missing-file result
# when an unrelated file is added
# then the missing-file result does not change
def test-unrelated-files-do-not-affect-result [] {
    let dir = (make-scratch-dir)
    touch-file $dir "README.md"
    touch-file $dir "LICENSE"

    let baseline = (run-check-expected-files $dir)
    touch-file $dir "notes.txt"
    touch-file $dir "CHANGELOG.md"
    let after_unrelated_files = (run-check-expected-files $dir)

    assert equal $baseline $after_unrelated_files
    rm -rf $dir
}

# given a project-layout record
# when check-library-layout.nu executes through run
# then it produces the record shown by the lesson contract
def test-check-library-layout-through-run [] {
    let dir = (make-scratch-dir)
    touch-file $dir "README.md"
    touch-file $dir "LICENSE"

    let result = (run-check-library-layout { project_root: $dir })

    assert equal $result.complete false
    assert equal $result.missing ["CODE_OF_CONDUCT.md"]
    assert equal $result.project ($dir | path basename)
    rm -rf $dir
}

# given the canonical album fixture
# when it is piped through album-title
# then the result is "Powerslave"
def test-album-title-returns-the-title [] {
    let title = (open $album_fixture_path | album-title)

    assert equal $title "Powerslave"
}

# given an album record with additional unrelated fields
# when album-title executes
# then the returned title does not change
def test-album-title-ignores-unrelated-fields [] {
    let enriched = (open $album_fixture_path | insert label "EMI" | insert catalog_number "EMC 3546")

    assert equal ($enriched | album-title) "Powerslave"
}

test-all-expected-files-present
test-some-expected-files-missing
test-expected-files-truth-table
test-unrelated-files-do-not-affect-result
test-check-library-layout-through-run
test-album-title-returns-the-title
test-album-title-ignores-unrelated-fields

print "All support-scripts tests passed."
