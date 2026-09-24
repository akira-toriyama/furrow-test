# Drill 3 — reschedule

> The dinner moves one week later, from 2026-11-21 to 2026-11-28. Bring the
> whole board in line: every date, every task whose plan assumed the old
> date, and anything that no longer makes sense at the new one.

## Measured on

- board commit: `ce5f326`
- furrow version: `furrow dev`
- run: 2026-09-24, 18:51 JST (Asia/Tokyo), session with no prior knowledge of this board
- board at read time: 100 tasks (75 backlog / 8 ready / 1 in-progress / 4 waiting / 4 done / 8 icebox), 5 epics, 95 tasks carrying a `due`

## Plan

Not executed. Classification used, and the assumptions behind it:

- **D0 = 2026-11-21 → 2026-11-28.** D0 is not stated anywhere on the board; it
  was inferred from the 18 tasks whose `due` falls on 2026-11-21 and from the
  string `11/21` in two `done` tasks (`t-0n6gq`, `t-cc22s`).
- **Shift +7d (76 tasks, `due >= 2026-10-14` and not `done`).** From D-38
  onward the plan is a backward plan off D0 — most of these bodies literally
  name their offset (`D-42`, `D-21`, `D-14`, `D-7`, `D-1`, `D0`, `D+7`). A
  7-day shift also preserves every weekday, which matters for
  `D-1(金) は半休`(`t-9vd5f`, `t-fb0ed`) and for the Saturday repeaters.
- **Do NOT shift (19 tasks: 4 `done` + 15 open with `due <= 2026-10-12`).**
  The venue/guest front half is gated by replies already in flight and by how
  fast a Saturday evening slot can be booked, not by D0. Moving the event a
  week later does not buy slack there — it *adds* work, because every
  candidate's availability and quote must now be re-confirmed for the new date.
- **5 tasks have no `due`** (`t-twa64 t-an72x t-mcbf4 t-yry2a t-5cpgj`, all
  icebox): nothing to do.

