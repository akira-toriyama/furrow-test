# CLAUDE.md

This board is a worked example for Claude Code: a one-day restaurant, five
boxes, a hundred tasks, a dependency graph. `furrow lint` is the rulebook (it
exits 2 whenever it reports an error: never chain a read behind it with `&&`);
the lines below are the rules lint cannot express (docs/drills.md measures
which ones a fresh session actually needs). Every command's contract is
`furrow <cmd> --help`.

- Pick in this order: a `ready` task overdue (lint's error), then a `ready`
  task due today (its warning), then the task already in `in-progress`, then
  `next`'s first row. `priority` is lower-is-sooner, and inside one tier it
  is the tie-break — not how long a task has been overdue. An overdue
  repeating task is a lapsed occurrence, not today's work: it runs on its
  next scheduled day, and its due is not pushed to clear the lint. The due
  band spans every box, so the pick is taken wherever it sits — never
  `epic activate` to reach it — and a box's `waits` orders the boxes, not
  their tasks: a task with no unmet dep is workable whatever its box waits
  on. A `waiting` row is never the pick (its due is a chase date, below). An
  operator's request outranks this order.
- One task in flight per session. The rule counts work you START
  (`set -s in-progress`), not inbound facts you file: closing a `waiting`
  task on an arrival, retiring a 前提, rewording a row start nothing.
  Starting a task while another is `in-progress` moves that one back to
  `ready` with a `furrow note` saying where it stopped; it is never left open
  beside the new one, and it is resumed once the new one closes. A session
  owes only its pick: `due-overdue` on tasks it did not take (a `waiting`
  chase, a lapsed repeat) stays red, is named in the closing read, and is
  never snoozed to make lint green.
- Deps are the truth; bodies describe. When a body's 前提 contradicts a dep
  edge, fix the edge with `furrow dep`, never the prose. A handoff is a task
  named in 完了条件 — the receiver of this task's output, or the input it
  consumes — and it has an edge; a `[[link]]` anywhere else (前提, 次の一手,
  メモ) is context and needs none. A close that satisfies a dependent's last
  dep promotes that dependent to `ready`: the session does it
  (`furrow set <id> -s ready` — furrow never moves a lane on its own),
  `dep --list` names it, and the close note says so.
- A 前提, 現状 or 完了条件 line that stopped being true is retired with
  `furrow note`, saying what changed; the line itself stays. The task keeps
  its scope unless the population its title counts has changed (候補 3 件 →
  2 件) — that count is the population this task works (返信済み A/B 2 会場
  counts the venues whose inventory it fills), so it shrinks when a member
  drops out and never grows because a fact arrived: then `furrow retitle`
  plus the same note — at one member the count goes and the name stays
  (候補 A) — the rows for the dropped member go with `check --rm` (highest
  index first: indexes shift), and a row that counts the population (3 件分,
  両会場分) is `check --reword`ed to the survivors, never removed. If the
  survivors' work is already finished, close the task in the same pass.
- A done task's body is history: never rewrite it, never append to it, and
  its title, due and 結果 stay as written. Redo work is a new task with a dep
  on the one it replaces.
- `waiting` is a terminal lane: its task stays off `next` until you move
  it, and its due is the chase date. `due-overdue` there means "chase or
  escalate", not "do it". A close may come straight from `waiting`;
  `in-progress` is only for work you are doing. A reply that answers part of
  what was asked closes the task that asked for the answered part; every task
  still waiting for the rest gets a note naming the missing sections and
  keeps its rows and its lane — nothing unanswered is inferred as answered.
  That holds for candidates still in the running: a dropped candidate's
  unanswered sections are not chased, and its rows go with the drop.
- Bodies keep the template 目的 / 完了条件 / 前提 / 次の一手; the close
  appends 結果 last (`done --note`). lint warns `provenance-missing` when
  完了条件 is absent. Progress is appended with `furrow note`; `edit --body`
  replaces the whole file and is for repair only (a derived date that moved).
  Rows are ticked with `check <i>` as their work lands; a close settles the
  完了条件, not the checklist, so a row whose condition never arose stays
  unticked and the close note says so.
- The event date lives in ONE place: `event_date` in the venue box's meta
  (`furrow epic show 会場 --json | jq -r .meta.event_date` — `会場` is a
  unique title substring; ids change on every regeneration, titles do not).
  Every `due` and every D-N in a body is derived from it, except a date the
  other side set or the calendar fixed — a venue's application or payment
  deadline, a booked appointment, a slot chosen because the day is a public
  holiday — which the body marks with a 固定 line and a reschedule leaves
  where it is (a task to confirm it with the other side, not a shift, is
  what moves it). A reschedule changes the meta first, then the derived dues,
  then the body lines and checklist rows that spell a derived date
  (`edit --body`, `check --reword`).
- A venue candidate is a label, not a task: `cand-a` / `cand-b` / `cand-c`
  marks the tasks whose plan is rewritten if that candidate drops out, so a
  withdrawal — and a reply, which touches the same tasks — is
  `furrow ls -l cand-b`. A task that merely names a candidate carries no
  label; the comparison table itself is `notes/venue-compare.md`. A
  candidate that fails a knockout condition (the decision task's 前提) drops
  the moment the failing answer lands, and so does one that withdraws for
  its own reasons; the session filing the answer executes the drop, and the
  decision task alone records why (the box's body records nothing). The
  「候補が 2 件残る場合に限る」 clause on a chase task guards its timeout —
  dropping a candidate that never answered — never a knockout or a
  withdrawal: those drop the candidate whatever the count, and at one
  survivor the decision task records only whether that one is acceptable.
  A drop rewrites every `ls -l cand-x` task in place — retitle, reword,
  note; never remove or icebox — and takes `cand-x` off it once the rewrite
  is done, so `ls -l cand-x` coming back empty is the check that the drop
  is complete.
- `notes/` is part of the board and lives: a task rewrite edits its note in
  the same change, and a done task's note keeps taking dated additions (its
  body does not) — a sent text or a log line inside one is appended to,
  never rewritten, a status cell in one of its tables is updated in place,
  and a task title it quotes stays as written (the dated line carries the
  new one). A note that copies a body's text follows the body: what the copy
  wants and the body lacks goes into the body (or its checklist) first.
  `notes/` you commit yourself; `furrow sync` publishes only what furrow
  wrote under `.furrow/`.
