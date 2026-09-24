# Drills: can a session that has never seen this board act on it?

This board exists to be read by a Claude Code session that has no prior
context. The drills below measure that directly: each one hands a fresh
session a realistic request, forbids every write, and records where the
session hesitated. The hesitation count is the board's usability score, and
every gap that furrow itself could close is filed against furrow (epic
`e-axjj` on the `akira-toriyama/projects` board).

Run them again after any change to furrow or to this board's conventions,
and append the numbers to the results table at the end.

## Setup

```sh
cd furrow-test
git rev-parse --short HEAD        # the board state the run measured
furrow version                    # the furrow the run measured
furrow sync && furrow brief       # the session-start read, exactly as CLAUDE.md prescribes
```

Record both values in the run log. A run on a different board commit or a
different furrow is a new row, never a correction of an old one.

## Rules

- **Read-only.** Allowed: `brief`, `ls`, `show`, `next`, `revisit`, `search`,
  `stats`, `board`, `lint`, `vocab`, `dep --list`, `epic ls|show|dep --list`,
  and any `--help`. Forbidden: everything that writes — `add`, `set`, `move`,
  `done`, `dep` without `--list`, `note`, `edit`, `attach`, `check`, `label`,
  `ref`, `repo`, `reorder`, `retitle`, `value`, `effort`, `review`, `apply`,
  `archive`, `rm`, `tidy`, `upgrade`, `config set`, `epic add|set|activate|
  deactivate|done|reopen|rm`, and `sync` after the setup read. No `git` writes
  either. A run that wrote anything is void: the board state has moved and
  the next run cannot be compared to it.
- **No prose rules beyond this file.** The session gets the request, this
  file's rules, and the board. Whatever it needs beyond `furrow --help`,
  `furrow <cmd> --help`, and `furrow lint` is a hesitation by definition.
- **Write down the commands you would have run**, in order, as a fenced
  block. A drill's deliverable is that plan plus the hesitation log; the
  plan is never executed.

## The four requests

Each drill is one session. Hand it exactly the text in the box.

### 1. orient

> You are starting a session on this board. Pick exactly ONE task to work on
> today and spell out how you would take it to done: the commands you would
> run, the checklist items you would tick, what you would write in the body.
> Also name the tasks you considered and did NOT pick, and why.

### 2. unblock

> Venue C has replied by email: the quote is 28,000 JPY for the day, all
> nine equipment questions are answered (no oven, everything else yes), and
> the PDF is attached. Reflect this on the board and get everything that was
> waiting on it moving.

### 3. reschedule

> The dinner moves one week later, from 2026-11-21 to 2026-11-28. Bring the
> whole board in line: every date, every task whose plan assumed the old
> date, and anything that no longer makes sense at the new one.

### 4. invalidate

> Venue candidate B has withdrawn (double-booked). Dispose of everything on
> the board that assumed B: tasks that only made sense for B, comparisons
> that included B, and dependencies that ran through it.

## What to record

One run log per drill, in `docs/drills/runs/<date>-<drill>.md`, in English,
with these sections in this order:

1. **Measured on** — board commit, furrow version, run date and local time
   (the due band shifts with the calendar, so the same board reads
   differently on another day).
2. **Plan** — the fenced command block you would have run.
3. **Hesitations** — one row per stop, in the order they happened:

   | # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
   |---|---|---|---|---|---|

   `stage` is the command you were about to run. `what would have removed
   it` is one of: a lint code (name it), a `config.toml` setting (name the
   key), a line of prose (quote the line you wanted), or a furrow change
   (one sentence). `lint catches it?` is `yes: <code>` only if `furrow lint`
   on this board actually reports it — run it and check; otherwise `no`.
4. **Verdict** — `could_act_confidently: true|false`, one sentence why, the
   hesitation count, and how many rows said `yes` in the last column.

A hesitation is any point where you stopped to guess, to re-read, to run an
extra command you had not planned, or to look for information the board
does not carry. Undercounting is the failure mode; when unsure, record it.

## Results

| run date | board | furrow | drill | confident | hesitations | lint caught |
|---|---|---|---|---|---|---|
| 2026-09-15 | a7ff857 | dev (post-v6.0.0) | orient | no | — | — |
| 2026-09-15 | a7ff857 | dev (post-v6.0.0) | unblock | no | — | — |
| 2026-09-15 | a7ff857 | dev (post-v6.0.0) | reschedule | no | — | — |
| 2026-09-15 | a7ff857 | dev (post-v6.0.0) | invalidate | no | — | — |
| 2026-09-15 | a7ff857 | dev (post-v6.0.0) | **total** | 0 / 4 | 43 | 2 |
| 2026-09-24 | ce5f326 | dev (main at 958716b) | orient | no | 18 | 2 |
| 2026-09-24 | ce5f326 | dev (main at 958716b) | unblock | no | 21 | 2 |
| 2026-09-24 | ce5f326 | dev (main at 958716b) | reschedule | no | 17 | 0 |
| 2026-09-24 | ce5f326 | dev (main at 958716b) | invalidate | no | 19 | 1 |
| 2026-09-24 | ce5f326 | dev (main at 958716b) | **total** | 0 / 4 | 75 | 5 |

The 2026-09-15 run predates this file: its four logs were not kept, only
the totals, and the 21 gaps it filed are the first members of `e-axjj`.
Every later run keeps its logs under `docs/drills/runs/`. Counts are
comparable only within one protocol — the 2026-09-24 run is the first
under this file, and its 75 is the baseline later runs are read against.

The board state a run measured is the `.furrow/` tree at the commit in the
`board` column; no tag is kept, the hash is the reference. A run on a
board whose `.furrow/` tree differs from the previous row's is a new
baseline, not a delta.

What the 2026-09-24 run says, in one line per drill (the logs carry the
rows): every drill stopped on the bodies' private id namespace
(`venue-NN`, `menu-NN` — unresolvable by furrow and inconsistent between
bodies) and on `refs` naming files that do not exist in the repo; unblock
and invalidate found dep edges that contradict the prose; reschedule found
that the event date exists nowhere but in 95 `due` stamps. Those are
defects of this board's content, and fixing them is the next measurement.
