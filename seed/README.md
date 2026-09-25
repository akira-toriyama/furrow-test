# seed

The board's source, in the shape `furrow add --batch` reads: one task per
line in `tasks.ndjson`, one box per line in `epics.ndjson` (boxes are
created first with `furrow epic add` / `epic dep`; `--batch` resolves the
`epic` field by title). Keys are readable slugs (`venue-quote-c`); a
`[[key]]` in a body, title, or checklist item and a key in `deps` become
the minted id when the batch runs, so the file is the whole dependency
graph with no id known in advance. A checklist entry is a string or the
shard's own `{"text", "done"}` item, so the rows a done or half-done task
has ticked survive a regeneration. Every `file:` ref points at a file
under `notes/`, which holds the story's artifacts (the venue comparison
table, the budget split, the intake form, the templates the wrap tasks
fill). A note names a task by its TITLE in 「」, never by a seed key (keys
never reach the board, so `furrow search` cannot find them) and never by
an id (ids change on every regeneration), and its first line states
whether it is a draft a still-open task will settle or the confirmed
output of a done one — a note must not read as finished while the task
that produces it is open.

This file, not the shards, is what a reader edits to change the story:
the live board is regenerated from it by `sh seed/rebuild.sh` (empty the
store, create the boxes, `furrow add --batch seed/tasks.ndjson`) followed
by `furrow sync`, and every regeneration mints new ids — a drill run on
the regenerated board is a new baseline in `docs/drills.md`.
