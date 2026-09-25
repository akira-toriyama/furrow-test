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
different furrow is a new row, never a correction of an old one. When an
operator drives the run, the operator syncs; the session then runs
`furrow brief` alone and never `furrow sync`.

## Rules

- **Read-only.** Allowed: `brief`, `ls`, `show`, `next`, `revisit`, `search`,
  `stats`, `board`, `lint`, `vocab`, `dep --list`, `epic ls|show|dep --list`,
  and any `--help`, plus reading any file under `.furrow/` (the config
  included — `furrow config` has no read form; `furrow board` prints the
  settings that matter) and under `notes/`. Forbidden: everything that writes — `add`, `set`, `move`,
  `done`, `dep` without `--list`, `note`, `edit`, `attach`, `check`, `label`,
  `ref`, `repo`, `reorder`, `retitle`, `value`, `effort`, `review`, `apply`,
  `archive`, `rm`, `tidy`, `upgrade`, `config set`, `epic add|set|activate|
  deactivate|done|reopen|rm`, and `sync` after the setup read. No `git` writes
  either. A run that wrote anything is void: the board state has moved and
  the next run cannot be compared to it.
- **No prose beyond what a real session would read.** The session gets the
  request, this file's rules, the repo's `README.md` and `CLAUDE.md`, and
  the board. Whatever it needs beyond those, `furrow --help`, `furrow <cmd>
  --help`, and `furrow lint` is a hesitation by definition.
- **The log's shape is the four sections under "What to record", handed to
  the session inline with the rules.** A run never opens `docs/` — not this
  file's results, not a sibling log under `docs/drills/runs/` — so the
  operator passes the rules, the recording format and the output path in
  the request itself. A stop on "what does a log look like" is the
  protocol's cost, not the board's; the fourth run paid it five times before
  this line existed.
- **Write down the commands you would have run**, in order, as a fenced
  block. A drill's deliverable is that plan plus the hesitation log; the
  plan is never executed. An edit to a hand-kept file under `notes/`
  belongs in the same block, as comment lines naming the file and the lines
  that change: the plan covers the whole board, `notes/` included, and is
  never executed either way.

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
   hesitation count, and how many rows said `yes` in the last column. Then
   a line `Most consequential:` naming the three rows that mattered most,
   in order, one clause each — the results table's reading is built on
   these, not on the count.

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
| 2026-09-24 (2) | 49d666c | dev (main at a1c5915) | orient | no | 20 | 2 |
| 2026-09-24 (2) | 49d666c | dev (main at a1c5915) | unblock | no | 23 | 1 |
| 2026-09-24 (2) | 49d666c | dev (main at a1c5915) | reschedule | no | 24 | 1 |
| 2026-09-24 (2) | 49d666c | dev (main at a1c5915) | invalidate | no | 22 | 1 |
| 2026-09-24 (2) | 49d666c | dev (main at a1c5915) | **total** | 0 / 4 | 89 | 5 |
| 2026-09-24 (3) | f497db3 | dev (main at ac777e8) | orient | no | 20 | 2 |
| 2026-09-24 (3) | f497db3 | dev (main at ac777e8) | unblock | no | 23 | 2 |
| 2026-09-24 (3) | f497db3 | dev (main at ac777e8) | reschedule | no | 22 | 1 |
| 2026-09-24 (3) | f497db3 | dev (main at ac777e8) | invalidate | no | 24 | 1 |
| 2026-09-24 (3) | f497db3 | dev (main at ac777e8) | **total** | 0 / 4 | 89 | 6 |
| 2026-09-24 (4) | 1429073 | dev (main at ac777e8) | orient | **yes** | 17 | 2 |
| 2026-09-24 (4) | 1429073 | dev (main at ac777e8) | unblock | no | 24 | 0 |
| 2026-09-24 (4) | 1429073 | dev (main at ac777e8) | reschedule | no | 24 | 2 |
| 2026-09-24 (4) | 1429073 | dev (main at ac777e8) | invalidate | no | 25 | 1 |
| 2026-09-24 (4) | 1429073 | dev (main at ac777e8) | **total** | 1 / 4 | 90 | 5 |
| 2026-09-25 (5) | 9896fee | dev (main at eb85970) | orient | **yes** | 19 | 1 |
| 2026-09-25 (5) | 9896fee | dev (main at eb85970) | unblock | **yes** | 29 | 3 |
| 2026-09-25 (5) | 9896fee | dev (main at eb85970) | reschedule | no | 28 | 2 |
| 2026-09-25 (5) | 9896fee | dev (main at eb85970) | invalidate | **yes** | 25 | 2 |
| 2026-09-25 (5) | 9896fee | dev (main at eb85970) | **total** | 3 / 4 | 101 | 8 |

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

