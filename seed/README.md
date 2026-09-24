# seed

The board's source, in the shape `furrow add --batch` reads: one task per
line in `tasks.ndjson`, one box per line in `epics.ndjson` (boxes are
created first with `furrow epic add` / `epic dep`; `--batch` resolves the
`epic` field by title).

Exported from the live board on 2026-09-24, keys = the ids of that day.
It is the working copy for rebuilding the board with its content fixed —
body cross-references as `[[key]]`, refs that exist, dep edges that match
the prose — after which the live board is regenerated from it and this
file, not the shards, is what a reader edits to change the story.
