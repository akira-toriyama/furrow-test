# Drill run — reschedule (2026-09-28)

> The dinner moves one week later, from 2026-11-21 to 2026-11-28. Bring the
> whole board in line: every date, every task whose plan assumed the old date,
> and anything that no longer makes sense at the new one.

## Measured on

- `git rev-parse --short HEAD` → `c6f69aa`
- `furrow version` → `furrow dev` (no version string; `furrow board` was needed
  to learn the binary is schema v11 and the board writable)
- 2026-09-28, 20:09 JST (first measurement); board zone `Asia/Tokyo`
  (`[due].timezone` in `.furrow/config.toml`, echoed by `furrow board`)
- Board: 100 tasks, 5 boxes, 95 dated — 80 anchored to `e-1rxdr` (`会場と日程を確定する`,
  anchor 2026-11-21), 15 not. 7 repeating tasks, all in the un-anchored 15.
- Reads only; `git status` clean before and after.

## Plan

```sh
# ── 0. orient (operator already ran `furrow sync`)
furrow brief
furrow board                                    # schema v11 writable, timezone Asia/Tokyo
furrow epic show 会場 --json                     # anchor 2026-11-21, id e-1rxdr, slug venue

# ── 1. split the dated board in two BEFORE touching anything
furrow ls -q 'anchor:e-1rxdr'                    # 80 derived dues  (the ID: -q resolves no title substring)
furrow ls -q 'has:due no:anchor'                 # 15 fixed/repeat/done dues — decided one by one in §3-4
furrow lint --code anchor-undated,anchor-on-repeat   # must be silent: one repeating or undated follower
                                                 # makes `epic set --anchor` refuse the WHOLE move

# ── 2. the one mechanical move: 80 derived dues, +7 calendar days
furrow epic set e-1rxdr --anchor 2026-11-28       # PREVIEW — expect 80 moves, 0 kept, 0 refused
                                                  # (incl. the 1 icebox follower t-ebx1j; `is:open` covers icebox)
furrow epic set e-1rxdr --anchor 2026-11-28 --yes # one write. D-N distances, times of day and weekdays all survive:
                                                  # 2026-11-21 and 2026-11-28 are both Saturdays (checked with `date`)

# ── 3. the 7 repeating tasks — no anchor is possible on a series, so each is a hand write.
#      Re-anchor with --due + --repeat in ONE write; UNTIL keeps the board's existing
#      "local wall clock + Z" spelling (the dues use real UTC — the two differ, left as found).
# 3a. lapsed occurrence: due NOT pushed (CLAUDE.md); UNTIL follows the new 回答期限 10/17 → next Sunday 10/18
furrow set t-pq4pm --repeat 'FREQ=WEEKLY;UNTIL=20261018T235959Z'
# 3b. start day was chosen ("10/17（土）から開始"), so the due stays; UNTIL = 開催日の週の土曜 → 11/28
furrow set t-pmnx3 --repeat 'FREQ=WEEKLY;UNTIL=20261128T235959Z;BYDAY=SA'
# 3c. first round is D-21 (11/07 Sat), last is D-7 (11/21 Sat)
furrow set t-msexg --due 2026-11-07T18:00 --repeat 'FREQ=WEEKLY;UNTIL=20261121T235959Z;BYDAY=SA'
# 3d. first round is D-14 (11/14 Sat — same Saturday t-nz6ts lands, as its body claims), UNTIL D-1 (11/27)
#     the due MUST move: at 11/07 it would precede both its deps (t-v8w4w 11/13, t-nz6ts 11/14)
furrow set t-f429m --due 2026-11-14 --repeat 'FREQ=WEEKLY;UNTIL=20261127T235959Z;BYDAY=SA'
# 3e. +7d keeps the Sunday and puts it back behind t-wjj50 (→12/03); UNTIL 12/27 → 2027-01-03
furrow set t-xsy5a --due 2026-12-06T20:00 --repeat 'FREQ=WEEKLY;UNTIL=20270103T235959Z'
# 3f/3g. the two icebox next-time series: body of t-mdgcy names the anchor ("開催日…の 1 年後"), so both +7d
furrow set t-1zkfj --due 2027-05-27 --repeat 'FREQ=MONTHLY;INTERVAL=6'
furrow set t-mdgcy --due 2027-11-28 --repeat 'FREQ=MONTHLY;INTERVAL=12'

# ── 4. the un-anchored due whose own 固定: line says it moves
furrow set t-9t7ab --due-shift +7d                # 2026-10-03 18:00 → 2026-10-10 18:00 (B's own deadline).
                                                  # A's agreed 10/1(木) 14:00 appointment stays, in prose only.

# ── 5. the un-anchored dues that stay, and the promise they now break
#      t-ynhnk 10/04 17:00 / t-nxh9d 10/12 15:00 — the venue's own deadlines for an 11/21 booking.
#      t-csnqw (decision) now lands 10/10, i.e. AFTER the 10/04 application deadline: the inversion
#      STANDS until the venue re-issues the dates (CLAUDE.md), and `due-inversion` will name it.
furrow note t-ynhnk "日程変更 2026-11-21 → 2026-11-28。固定: 行の申込 10/4 17:00・入金 10/12 は旧日程に対して会場が示した期限で、いまは前提が崩れている(行自体は残す)。新日程での期限は [[<new-1>]] の再問い合わせで取り直す。決定 [[t-csnqw]] が 10/10 に動いたため申込期限を追い越しており、再提示が来るまで due-inversion は解消しない。"
furrow note t-nxh9d "日程変更 2026-11-21 → 2026-11-28。固定: 行の入金期限 10/12 は旧日程に対する会場の提示。新日程での期限は [[<new-1>]] の回答で取り直す。振込予定日はそれまで動かさない。"
# t-jtq5t 11/03 (public holiday) — body line 4 already says it does not move. No write.
# t-zapdx / t-v5kma / t-mxg58 / t-8yac1 (done) — dues are history. No write.

# ── 6. two redo tasks: the facts that stopped being true, not dates
#      (one redo per replaced task, covering every recipient; due = the replaced task's D-N
#       re-derived — D-68 → 9/21 and D-72 → 9/17, both already past → today)
furrow add "候補 3 件に新日程 2026-11-28 の空きと申込・入金期限の再提示を問い合わせる" \
  -e 会場 -s ready -l external-wait,venue-selection --dep t-8yac1 \
  --due 2026-09-28 --value 5 --effort 2 \
  --ref file:notes/venue-inquiry-template.md:1 \
  --check "A/B/C に 11/28 の空きを問い合わせる" \
  --check "申込期限と入金期限の再提示をもらう" \
  --check "回答を比較表の状態セルに書く" \
  --body "目的: 旧日程 11/21 で取り切った空き・料金・期限を、新日程 11/28 で取り直す。
完了条件: A/B/C の 3 件について 11/28 の空き可否と、申込・入金の新しい期限が比較表に記録されている。
次の一手: [[t-8yac1]] のテンプレを notes/venue-inquiry-template.md の新しい日付節から再送する。
前提: 空き無しの回答はノックアウト（[[t-csnqw]] の 前提 ⑤）。落ちた候補の処分はこの回答を届けた session が実行する。
前提: 設備・ゴミ・キャンセル・鍵の回答は日程に依らないので取り直さない（[[t-q5e6n]] [[t-4kg8d]] [[t-g5asy]] [[t-f5pva]] はそのまま生きる）。"
furrow add "ゲスト 12 名に新日程 2026-11-28 の可否を再打診して一次回答を取り直す" \
  -e 会場 -s ready -l guest-comms,scheduling --dep t-v5kma \
  --due 2026-09-28 --value 5 --effort 2 \
  --check "12 名全員に 11/28 を打診する" \
  --check "OK / NG / 未返信 を出欠表に入れ直す" \
  --body "目的: 旧日程 11/21 で取った一次可否を、新日程 11/28 で取り直す。
完了条件: 打診した 12 名全員について OK / NG / 未返信 のいずれかが新日程で出欠表に記録されている。
次の一手: 旧回答（OK 9 / NG 1 / 未返信 2）は一度無効にして全員に再打診する。
前提: [[t-v5kma]] の NG 1 名は 11/21 の出張が理由で、新日程では OK になり得る。逆に旧 OK 9 名が NG に転じ得る。
前提: [[t-v5kma]] の「日付は固定条件として動かさない前提で打診した」はもう成り立たない。代替日提示の余地はこの task が持つ。"
furrow dep t-csnqw <new-1>      # the decision now needs the new-date availability
furrow dep t-gf92s <new-2>      # 未返信 2 名の追いは新しい母集団の上でやる

# ── 7. prose the anchor move does not touch: derived absolute dates in bodies
#      (edit --body = repair; the whole file is replaced, so each is one command with the full text)
furrow edit t-a91yt --body -    # L4  前提: 受取は D-1（11/20 金） → D-1（11/27 金）
furrow edit t-gczt2 --body -    # L4  前提: 生鮮は D-1（11/20）受け取り → D-1（11/27）
furrow edit t-3xbv0 --body -    # L3  次の一手: 11/14(土) までに電話 → 11/21(土)
furrow edit t-wbhsk --body -    # L6  前提: 回答期限は D-42（10/10） → D-42（10/17）
furrow edit t-xmcmx --body -    # L3  次の一手: 9/28 までに配布 → 10/5 までに配布 / 回答期限 10/10(D-42) → 10/17(D-42)
furrow edit t-f429m --body -    # L3  D-14(11/7 土) → D-14(11/14 土)
                                # L4  UNTIL に D-1（11/20）…最後の回は D-7（11/14 土） → D-1（11/27）…D-7（11/21 土）
                                # L5  1 回目の D-14(11/7 土) → D-14(11/14 土)
furrow edit t-pq4pm --body -    # L5  逃がし: UNTIL(10/11 — 回答期限 10/10 の次の日曜) → UNTIL(10/18 — 10/17 の次の日曜)
                                #     L3 の 9/20(日) は経過した occurrence なので手を付けない
furrow edit t-xsy5a --body -    # L5  メモ: UNTIL=12/27 → UNTIL=2027/1/3
furrow edit t-9t7ab --body -    # L3  B は 10/3 までに枠をもらう → 10/10
                                # L4  固定: B の 10/3 は自分の締切なので動く → 「B の締切は 10/10（旧 10/3 +7 日）」
                                #     A の 10/1(木) 14:00 と L7 の逃がしは据え置き
furrow edit t-gf92s --body -    # L4  次の一手: 9/20 の週次督促…9/27 までに返事が無ければ → 10/4 に再derive
furrow edit t-csnqw --body -    # L4  前提に ⑤新日程 2026-11-28 に空きがあること（[[<new-1>]] の回答で判定）を足す
                                # L6  逃がし: 「決定入力が 6 task / dep 6 本」→ 7 に直す（<new-1> を張ったため）
furrow check t-wbhsk 3 --reword "回答期限を10/17と明記する"
furrow check t-9t7ab 4 --reword "B の下見枠を 10/10 までにもらう"

# ── 8. 前提/現状 that stopped being true: retired with a note, the line itself stays
furrow note t-ar35z "日程変更 2026-11-21 → 2026-11-28。前提: の「9/14 に口頭で打診済み」は旧日程に対する打診で、いまは成り立たない。due は D-7 のまま 11/21 21:00 に動いたので、新日程での在場可否を同じ確定返信で取る。"
furrow note t-v8w4w "日程変更 2026-11-21 → 2026-11-28。前提: の稼働前提は据え置きだが、新しい D-14〜D-1（11/14〜11/27）には 11/23（月・勤労感謝の日）が入り、旧窓には無かった 5 時間枠が 1 つ増える。工程の再配置はこの枠を当てにしてよい。"

# ── 9. notes/ — part of the board, edited in the same change (committed by hand, not by `furrow sync`)
# notes/dietary-form.md:5        回答期限: 2026-10-10（開催日の D-42）→ 2026-10-17（開催日の D-42）
# notes/site-visit-checklist.md:8   表ヘッダ B（枠待ち・10/3 期限）→ B（枠待ち・10/10 期限）
# notes/site-visit-checklist.md:26  「B の枠が 10/3 までに出なければ」→ 10/10
# notes/venue-compare.md:4      最終更新: 2026-09-24 → 2026-09-28
# notes/venue-compare.md        基本情報表の下に日付行を 1 本追加: 2026-09-28 開催日が 11/21 → 11/28 に変更。
#                               A/B/C の空きは <new-1> で再確認中。状態セルは回答が届いた時点で更新する。
# notes/venue-inquiry-template.md   L16/L18/L19 の送信済み本文は書き換えない（送信記録）。
#                               末尾に「2026-09-28 再送分（新日程 2026-11-28）」の新しい日付節を追加し、
#                               件名と本文を 11/28(土) 17:00-22:00 で書く。
# notes/budget-80k.md / handoff.md / receipts.md / recipes.md / venue-final-inventory.md — 日付リテラル無し、無変更

# ── 10. close
furrow lint      # expect exactly 1 error left: due-overdue t-pq4pm (the lapsed repeat — named, never snoozed).
                 # the other 6 overdue rows (incl. the 2 waiting chase dates t-f5pva / t-4kg8d) went green
                 # because their dues are derived, not because they were pushed.
                 # also expect due-inversion: t-csnqw → t-ynhnk, standing until the venue re-issues the dates.
furrow sync                                  # publishes .furrow/ only
git add notes/ && git commit                 # notes/ is committed by hand
```