The third run is a new baseline, not a delta: the board was regenerated
from `seed/` with its content fixed (every cross-reference a `[[id]]`
link, every `refs` target present under `notes/`, dep edges that match
the prose, `event_date` once in the venue box's meta, `cand-a/b/c` on the
tasks a withdrawal rewrites), so no id survived from the previous rows.
The total did not move (89), but what stopped the sessions did. Not one
of the four top-threes names the private id namespace, a missing file, a
contradictory edge, or the event date any more; the rows those occupied
went to three new classes. First, the artifacts themselves: `notes/`
named tasks by the seed's keys (`venue-quote-c`), which furrow never
sees, and held the finished deliverable of a task still open at 0/5 —
both defects of the regeneration, fixed in the commit after this run.
Second, furrow: a relative due shift (the reschedule is 78 hand-typed
stamps), a reason on a dep edge, a due that is externally fixed and must
not move with the event, `search` not reaching epic meta, a negated
label filter the session did not find in `ls --help` (it exists: `-q
-label:cand-a`). Third, the rules: who applies a knockout criterion when
a reply lands, how a partially answered inquiry is recorded, whether a
task whose deliverable already exists in `notes/` is closable as-is. Read
the flat total as the protocol's floor rather than the board's score: a
session told that undercounting is the failure mode records about twenty
stops whatever the board, and the useful signal is which rows appear at
the top, not how many rows there are.

The fourth run is the first row that is a delta rather than a new
baseline: its `.furrow/` tree is byte-identical to the third run's
(`git diff f497db3 1429073 -- .furrow` is empty), only `notes/` changed —
every note names tasks by title and says whether it is a draft or settled —
and furrow is the same build. 89 became 90, and orient answered
`could_act_confidently: true` for the first time under the protocol: one
defensible pick with a complete close plan, after eleven unplanned reads.
The notes fix did what it was meant to: no row in any of the four logs
names the seed's key namespace, and the "deliverable already sitting in
`notes/`" stop shrank to "the draft holds two questions the task's
checklist does not count". Eight of the 90 rows are the cost of the run's
own setup, not the board's: five stopped on the shape of the log (the
sessions were forbidden `docs/`), two on the operator's instruction to
reach `.furrow/` only through the CLI (the protocol never said so), one on
whether a plan may name `notes/` edits — all settled in the rules above.
The rows at the top fall into the third run's three classes, in a different
order. First, the rules, now the largest class and the same holes as
before: who executes a knockout that an arriving answer fails, how a partly
answered inquiry is recorded, whether filing an inbound fact counts against
one-in-flight, whether a close may leave `waiting` directly, `--reword` for
a checklist row that counts a population where CLAUDE.md names only
`--rm`, whether `cand-X` comes off after the rewrite, and `notes/` as living
documents beside frozen done bodies. One CLAUDE.md line was measured
against the board and cannot be read as written — "a handoff a body names
without an edge is a missing edge": 69 of this board's 181 `[[t-id]]`
links have no dependency edge in either direction, so a lint for it would
fire 69 times on a board whose graph is right, and orient spent three
`dep --list` reads on the sentence. Second, furrow: a relative due shift
(the fourth reschedule in a row to type 78 absolute stamps, this time
converted by hand from the UTC instants `ls --json` prints), a due that is
promised to a third party and must not move with the event, a dependency
edge that carries no reason (the "dependencies that ran through B" clause
resolved to zero edges, because B lived only in prose), `revisit`'s text
table printing no signal (third run; `dep_done` read as "all deps done"
nearly sent orient to a still-blocked task), `attach` refusing a PDF by its
own help (third run), `search` matching a one-letter candidate as a
substring (third run), and four `--help` gaps. Third, content, and new: two
bodies (`t-qw8jc`, `t-19nfz`) say "if C has not replied by 9/24, drop C and
decide between A and B" — the run fell on 9/24, and B's withdrawal makes
the sentence self-contradictory; a date-bound rule inside prose is what the
calendar rots first, and no lint reaches it. Two things were measured for
lint on this run. A dependency whose due falls later than its dependent's:
none on this board, one on the board before the rebuild (`t-fejrz` →
`t-ehf4f`, found by hand during the rebuild) — the one new lint code the
run justifies. A done task with an untouched checklist: all four done tasks
here are 0/N, 0 of the board's 372 rows are ticked, and two drills stopped
on it — that stays a content fix and no lint, by the earlier decision that a
close settles the task, not its checklist.

