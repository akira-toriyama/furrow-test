# Drill run — reschedule (2026-09-24d)

Request handed to the session:

> The dinner moves one week later, from 2026-11-21 to 2026-11-28. Bring the
> whole board in line: every date, every task whose plan assumed the old
> date, and anything that no longer makes sense at the new one.

## Measured on

- board commit: `1429073` (confirmed with `git rev-parse --short HEAD`)
- furrow version: `furrow dev`
- run date / local time: 2026-09-24, started 21:36 JST, ended 21:52 JST
  (Asia/Tokyo; the board's own `timezone = Asia/Tokyo` per `furrow board`)
- session: a Claude Code subagent (Opus), never having seen this board,
  handed only the request, the drill rules, `README.md`, `CLAUDE.md`, and
  the board (`.furrow/` through the CLI, plus `notes/`). `docs/` and `seed/`
  were not opened. The operator had already run `furrow sync`; this run
  never ran it.
- read-only: no `furrow` write, no `furrow sync`, no `git` write. The one
  file created is this log.
- `furrow lint` on this board at this commit: 2 errors `due-overdue`
  (t-16hvj, t-qw8jc), 2 warnings `due-today` (t-1j38n, t-pvpwd). Nothing
  else. That is the whole of what lint can say about a reschedule.

Shape of the problem, measured: 100 tasks, 96 of them dated (operator's check after the run: `furrow ls -q
'has:due' -n 0 --json` on this commit counts 95 — the run's 78 + 14 + 4 tally
is one high); 5 boxes; the
event date lives in exactly one place (`e-0w7hf.meta.event_date =
2026-11-21`) and nothing in furrow derives a due from it. 30 bodies carry
`D-N`, 4 carry `D0`, 2 carry `D+N`; 9 bodies and 2 `notes/` files carry an
absolute calendar date; 6 dated tasks repeat, 4 of them with an
event-anchored `UNTIL`.

## Plan

The classification the plan rests on, stated because the board does not
carry it: a due is **derived** (shift +7) when its body anchors it with
`D-N`/`D0`/`D+N` or names `event_date`; it is **external** (hold) when the
board names a commitment already made to someone else — a deadline already
sent, an appointment already booked, a deadline the venue set — or when
the task's content does not depend on the date at all. Done tasks are
history and are never touched.

```sh
# ── 0. the reads already made (repeated here as the run's first steps) ──
git rev-parse --short HEAD                       # 1429073
furrow version                                   # furrow dev
furrow brief                                     # session-start read; no sync
furrow epic show 会場 --json | jq -r .meta.event_date   # 2026-11-21

# ── 1. the single source of the date, first (CLAUDE.md: meta, then dues) ──
furrow epic set 会場 --meta event_date=2026-11-28

# ── 2. the 6 repeating series: --due alone moves THIS occurrence only, so
#      --due + --repeat must ride in ONE write to move the anchor ──────────
furrow set t-nt65v --due 2026-10-24 --repeat 'FREQ=WEEKLY;UNTIL=20261128T235959Z;BYDAY=SA'
furrow set t-74ffs --due 2026-11-14 --repeat 'FREQ=WEEKLY;UNTIL=20261127T235959Z;BYDAY=SA'
furrow set t-fg902 --due 2026-11-07T18:00 --repeat 'FREQ=WEEKLY;UNTIL=20261121T235959Z;BYDAY=SA'
furrow set t-r6xpt --due 2026-12-06T20:00 --repeat 'FREQ=WEEKLY;UNTIL=20261227T235959Z'
furrow set t-csy5w --due 2027-05-27 --repeat 'FREQ=MONTHLY;INTERVAL=6'
furrow set t-4zw13 --due 2027-11-28 --repeat 'FREQ=MONTHLY;INTERVAL=12'
# t-16hvj: due HELD (it is overdue; a +7 would clear a lint error without
# the work being done). Only the UNTIL moves, chained to the form deadline
# 10/10 -> 10/17, so "the next Sunday" is 10/18.
furrow set t-16hvj --repeat 'FREQ=WEEKLY;UNTIL=20261018T235959Z'

# ── 3. +7 on every derived due (71 writes; each value is the stored instant
#      re-rendered in Asia/Tokyo, so a 16:00 stays 16:00) ─────────────────
furrow set t-52bk3 --due 2026-10-21
furrow set t-67mw6 --due 2026-10-23
furrow set t-a4qgf --due 2026-10-27
furrow set t-mamd8 --due 2026-10-29
furrow set t-21dax --due 2026-10-31
furrow set t-rek26 --due 2026-11-03
furrow set t-ts95s --due 2026-11-12
furrow set t-g92fz --due 2026-11-04
furrow set t-fjrkx --due 2026-11-14T18:00
furrow set t-8nt5h --due 2026-10-24
furrow set t-6bn1n --due 2026-11-16
furrow set t-n5n7w --due 2026-11-15
furrow set t-aradr --due 2026-11-18
furrow set t-qwn6x --due 2026-10-31
furrow set t-c6q9y --due 2026-11-08
furrow set t-c3jda --due 2026-11-13
furrow set t-5ntm2 --due 2026-11-14
furrow set t-8cvve --due 2026-11-15
furrow set t-s2gnz --due 2026-11-16
furrow set t-9c6gj --due 2026-11-19
furrow set t-gpy5r --due 2026-11-20
furrow set t-gsnnp --due 2026-11-21
furrow set t-v2k46 --due 2026-11-21
furrow set t-hba7h --due 2026-11-22
furrow set t-r8y19 --due 2026-11-25
furrow set t-zqsqw --due 2026-11-25
furrow set t-t24m0 --due 2026-11-26
furrow set t-hfhm9 --due 2026-11-27T11:00
furrow set t-g9m6s --due 2026-11-27T15:00
furrow set t-k6bbk --due 2026-11-27T18:00
furrow set t-dtrh2 --due 2026-11-27T22:00
furrow set t-q2ke1 --due 2026-10-17
furrow set t-v6b0w --due 2026-10-21
furrow set t-ca3ef --due 2026-10-17
furrow set t-xc1h1 --due 2026-10-29
furrow set t-0fytb --due 2026-10-31
furrow set t-rzk8j --due 2026-11-21T12:00
furrow set t-z1fry --due 2026-11-27T21:00
furrow set t-1stn7 --due 2026-11-28T21:30
furrow set t-jayrp --due 2026-11-28T21:40
furrow set t-dca61 --due 2026-11-28T21:45
furrow set t-8x6qn --due 2026-11-28T21:55
furrow set t-kcdqp --due 2026-11-28T22:00
furrow set t-qfnd4 --due 2026-11-29
furrow set t-r84n7 --due 2026-12-12
furrow set t-4cq1g --due 2026-12-01T21:00
furrow set t-sgpfv --due 2026-12-03
furrow set t-f0stz --due 2026-12-10
furrow set t-245zs --due 2026-12-02
furrow set t-bxkk1 --due 2026-11-29T12:00
furrow set t-gjxws --due 2026-12-05T20:00
furrow set t-m8hc7 --due 2026-12-08
furrow set t-2sct2 --due 2026-12-12
furrow set t-y5mxq --due 2026-11-22T21:00
furrow set t-a9cnz --due 2026-11-23T21:00
furrow set t-70evb --due 2026-11-28T16:00
furrow set t-5mn77 --due 2026-11-28T16:20
furrow set t-e2yf0 --due 2026-11-28T16:45
furrow set t-z45bj --due 2026-11-28T16:30
furrow set t-8x2vs --due 2026-11-28T19:00
furrow set t-vk0kf --due 2026-11-28T16:40
furrow set t-p2sb7 --due 2026-11-28T16:00
furrow set t-1bghx --due 2026-11-28T16:50
furrow set t-t770e --due 2026-11-28T17:30
furrow set t-bk5re --due 2026-11-28T18:45
furrow set t-b71f5 --due 2026-11-28T19:30
furrow set t-836kh --due 2026-11-28T21:00
furrow set t-z564r --due 2026-11-28T20:45
furrow set t-xb97g --due 2026-11-26T21:00
furrow set t-v8km8 --due 2026-11-21T21:00
furrow set t-mkrf6 --due 2026-12-19

# ── 4. the one date a mechanical +7 gets wrong ─────────────────────────────
# t-18gd9's body pins the trial cook to "11/03（祝）13:00-18:00" — a 5-hour
# window that exists because 11/03 is a holiday. +7 = 11/10 (Tue), a weekday
# with 2 evening hours. It cannot simply stay on 11/03 either: its dependency
# t-rek26 lands there. Nearest slot of the same KIND after t-rek26: Sat 11/07.
furrow set t-18gd9 --due 2026-11-07
furrow note t-18gd9 '前提を退役: 「11/03（祝）13:00-18:00 で試作」は 11/28 開催では成立しない（+7 の 11/10 は平日で夜 2 時間しか取れず、11/03 は依存する t-rek26 の期日になった）。同じ 5 時間枠を持つ 11/07(土) に移した。同日は t-fg902 の肉リハーサル 1 回目（D-21 土）と重なるので、火入れは 1 枠にまとめて実施する。'

# ── 5. the 9 bodies whose prose names an absolute date ─────────────────────
# `furrow edit --body` REPLACES the whole body, so each of these retypes the
# body verbatim with only the dated lines changed. Shown abbreviated; the
# real run pastes each full body.
furrow edit t-74ffs --body - <<'EOF'   # D-14(11/7土)->(11/14土), UNTIL D-1（11/20）->（11/27）, 最後の回 D-7（11/14土）->（11/21土）
…（全文。日付行のみ差し替え）…
EOF
furrow edit t-g92fz --body - <<'EOF'   # 生鮮は D-1（11/20）-> （11/27）
…
EOF
furrow edit t-fjrkx --body - <<'EOF'   # 受取は D-1（11/20 金）-> （11/27 金）
…
EOF
furrow edit t-rzk8j --body - <<'EOF'   # 11/14(土) までに電話 -> 11/21(土)
…
EOF
furrow edit t-q2ke1 --body - <<'EOF'   # 回答期限 10/10(D-42) -> 10/17(D-42); 配布 9/28 -> 10/5
…
EOF
furrow edit t-pvpwd --body - <<'EOF'   # 回答期限は D-42（10/10）-> （10/17）
…
EOF
furrow edit t-nt65v --body - <<'EOF'   # 10/17（土）から開始 -> 10/24（土）
…
EOF
furrow edit t-16hvj --body - <<'EOF'   # UNTIL(10/11 — 回答期限 10/10 の次の日曜) -> (10/18 — 10/17 の次の日曜)
…
EOF
furrow edit t-18gd9 --body - <<'EOF'   # 11/03（祝）の 2 行 -> 11/07（土）
…
EOF
# the one checklist row that carries a date
furrow check t-pvpwd 2 --reword '回答期限を10/17と明記する'   # index re-read first: check indexes are positions in the CURRENT list

# ── 6. notes retiring the 前提 that stopped being true (CLAUDE.md: note,
#      not a rewrite) ─────────────────────────────────────────────────────
furrow note t-w06qv '（履歴として残す。11/28 への変更は再打診 task を起票して追う）'   # DROPPED — see hesitation 11: a done body is history, no note either
furrow note t-a014x '前提を退役: 出席 12 名の母集団は 11/21 前提で集めた回答（OK 9 / NG 1「11/21 出張」/ 未返信 2）。開催日が 11/28 になったため NG 1 名の理由が消える可能性がある。再打診 task の回答が出るまでこの task の「補欠で埋める」判断は保留。'
furrow note t-qw8jc 'C 会場に送った見積依頼は 11/21 の枠に対するもので、11/28 では見積そのものが引き直しになる。due（9/22 の督促期限）は先方に明記済みの日付なので動かさない。11/28 の空き再照会 task と束ねて 1 本の連絡にする。'
furrow note t-cfqge '前提を退役: 「申込は 10/4 17:00 まで / 入金は 10/12 まで」は 11/21 の見積に付いていた期限。11/28 の枠では先方が出し直すため、期限が判明するまで due は動かさない（+7 すると先方の言っていない期限を捏造することになる）。'
furrow note t-p3cnk '前提を退役: 入金期限 10/12 は 11/21 の見積の条件。11/28 の見積を取り直してから due を引き直す。'
furrow note t-19nfz '前提: 決定の母集団は 11/28 の空き回答で変わる。比較表の「当日予約済みで候補外」（F）は 11/21 についての判定で、11/28 では候補に戻り得る。due は会場側の申込期限（10/4）より前に置く必要があるため +7 しない。'
furrow note t-g61ny 'due と body の 10/1(木) 14:00 / 10/3 は先方と約束済みの日付。開催日の変更では動かさない。'
furrow note t-r6xpt 'repeat の UNTIL は +7 しない: 12/27 -> 1/3 にすると最後の督促が年始に落ちる。アンカーだけ D+8（12/6）に移し、終了日は 12/27 に据え置く。'
furrow note t-1swgk '（履歴。11/28 での空き状況は再照会 task で取り直す）'   # DROPPED — done body is history

# ── 7. the work the reschedule CREATES (CLAUDE.md: redo work is a new task
#      with a dep on the one it replaces) — one batch = one write ─────────
furrow add --batch - <<'EOF'
{"key":"recanvass","title":"開催日 11/28 をゲスト 12 名に再打診して可否を取り直す","epic":"e-0w7hf","status":"ready","due":"2026-09-30","deps":["t-w06qv"],"labels":["guest-comms","schedule","guests"],"value":5,"effort":2,"check":["11/28 で全 12 名に可否を送る","11/21 NG だった 1 名（出張）に改めて可否を聞く","回答を t-a014x に引き渡す"],"body":"目的: 開催日が 11/28 になったので、11/21 前提で集めた一次回答をやり直し、出席 12 名の母集団を取り直す。\n完了条件: 12 名全員の 11/28 での可否が集まり、OK/NG/未返信の内訳が body に残っている。\n前提: 11/21 の回答は [[t-w06qv]] に記録済み（OK 9 / NG 1「11/21 出張」/ 未返信 2）。NG 1 名は日付が理由なので 11/28 なら出席可の可能性がある。\n次の一手: 11/21 と同じ文面の日付だけ差し替えて送る。"}
{"key":"reinquire","title":"候補 A/B/C と落選した F に 11/28 の空き状況を再照会する","epic":"e-0w7hf","status":"ready","due":"2026-09-28","deps":["t-3nc93"],"labels":["venue-selection","external-wait","booking"],"value":5,"effort":1,"check":["A/B/C に 11/28 17:00-22:00 の空きを確認する","F の 11/28 の空きを確認する（11/21 は予約済みで候補外だった）","比較表の状態列を 11/28 の回答で置き換える"],"body":"目的: 比較表の空き状況は 11/21 についての回答。11/28 では全件やり直しになる。\n完了条件: A/B/C/F の 11/28 での空きと通し料金が比較表に入り、候補外の判定が 11/28 基準で付け直されている。\n前提: F は「当日予約済みで候補外」だった（notes/venue-compare.md）。落選理由が日付なので 11/28 では候補に戻り得る。戻る場合は cand-f label を新設して該当 task に付ける。\n前提: 送付文面は notes/venue-inquiry-template.md。9/14 送信ぶんは履歴として残し、11/28 ぶんを追記する。"}
{"key":"redeadline","title":"11/28 の見積で会場の申込・入金期限を取り直して due を引き直す","epic":"e-0w7hf","status":"backlog","due":"2026-10-05","deps":["reinquire"],"labels":["venue-selection","contract","deadline-hard","money"],"value":4,"effort":1,"check":["申込期限を先方から書面で取る","入金期限を先方から書面で取る","t-cfqge と t-p3cnk の due を回答値に合わせる"],"body":"目的: 「申込 10/4 17:00 / 入金 10/12」は 11/21 の見積の条件。11/28 の枠では先方が出し直すので、期限を取り直してから due を置く。\n完了条件: 申込期限と入金期限が書面で取れ、[[t-cfqge]] と [[t-p3cnk]] の due がその値になっている。\n前提: この 2 件は +7 しない（先方の言っていない期限を作らないため）。"}
EOF
# the handoff the new task names must exist as an edge (CLAUDE.md: deps are
# the truth) — ids from the batch report
furrow dep t-19nfz --add <reinquire-id>
furrow dep t-a014x --add <recanvass-id>

# ── 8. the hand-written tables (notes/ carries the old date in 2 files) ────
# notes/dietary-form.md:5   回答期限: 2026-10-10（開催日の D-42）-> 2026-10-17
# notes/venue-inquiry-template.md:16,18  送信済み文面はそのまま残し、
#   「11/28 ぶん（再照会）」として 2026-11-28(土) 版の件名と本文を追記
# notes/venue-compare.md    状態列（F の「当日予約済みで候補外」を含む）は
#   再照会の回答が来てから 11/28 基準で書き換える。今回は 1 行の注記だけ:
#   「空き状況は 11/21 についての回答。11/28 での再照会中」
# notes/site-visit-checklist.md  10/1・10/3 は先方と約束済み。変更なし。

# ── 9. close ──────────────────────────────────────────────────────────────
furrow lint                 # expect: due-overdue t-16hvj / t-qw8jc still red (held on purpose), due-today gone
furrow ls -q 'has:due' --json | jq -r '.[] | [.id,.due] | @tsv'   # re-read the 96 dues and diff against the intended table
furrow sync
```

Two lines above are struck through deliberately: the `furrow note` on
t-w06qv and on t-1swgk. CLAUDE.md says a done task's body is history and is
never rewritten — appending a note still stamps `updated` and edits the
file, so the reschedule is recorded on the NEW tasks instead. They are left
visible here because writing them was my first instinct and the rule that
stopped me is one line long.

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow epic show 会場 --json` | CLAUDE.md gives the command with `会場`, but `brief` had shown the box as `e-0w7hf 会場と日程を確定する`. I did not know whether `会場` was an id alias, a slug, or a title substring, so I ran the documented form AND the id form and compared the two outputs. | that `会場` is a unique title substring and both resolve to the same box (it did). | a line of prose — CLAUDE.md writing the id it means: "`furrow epic show e-0w7hf --json \| jq -r .meta.event_date` (venue box; `会場` also resolves as a title substring)". | no |
| 2 | `furrow ls --json` | I needed every due including `done` and `icebox`, and `ls --help` never states which lanes the default listing covers (it has no `--all`). Ran an unplanned second listing with all seven lanes named explicitly to check the counts matched. | that a bare `ls` lists every lane (100 = 100, so it does). | a line in `ls --help`: "with no `-s`, every lane is listed, terminal lanes included". | no |
| 3 | `furrow show <100 ids>` | I passed the id list through a shell variable; zsh does not word-split it, so furrow received all 100 ids as ONE argument and answered `not-found` with the whole blob as `subject` and as `details.missing[0]`. I had to re-run. | that the failure was my quoting, not a furrow bug. | a furrow change: reject an id argument containing whitespace with its own message ("one argument held 100 ids — did the shell fail to split?") instead of reporting it as one missing id. | no |
| 4 | deciding WHICH dues move | Nothing on the board marks a due as derived-from-`event_date` versus fixed-by-someone-else. `event_date` is free-form epic meta that no furrow code reads. To classify 96 dues I read all 100 bodies and sorted them by hand. | that `D-N`/`D0`/`D+N` in a body means derived, and a named external commitment (a deadline already sent, a booked appointment, a venue-set deadline) means fixed. 78 shift, 14 hold, 4 are history. | a furrow change: a due expressed relative to its box — `--due D-7` stored as an offset against `epic.meta.event_date`, so one `epic set --meta` moves the whole board and nothing else needs touching. | no |
| 5 | `furrow set --due` | I assumed `--due +7d` would push each existing due by a week and planned ONE bulk `set -q 'has:due' --due +7d`. `set --help` says the offset is "the snooze, measured from now" — there is no relative shift at all, so 78 absolute datetimes have to be typed, each one a chance to mistype. | that typing all 78 is the only route (it is). | a furrow change: `furrow set … --shift-due +7d` (or `--due` accepting a `~+7d` form meaning "relative to the stored value"), which is what a reschedule actually needs. | no |
| 6 | `furrow set --due` for the 24 timed tasks | `ls --json` renders dues as UTC instants (`2026-11-21T07:00:00Z`) while `--due` takes a bare local datetime. To keep a 16:00 load-in at 16:00 I had to convert every instant into Asia/Tokyo first, with an unplanned `date` script. `set --help` never names the zone a bare datetime is parsed in. | that a bare `--due 2026-11-28T16:00` is read in the board's `timezone` (`Asia/Tokyo`, from `furrow board`). | a line in `set --help`: "a bare date or datetime is interpreted in the board's `timezone`". | no |
| 7 | `furrow set` on the 6 repeating tasks | `--due` on a repeating task "moves THIS occurrence only — the series anchor never moves", so a reschedule needs `--due` and `--repeat` in one write even when the rule text is unchanged (t-csy5w, t-4zw13). I also had to guess that the stored `UNTIL=20261121T235959Z` may be handed back verbatim with the date bumped. | that `--repeat '<raw RRULE>'` with the bumped `UNTIL` is accepted as-is ("a raw RRULE line also works, minus a DTSTART"). | a line of prose — an example under `set --help`: "re-anchor a series a week later: `--due <new date> --repeat '<same rule, UNTIL bumped>'`". | no |
| 8 | `furrow set t-16hvj --repeat …` | For the one task whose due I hold but whose `UNTIL` must move, I could not tell whether `--repeat` alone re-anchors the series to the existing (overdue) due or leaves the anchor where it is. | that `--repeat` alone anchors to the task's existing due and so is safe with no `--due`. | a line in `set --help` saying explicitly what `--repeat` without `--due` does to the anchor. | no |
| 9 | `furrow set t-18gd9 --due` | The body pins the trial cook to "11/03（祝）13:00-18:00" — a 5-hour window that exists only because the day is a holiday. A mechanical +7 gives 11/10, and to know that 11/10 is NOT a holiday I had to use a Japanese holiday calendar the board does not carry. Then an unplanned `furrow dep t-18gd9 --list` to test whether it could just stay on 11/03 — it cannot, its dependency t-rek26 lands there. | that the rule is "same KIND of slot, not same weekday", so 11/07 (Sat, 5 hours, after t-rek26) is the move, and the 前提 gets retired with a note. | a line of prose in CLAUDE.md: 「祝日・半休・週末の枠を前提にした task は body にその枠種を書く。reschedule では同じ日数ではなく同じ枠種を探す」. | no |
| 10 | `furrow set t-cfqge / t-p3cnk --due` | Their dates (申込 10/4 17:00, 入金 10/12) are the VENUE's deadlines, quoted for the 11/21 booking. +7 invents deadlines the venue never gave; holding them puts the venue decision (t-19nfz, itself due 10/3) inside a window whose terms no longer exist. Either way the board is wrong until the venue answers. | hold all three, file a new task to re-derive the two deadlines from the 11/28 quote, and note the retired 前提 on each. | a furrow change: mark a due as externally set (`--due 2026-10-04 --external`, excluded from any bulk reschedule) so a session can tell a promise from a plan. | no |
| 11 | `furrow note t-w06qv` | t-w06qv is `done` and its 結果 records 「OK 9 / NG 1（11/21 出張）/ 未返信 2」. At 11/28 that NG may become OK, so the headcount of 12 is no longer established — but the body is history. I wrote the note command, then deleted it. | that even an append is a rewrite of history, so the re-canvass becomes a NEW task with a dep on t-w06qv, and the note goes on the still-open t-a014x instead. | a line of prose in CLAUDE.md: 「done task の body は history。`furrow note` も含めて触らない」 (today's line says "never rewrite it", which does not obviously cover an append). | no |
| 12 | reading `notes/venue-compare.md` | Candidate F is excluded as 「当日予約済みで候補外」 — a reason true only of 11/21. At 11/28 F may re-enter, and A/B/C's 一次返信 was availability for 11/21 only, so the whole 状態 column is stale. CLAUDE.md's candidate vocabulary (`cand-a`/`cand-b`/`cand-c`) has no `cand-f`. | leave the table's 状態 column alone until the re-inquiry answers, add one dated note-line saying it is 11/21-based, and create `cand-f` only if F actually returns. | a line of prose in CLAUDE.md: 「候補の空き状況は開催日ごとの回答。日程変更では落選理由も含めて全件無効になる」. | no |
| 13 | `furrow edit --body` | Nine bodies need one parenthetical date changed, and `--body` REPLACES the whole body — there is no in-place edit, so each of the nine is retyped verbatim and a typo silently destroys prose that is the board's only progress record. CLAUDE.md also says a stale 前提 is retired with `furrow note`, "never the prose", which reads as forbidding exactly this rewrite. | that the rule is about a premise that became FALSE (note it) and not about a derived date that simply moved (rewrite it), and do both where both apply. | a furrow change: `furrow edit <id> --replace '<old>=<new>'` — an in-place body substitution that stamps `updated`, so a date fix is not a full retype. | no |
| 14 | editing `notes/venue-inquiry-template.md` | The file records what was actually SENT on 9/14 ("状態: 確定"), with 11/21 in the subject line. CLAUDE.md's history rule names done task BODIES, not the `notes/` artifacts a done task produced, so I had to decide whether the sent text may be rewritten. | that a sent artifact is history too: leave the 9/14 text intact and append an 11/28 re-inquiry block below it. | a line of prose in CLAUDE.md: 「done task の成果物 notes/ も history。追記で更新する」. | no |
| 15 | `furrow check t-pvpwd --reword` | t-pvpwd is due TODAY and its checklist row 「回答期限を10/10と明記する」 holds the old D-42 date. I had to decide whether the question-text task itself slips a week, and then read `check --help` (unplanned) to find `--reword` and to learn indexes are positions in the CURRENT list. | hold the due (slipping it only delays the chain; nothing about the question text depends on the date) and reword the row to 10/17 after re-reading the index. | a config/lint addition: a check that a checklist row or body line contains a date matching no due on the board. | no |
| 16 | `furrow set t-nt65v --due` | Its due is the START of a weekly budget tally. The date is `event_date - 35d` by arithmetic, but the body only says 「10/17（土）から開始し、開催日…の週まで」. Shifting the start leaves a week of spending untracked; shifting only the `UNTIL` leaves the body's 10/17 correct. | shift both (keep it a clean +7) and rewrite the body's 10/17, because a series whose start does not move stops being D-N-anchored and the next session cannot tell which. | a line of prose in the body — 「開始は D-35 起点」 or 「開始は 10/17 固定」 — either one settles it. | no |
| 17 | `furrow set t-16hvj --due` | It is overdue since 9/20 and repeats weekly. A mechanical +7 puts it at 9/27, in the future, which clears a `lint` error without the dunning having been sent. | hold the due (the overdue work is still owed) and move only the `UNTIL`, which is chained to the form deadline. | a lint code — and this one exists: lint reports the overdue state that made me stop. | yes: due-overdue |
| 18 | `furrow set t-qw8jc --due` | Same shape, worse: overdue 9/22, `waiting`, and 「返信期限は 9/22 と明記」 — the date was already stated to venue C. Meanwhile the thing being chased (C's quote for 11/21) is itself void at the new date, so the chase changes content, not just date. | hold the due, note that the quote must be re-requested for 11/28, and fold the chase into the re-inquiry task. | a lint code — again the one that fired. | yes: due-overdue |
| 19 | writing this log | I wanted to open an existing file under `docs/drills/runs/` to match the log's shape, and `docs/` is explicitly not given. Went without. | that the section list in the request is the whole contract. | a line of prose in the drill protocol: the log skeleton inline, so no run needs to read a sibling log. | no |
| 20 | `.furrow/config.toml` | I wanted `[labels]` (would a new `cand-f` be refused?) and `[due]` (how is a bare `--due` date parsed?). `furrow config` (read) is not in the protocol's Allowed list, only `config set` is named as forbidden, and the board is to be read "through the `furrow` CLI" so opening the file is out too. Went without. | that `furrow board`'s `labels_required: false` line is enough, and that a new label is free. | a line of prose in the protocol: add `config` (read) to the Allowed list. | no |
| 21 | `furrow lint --json` | I ran it to enumerate findings for this table's last column, filtered `.findings[]`, and got nothing — the command exits 2 and prints an error envelope, so I fell back to the plain output and an unplanned `lint --help` for the code list. Only later did a raw look show `--json` emits a bare top-level ARRAY, not an object with `findings`. | the codes from the plain-text run (right answer, wrong route). | a line in `lint --help` naming the `--json` shape ("an array of {severity, code, id, message}"), since the envelope on stderr reads like a total failure. | no |
| 22 | `furrow set t-csy5w --due` | Whether its 2027-05-20 anchor is event-derived at all. Its sibling t-4zw13 says 「開催日(会場 epic の meta event_date)の 1 年後」 outright; t-csy5w's body says only 「半年間隔は仮置き」. I verified by arithmetic that 2026-11-21 + 180d = 2027-05-20 and shifted it. | that the arithmetic fit is not a coincidence and the anchor is derived. | a line of prose in t-csy5w's body, matching t-4zw13's: 「開催日の半年後に初回」. | no |
| 23 | `furrow set t-r6xpt --repeat` | Mechanical +7 moves the collection-reminder `UNTIL` from 12/27 to 2027-01-03, putting the last dunning inside the New Year break. The series end is a calendar fact, not an event-derived one, but nothing on the board says so. | shift only the anchor (D+8, to 12/6) and hold `UNTIL=20261227`. | a line of prose in the body: 「UNTIL は年内で打ち切る。開催日の +7 では動かさない」. | no |
| 24 | planning the `notes/` edits | Whether `notes/` is in scope at all: the request says "the whole board", the drill says nothing else in the repository is written or edited. The plan is never executed, so a planned edit is not a write — but I stopped to work that out. | that a plan may name `notes/` edits, and wrote them as comments rather than commands so nothing in the block could be pasted into a write by accident. | a line of prose in the protocol: whether the plan's scope includes the repo's hand-written tables. | no |

## Verdict

- `could_act_confidently: false`
- Why: the mechanical half is reachable — the event date sits in one place
  and 78 dues shift by a fixed week — but the board carries no way to tell a
  due that is derived from the event date from one that was promised to
  somebody else, so every one of the 14 holds and all three new tasks rest
  on my reading of prose rather than on anything the board asserts, and one
  mechanical shift (t-18gd9's holiday window) is outright wrong.
- hesitations: 24
- rows answering `yes` in the last column: 2 (both `due-overdue`, both on
  the question of whether an overdue due may be pushed — lint sees the
  overdue state, never the reschedule)
