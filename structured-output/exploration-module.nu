# Return a list of exploration records for pipelines that operate on tabular data. Each row keeps the same fields: 
# `world`, `hazard`, and `explorer`.
#
# Example:
#   let explorations = (get-explorations)
#   $explorations | where explorer == "Papika"
#   $explorations | get world
#
# This module also serves as a structured-output example for importing a command that returns a list of records.
export def get-explorations [] {
    [
        { world: "Desert of Time", hazard: "Temporal Distortion", explorer: "Cocona" }
        { world: "School Paradise", hazard: "Memory Loop", explorer: "Papika" }
        { world: "Candy Kingdom", hazard: "Illusion Collapse", explorer: "Yayaka" }
    ]
}