The fifth run is the first delta measured after a rule fix rather than a
content fix, and it sits on a rebuilt `.furrow/` tree: the seed was
regenerated (`0b52fa7`, so no id survives from the fourth run's rows),
CLAUDE.md grew from 39 to 77 lines with the eight rule holes the third and
fourth runs both hit folded into its ten existing bullets, the C cutoff
became a condition ("only while two candidates remain"), the four done
tasks' rows were ticked (17 of the board's 372, from 0), each copy under
`notes/` now says which of its lines its source lacks, and furrow moved from
ac777e8 to eb85970 (`add --batch` seeding a ticked row, so a rebuild keeps
the ticks). The flat total rose from 90 to 101 while the confident count
went from 1 of 4 to 3 of 4; read the two together, as the third run's
paragraph asks — a session told that undercounting is the failure mode
records every re-read, and three of the four now record theirs on the way
to a plan they stand behind. Not one top-three row in the four logs names
one of the eight holes as a rule the board lacks. Six of the twelve name a
question the new lines' own wording opened: which of two tier-one tasks
wins (due age says one, `priority` the other); whether a withdrawal for the
other side's reasons takes the knockout path, and whether the "only while
two remain" guard gates a knockout drop or only the timeout; the
partial-answer rule and the drop rule giving opposite orders for the
dropped member's rows; whether a status cell inside a done task's note is a
rewrite or an update; and whether furrow or the session promotes the
dependent a close frees. Those are the next CLAUDE.md lines, and they are
questions of degree inside a rule that is now there, not the absence of
one. The three content fixes held: the conditional cutoff read correctly on
the day B withdrew — invalidate saw it flip from allowed to forbidden and
said so, then noted that the task carrying the clause has no `cand-b`
label, so the "`ls -l cand-b` comes back empty" check passes with that
change unmade; no drill stopped on whether ticks mean anything; the dietary
copy stopped orient once more, now on the criterion for adopting its two
extra questions rather than on which side is the source. The protocol's
own cost fell from eight rows to none — the log shape, the `.furrow/`
access rule and the `notes/` scope were all in the request — and four rows
are the sessions' own (a mistyped flag, a pipe that interleaved stderr into
`lint --json`, the lint vocabulary, `git log` for a commit style).
reschedule alone stays `false`, on the same three furrow gaps as every run
before it: no shift-by-N primitive (77 hand-typed writes, the fifth time),
nothing that marks a due as promised to a third party or pinned to a
holiday, and a done task whose title and result name the old date and may
not be edited — lines in CLAUDE.md cannot close these, the filed tasks can.
One row was checked and refuted: invalidate reported `furrow search 'B
会場'` finding nothing where `grep` found nine bodies; `grep -l 'B 会場'`
over `.furrow/bodies` finds nothing either (the nine came from a looser
pattern), so no search defect is filed. Two furrow gaps recur enough to
file: `show` prints checklist rows without their index, so every session
counts rows by hand before `check <i>` (two drills here, one in the fourth
run), and `brief`'s `1 hidden by -n` note names a lane but not the id,
which three of the four drills re-ran `next` uncapped to learn (the hidden
row was the recurring chase every time). `attach` refusing a PDF stopped
unblock for the third run in a row and is filed beside them; `revisit`'s
per-dep `dep_done` (four runs), the relative due shift (five), and the
missing chase interval behind a `waiting` due (two drills) go as notes onto
the tasks that already carry them.

The second run measured the config change (`provenance_markers`,
in-progress ahead of ready) plus a nine-line CLAUDE.md, with seven furrow
fixes merged in between (#401–#407), on the same content. It did not go
down: 89, with the same content defects in every top-three and two of the
new prose rules contradicting each other (pick-order vs one-in-flight;
retire-by-note vs retitle-on-count) — both reworded after the run. Read
the two runs as one lesson: prose and lint settings do not compensate for
a board whose bodies, refs, and edges disagree with each other. The
content fix comes first; the drills are re-run after it.