```sh
# ---- 0. see the board I am about to rewrite, and freeze what I read
furrow sync
furrow ls -q 'has:due' -n 0 --json > /tmp/before.json

# ---- 1. record the decision itself (the board has nowhere else to put it)
furrow edit e-jd4kb --body -   # append: "D0 = 2026-11-28 (moved +7d from 2026-11-21 on 2026-09-24);
                               #          every due at D-38 or later was shifted +7d; the venue and
                               #          guest polls taken for 11/21 are void — see the two new tasks."

# ---- 2. shift the event-anchored dues (+7d): 70 non-repeating tasks, 59 writes
furrow set t-1r7ak --due 2026-10-21
furrow set t-rg1n0 --due 2026-10-23
furrow set t-dtrn6 t-db1ed --due 2026-10-24
furrow set t-s8yt2 --due 2026-10-27
furrow set t-gscsy t-7a3mg --due 2026-10-29
furrow set t-1a39k t-95rjw t-495mc --due 2026-10-31
furrow set t-hwwfd --due 2026-11-03
furrow set t-me4ef --due 2026-11-04
furrow set t-wa29c --due 2026-11-08
furrow set t-sgfcs --due 2026-11-10
furrow set t-nfqm5 t-9vd5f --due 2026-11-12
furrow set t-zneqs --due 2026-11-14T18:00
furrow set t-3b6va --due 2026-11-14
furrow set t-mh9m7 t-3gwtn --due 2026-11-15
furrow set t-j80mp t-3qax0 --due 2026-11-16
furrow set t-ccj9f --due 2026-11-18
furrow set t-cpbcy --due 2026-11-19
furrow set t-c7vjj --due 2026-11-20
furrow set t-n5431 --due 2026-11-21T12:00
furrow set t-4tcxy --due 2026-11-21T21:00
furrow set t-kq6j1 t-8efq1 --due 2026-11-21
furrow set t-epgyd --due 2026-11-22
furrow set t-fejrz --due 2026-11-23T21:00
furrow set t-3tg4t t-rc5ry --due 2026-11-25
furrow set t-ehf4f t-9e9y1 --due 2026-11-26T21:00
furrow set t-2pcnj --due 2026-11-26
furrow set t-fb0ed --due 2026-11-27T11:00
furrow set t-zv988 --due 2026-11-27T15:00
furrow set t-fzqgk --due 2026-11-27T18:00
furrow set t-jhcpe --due 2026-11-27T21:00
furrow set t-xwche --due 2026-11-27T22:00
furrow set t-257mq --due 2026-11-28T09:30
furrow set t-sezkn --due 2026-11-28T10:15
furrow set t-j5k1v --due 2026-11-28T10:30
furrow set t-43svn --due 2026-11-28T12:00
furrow set t-9gyjs --due 2026-11-28T15:00
furrow set t-nkb7b --due 2026-11-28T16:00
furrow set t-aq1fe --due 2026-11-28T16:30
furrow set t-171r2 --due 2026-11-28T17:30
furrow set t-4rkbe --due 2026-11-28T18:45
furrow set t-q2d3q --due 2026-11-28T19:00
furrow set t-wdye6 --due 2026-11-28T19:30
furrow set t-5d50g --due 2026-11-28T20:45
furrow set t-xnwtj --due 2026-11-28T21:00
furrow set t-j6v1s --due 2026-11-28T21:30
furrow set t-2jgvj --due 2026-11-28T21:40
furrow set t-k07j4 --due 2026-11-28T21:45
furrow set t-xn9f4 --due 2026-11-28T21:55
furrow set t-mj4rm --due 2026-11-28T22:00
furrow set t-15w84 --due 2026-11-29T12:00
furrow set t-7wejj --due 2026-11-29
furrow set t-z70bc --due 2026-12-01T21:00
furrow set t-44tx0 --due 2026-12-02
furrow set t-jd2f6 --due 2026-12-03
furrow set t-94rmy --due 2026-12-05T20:00     # was 2026-11-28 20:00 — i.e. the NEW dinner night; miss this one and the retro lands on the event
furrow set t-rbbqj --due 2026-12-08
furrow set t-7rgpc --due 2026-12-10
furrow set t-h1y52 t-7hgan --due 2026-12-12
furrow set t-3mjrq --due 2026-12-19

# ---- 3. repeating tasks: the series anchor is immovable, so drop and re-bind
#         (t-snxbs is deliberately NOT here — see hesitation 11)
furrow set t-t2tvm --clear-repeat
furrow set t-t2tvm --due 2026-11-14 --repeat 'weekly on sat until 2026-11-27'
furrow set t-5k014 --clear-repeat
furrow set t-5k014 --due 2026-11-07T18:00 --repeat 'weekly on sat until 2026-11-27'
furrow set t-p0xy6 --clear-repeat
furrow set t-p0xy6 --due 2026-12-06T20:00 --repeat 'weekly'
furrow set t-2tsdm --clear-repeat
furrow set t-2tsdm --due 2027-05-27 --repeat 'every 6 months'
furrow set t-6cgw1 --clear-repeat
furrow set t-6cgw1 --due 2027-11-28 --repeat 'yearly'

# ---- 4. bodies that spell an absolute date (edit --body replaces the whole body)
furrow edit t-sgfcs --body -   # 11/03 -> 11/10
furrow edit t-me4ef --body -   # 11/20 -> 11/27
furrow edit t-zneqs --body -   # 11/20 -> 11/27
furrow edit t-n5431 --body -   # 11/14(土) -> 11/21(土)
furrow edit t-t2tvm --body -   # D-14(11/7 土) -> D-14(11/14 土)
furrow edit t-6cgw1 --body -   # 開催日(2026-11-21)の1年後 -> (2026-11-28)
furrow edit t-snxbs --body -   # 開催日 11/21 まで -> 11/28 まで  (start date 10/17 kept on purpose)

# ---- 5. checklist text carrying an absolute date (search does not reach it)
furrow check t-8q9pg 3 --reword '回答期限を10/17と明記する'   # D-42 of the new date

# ---- 6. refs whose path encodes the date
furrow ref t-z70bc --rm file:docs/oneday-restaurant/2026-11-21/receipts.md --add file:docs/oneday-restaurant/2026-11-28/receipts.md
furrow ref t-rbbqj --rm file:docs/oneday-restaurant/2026-11-21/recipes.md  --add file:docs/oneday-restaurant/2026-11-28/recipes.md
furrow ref t-7hgan --rm file:docs/oneday-restaurant/2026-11-21/handoff.md  --add file:docs/oneday-restaurant/2026-11-28/handoff.md

# ---- 7. what no longer makes sense at the new date: two premises died
#  t-0n6gq (done) built the 6-candidate table on the axis "11/21(土) 17:00-22:00";
#  t-cc22s (done) polled 12 guests for 11/21. Both stay done — they are a record —
#  and the redo is filed as new work that blocks the decisions downstream of them.
furrow add '候補 3 件に 2026-11-28(土) 17:00-22:00 の空きと見積据え置きを再確認する' \
  -e e-jd4kb -s ready --due 2026-09-28 --label venue-selection,external-wait
furrow add '開催日変更 11/28 をゲスト 12 名に再打診して可否を取り直す' \
  -e e-jd4kb -s ready --due 2026-09-30 --label guest-comms,scheduling
furrow dep t-06pzy <new-venue-id>     # cannot decide a venue before the new date is confirmed free
furrow dep t-92sfy <new-guest-id>     # 12 名確定 is void until the re-poll returns
furrow dep t-495mc <new-guest-id>     # the formal invitation must carry the new date

# ---- 8. verify the result myself (lint has no check for this)
furrow lint
furrow ls -q 'has:due' -n 0 --json > /tmp/after.json   # diff against before.json: every shifted row +7d
furrow ls -q '11/21' -n 0                              # must return only the two done tasks
furrow sync
```

