# CLAUDE.md

This board is a worked example for Claude Code: a one-day restaurant, five
boxes, a hundred tasks, a dependency graph. `furrow lint` is the rulebook;
the lines below are the rules lint cannot express (docs/drills.md measures
which ones a fresh session actually needs). Every command's contract is
`furrow <cmd> --help`.

- Finish what is open before starting: at most one task in `in-progress`
  per session, and it leads `next` (`[lanes].order` puts it ahead of
  `ready` on purpose).
- Pick in this order: a task due today, then the one in `in-progress`,
  then `next`'s first row. `priority` is lower-is-sooner.
- Deps are the truth; bodies describe. When a body's 前提 contradicts a
  dep edge, fix the edge with `furrow dep`, never the prose.
- A 前提 line that stopped being true is retired with `furrow note`,
  saying what changed — never by rescoping the task.
- A done task's body is history: never rewrite it. Redo work is a new task
  with a dep on the one it replaces.
- A title that carries a count (候補 3 件) is retitled when the population
  changes.
- `waiting` is a terminal lane: its task stays off `next` until you move
  it, and its due is the chase date. `due-overdue` there means "chase or
  escalate", not "do it".
- Bodies keep the template 目的 / 完了条件 / 前提 / 次の一手; the close
  appends 結果 last (`done --note`). lint warns `provenance-missing` when
  完了条件 is absent.
- Never hand-commit `.furrow/`: `furrow sync` publishes what furrow wrote.
