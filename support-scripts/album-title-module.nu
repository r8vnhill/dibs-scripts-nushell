# Commands used by the reusable support-scripts lesson.

# Extracts the album title from a record received through pipeline input.
#
# Expects a record containing a `title` field whose value is a string. Returns that title as a string.
#
# Example:
#   open resources/album.json | album-title
export def album-title []: record -> string {
    get title
}