Touch count: **79 existing tasks** (70 plain shifts + 5 repeater re-anchors +
`t-snxbs` body + `t-8q9pg` checklist + `t-06pzy`/`t-92sfy` dep edges),
**1 epic body**, **2 tasks created**, **3 dependency edges added**.
Commands: 59 `set --due`, 10 `set` for repeaters, 8 `edit --body`, 1
`check --reword`, 3 `ref`, 2 `add`, 3 `dep` — 86 writes.

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow sync && furrow brief` | Setup prescribes `sync` first, but this run was told the operator had already synced; unclear whether the session-start read was still valid without it | that `furrow brief` alone is the same read | a line of prose in Setup: "if the operator already synced, run `furrow brief` alone" | no |
| 2 | `furrow brief` | the session-start read shows 4 due rows + 3 next rows out of 100 tasks and never names the event, so it could not tell me what "the dinner" is or when | nothing yet — kept reading | a furrow change: a board-level event/anchor date in `config.toml` that `brief` prints | no |
| 3 | `furrow ls --all` | the flag does not exist (exit 2, `unknown flag`); I had to read `ls --help` to learn the whole-board read is `-n 0` | `--all`, by analogy with other CLIs | a furrow change: accept `--all` as an alias for `-n 0`, or name `-n 0` in the exit-2 `candidates` | no |
| 4 | locating D0 | the old date exists on the board only as 18 `due` timestamps that happen to land on 2026-11-21, plus the literal `11/21` in two **done** tasks and one recurring body — nothing states "the dinner is on 2026-11-21" | D0 = 2026-11-21, read off the D+0 cluster | a `config.toml` setting: an event/anchor date key the board declares once | no |
| 5 | classifying 95 `due`s | no field says whether a due was derived from D0 or is externally fixed; I dumped all 100 tasks (`show --json`) and rebuilt the `D-N` ladder by hand to find the boundary | a cut line at 2026-10-14 (D-38): everything from there on is backward-planned, everything before it is gated by replies in flight | a furrow change: an anchored/relative due (`--due D-14`) that stores the offset, so a move of the anchor moves the ladder | no |
| 6 | `furrow set --due` | the offset form `+7d` is measured **from now**, not from the task's own due, so there is no "shift this task by a week"; 76 tasks had to be enumerated as 63 absolute datetimes | nothing — the help is explicit; I enumerated | a furrow change: `--due-shift +7d` (relative to the existing due) honoring the `-q`/`-l` selection | no |
| 7 | `furrow set <repeater> --due` | on a repeating task `--due` moves THIS occurrence only and the anchor is "immovable"; the help never says whether `--due X --repeat <rule>` in one write re-anchors the series | that it does not; planned `--clear-repeat` then a re-bind — 2 writes per repeater | a line of prose in `set --help`: "`--due` together with `--repeat` re-anchors the series" | no |
| 8 | re-binding the repeat rules | `t-t2tvm` and `t-snxbs` bodies both assert 「repeat に終了条件を書けない」, but `add --help` documents `until <date>`; I re-read both helps to find out which is true | that `until` works and both bodies are stale prose | a line of prose — or `set --repeat`'s help naming `until`/`for` the way `add --repeat` does | no |
| 9 | finding every date | three tasks point at `docs/oneday-restaurant/2026-11-21/…` in `refs`, and `furrow search oneday-restaurant` returns **no matches** (measured); no list view prints refs, so I found them only in the JSON dump | nothing — dumped every task to JSON | a furrow change: free text (`search`, `-q`) covering `refs`, or a `has:ref` qualifier plus a refs column | no |
| 10 | finding every date | `furrow search` covers title+body only — a checklist-only phrase from `t-c7vjj` returns no matches (measured) — yet `t-8q9pg`'s checklist item 3 hard-codes `10/10` | nothing — same JSON dump | a furrow change: `search`/`-q` free text covering checklist item text | no |
| 11 | `furrow set t-snxbs --due` | a mechanical +7 would push the weekly budget tally's FIRST run from 10/17 to 10/24, although only its end (「開催日 11/21 まで」) moved | kept the due at 10/17 and rewrote the body instead | an anchored due that can say "start 10/17, run until D0" — the same relative-due change as row 5 | no |
| 12 | the two `done` tasks | `t-cc22s` polled 12 guests for 11/21 and `t-0n6gq` built the candidate table on the "11/21(土) 17:00-22:00" axis; both are closed, both outputs are now false, and nothing links a task to the artifact it produced | left the done rows untouched as a record and filed 2 new tasks that block the decisions downstream | a line of prose: "done tasks are a record — never re-open; file the redo and wire the dep" | no |
| 13 | assessing the new date | whether A/B/C are free on 2026-11-28 and whether the quotes hold is not on the board at all — the comparison table lives outside furrow and is referenced only in prose | unknown; filed it as the first new blocking task | board prose or a `ref` pointing at the comparison table, so the artifact is addressable | no |
| 14 | `furrow dep --list` sweep | `t-fejrz` (D-5) depends on `t-ehf4f` (D-2) — a dependency due AFTER its dependent; I stopped to work out whether my shift had created it | pre-existing: a uniform +7 preserves every edge, and the same single inversion is there before and after (measured over all 100 tasks) | a lint code, e.g. `dep-due-inversion` | no |
| 15 | the icebox next-time tasks | `t-6cgw1` states its anchor (「開催日(2026-11-21)の1年後」) but `t-2tsdm` (every 6 months from 2027-05-20) and `t-3mjrq` (D+21) do not, so whether they follow the move is a guess | shifted all three +7d for consistency | the same anchored-due field as row 5 | no |
| 16 | recording the move | no entity on the board carries the event date or a decision log: the 5 epics have a goal and a body but no date, and there is no project-level object | appended the decision to the active epic `e-jd4kb`'s body | a furrow change: a board-level note/anchor (or the `config.toml` key from row 4) | no |
| 17 | `furrow lint` | ran it (2 `due-overdue`, 2 `due-today` — all about today's calendar, none about the reschedule); nothing would catch a half-finished date move, e.g. `t-94rmy` left at its old `2026-11-28 20:00`, which is now the dinner night itself | verification is my own `ls -q 'has:due'` before/after diff | a lint code, e.g. `due-anchor-drift` | no |

## Verdict

`could_act_confidently: false`

The board can be *changed* mechanically, but it cannot be *trusted*: the date
the whole plan hangs on is written nowhere except in 95 `due` timestamps and
three stale strings, so every decision about which of those timestamps is
event-anchored was mine to invent, and `furrow lint` would have called the
result clean either way.

- hesitations: **17**
- rows where `furrow lint` caught it: **0**
