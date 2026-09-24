# Drill 3 — reschedule

Request: "The dinner moves one week later, from 2026-11-21 to 2026-11-28.
Bring the whole board in line: every date, every task whose plan assumed the
old date, and anything that no longer makes sense at the new one."

## Measured on

- board commit: `49d666c`
- furrow version: `furrow dev` (unstamped — no build commit or date)
- run date / local time: 2026-09-24 19:16 JST (Asia/Tokyo, the board's timezone)
- operator had already synced; this session ran `furrow brief` alone.

## Plan

The plan is never executed. 84 entities would be touched: 82 existing tasks
(73 due shifts, 9 more that get prose only), 1 epic, 2 new tasks.

The rule I settled on, because the board states none: **a due at D-38 or
later (2026-10-14 onward, i.e. everything downstream of the venue booking and
payment) is dinner-anchored and moves +7 days with the time-of-day kept;
a due at D-40 or earlier (E1 venue/guest/budget, plus the three E2 tasks that
start now) is driven by external reply deadlines and by today's calendar, so
it does not move — the shift gives those tasks slack, not a later deadline.**
Three tasks inside the shift band are deliberate exceptions, marked below.

```sh
# ---- 0. reads (done; listed so the run is reproducible) ----
furrow brief
furrow board; furrow epic ls; furrow stats
furrow ls -n 0 -s inbox,backlog,in-progress,ready,waiting,done,icebox --json
furrow show <all 100 ids> --json          # bodies, refs, repeat rules, deps
furrow search 2026-11-21; furrow search 11/21; furrow search 11-21
furrow dep t-cc22s --list; furrow dep t-0n6gq --list
furrow dep t-92sfy --list; furrow dep t-4tcxy --list
furrow epic show e-jd4kb e-38f7f e-ctr9m e-hp2zp e-06m7s
furrow lint

# ---- 1. put the new date somewhere a reader will find it ----
# Nothing on this board names the event date: it lives only in 95 due stamps,
# three body lines and three ref paths. The active epic's body is the only
# board-level prose that a fresh session reads, so the record goes there.
furrow note e-jd4kb "開催日を 2026-11-21(土) → 2026-11-28(土) に変更。曜日は同じ。D-0 基準の due を +7 日ずらし、E1 の会場・出欠まわりの due は据え置き(外部返信の期限であって開催日基準ではないため)。11/21 前提で閉じた打診(t-cc22s)と候補洗い出し(t-0n6gq)は done のまま残し、取り直しを新 task で起票した。"

# ---- 2. what no longer makes sense: the two done tasks that assumed 11/21 ----
# t-cc22s (done) "開催日 11/21 を…打診" 結果 = OK 9 / NG 1(11/21 出張) / 未返信 2。
# t-0n6gq (done) 候補 6 件の軸が「11/21(土) 17:00-22:00 の通し利用」。
# CLAUDE.md: done の body は履歴、書き換えない。やり直しは新 task + dep。
furrow add "開催日 11/28 をゲスト 12 名に再打診して可否を取り直す" \
  -s ready -e e-jd4kb -l guest-comms,scheduling --value 5 --effort 2 \
  --due 2026-09-27 --ref notes/venue-compare.md:1 \
  --body "目的: 日程変更(11/21→11/28)で全員の可否が無効になったため、12 名分を取り直す。
完了条件: 12 名全員について 11/28 の OK / NG / 未返信 が出欠表に記録されている。
前提: 11/21 で NG だった 1 名(出張)は 11/28 なら来られる可能性があるので必ず再打診に含める。
前提: 11/21 で OK だった 9 名の回答は 11/28 には使えない。
次の一手: LINE グループ + 個別 DM で「日程が 1 週間後ろにずれた」旨と新日付を送る。"
furrow dep <new-repoll-id> t-cc22s
furrow dep t-92sfy <new-repoll-id>      # 出席 12 名確定は取り直しの後

furrow add "候補 A/B/C の 11/28 空き状況を取り直して比較表を更新する" \
  -s ready -e e-jd4kb -l venue-selection,external-wait --value 5 --effort 1 \
  --due 2026-09-26 --ref notes/venue-compare.md:1 \
  --body "目的: 空き・料金の問い合わせ(t-7s17t)は 11/21 の日付で送ってあるため、11/28 の空きは未知。会場決定の前に取り直す。
完了条件: A/B/C それぞれについて 11/28(土) 17:00-22:00 の空き(可/不可/要確認)が比較表に入っている。
前提: 土曜夕方枠は埋まりやすい。11/28 が埋まっている会場は候補から落ちる。
次の一手: 既存の問い合わせスレッドに 1 行で日付変更を送る。C は未返信のため t-nd5a5 の督促に同梱する。"
furrow dep <new-avail-id> t-7s17t
furrow dep t-06pzy <new-avail-id>       # 会場決定は空き再確認の後

# ---- 3. the +7 sweep (73 writes; --due has no "shift by" form, and a bulk
#         `set -q ... --due X` would collapse them all onto one date) ----
furrow set t-1r7ak --due 2026-10-21         # D-38
furrow set t-rg1n0 --due 2026-10-23         # D-36
furrow set t-db1ed --due 2026-10-24         # D-35
furrow set t-dtrn6 --due 2026-10-24         # D-35
furrow set t-s8yt2 --due 2026-10-27         # D-32
furrow set t-7a3mg --due 2026-10-29         # D-30
furrow set t-gscsy --due 2026-10-29         # D-30
furrow set t-1a39k --due 2026-10-31         # D-28
furrow set t-495mc --due 2026-10-31         # D-28
furrow set t-95rjw --due 2026-10-31         # D-28
furrow set t-hwwfd --due 2026-11-03         # D-25
furrow set t-me4ef --due 2026-11-04         # D-24
furrow set t-wa29c --due 2026-11-08         # D-20
furrow set t-9vd5f --due 2026-11-12         # D-16
furrow set t-nfqm5 --due 2026-11-12         # D-16
furrow set t-zneqs --due 2026-11-14T18:00   # D-14
furrow set t-3b6va --due 2026-11-14         # D-14
furrow set t-t2tvm --due 2026-11-14         # D-14
furrow set t-3gwtn --due 2026-11-15         # D-13
furrow set t-mh9m7 --due 2026-11-15         # D-13
furrow set t-3qax0 --due 2026-11-16         # D-12
furrow set t-j80mp --due 2026-11-16         # D-12
furrow set t-ccj9f --due 2026-11-18         # D-10
furrow set t-cpbcy --due 2026-11-19         # D-9
furrow set t-c7vjj --due 2026-11-20         # D-8
furrow set t-n5431 --due 2026-11-21T12:00   # D-7
furrow set t-4tcxy --due 2026-11-21T21:00   # D-7
furrow set t-8efq1 --due 2026-11-21         # D-7
furrow set t-kq6j1 --due 2026-11-21         # D-7
furrow set t-epgyd --due 2026-11-22         # D-6
furrow set t-fejrz --due 2026-11-23T21:00   # D-5
furrow set t-3tg4t --due 2026-11-25         # D-3
furrow set t-rc5ry --due 2026-11-25         # D-3
furrow set t-9e9y1 --due 2026-11-26T21:00   # D-2
furrow set t-ehf4f --due 2026-11-26T21:00   # D-2
furrow set t-2pcnj --due 2026-11-26         # D-2
furrow set t-fb0ed --due 2026-11-27T11:00   # D-1
furrow set t-zv988 --due 2026-11-27T15:00   # D-1
furrow set t-fzqgk --due 2026-11-27T18:00   # D-1
furrow set t-jhcpe --due 2026-11-27T21:00   # D-1
furrow set t-xwche --due 2026-11-27T22:00   # D-1
furrow set t-257mq --due 2026-11-28T09:30   # D+0
furrow set t-sezkn --due 2026-11-28T10:15   # D+0
furrow set t-j5k1v --due 2026-11-28T10:30   # D+0
furrow set t-43svn --due 2026-11-28T12:00   # D+0
furrow set t-9gyjs --due 2026-11-28T15:00   # D+0
furrow set t-nkb7b --due 2026-11-28T16:00   # D+0
furrow set t-aq1fe --due 2026-11-28T16:30   # D+0
furrow set t-171r2 --due 2026-11-28T17:30   # D+0
furrow set t-4rkbe --due 2026-11-28T18:45   # D+0
furrow set t-q2d3q --due 2026-11-28T19:00   # D+0
furrow set t-wdye6 --due 2026-11-28T19:30   # D+0
furrow set t-5d50g --due 2026-11-28T20:45   # D+0
furrow set t-xnwtj --due 2026-11-28T21:00   # D+0
furrow set t-j6v1s --due 2026-11-28T21:30   # D+0
furrow set t-2jgvj --due 2026-11-28T21:40   # D+0
furrow set t-k07j4 --due 2026-11-28T21:45   # D+0
furrow set t-xn9f4 --due 2026-11-28T21:55   # D+0
furrow set t-mj4rm --due 2026-11-28T22:00   # D+0
furrow set t-15w84 --due 2026-11-29T12:00   # D+1
furrow set t-7wejj --due 2026-11-29         # D+1
furrow set t-z70bc --due 2026-12-01T21:00   # D+3
furrow set t-44tx0 --due 2026-12-02         # D+4
furrow set t-jd2f6 --due 2026-12-03         # D+5
furrow set t-94rmy --due 2026-12-05T20:00   # D+7
furrow set t-p0xy6 --due 2026-12-06T20:00   # D+8
furrow set t-rbbqj --due 2026-12-08         # D+10
furrow set t-7rgpc --due 2026-12-10         # D+12
furrow set t-7hgan --due 2026-12-12         # D+14
furrow set t-h1y52 --due 2026-12-12         # D+14
furrow set t-3mjrq --due 2026-12-19         # D+21
furrow set t-2tsdm --due 2027-05-27         # D+180
furrow set t-6cgw1 --due 2027-11-28         # D+365

# ---- 4. the three tasks inside the band that must NOT move ----
# t-snxbs 週次の予算ロールアップ: 開始 10/17 は据え置き(早く始めるほど良い)。
#   終わりが 11/21 → 11/28 に伸び、回数が 1 回増える。
furrow set t-snxbs --repeat 'weekly on sat until 2026-11-28'   # add --help documents
                                                               # `until <date>`; if set's
                                                               # parser refuses it, fall back
                                                               # to the note below only.
# t-5k014 肉の火入れリハーサル: 初回 10/31 据え置き。D-21 が D-28 になるだけで、
#   本番前のリハ回数が 1 回増える(得しかしない)。
# t-sgfcs 火入れ試作: 11/03 据え置き。body が「11/03（祝）に自宅で試作」と書いており、
#   +7 すると 11/10(火)の平日夜に落ちて 1 日まるごと使える枠を失う。新日付では 11/03 = D-25。

# ---- 5. refs that carry the old date in a path (lint cannot see these:
#         `ref --add` is "verbatim, never checked for existence") ----
furrow ref t-z70bc --rm file:docs/oneday-restaurant/2026-11-21/receipts.md --add file:docs/oneday-restaurant/2026-11-28/receipts.md
furrow ref t-rbbqj --rm file:docs/oneday-restaurant/2026-11-21/recipes.md  --add file:docs/oneday-restaurant/2026-11-28/recipes.md
furrow ref t-7hgan --rm file:docs/oneday-restaurant/2026-11-21/handoff.md  --add file:docs/oneday-restaurant/2026-11-28/handoff.md

# ---- 6. bodies. D-N notation survives the move untouched; only the lines
#         that hardcode a calendar date, or a 前提 that stopped being true,
#         get a note (CLAUDE.md: 前提 は note で退役、rescope しない) ----
furrow note t-snxbs "日程変更: 開催日が 11/28 になったため、この週次ロールアップの終わりも 11/28。次の一手の『開催日 11/21 まで』は退役。開始 10/17(土) は変えない(回数が 1 回増えるだけ)。"
furrow note t-t2tvm "日程変更: D-14 は 11/14(土) になった。次の一手の『D-14(11/7 土)』は退役。曜日は土のままなので repeat の BYDAY=SA は据え置き。"
furrow note t-5k014 "日程変更: 開催日が 11/28 になり、初回 10/31 は D-21 ではなく D-28 になった。初回は前倒しのまま据え置き、本番前のリハ回数が 1 回増える。"
furrow note t-sgfcs "日程変更: 開催日が 11/28 になったが、試作日 11/03(祝) は据え置く。+7 すると 11/10(火)の平日夜になり、1 日使える枠を失うため。新日付では 11/03 = D-25。"
furrow note t-me4ef "日程変更: 前提の『生鮮は D-1（11/20）受け取り』は退役。D-1 = 11/27(金)、D-7 = 11/21(土)。"
furrow note t-zneqs "日程変更: 前提の『受取は D-1（11/20 金）夕方』は退役。D-1 = 11/27(金)。曜日は変わらないので受取を金曜夕方に置く方針はそのまま。"
furrow note t-n5431 "日程変更: 次の一手の『11/14(土) までに電話』は退役。開催 1 週間前 = 11/21(土)。"
furrow note t-8q9pg "日程変更: 前提の『回答期限は D-42（10/10）』は退役。開催日 11/28 の D-42 = 10/17。この task の due(9/24)は設問文を E1 に渡す期限なので動かさない。"
furrow note t-jhcpe "日程変更: 前提の『手伝い 2 名の 22:00 在場確約を D-14 までに取る』の D-14 は 11/14(土)。"
furrow note t-6cgw1 "日程変更: メモの『開催日(2026-11-21)の1年後』は退役。開催日は 2026-11-28 で、初回は 2027-11-28。"
furrow note t-4tcxy "日程変更: 11/21 で取った入り時刻・担当の返信は無効。11/28 で取り直す。D-7 = 11/21(土) が新しい督促期限。"
furrow note t-92sfy "日程変更: 11/21 での一次可否(OK 9 / NG 1 / 未返信 2)は無効になった。『出席 12 名』は 11/28 での確定を意味する。再打診 task を dep に入れた。"
furrow note t-nd5a5 "日程変更: C への問い合わせは 11/21 の日付で送ってある。督促に『日程が 11/28 に変わった』を同梱し、見積と 11/28 の空きを同時に取る。打ち切り判断(C を落として A/B の 2 択)の条件は据え置き。"
furrow note t-0dqt7 "日程変更: 持ち込み酒・ゴミ規定は日付に依存しないのでこの task の内容は変わらない。11/28 の空き確認は別 task に分けた。"
furrow note t-x5pxf "日程変更: 申告の回収自体は日付に依存しないが、母数は 11/28 での出席確定に変わる。再打診で参加者が入れ替わったら差分に追送する。"
furrow note t-495mc "日程変更: 正式案内は 11/28 の日付で送る。due は +7 の 10/31。"
furrow note t-qzgp6 "日程変更: 週次督促の対象に『11/28 の可否(再打診)』が加わった。出欠・食事制限の 2 表に加えて再打診の回収状況も見る。"

# ---- 7. reset the chase date on the one waiting task whose chase is now
#         a different question (CLAUDE.md: waiting の due は督促日) ----
furrow set t-nd5a5 --due 2026-09-29T18:00

# ---- 8. verify ----
furrow lint          # expect: due-overdue t-qzgp6 のみ残る (t-nd5a5 は押し直した)
furrow ls -n 0 --json | <check every due at D-38+ is 7 days later>
furrow brief
furrow sync          # operator
```

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow version` | It prints `furrow dev` — no build commit, no date. The drill asks me to record "the furrow the run measured" and I cannot. | Wrote `dev (unstamped)`; a later run cannot tell whether it used the same binary. | furrow change: stamp commit/date into the `dev` build the same way a release is stamped. | no |
| 2 | `furrow brief` | The request names 2026-11-21, but the brief (and the whole board) names no event date. I had to go looking for what the date even attaches to. | Assumed the date is only implicit in `due` stamps, then went to verify. | furrow change: a board-level or epic-level date/anchor field that `brief` prints. | no |
| 3 | `furrow search` | I had to try three spellings — `2026-11-21`, `11/21`, `11-21` — because the board writes the date three different ways (ISO in one body, `11/21` in two, and a `2026-11-21` path segment in refs). | Ran all three and unioned the hits. | a line of prose in CLAUDE.md: "日付は body でも `YYYY-MM-DD` で書く". | no |
| 4 | `furrow ls` | I did not know the flag to list every lane at once (`-s` takes a list; drafts and icebox are easy to miss) or the `--json` row shape. | Read `furrow ls --help`, then passed all seven lanes explicitly plus `-n 0`. | a line of prose in CLAUDE.md naming the whole-board read. | no |
| 5 | `furrow ls --json` | `due` comes out in UTC (`2026-10-14T14:59:59Z`) while the board's timezone is Asia/Tokyo and every human view shows `+09:00`. Grouping 95 dues by day needs a conversion I could get wrong at the day boundary. | Converted to +09:00 myself before doing anything. | furrow change: emit the due in the board's timezone (or add a board-local field) in `--json`. | no |
| 6 | classifying the 95 dues | **Nothing on the board marks which dues are event-relative and which are externally driven.** Every due is an absolute instant; there is no anchor field, no label, no convention. Deciding "does this one move +7?" is a judgment call on all 95. | Invented the D-38 cut line (below) and wrote it into the log so the next run can disagree with it. | furrow change: an anchor/offset due (`--due D-14` relative to a board or epic date), so a reschedule is one write. | no |
| 7 | choosing the cut line | Even with a rule, the boundary is arbitrary. E1's venue tasks chase external replies; E2's first three (`t-8q9pg` due today, `t-xvfp7`, `t-26pre`) start now. Moving those would delay today's actionable work for no reason. | Cut at D-38 (2026-10-14), i.e. after the venue booking (`t-czp8y` 10/4) and payment (`t-b1dhy` 10/12). 19 dues stay, 73 move, 3 are exceptions. | a line of prose in CLAUDE.md: "due は『開催日基準』と『外部期限基準』の 2 種類あり、前者だけが日程変更で動く" — plus a label to mark them. | no |
| 8 | reading the bodies | Bodies use `D-N` notation **and** hardcode the derived calendar date beside it (`D-14(11/7 土)`, `D-1（11/20 金）`, `週末(D-7 土)`). Every one of those pairs had to be checked by hand for whether the derived half drifts. | Verified all 14 D-N/date pairs against the 11/21 anchor (they all matched), then decided the `D-N` halves need no edit and only the hardcoded halves get a note. | a line of prose in CLAUDE.md: "body に開催日基準の日付を書くときは D-N だけを書き、実日付を括弧で添えない". | no |
| 9 | `furrow set --due` | There is **no relative shift**: `--due +7d` is measured from *now*, not from the task's current due. And bulk `set` applies the *same* edit to every id, so `set -q ... --due X` would collapse 73 tasks onto one date. | 73 individual `set --due <absolute>` writes, each with its own time-of-day, generated mechanically from the read. | furrow change: `--due-shift +7d` (or `--due +7d --relative-to-due`) that moves each selected task's existing due. | no |
| 10 | `furrow set --repeat` | `set --help` says `--due` on a repeating task "moves THIS occurrence only — the series anchor never moves". Four repeaters sit in the shift band (`t-t2tvm`, `t-p0xy6`, `t-2tsdm`, `t-6cgw1`) and I cannot tell what their series does after I move one occurrence. | Assumed the shifted occurrence is enough because the rules are weekday/interval based and +7 preserves the weekday; flagged `t-6cgw1` (yearly, anchored 11/21) as the one that will drift back to the 21st. | furrow change: let `set` move a series anchor (`--reanchor`), or say in `--help` what a moved occurrence does to the next one. | no |
| 11 | `furrow set --repeat` | Three bodies state "repeat に終了条件を書けない" (`t-snxbs`, `t-t2tvm`, `t-qzgp6`) — but `add --help` documents `until <date>` and `for <n> times`. `set --help` does not repeat that grammar, so I cannot tell whether `set --repeat '... until 2026-11-28'` is accepted. | Wrote the `set --repeat ... until` line with a fallback to the note alone, and treated the three bodies' claim as stale prose. | a line in `set --help` mirroring `add --help`'s repeat grammar. | no |
| 12 | disposing of `t-cc22s` | It is **done**, its title carries `開催日 11/21`, and its 結果 records answers that are now void. CLAUDE.md says a done body is history and never rewritten, and the retitle rule covers only titles carrying a *count*. A stale date in a done title is not covered either way. | Left both title and body untouched; created a redo task with a dep on it. | a line of prose in CLAUDE.md: "日付を抱えた title も、母数が変わった時点で retitle 対象" — or an explicit "done の title も凍結". | no |
| 13 | reading `t-cc22s` 結果 | `結果: OK 9 / NG 1（11/21 出張）/ 未返信 2` — the one NG may now be free on 11/28, and the 9 OKs are void. The attendance table itself is not on the board (it lives in prose and in `notes/venue-compare.md`), so I cannot scope the re-poll to anyone in particular. | Wrote the redo task to re-poll all 12, with the 出張 case called out in 前提. | furrow change: nothing — this is board content; a line of prose in the body naming where the 出欠表 lives would do it. | no |
| 14 | `furrow add` | Where does a redo task land? `furrow board` says the add default is `inbox`; CLAUDE.md gives a *pick* order and an in-progress cap but says nothing about the lane a newly-filed blocking task starts in. | `-s ready` for both, because the whole venue decision now waits on them. | a line of prose in CLAUDE.md: "起票時の lane は …". | no |
| 15 | checking the refs | Three refs carry the old date **inside a path** (`file:docs/oneday-restaurant/2026-11-21/{receipts,recipes,handoff}.md`). `ref --help` says refs are "verbatim, never checked for existence", so nothing will ever flag them. I only found them by dumping every ref. | Re-pointed all three to `2026-11-28/`, assuming the directory is renamed outside the board. | furrow lint check: a `ref-missing` code for `file:` refs whose path is not in the repo. | no |
| 16 | reading the bodies | Bodies cross-reference tasks by a private namespace — `venue-05`, `menu-08`, `prep-15`, `dayof-01`, `wrap-17` — that no furrow read resolves; and `venue-03`/`venue-05` are *also* used as ref paths into `.furrow/bodies/venue-NN.md`, which is not a task body. I could not confirm which task a 前提 points at. | Left every such reference alone and worded the notes so they make sense without resolving it. | furrow change: `[[t-xxxxx]]`-style links that `show`/`lint` resolve (`add --batch` already mints `[[key]]` → `[[id]]`), plus a lint code for an unresolvable one. | no |
| 17 | `t-sgfcs` | Its body says "11/03（祝）に自宅で1人前を試作". +7 lands on 11/10, a weekday evening, losing a whole free day. The board carries no calendar of holidays or of my own availability — only that one `（祝）` in prose told me. | Kept 11/03 (it is D-25 under the new date) instead of shifting. Also noticed 11/23(祝) now falls at D-5 but could not use it for anything without more information. | furrow change: nothing furrow can hold; a line of prose per task naming the constraint ("この日は祝日だから選んだ"). | no |
| 18 | `t-257mq` vs `t-7a3mg` | Contradictory load-in times: `t-7a3mg` 前提 "搬入開始は 15:00(入場 17:00 の 2 時間前)を想定", `t-257mq` 前提 "入室可能時刻を 08:30 と仮置き". Both are 前提 on the new date too, so I had to decide whether "anything that no longer makes sense" covers it. | Judged it pre-existing and out of scope for a reschedule; left both alone and did not file it. | furrow lint check: nothing can see a contradiction between two prose 前提 lines. | no |
| 19 | recording the change | After 73 due writes, **nothing on the board says 2026-11-28**. No project object, no epic field, no epic body carries the date; `epic show` on all five printed goals with no date in them. | `furrow note e-jd4kb` — the active epic's body, because that is the only board-level prose a fresh session reads. | furrow change: a board- or epic-level key/value (a `meta` entry is already there for `slug`) that `brief` surfaces. | no |
| 20 | `t-06pzy` | Venue availability for 11/28 is unknown for all three candidates, and the 比較表 that would hold it is `notes/venue-compare.md`, outside the board. I could not update data; I could only file work. | Created the availability re-check task and made `t-06pzy` depend on it. | furrow change: nothing — the board deliberately keeps the table off-board; a prose line saying so would have saved the search. | no |
| 21 | `furrow lint` | Ran it as the drill requires. It reported 2 errors + 2 warnings, all of them `due-overdue`/`due-today` — **none** of the 20 stops above. I had to confirm by hand that it sees nothing about the reschedule. | Recorded `no` in every other row. | — | — |
| 22 | `t-nd5a5` / `t-qzgp6` | Both are already overdue *before* my change (lint errors). Does a reschedule reset a chase date? CLAUDE.md says a waiting due is the chase date and `due-overdue` there means "chase or escalate", which is exactly what the date change forces me to do — but for `t-qzgp6` (weekly reminder) it does not. | Pushed `t-nd5a5` to 9/29 18:00 (the chase now carries a new question); left `t-qzgp6` overdue and only noted it. | a line of prose in CLAUDE.md: what a reschedule does to an already-overdue chase. | yes: `due-overdue` |
| 23 | every mutation | Every write takes `--expect-updated`, and this is a `mode = shared` board. I read all 100 tasks at one instant and would then issue 84 writes over a long stretch. | Skipped `--expect-updated` everywhere; a concurrent writer would be silently overwritten. | a line of prose in CLAUDE.md: when a bulk sweep should carry `--expect-updated`. | no |
| 24 | `note` / `add` / `dep` / `check` / `retitle` / `edit --help` | I could not plan a single write without reading six help pages: whether `note` appends to a done body, whether `add` can carry a body and deps in one call, whether `retitle` touches the body heading, whether `check --reword` is the right tool for a checklist item that names a date. | Read all six; the plan above uses `add --body`, `note`, `dep`, `ref`, `set`. | — (help is the contract by design; counted because the drill counts it) | no |

## Verdict

`could_act_confidently: false`

The arithmetic is trivial — 11/21 and 11/28 are both Saturdays, so every
weekday-bound plan survives and the shift is a clean +7 — but the board
carries no anchor: not one field, label or line says which of its 95 dues are
measured from the dinner and which from an external deadline, and no command
shifts a due relative to itself, so "move the dinner one week" is 73
hand-picked absolute writes plus a judgment call I had to invent and document.

- hesitations: 24
- rows answering `yes` in the last column: 1
