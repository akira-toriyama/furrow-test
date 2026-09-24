# furrow-test

A [furrow](https://github.com/akira-toriyama/furrow) board at working
scale, kept so a Claude Code session can read a real one instead of a
hello-world. The subject is a one-day restaurant — rent a kitchen, seat
twelve friends, serve five courses on 2026-11-21 — planned as five boxes
that depend on one another (venue → menu → prep → day-of → wrap-up), a
hundred tasks, 178 dependency edges, dated work, checklists, external
waits, and a recurring task. The dinner is fictional; the board is not.

## What to read it for

1. **Whether a session that has never seen the board can act on it.**
   [docs/drills.md](docs/drills.md) hands four fresh sessions four
   requests — orient, unblock, reschedule, invalidate — read-only, and
   counts where each one stops. The logs are under
   [docs/drills/runs/](docs/drills/runs/); the results table in
   docs/drills.md is the score. It is not a success story: the first run
   under the protocol stopped 75 times, 5 of them on something `furrow
   lint` reports, and most of the rest on this board's own content — the
   logs name the rows. Read them to see where a real board trips an
   agent, and what removed each trip.
2. **How a box with a dependency graph is assembled.** The tasks carry
   `value`, `effort`, `due`, checklists and cross-box deps; building them
   one `furrow add` at a time took a hand-kept key-to-id table, which is
   why `furrow add --batch` exists. The board's own source file in that
   format is the next measurement (see the results table).

## Using it

The store is repo-local, so discovery needs no configuration:

```sh
cd furrow-test
furrow sync && furrow brief
```

`furrow lint` is this board's rulebook; [CLAUDE.md](CLAUDE.md) holds the
rules lint cannot express, one line each. Every command's contract is
`furrow <cmd> --help`.

## Where findings go

A gap in furrow found while driving this board is filed against furrow on
the private `akira-toriyama/projects` board, under epic `e-axjj`, never as
a task here: this board carries only the restaurant, so that a session
reading it sees one project, not two.