Expected footprint: 80 dues moved by one command, 7 repeating series hand-written,
1 un-anchored due shifted, 3 un-anchored dues deliberately left, 15 body lines
across 11 bodies, 2 checklist rows, 4 `furrow note`s, 2 new tasks + 2 dep edges,
4 notes/ files.

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow version` | printed `furrow dev` — no way to tell whether this binary's `--help` text matches what wrote the board | ran `furrow board` to get `schema: v11 (board) / v11 (binary) — writable` and trusted it | `version` printing a build/commit stamp beside `dev` | no |
| 2 | `furrow brief` | the brief names the anchor (`anchor 2026-11-21`) but not that 80 dues follow it, so I could not tell whether the request was a one-command job or a 100-task sweep | ran `board`, `epic ls`, `stats`, then `ls -q has:anchor` to size it | `brief` printing the active box's follower count beside the anchor | no |
| 3 | before any read | the reschedule mechanism is not discoverable from furrow: `furrow epic set --help` explains `--anchor`, but only CLAUDE.md's "The event date moves" section says the anchor is where the event date LIVES on this board | read all 192 lines of CLAUDE.md before planning anything | `furrow epic show` labelling the field ("event day — the date every derived due counts back from") | no |
| 4 | `furrow ls -q 'anchor:会場'` | returned `(no tasks)`, silently — CLAUDE.md writes `-q anchor:<box>` and says `会場` is a unique title substring (which `set --anchor` and `-e` both accept) | guessed the qualifier is id-only, retried `anchor:e-1rxdr` → 80. `epic:会場` is the same trap (0 rows) | `anchor:`/`epic:` resolving a title substring, or exiting 2 on an unresolvable one instead of matching nothing | no |
| 5 | `furrow epic set e-1rxdr --anchor 2026-11-28` | the preview is the only thing that tells you exactly which dues move and to what — and it is a mutation command, so this drill cannot run it | hand-computed all 80 shifts in python from the shards | a read-only preview (`furrow epic show <box> --anchor-preview <date>`) | no |
| 6 | same | does the move include the one **icebox** follower (t-ebx1j)? `--help` says "every open follower"; icebox is a *terminal* lane in this board's config | ran the unplanned `ls -q 'has:anchor is:open'` → 80, so icebox counts as open | `--help` saying "every follower that is not done" | no |
| 7 | same | "a follower with no due or with a repeat rule refuses the WHOLE move" — I had to prove none of the 80 is either, or the whole plan collapses | `has:anchor no:due` → 0, and a grep of all 80 shards for `"repeat"` → 0 | the same read-only preview, or `--help` naming `lint --code anchor-undated,anchor-on-repeat` as the pre-flight | no (both codes are silent, which is the evidence — once you know to ask) |
| 8 | deciding the 7 repeating tasks | CLAUDE.md's "a reschedule moves only its series' `UNTIL`" sits inside the bullet about an **overdue** repeat. Does it govern all 7 or only the lapsed one? | only the lapsed one (t-pq4pm). The other 6 move their due too — otherwise 3 dep edges invert (t-f429m would fall behind both its deps, t-xsy5a ahead of t-wjj50) | a line: "a repeating task's due moves with the anchor as well; only a lapsed occurrence's does not" | no (post-change `due-inversion` would have caught 3 of them, after the damage) |
| 9 | `furrow set t-f429m --repeat …` | the stored `UNTIL=20261120T235959Z` is local wall clock stamped `Z`, while the due at the same wall clock is `2026-11-07T14:59:59Z` (real UTC). Two conventions in one shard | kept the existing spelling (+7 calendar days, `Z` retained), on the consistency rule | furrow normalising `UNTIL` to a true instant on write, or `show` rendering it in the board's zone | no (`repeat-invalid` is silent) |
| 10 | `furrow set t-9t7ab --due-shift +7d` | CLAUDE.md says the un-anchored set stays put; this task's own `固定:` line says "B の 10/3 は自分の締切なので動く". One due holds two dates (A's agreed 10/1 appointment, B's own 10/3 deadline) | the body's explicit word wins → shift the due; A's 10/1 stays in prose | CLAUDE.md conceding "an un-anchored due whose `固定:` line says it moves, moves", or the task split in two | no |
| 11 | after the shift | t-csnqw (decision) lands 10/10, past t-ynhnk's fixed 10/04 application deadline. CLAUDE.md says the inversion stands "until the confirmation lands" — but no task on the board holds that confirmation | filed it into the new re-inquiry task and noted both fixed-due tasks | t-ynhnk carrying the re-negotiation as a checklist row | no (post-change: `due-inversion`) |
| 12 | `furrow add` (re-inquiry) | is the re-inquiry one task or two? The redo rule covers "every recipient", not "every question" — availability and the two deadlines are different questions to the same three venues | one task (t-8yac1's template already bundled six questions to the same three recipients) | the redo line adding "and every question that template asked" | no |
| 13 | `furrow add --due` | the redo rule says "the replaced task's D-N re-derived — or today, when that date is already past". t-8yac1 and t-v5kma are done and un-anchored, so nothing prints their D-N | hand-computed D-68 → 9/21 and D-72 → 9/17, both past → both due today | `show` printing D-N against a box's day for any dated task, not only anchored ones | no |
| 14 | `furrow add --anchor?` | should a redo whose due collapsed to "today" carry `--anchor e-1rxdr`? Anchoring it would make the next reschedule move a date that is not a D-N distance | no anchor on either redo | the redo rule saying whether a redo inherits the replaced task's anchor | no |
| 15 | `furrow note t-v5kma` | t-v5kma's 前提 "日付は固定条件として動かさない前提で打診した" is now false, and its 結果 records "NG 1（11/21 出張）" — the one refusal may be free on 11/28. But a done task's body is history: never append | put both facts in the redo task's 前提; wrote nothing on t-v5kma | nothing — the rule is explicit; I re-read the "A done task" section twice to confirm `note` is banned too, not just `edit` | no |
| 16 | `furrow check t-wbhsk … --reword` | my own shard scan numbered checklist rows from 1; `check` indexes from 0 | ran two unplanned `furrow show`s to read the real indices (3 and 4) | nothing (the help is clear) — recorded as my error | no |
| 17 | deciding 回答期限 | one fact, four spellings: `D-42（10/10）` (t-wbhsk 前提), `10/10(D-42)` (t-xmcmx 次の一手), a bare `10/10` (t-wbhsk checklist row 3), `2026-10-10（開催日の D-42）— 仮` (notes/dietary-form.md:5). Only two are self-identifying as derived | all four move to 10/17 | a board rule: "a derived date is always written `D-N（YYYY-MM-DD）`, never bare" | no |
| 18 | same body | t-xmcmx's "9/28 までに配布する" — today's date, reading like "get it out this week" rather than a D-N distance, but sitting in 次の一手 (derived by CLAUDE.md's rule) | re-derived it to 10/5 (D-54) | the same D-N spelling rule | no |
| 19 | `furrow set t-pmnx3` | its due 10/17 is D-35 — chosen start day or derived? Body: "10/17（土）から開始し、開催日（会場 epic の anchor）の週まで" — the END names the anchor, the START does not | chosen: keep the due, move only `UNTIL` (→ 11/28) | the body marking the start `固定:` | no |
| 20 | `furrow set t-msexg` | body says "D-21 の土曜に 1 回目"; the due 10/31 is old D-21. No dep inverts either way, so nothing forced the call | shifted (+7 → 11/07 = new D-21), so the prose stays true, matching t-f429m | the repeating-due rule of #8 | no |
| 21 | `furrow set t-mdgcy` | due 2027-11-21 is exactly one year out and carries no anchor, so the machine rule would leave it a week wrong. Only line 5 of its body says "開催日(会場 epic の anchor)の 1 年後に初回が来る設定" | +7d → 2027-11-28 (also a Sunday) | `repeat_anchor` being able to point at a box, so a series can follow the anchor | no |
| 22 | `furrow set t-1zkfj` | due 2027-05-20 is event + 180 days, but its body only says "半年間隔は仮置き" and never names the anchor. Derived or arbitrary? | +7d → 2027-05-27 (also a Thursday), for consistency with #21 | the same | no |
| 23 | `furrow set t-xsy5a` | body says "[[t-wjj50]] の 1 枚を配ってから 1 週間後", but t-wjj50 is due 11/26 and this is due 11/29 — 3 days, not 7. A pre-existing contradiction I had to decide not to fix | +7d (12/06, keeps the Sunday and clears the inversion); left the "1 週間後" wording alone | the body not restating a distance the dep graph already holds | no |
| 24 | same | the shifted `UNTIL` puts the last payment-chase occurrence on 2027-01-03 — inside the New Year holidays. Nothing on the board says whether a shifted date is checked against a calendar | shifted it and named it in the note | a line: "a shifted date that lands on a holiday is named, not moved" | no |
| 25 | `furrow note t-v8w4w` | the new D-14〜D-1 window (11/14–11/27) contains 11/23, a public holiday; the old one contained none, so the 前提 "平日は夜 2 時間、週末は 5 時間" now understates capacity | a `furrow note`, not a plan rewrite | a line on whether a reschedule re-checks the working-hours 前提 | no |
| 26 | `furrow edit t-csnqw --body` | the new date is a de-facto knockout, and knockouts live in the decision task's 前提 "and nowhere else" — but `edit --body` is "for repair only (a derived date that moved)" and `note` appends prose that is not a 前提 | used `edit --body` to add 前提 ⑤ (and fix the 逃がし's "dep 6 本" → 7) | the 前提 rule conceding a non-date addition, or a `furrow note --as 前提` | no |
| 27 | `notes/venue-inquiry-template.md` | lines 16/18/19 quote the SENT inquiry ("2026-11-21(土) 17:00-22:00"). "Derived dates get rewritten" and "a sent text is never rewritten" read as a conflict until you notice one is prose and the other a transcript | appended a new dated section for the 11/28 re-issue; left 16-19 untouched | the `notes/` rule naming the sent-text exemption in the same breath as the derived-date rewrite | no |
| 28 | `notes/venue-compare.md` | its `最終更新: 2026-09-24` line — does a dated addition bump it? The 運用 line covers a dropped candidate's row and column, not a reschedule | bumped it to 2026-09-28 and added a dated line under 基本情報 | the 運用 line naming 最終更新 upkeep | no |
| 29 | `furrow epic set … --yes` | the move takes 6 of the 7 red `due-overdue` rows green in one write, including two `waiting` chase dates (t-f5pva 9/22, t-4kg8d 9/24) I have already missed. CLAUDE.md says a reschedule is not a snooze, but a missed chase date sliding forward is a snooze in effect | let them move (they carry the anchor, so the machine calls them derived) and named the two `waiting` ones in the closing read | a line: "a `waiting` chase date is never anchored" — chase dates are not distances from the event | yes: `due-overdue` (all 7 reported now; 6 are the rows that silently clear) |
| 30 | `furrow edit t-pq4pm --body` | its 次の一手 "9/20(日) 20:00 に未返信 2 名へ再送する" is a lapsed occurrence, not a derived date the reschedule moved. Repair it to the next scheduled Sunday, or leave it as history? | left it; rewrote only line 5, where the `UNTIL` follows the moved 回答期限 | a line on whether a lapsed occurrence's 次の一手 is history | no |
| 31 | `furrow edit t-gf92s --body` | its 次の一手 branch ("9/27 までに返事が無ければ補欠へ") is derived (D-55 → 10/4), but the re-poll task resets the whole population, arguably making the branch moot | re-derived the dates AND added the dep on the re-poll; did not retire the branch | the redo rule saying what happens to a replaced task's dependents | no |
| 32 | reading every `(土)`/`(金)`/`週末(D-7 土)` | the board's weekday claims are load-bearing (two `BYDAY=SA` series, "D-1(金) は半休を取る", "週末(D-6 日)"), and nothing on the board states the anchor's weekday | ran `date` on 16 dates: 11/21 and 11/28 are both Saturdays, so every weekday claim survives the +7 | `furrow epic show` printing the anchor's weekday | no |
| 33 | deciding whether t-zapdx needs a redo | it screened the 6-candidate population on the axis "11/21(土) 17:00-22:00 の通し利用" — a date-dependent screen on a done task | no redo: its 結果 says the three exclusions were capacity and price, both date-independent | nothing; it needed reading the 結果 line closely | no |
| 34 | `furrow note t-ar35z` | the two helpers were asked verbally on 9/14 for the old date. Retire the 前提, or file a redo like the guests? | retired the 前提 — the task is still open and its 完了条件 (確定返信) is unsatisfied, so it can just ask for the new date | the redo rule distinguishing "a done promise" from "an open task whose 前提 went stale" | no |
| 35 | one-task-in-flight | t-q5e6n is `in-progress`. Does a board-wide reschedule count as starting work, so it must be parked back to `ready` first? | no — the rule counts `set -s in-progress`, and a reschedule starts nothing | a line: "a reschedule is an operator request, not a pick" | no |
| 36 | `furrow sync` / `git commit` | `furrow sync` publishes only `.furrow/`, `notes/` is committed by hand — so the change lands in two systems and the ordering matters (sync first leaves the board a week ahead of its notes) | sync last, `notes/` commit in the same push | nothing (the line is explicit); recorded because the ordering is mine to invent | no |

## Verdict

`could_act_confidently: true`

The board carries its own reschedule mechanism (`anchor` on the venue box) and
80 of 95 dated tasks ride it, so the date move is one command; every hesitation
above is about the 15 that do not ride it, and CLAUDE.md answered or nearly
answered each one.

- hesitations: **36**
- rows where `furrow lint` reports it here: **1**

`Most consequential:`
- **#8** — reading "a reschedule moves only its series' `UNTIL`" as covering all 7 repeats would have left t-f429m due before both its deps and t-xsy5a chasing money before the bill went out.
- **#4** — `-q 'anchor:会場'` answering `(no tasks)` instead of erroring invites the conclusion that nothing is anchored, i.e. 80 dues moved by hand.
- **#11** — the shift pushes the venue decision past a fixed application deadline that no task owns, so the inversion is permanent unless a session invents the re-negotiation task.
