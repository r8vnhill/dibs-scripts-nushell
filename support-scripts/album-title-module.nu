# Commands used by the reusable support-scripts lesson.

# Returns the title stored in an album record.
#
# Example: open resources/album.json | album-title
export def album-title []: record -> string {
    get title
}
