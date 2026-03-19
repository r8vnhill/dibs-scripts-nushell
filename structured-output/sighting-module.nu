# Create a normalized troll sighting record for pipelines and downstream field access. The command is side-effect free 
# and always returns the same shape: `location`, `troll_type`, and `sighted_at`.
#
# `troll_type` defaults to `"unknown"` so callers can omit it without changing the output schema.
#
# Example:
#   new-sighting --location "Jotunheimen Mountains" --sighted_at (date now)
#   new-sighting --location "Jotunheimen Mountains" --sighted_at (date now) --troll_type "Mountain Troll"
#
# This module also serves as the structured-output example for the accompanying lesson.
export def new-sighting [
    --location: string,
    --sighted_at: datetime
    --troll_type: string = "unknown",
] {
    {
        location: $location
        troll_type: $troll_type
        sighted_at: $sighted_at
    }
}
