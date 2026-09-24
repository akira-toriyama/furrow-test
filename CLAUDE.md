# CLAUDE.md

This board is a worked example for Claude Code: a one-day restaurant, five
boxes, a hundred tasks, a dependency graph. `furrow lint` is the rulebook;
the lines below are the rules lint cannot express (docs/drills.md measures
which ones a fresh session actually needs). Every command's contract is
`furrow <cmd> --help`.

- Pick in this order: a task due today, then the task already in
  `in-progress`, then `next`'s first row. `priority` is lower-is-sooner.
- One task in flight per session. Starting a due-today task while another
  is `in-progress` moves that one back to `ready` with a `furrow note`
  saying where it stopped; it is never left open beside the new one.
- Deps are the truth; bodies describe. When a body's 前提 contradicts a
  dep edge, fix the edge with `furrow dep`, never the prose. A handoff a
  body names without an edge is a missing edge: add it.
- A 前提 line that stopped being true is retired with `furrow note`,
  saying what changed. The task itself keeps its scope unless the
  population its title counts has changed (候補 3 件 → 2 件): then
  `furrow retitle` plus the same note, and the checklist rows for the
  dropped member go with `check --rm`.
- A done task's body is history: never rewrite it. Redo work is a new task
  with a dep on the one it replaces.
- `waiting` is a terminal lane: its task stays off `next` until you move
  it, and its due is the chase date. `due-overdue` there means "chase or
  escalate", not "do it".
- Bodies keep the template 目的 / 完了条件 / 前提 / 次の一手; the close
  appends 結果 last (`done --note`). lint warns `provenance-missing` when
  完了条件 is absent.
- The event date lives in ONE place: `event_date` in the venue box's meta
  (`furrow epic show 会場 --json | jq -r .meta.event_date`). Every `due`
  and every D-N in a body is derived from it; a reschedule changes the
  meta first, then the dues.
- A venue candidate is a label, not a task: `cand-a` / `cand-b` / `cand-c`
  marks the tasks whose plan is rewritten if that candidate drops out, so a
  withdrawal is `furrow ls -l cand-b`. A task that merely names a
  candidate carries no label; the comparison table itself is
  `notes/venue-compare.md`.
- Never hand-commit `.furrow/`: `furrow sync` publishes what furrow wrote.
