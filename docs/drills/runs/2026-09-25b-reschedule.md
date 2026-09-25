# Drill run — reschedule (2026-09-25b)

Request: "The dinner moves one week later, from 2026-11-21 to 2026-11-28.
Bring the whole board in line: every date, every task whose plan assumed the
old date, and anything that no longer makes sense at the new one."

## Measured on

- Board commit: `1fca1cb` (akira-toriyama/furrow-test, clean)
- furrow version: `furrow dev` (built from furrow main at `eb85970`)
- Run: 2026-09-25 (Fri) 15:39–15:48 JST
- Board: 100 tasks / 5 boxes / schema v10, repo-local, mode `shared`,
  `timezone = "Asia/Tokyo"`. `furrow lint` at start: 4 errors
  (`due-overdue` ×4), 0 warnings.
- Session: a Claude Code subagent on Opus, handed only this request, the
  drill rules, the recording format, the repo's `README.md` and `CLAUDE.md`,
  and the board through the `furrow` CLI, the files under `.furrow/`, and
  `notes/`. No `docs/`, no `seed/`, no prior knowledge of this board.
- The operator had already run `furrow sync`; this run never ran it. The run
  is read-only: nothing below was executed.

## Plan

```sh
# ---- orient (read-only) -------------------------------------------------
furrow sync && furrow brief
furrow epic show 会場 --json | jq -r .meta.event_date     # 2026-11-21
furrow ls --json | jq -r '.[] | [.id,.status,.due,.title] | @tsv'
furrow lint
grep -rn '固定' .furrow/bodies/                            # the frozen dates
grep -rnE 'D-[0-9]+|D\+[0-9]+|[0-9]{1,2}/[0-9]{1,2}' .furrow/bodies/ notes/

# ---- 1. the one place the event date lives ------------------------------
furrow epic set 会場 --meta event_date=2026-11-28

# ---- 2. derived dues: +7d --------------------------------------------—--
# Shifted: every OPEN task carrying a due (91 of them) minus the exceptions.
# NOT shifted: the 4 done tasks (a done task's due is history) and the three
# 固定 dues — t-76q4d (申込 10/4 17:00, venue-set), t-j8jh0 (入金 10/12,
# venue-set), t-v8qs5 (11/03, chosen because it is a public holiday).
# t-pafaq DOES shift: its 固定 line freezes A's 10/1 appointment but says
# B's 10/3 — which is what the single due carries — is the operator's own.
# `--due +7d` is measured from NOW, not from the task's own due, so every
# target instant is spelled out; ids sharing a target go in one write.
# (Instants are the stored UTC values; a bare date would bind 23:59:59 JST
# and flatten the 07:00Z-style day-of times.)
furrow set t-2sjvt --due 2026-09-29T09:00:00Z
furrow set t-ec9cd --due 2026-10-03T14:59:59Z
furrow set t-hjkxq t-4kawk --due 2026-10-01T14:59:59Z
furrow set t-2bjdh t-c1yqw --due 2026-10-04T14:59:59Z
furrow set t-0298a --due 2026-10-06T14:59:59Z
furrow set t-b3crp --due 2026-10-07T14:59:59Z
furrow set t-pafaq --due 2026-10-10T09:00:00Z
furrow set t-3m6x2 --due 2026-10-10T14:59:59Z
furrow set t-axk0n t-gccr4 --due 2026-10-17T14:59:59Z
furrow set t-t62zh t-jktmd --due 2026-10-21T14:59:59Z
furrow set t-n1av9 --due 2026-10-23T14:59:59Z
furrow set t-0y0cv --due 2026-10-24T14:59:59Z
furrow set t-sxnkt --due 2026-10-27T14:59:59Z
furrow set t-4298t t-xpvh6 --due 2026-10-29T14:59:59Z
furrow set t-et09k t-8c6xr t-q5mf4 --due 2026-10-31T14:59:59Z
furrow set t-xgv1e --due 2026-11-03T14:59:59Z     # see the note in step 7
furrow set t-mqmk2 --due 2026-11-04T14:59:59Z
furrow set t-hsz0x --due 2026-11-08T14:59:59Z
furrow set t-1jm7j --due 2026-11-12T14:59:59Z
furrow set t-0bzck --due 2026-11-13T14:59:59Z
furrow set t-ratkj --due 2026-11-14T09:00:00Z
furrow set t-fpx4c --due 2026-11-14T14:59:59Z
furrow set t-mjnzg t-22yf7 --due 2026-11-15T14:59:59Z
furrow set t-zvykb t-9k4eg --due 2026-11-16T14:59:59Z
furrow set t-1t57s --due 2026-11-18T14:59:59Z
furrow set t-xe8j3 --due 2026-11-19T14:59:59Z
furrow set t-9nvxf --due 2026-11-20T14:59:59Z
furrow set t-dwbkq --due 2026-11-21T03:00:00Z
furrow set t-6stn3 --due 2026-11-21T12:00:00Z
furrow set t-9sy7z t-m2c48 --due 2026-11-21T14:59:59Z
furrow set t-4pyc9 --due 2026-11-22T12:00:00Z
furrow set t-kt1bn --due 2026-11-22T14:59:59Z
furrow set t-g5qjj --due 2026-11-23T12:00:00Z
furrow set t-2ksag t-hbdt1 --due 2026-11-25T14:59:59Z
furrow set t-gjak9 --due 2026-11-26T12:00:00Z
furrow set t-s18x8 --due 2026-11-26T14:59:59Z
furrow set t-db435 --due 2026-11-27T02:00:00Z
furrow set t-ck97a --due 2026-11-27T06:00:00Z
furrow set t-tfg2m --due 2026-11-27T09:00:00Z
furrow set t-wcxh9 --due 2026-11-27T12:00:00Z
furrow set t-s2mdy --due 2026-11-27T13:00:00Z
furrow set t-bxy6s t-ysfgk --due 2026-11-28T07:00:00Z
furrow set t-bjf3j --due 2026-11-28T07:20:00Z
furrow set t-3k7ca --due 2026-11-28T07:30:00Z
furrow set t-6cprh --due 2026-11-28T07:40:00Z
furrow set t-9nest --due 2026-11-28T07:45:00Z
furrow set t-pbn8p --due 2026-11-28T07:50:00Z
furrow set t-ywwk0 --due 2026-11-28T08:30:00Z
furrow set t-rsc60 --due 2026-11-28T09:45:00Z
furrow set t-bn5bb --due 2026-11-28T10:00:00Z
furrow set t-vbkb6 --due 2026-11-28T10:30:00Z
furrow set t-8rx4p --due 2026-11-28T11:45:00Z
furrow set t-766g2 --due 2026-11-28T12:00:00Z
furrow set t-trrw8 --due 2026-11-28T12:30:00Z
furrow set t-h2mqg --due 2026-11-28T12:40:00Z
furrow set t-ha07c --due 2026-11-28T12:45:00Z
furrow set t-ax9qn --due 2026-11-28T12:55:00Z
furrow set t-v18ak --due 2026-11-28T13:00:00Z
furrow set t-chne9 --due 2026-11-29T03:00:00Z
furrow set t-ax1aw --due 2026-11-29T14:59:59Z
furrow set t-2vhps --due 2026-12-01T12:00:00Z
furrow set t-dzf7b --due 2026-12-02T14:59:59Z
furrow set t-2hf6s --due 2026-12-03T14:59:59Z
furrow set t-nhmbp --due 2026-12-05T11:00:00Z
furrow set t-y5bn5 --due 2026-12-08T14:59:59Z
furrow set t-3890v --due 2026-12-10T14:59:59Z
furrow set t-63vjr t-6j81q --due 2026-12-12T14:59:59Z
furrow set t-j4cj7 --due 2026-12-19T14:59:59Z

# ---- 3. the 7 repeating tasks ------------------------------------------
# The UNTIL is a derived date INSIDE the rule text (D-1 / D-7 / D0 / D+36),
# and `--due` alone never re-anchors a series (`furrow set --help`), so the
# due and the rule go in ONE write.
furrow set t-9dk3k --due 2026-10-24T14:59:59Z --repeat 'FREQ=WEEKLY;UNTIL=20261128T235959Z;BYDAY=SA'
furrow set t-hr81x --due 2026-11-07T09:00:00Z --repeat 'FREQ=WEEKLY;UNTIL=20261121T235959Z;BYDAY=SA'
furrow set t-k6p6x --due 2026-11-14T14:59:59Z --repeat 'FREQ=WEEKLY;UNTIL=20261127T235959Z;BYDAY=SA'
furrow set t-x2xs6 --due 2026-12-06T11:00:00Z --repeat 'FREQ=WEEKLY;UNTIL=20270103T235959Z'
furrow set t-av93v --due 2027-05-27T14:59:59Z --repeat 'FREQ=MONTHLY;INTERVAL=6'
furrow set t-w0jz4 --due 2027-11-28T14:59:59Z --repeat 'FREQ=MONTHLY;INTERVAL=12'
# t-zw0h1's 9/20 occurrence is LAPSED, and CLAUDE.md says a lapsed repeat's
# due is not pushed — so only the UNTIL moves, and `--repeat` alone
# re-anchors to the due the task already carries.
furrow set t-zw0h1 --repeat 'FREQ=WEEKLY;UNTIL=20261018T235959Z'

# ---- 4. body lines that spell a derived date ----------------------------
# edit --body replaces the WHOLE file; every untouched line is re-emitted
# verbatim. Dates recording something that already happened (9/12 の DM,
# 9/14 送信, 9/16・9/17 一次返信, 9/22 の電話催促) stay as written.
furrow edit t-axk0n --body -   # 次の一手: 「9/28 までに配布」→ 10/5、「回答期限は 10/10(D-42)」→ 10/17(D-42)
furrow edit t-hjkxq --body -   # 前提: 「回答期限は D-42（10/10）」→（10/17）
furrow edit t-0298a --body -   # 次の一手・逃がし: 「9/27 までに返事が無ければ補欠へ」→ 10/4（×2）
furrow edit t-pafaq --body -   # 次の一手・固定: B の「10/3」→ 10/10。A の 10/1(木) 14:00 は据え置き
furrow edit t-k6p6x --body -   # 「D-14(11/7 土)」→(11/14 土)×2、「UNTIL に D-1（11/20）」→（11/27）、「最後の回は D-7（11/14 土）」→（11/21 土）
furrow edit t-9dk3k --body -   # 次の一手: 「10/17（土）から開始」→ 10/24（土）
furrow edit t-x2xs6 --body -   # メモ: 「UNTIL=12/27」→ UNTIL=2027-01-03
furrow edit t-zw0h1 --body -   # 次の一手: 「9/20(日) 20:00」→ 9/27(日) 20:00、逃がし: 「UNTIL(10/11 — 回答期限 10/10 の次の日曜)」→（10/18 — 10/17 の次の日曜）
furrow edit t-ratkj --body -   # 前提: 「D-1（11/20 金）」→（11/27 金）
furrow edit t-mqmk2 --body -   # 前提: 「D-1（11/20）受け取り」→（11/27）
furrow edit t-dwbkq --body -   # 次の一手: 「11/14(土) までに電話」→ 11/21(土)

# ---- 5. checklist rows that spell a derived date (ZERO-based indexes) ---
furrow check t-hjkxq 3 --reword '回答期限を10/17と明記する'
furrow check t-pafaq 4 --reword 'B の下見枠を 10/10 までにもらう'
# t-2sjvt index 0 is already TICKED (the 9/22 18:00 call happened), so it is
# history: add the next chase rather than reword a done row.
furrow check t-2sjvt --add '9/29 18:00 時点で未着なら再度電話する'

# ---- 6. work the old date invalidated ----------------------------------
# A done task's body is history, so redo work is a NEW task with a dep on
# the one it replaces.
furrow add '開催日 2026-11-28(土) をゲスト 12 名に再打診して可否を取り直す' \
  -e 会場 -s ready -l guest-comms -l scheduling --value 5 --effort 2 \
  --due 2026-10-02T14:59:59Z --dep t-qxzdt \
  --check '12 名全員に 11/28(土) 17:00-21:00 の可否を送る' \
  --check '11/21 が NG だった 1 名（出張）に再度あたる' \
  --check '未返信 2 名にも 11/28 で再送する' \
  --check '出欠表を 11/28 の回答で作り直す' \
  --body '目的: 11/28 に動いた開催日でゲスト 12 名の可否を取り直す。/完了条件: 打診した 12 名全員について OK / NG / 未返信 のいずれかが 11/28 基準の出欠表に記録されている。/前提: [[t-qxzdt]] の 結果（OK 9 / NG 1 / 未返信 2）は 11/21 の回答で、日程変更により無効。NG 1 名の理由は 11/21 の出張なので 11/28 は空く可能性がある。/次の一手: LINE グループ + 個別 DM で 11/28 を送り、[[t-0298a]] の 12 名確定に渡す。'
furrow add '候補 3 件に 11/28(土) の空き・料金・申込/入金期限を再照会して比較表に反映する' \
  -e 会場 -s ready -l cand-a -l cand-b -l cand-c -l external-wait -l venue-selection \
  --value 5 --effort 2 --due 2026-10-02T14:59:59Z --dep t-2db3n \
  --ref file:notes/venue-compare.md:1 \
  --check 'A/B/C に 11/28(土) 17:00-22:00 の空き可否を照会する' \
  --check '通し料金が 11/21 の見積から変わるかを確認する' \
  --check '申込期限と入金期限を 11/28 基準で取り直す' \
  --check '比較表の基本情報／入館／キャンセルの各節に回答を転記する' \
  --body '目的: 11/21 で取った空き・料金・期限を 11/28 で取り直し、決定（[[t-3m6x2]]）が古い日付の回答に乗らないようにする。/完了条件: A/B/C それぞれについて 11/28 の空き可否・通し料金・申込期限・入金期限がメール本文で返り、比較表に転記されている。/前提: [[t-2db3n]] の照会は 11/21 前提。[[t-76q4d]] の 固定（申込 10/4 17:00・入金 10/12）はこの再照会で取り直す。/次の一手: notes/venue-inquiry-template.md に日程変更版の本文を追記して 3 宛先へ送る。'
# ids are minted on add — wire the reverse edges with the real ids
furrow dep t-0298a <new-poll-id>
furrow dep t-3m6x2 <new-venue-id>
furrow dep t-76q4d <new-venue-id>

# ---- 7. 前提/現状 lines that stopped being true (the line stays) --------
furrow note t-6stn3 '9/14 の口頭打診は 11/21 前提。開催日が 11/28 に動いたので、手伝い 2 名には 11/28 で「14:45 入り / 22:00 まで」を取り直す。完了条件そのものは変わらない。'
furrow note t-0298a '出欠の母集団が [[t-qxzdt]]（11/21 の一次回答）なので日程変更で無効。再打診 task を dep に足した。9/12 の個別 DM と 9/20 の督促は 11/21 前提の実績として残す。'
furrow note t-2sjvt '日程 +7 日に合わせて due（＝催促日）を 9/22 18:00 → 9/29 18:00 に引き直した。9/22 の電話催促は実績として残し、次の催促を checklist に足した。打ち切り期限も 1 週間後ろにずれる。'
furrow note t-76q4d '申込 10/4 17:00 / 入金 10/12 は 11/21 の予約に対する会場提示なので due は動かさない（固定）。日程変更の連絡と期限の取り直しは再照会 task が行う。取り直すまで dep の [[t-3m6x2]]（10/10）が自分の due より後ろになり、furrow lint が due-inversion を出す。'
furrow note t-j8jh0 '入金期限 10/12 は 11/21 の予約に対する会場提示なので据え置き（固定）。再照会で新しい期限が返ったら due を引き直す。'
furrow note t-v8qs5 '11/03 の試作枠は祝日で取った固定枠なので据え置き（D-18 → D-25）。ただし dep の [[t-xgv1e]] が +7 日で 11/03 23:59 に並び、レシピ清書と試作が同日になる。試作は 13:00-18:00 なので実務上は間に合わない。t-xgv1e を前倒すか試作枠を動かすかは未決。'
furrow note t-xgv1e '+7 日で 11/03 23:59 になり、dep 先の [[t-v8qs5]]（固定 11/03 13:00-18:00）と同日になった。due が同値なので lint の due-inversion は鳴らない。'

# ---- 8. notes/ (hand-kept; edited in the same change) -------------------
# notes/dietary-form.md L5: 「回答期限: 2026-10-10（開催日の D-42）」→「2026-10-17（開催日の D-42）」
# notes/site-visit-checklist.md L8: 表頭「B（枠待ち・10/3 期限）」→「B（枠待ち・10/10 期限）」。A（10/1 木 14:00 アポ済み）は据え置き
# notes/site-visit-checklist.md L26: 「B の枠が 10/3 までに出なければ」→「10/10 までに」
# notes/venue-compare.md L4: 「最終更新: 2026-09-24」→ 2026-09-25。開催日が 11/21 → 11/28 に動いた旨を 1 行足す
# notes/venue-compare.md L16: F 行の状態「当日予約済みで候補外」→「11/21 当日予約済み。11/28 の空きは未確認だが 15 名着席不可（12 席）で候補外のまま」
# notes/venue-inquiry-template.md L14-35: 本文は送信済みテキストなので書き換えない
# notes/venue-inquiry-template.md L8-12: 送信記録の表に 2026-09-25 の日程変更再照会の行を A/B/C 分だけ追加
# notes/venue-inquiry-template.md 末尾: 「## 本文（日程変更の再照会・2026-09-25）」を新節として追記（件名・本文の 11/21 → 11/28、返信期限 9/22 → 10/2）
git add notes/ && git commit -m ':memo:(notes)= re-anchor the hand-kept notes on 2026-11-28'

# ---- 9. verify and publish ---------------------------------------------
furrow lint    # expect: due-overdue clears except t-zw0h1's lapsed occurrence;
               # due-inversion (warn) on t-76q4d until the venue re-takes its deadlines
furrow sync
```

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow brief` | brief's `next` was capped (`3/4 — 1 hidden by -n`) and its `due` band only shows 4 rows, so I could not tell how many dated tasks the request touches | that the reschedule needs the whole board, and ran an unplanned `furrow ls --json` dump of all 100 tasks | a line of prose in CLAUDE.md: "a board-wide change starts from `furrow ls --json`, not `brief`" | no |
| 2 | `furrow lint` | only 4 `due-overdue` errors printed and nothing else — I did not know whether warnings are suppressed by default or simply absent | that warnings were absent; confirmed with `furrow lint --help` and `--severity warn` (`ok — no problems`) | a furrow change: print `0 warnings` explicitly instead of nothing | yes: due-overdue |
| 3 | `grep 固定 .furrow/bodies/` | `固定` is both the frozen-date marker AND an ordinary verb — 12 of the 16 hits are `…を固定する`, not markers | that a marker is a line beginning `固定:` (4 tasks: t-76q4d, t-j8jh0, t-v8qs5, t-pafaq) | a `config.toml` setting: a `[lint].fixed_date_marker` prefix the way `provenance_markers` already works, so the marker is a declared vocabulary and not a substring | no |
| 4 | deciding the span of the shift | CLAUDE.md says every due is derived from `event_date`, but the earliest band (9/20–10/4) is chase dates and deadlines for inquiries ALREADY SENT under the old date — shifting those looks like snoozing | that "derived" is literal: every non-`固定` due shifts +7, chase dates included | a line of prose: "a chase date is derived like any other: a reschedule moves it, and the chase is re-sent" | no |
| 5 | `furrow set --due` | there is no shift-by-offset: `--due +7d` is measured from NOW, so a bulk `set <91 ids> --due +7d` would flatten the whole board onto one instant | computed all 91 target instants myself and grouped the ids that share one (67 writes) | a furrow change: `furrow set --due-shift +7d`, an offset applied to each task's OWN due, usable with `-q`/`-l` selection | no |
| 6 | `furrow set` on the 7 repeating tasks | the `UNTIL` is a derived date (D-1 / D-7 / D0 / D+36) buried in the RRULE string, which no `--due` touches | re-read `set --help`, learned `--due X --repeat R` in ONE write re-anchors, and rewrote each `UNTIL` by hand | a furrow change: make `--due-shift` (row 5) move a series' `UNTIL` with its anchor | no |
| 7 | `furrow set t-zw0h1` | CLAUDE.md says a lapsed repeat's due "is not pushed to clear the lint", but a reschedule pushes every derived due — the two rules point opposite ways on the same field | kept the lapsed 9/20 anchor and moved only the `UNTIL` (`--repeat` alone re-anchors to the due already carried) | a line of prose: "a lapsed occurrence keeps its due through a reschedule; only the series' UNTIL moves" | yes: due-overdue (t-zw0h1 stays red either way) |
| 8 | `furrow set t-pafaq` | its `固定` line freezes A's 10/1 appointment but says B's 10/3 moves — and the task carries ONE due, which is B's 10/3 | that the due moves (+7 → 10/10) and the 10/1 in the prose stays | a furrow change: nothing — this is the board's "1 task, 2 deadlines" 逃がし; the prose already resolves it, I just had to read it twice | no |
| 9 | `furrow set t-xgv1e` | t-v8qs5's `固定` 11/03 does not move, but its dependency t-xgv1e shifts 10/27 → 11/03 23:59 — same instant, and the 試作 is 13:00-18:00 that day | tried holding t-xgv1e at 10/27; that inverts it against its OWN deps (t-4298t 10/29, t-et09k 10/31) and cascades back through the whole menu chain, so I shifted it and left a `furrow note` on both ends naming the zero slack | a furrow change: `due-inversion` should fire on an EQUAL due, not only a later one (a dependency finishing at 23:59 cannot feed work that starts at 13:00 the same day) | no |
| 10 | `furrow set t-76q4d` | freezing 10/4 while its dep t-3m6x2 moves to 10/10 knowingly leaves the board inverted | accepted it: the `固定` line prescribes re-taking the deadline with the venue, so the inversion is the standing flag until that lands | a lint code — `due-inversion` already covers it, but it does not fire on this board TODAY, only after the plan runs | no |
| 11 | done tasks' dues | 4 done tasks carry dues in the same derived series (t-qxzdt 9/10 = D-72, t-8vahe 9/7 = D-75) — "every due is derived" would shift them too | left them: "a done task's … title, due and 結果 stay as written" | a line of prose: name done tasks in the reschedule rule itself, not three bullets away | no |
| 12 | t-qxzdt (done) | the poll that fixed 11/21 is done, and its 結果 (OK 9 / **NG 1（11/21 出張）** / 未返信 2) is void at 11/28 — the NG may now be free — but a done body may not be rewritten | filed a NEW task with `--dep t-qxzdt`; had to invent its title, due (10/02, ahead of t-0298a and t-3m6x2), labels and body wording with no template on the board | a line of prose: "a reschedule's redo task inherits the replaced task's epic, labels and body template; its due is the replaced task's D-N, re-derived" | no |
| 13 | t-2db3n / t-8vahe (done) | the candidate pool and the 3-venue inquiry were both built on "11/21(土) 17:00-22:00 通し" — availability at 11/28 is unknown for every candidate | filed a second NEW task (re-inquiry: 空き・料金・申込/入金期限) with `--dep t-2db3n`, blocking t-3m6x2 and t-76q4d — and had to decide it is one task, not three per-candidate ones | a line of prose: "a reschedule re-asks the other side once per counterparty, not once per candidate" | no |
| 14 | `notes/venue-compare.md` F row | F's 状態 is 「当日予約済みで候補外」 — a 11/21-specific fact that a reschedule invalidates, so F might re-enter | that F stays out (12 席 fails the 15-名着席 knockout independently) and the cell is updated in place to the durable reason | a line of prose: "a candidate dropped for a date-specific reason is re-checked on a reschedule; one that also fails a knockout stays out" | no |
| 15 | `notes/venue-inquiry-template.md` | the 本文 spells `2026-11-21(土)` twice, but CLAUDE.md says a sent text inside a note "is appended to, never rewritten" | appended a dated 再照会 本文 section and new 送信記録 rows, leaving the original block verbatim | a line of prose: the rule is there — what is missing is where the re-issued text goes (new section vs new file) | no |
| 16 | `furrow check t-2sjvt 0 --reword` | the row spelling `9/22 18:00` is already TICKED, and rewording a ticked row to 9/29 would read as "already called on 9/29" | left it as history and `--add`ed a new chase row | a line of prose: "a ticked row is history like a done body: reword only unticked rows, add a new row for the next occurrence" | no |
| 17 | `furrow check` indexes | I had built the row list 1-based from `jq '.key+1'`; `check` is ZERO-based | re-dumped the shards' checklists to read the real indexes before writing the two `--reword` lines | a furrow change: accept `--text <exact row text>` as an alternative to a positional index, so a reword cannot land on the wrong row | no |
| 18 | historical vs forward dates in bodies | 6 dates (9/12 DM, 9/14 送信, 9/16・9/17 一次返信, 9/20 督促, 9/22 電話) record things that already happened; 11 others are promises. Nothing in the shard or the prose separates them | that a date describing a completed action stays and only forward-looking derived dates move | a line of prose: "a date in 待ち先/現状/結果 is a log and never moves; a date in 次の一手/前提/完了条件 is derived" | no |
| 19 | t-6stn3 | the helpers were asked verbally on 9/14 for 11/21, so the 前提 is stale — but its 完了条件 (14:45 入り / 22:00 まで) is date-independent | a `furrow note` retiring the 前提, no new task and no retitle | a line of prose: "a stale 前提 whose 完了条件 still holds is retired with a note; only a stale 完了条件 needs a redo task" | no |
| 20 | t-x2xs6's UNTIL | D+36 shifts 2026-12-27 → 2027-01-03, i.e. a payment-chase occurrence lands in the New Year holidays | shifted it mechanically; no calendar-awareness anywhere on this board | a `config.toml` setting: a `[due].holidays` list (or a holiday calendar) so a derived date landing on one is at least warned about | no |
| 21 | the 4 `due-overdue` errors | after +7, three of the four (t-hjkxq, t-2sjvt, t-4kawk) land in the future — CLAUDE.md forbids snoozing to make lint green, and this looks exactly like it | that a reschedule is not a snooze: the whole series moved, and t-zw0h1's lapsed occurrence deliberately stays red | a line of prose: "a reschedule may clear due-overdue; a per-task --due may not" | yes: due-overdue |
| 22 | `furrow set t-dwbkq` | after the shift, t-dwbkq (開催 1 週間前の最終確認) is due 2026-11-21 — the OLD event date — and several day-of tasks now sit on 11/28 07:00Z; I re-checked twice that I had not mixed old and new rows | confirmed against the computed table that 11/21 is now D-7 and 2026-11-28T07:00:00Z is 16:00 JST on the new day | a furrow change: have `set --due` echo the resulting local datetime AND its D-N against the box's `event_date`, so a derived date is verifiable at the point of writing | no |
| 23 | `furrow epic set --meta` | there is no read-back for one meta key (`furrow config` has no read form either) and the help does not say whether `--meta` preserves untouched keys (`slug`) | that `--meta` sets only the named key because `--rm-meta` exists as its own flag | a line of prose in `epic set --help`: "an unnamed meta key is untouched" | no |

## Verdict

`could_act_confidently: true` — every date on this board is mechanically
derivable (`event_date` + D-N), the `固定` lines name the four exceptions,
and the two done-task invalidations have an explicit rule ("redo work is a
new task with a dep"); what stopped me was almost entirely cost and
edge-cases, not ambiguity about what to do.

- Hesitations: 23
- Rows where `furrow lint` on this board actually reports it: 3 (rows 2, 7,
  21 — all the same `due-overdue` finding seen from three angles)

Most consequential:

1. **Row 5** (no `--due-shift`) — the entire deliverable degenerates into 67
   hand-computed absolute instants, and one arithmetic slip is silent.
2. **Row 9** (t-xgv1e lands on the frozen 11/03 with zero slack) — the only
   place where the reschedule produces a plan that cannot be executed, and
   `due-inversion` does not fire because the two dues are equal, not later.
3. **Row 12** (the 11/21 guest poll is done and its NG was date-specific) —
   the redo task is the whole reason "bring the board in line" is not just
   arithmetic, and the board carries no template for writing one.
