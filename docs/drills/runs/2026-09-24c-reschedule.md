# Drill 3 — reschedule

Request: "The dinner moves one week later, from 2026-11-21 to 2026-11-28.
Bring the whole board in line: every date, every task whose plan assumed the
old date, and anything that no longer makes sense at the new one."

## Measured on

- board commit: `f497db3`
- furrow version: `furrow dev` (main at ac777e8)
- run date / local time: 2026-09-24, 21:10–21:20 JST (Asia/Tokyo)
- read-only run: the operator had synced; this session ran `furrow brief`
  and never `furrow sync`. Nothing below was executed.

Board facts the plan rests on (all measured this run): `event_date` =
`2026-11-21` in `e-0w7hf`'s meta; 95 tasks carry a `due`, every one of them
an exact D±N offset from that date; 4 of those are `done`; 7 carry a
`repeat`; 2026-11-21 and 2026-11-28 are both Saturdays, so every weekday
anchor (D-1 = Friday, the Saturday series) survives the move.

## Plan

```sh
# ---- 0. orient (these were actually run; the rest was not) -------------
furrow brief
furrow epic show 会場 --json | jq -r .meta.event_date   # 2026-11-21
furrow ls -q 'has:due' -n 0 --json                      # 95 dated rows
furrow lint                                             # 2 errors, 2 warns

# ---- 1. the anchor first (CLAUDE.md: the date lives in ONE place) -----
furrow epic set e-0w7hf --meta event_date=2026-11-28
furrow note e-0w7hf "開催日を 2026-11-21(土) → 2026-11-28(土) に変更 (2026-09-24 決定)。
曜日が同じなので D-N の曜日前提(D-1=金の半休、土曜の週次系列)はそのまま。
open な due 91 件を +7 日、done 4 件の due は履歴として据え置き。
11/21 前提で閉じた打診(t-w06qv)・候補洗い出し(t-1swgk)・問い合わせ送信(t-3nc93)は
done のまま残し、取り直しを新 task で起票して decision の手前に dep を張った。"

# ---- 2. every open, non-repeating due +7d, clock time preserved -------
#        84 tasks / 71 writes (same new instant = one bulk write)
furrow set t-qw8jc --due 2026-09-29T18:00
furrow set t-pvpwd t-1j38n --due 2026-10-01
furrow set t-rdw97 --due 2026-10-03
furrow set t-3e3px t-dkg1y --due 2026-10-04
furrow set t-a014x --due 2026-10-06
furrow set t-0c54z --due 2026-10-07
furrow set t-g61ny --due 2026-10-10T18:00
furrow set t-19nfz --due 2026-10-10
furrow set t-cfqge --due 2026-10-11T17:00
furrow set t-q2ke1 t-ca3ef --due 2026-10-17
furrow set t-p3cnk --due 2026-10-19T15:00
furrow set t-52bk3 t-v6b0w --due 2026-10-21
furrow set t-67mw6 --due 2026-10-23
furrow set t-8nt5h --due 2026-10-24
furrow set t-a4qgf --due 2026-10-27
furrow set t-mamd8 t-xc1h1 --due 2026-10-29
furrow set t-21dax t-qwn6x t-0fytb --due 2026-10-31
furrow set t-rek26 --due 2026-11-03
furrow set t-g92fz --due 2026-11-04
furrow set t-c6q9y --due 2026-11-08
furrow set t-18gd9 --due 2026-11-10        # was 11/03(祝) — see hesitation 13
furrow set t-ts95s --due 2026-11-12
furrow set t-c3jda --due 2026-11-13
furrow set t-fjrkx --due 2026-11-14T18:00
furrow set t-5ntm2 --due 2026-11-14
furrow set t-n5n7w t-8cvve --due 2026-11-15
furrow set t-6bn1n t-s2gnz --due 2026-11-16
furrow set t-aradr --due 2026-11-18
furrow set t-9c6gj --due 2026-11-19
furrow set t-gpy5r --due 2026-11-20
furrow set t-rzk8j --due 2026-11-21T12:00
furrow set t-v8km8 --due 2026-11-21T21:00
furrow set t-gsnnp t-v2k46 --due 2026-11-21
furrow set t-y5mxq --due 2026-11-22T21:00
furrow set t-hba7h --due 2026-11-22
furrow set t-a9cnz --due 2026-11-23T21:00
furrow set t-r8y19 t-zqsqw --due 2026-11-25
furrow set t-xb97g --due 2026-11-26T21:00
furrow set t-t24m0 --due 2026-11-26
furrow set t-hfhm9 --due 2026-11-27T11:00
furrow set t-g9m6s --due 2026-11-27T15:00
furrow set t-k6bbk --due 2026-11-27T18:00
furrow set t-z1fry --due 2026-11-27T21:00
furrow set t-dtrh2 --due 2026-11-27T22:00
furrow set t-70evb t-p2sb7 --due 2026-11-28T16:00
furrow set t-5mn77 --due 2026-11-28T16:20
furrow set t-z45bj --due 2026-11-28T16:30
furrow set t-vk0kf --due 2026-11-28T16:40
furrow set t-e2yf0 --due 2026-11-28T16:45
furrow set t-1bghx --due 2026-11-28T16:50
furrow set t-t770e --due 2026-11-28T17:30
furrow set t-bk5re --due 2026-11-28T18:45
furrow set t-8x2vs --due 2026-11-28T19:00
furrow set t-b71f5 --due 2026-11-28T19:30
furrow set t-z564r --due 2026-11-28T20:45
furrow set t-836kh --due 2026-11-28T21:00
furrow set t-1stn7 --due 2026-11-28T21:30
furrow set t-jayrp --due 2026-11-28T21:40
furrow set t-dca61 --due 2026-11-28T21:45
furrow set t-8x6qn --due 2026-11-28T21:55
furrow set t-kcdqp --due 2026-11-28T22:00
furrow set t-bxkk1 --due 2026-11-29T12:00
furrow set t-qfnd4 --due 2026-11-29
furrow set t-4cq1g --due 2026-12-01T21:00
furrow set t-245zs --due 2026-12-02
furrow set t-sgpfv --due 2026-12-03
furrow set t-gjxws --due 2026-12-05T20:00   # D+7 retro: sat exactly on the NEW date
furrow set t-m8hc7 --due 2026-12-08
furrow set t-f0stz --due 2026-12-10
furrow set t-r84n7 t-2sct2 --due 2026-12-12
furrow set t-mkrf6 --due 2026-12-19

# ---- 3. the 7 repeating series: due + rule in ONE write (re-anchor) ----
#        `--due` alone moves THIS occurrence only; the UNTIL is +7d as well
furrow set t-16hvj --due 2026-09-27T20:00 --repeat 'FREQ=WEEKLY;UNTIL=20261018T235959Z'
furrow set t-nt65v --due 2026-10-24       --repeat 'FREQ=WEEKLY;UNTIL=20261128T235959Z;BYDAY=SA'
furrow set t-fg902 --due 2026-11-07T18:00 --repeat 'FREQ=WEEKLY;UNTIL=20261121T235959Z;BYDAY=SA'
furrow set t-74ffs --due 2026-11-14       --repeat 'FREQ=WEEKLY;UNTIL=20261127T235959Z;BYDAY=SA'
furrow set t-r6xpt --due 2026-12-06T20:00 --repeat 'FREQ=WEEKLY;UNTIL=20270103T235959Z'
furrow set t-csy5w --due 2027-05-27       --repeat 'FREQ=MONTHLY;INTERVAL=6'
furrow set t-4zw13 --due 2027-11-28       --repeat 'FREQ=MONTHLY;INTERVAL=12'

# ---- 4. the two done outputs that are now false -> redo tasks + deps ---
#  t-w06qv (done) polled 12 guests for 11/21: OK 9 / NG 1(11/21 出張) / 未返信 2.
#  t-1swgk (done) built the 6-candidate table on the axis 「11/21(土) 17:00-22:00」,
#  t-3nc93 (done) sent the A/B/C inquiries carrying that date (9/14 送信).
#  Done bodies are history (CLAUDE.md) — never rewritten; the redo is new work.
furrow add "開催日 11/28 でゲスト 12 名に可否を取り直す" -e e-0w7hf -s ready \
  --value 5 --effort 2 --due 2026-10-01 -l guest-comms,guests,schedule \
  --body "目的: 11/21 で取った一次可否([[t-w06qv]])は日程変更で全件無効になったため、11/28 で取り直す。
完了条件: 12 名分の可否が 11/28 の日付で揃い、[[t-a014x]] の出欠表に反映されている。
前提: 11/21 が NG だった 1 名(出張)は 11/28 なら来られる可能性があるので必ず含める。
前提: 11/21 で OK だった 9 名の回答は 11/28 には使えない。人数が 12 名から動くと
      [[t-21dax]] の 15 人前基準と [[t-19nfz]] の定員ノックアウト条件が変わる。
次の一手: 変更の理由と新日程を 1 通にまとめて全員へ同報する。"
furrow add "候補 A/B/C に 11/28 の空きと料金を取り直す" -e e-0w7hf -s ready \
  --value 5 --effort 1 --due 2026-09-29T18:00 -l venue-selection,external-wait \
  --body "目的: 空き・料金の問い合わせ([[t-3nc93]])は 11/21 で送ってあり、11/28 の空きは未知。
完了条件: A/B/C それぞれから 11/28(土) 17:00-22:00 の可否と料金が返ってきて比較表に入っている。
前提: 設備インベントリ([[t-3e3px]])とキャンセル条項([[t-rdw97]])は日付に依らないので取り直さない。
前提: 1 件でも 11/28 が押さえられなければ [[t-19nfz]] の母集団が変わる。
次の一手: notes/venue-inquiry-template.md の日付行を 11/28 に直してから再送する。"
furrow dep t-19nfz --add <venue-recheck-id>     # decision waits on the new availability
furrow dep t-a014x --add <guest-repoll-id>      # 12 名確定 waits on the new poll
furrow dep <guest-repoll-id> --add t-w06qv      # redo declares what it replaces
furrow dep <venue-recheck-id> --add t-3nc93

# ---- 5. 前提 lines that stopped being true -> furrow note (never edited) ----
furrow note t-v8km8 "9/14 の口頭打診は 11/21 の日程で取ったもの。11/28 で改めて可否を取り直す。14:45 入り/22:00 までの条件自体は変えない。"
furrow note t-a014x "9/27 の補欠切り替え判断は 11/28 での再打診の結果で行う。11/21 の OK 9 / NG 1 はそのまま使えない。"
furrow note t-qw8jc "C に明記した返信期限 9/22 は送信済みの内容なので遡って動かさない。due だけ +7 日にした。9/29 18:00 で電話催促、10/1 まで出なければ C を落とす。"
furrow note t-1j38n "書面取り付けの締切だけ +7 日。候補への依頼文に書いた期限は送信済みのため据え置き。"
furrow note t-19nfz "C の足切り日を 9/24 → 10/1 に移した(日程変更ぶん)。ノックアウト条件と 5 軸の重みは変えない。"
furrow note t-g61ny "A の下見は 10/1(木) 14:00 でアポ済み。日程変更でも先方の枠は動かないのでこの訪問はそのまま実施する。due(両件の完了期限)だけ 10/10 にした。"
furrow note t-cfqge "申込 10/4 / 入金 10/12 は会場側の締切で、開催日の +7 日で自動的に動くとは限らない。11/28 で押さえ直す際に先方の締切を聞き直し、その値で [[t-p3cnk]] の due を置き直す。"
furrow note t-18gd9 "11/03(祝) の 5 時間枠を狙った試作だったが、+7 日で 11/10(火) の平日になり同じ時間が取れない。11/08(日) に前倒しするか、工程を 2 晩に割るかを [[t-c3jda]] の工程表と一緒に決める。"
furrow note t-gjxws "+7 日で 12/5。移動前の due(11/28)は新しい開催日そのものだったので、この 1 件は必ずずらす。"
furrow note t-16hvj "UNTIL を 10/11 → 10/18(申告回答期限 10/17 の次の日曜)に。9/20 の回は未実施のまま新日程に載せ替えた。"

# ---- 6. bodies carrying absolute dates derived from the old date -------
#  16 open bodies (the 3 done ones are left alone). `edit --body` REPLACES the
#  whole body, so each is re-emitted with only the dates changed:
#  t-pvpwd D-42(10/10 -> 10/17) / t-q2ke1 9/28 -> 10/5, 10/10 -> 10/17 /
#  t-rzk8j 11/14(土) -> 11/21(土) / t-fjrkx D-1(11/20 金 -> 11/27 金) /
#  t-g92fz D-1(11/20 -> 11/27) / t-74ffs D-14(11/7 -> 11/14), D-1(11/20 -> 11/27),
#  D-7(11/14 -> 11/21) / t-18gd9 11/03 -> 11/10 / t-nt65v 10/17 -> 10/24 /
#  t-r6xpt UNTIL 12/27 -> 1/3 / t-qw8jc 9/22,9/24 -> 9/29,10/1 /
#  t-a014x 9/20,9/27 -> 9/27,10/4 / t-g61ny 10/1,10/3 -> 10/1(据え置き),10/10 /
#  t-19nfz 9/24 -> 10/1 / t-cfqge 10/4,10/12 は会場側 / t-16hvj 9/20 -> 9/27 /
#  t-v8km8 (9/14 は履歴、変更なし)
furrow edit t-pvpwd --body -   # ... one per task, heredoc per body
# ---- 7. repo files that carry the same derived dates (hand edits) -----
#  notes/dietary-form.md:4   回答期限 2026-10-10（D-42） -> 2026-10-17
#  notes/venue-inquiry-template.md:16,18  2026-11-21(土) -> 2026-11-28(土)
#  notes/site-visit-checklist.md:8,26     10/3 期限 -> 10/10
#  README.md:6               "serve five courses on 2026-11-21" -> 2026-11-28
# ---- 8. verify --------------------------------------------------------
furrow lint
furrow epic show 会場 --json | jq -r .meta.event_date      # 2026-11-28
furrow ls -q 'has:due' -n 0 --json | jq -r '.[]|"\(.due) \(.id)"' | sort
furrow search 11/21          # must return only the 3 done tasks
furrow brief
furrow sync
```

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow brief` | the due band printed 4 dated rows ("due (4, every epic)") and nothing said how much dated work the board holds; a reschedule needs all of it, so I went to `furrow ls --help` to find the flag that lists every lane and then ran an unplanned `furrow ls -q 'has:due' -n 0 --json` | that `-n 0` = no cap and `has:due` is a real qualifier; that 95 is the whole population | a furrow change: brief's due band naming the total dated count it truncated to ("4 of 95 dated") | no |
| 2 | `furrow epic show 会場` | CLAUDE.md gives the read as `furrow epic show 会場 --json`, but no epic is titled 会場 — it is 会場と日程を確定する; I had to guess that a unique title substring resolves, and ran it to see | that substring resolution works (it did) | a line of prose: CLAUDE.md quoting the id — "`furrow epic show e-0w7hf --json \| jq -r .meta.event_date`" | no |
| 3 | `furrow epic set` | CLAUDE.md gives only the READ for event_date; the write form is nowhere in the board's prose, so I opened `furrow epic set --help` | `--meta event_date=2026-11-28`, and that setting one key leaves `slug` alone | a line of prose: "a reschedule is `furrow epic set e-0w7hf --meta event_date=<date>` first, then the dues" | no |
| 4 | locating every copy of the date | CLAUDE.md says "the event date lives in ONE place", but `2026-11-21`/`11/21` is also in README.md:6, notes/venue-inquiry-template.md (the outgoing email body) and notes/dietary-form.md (as a derived 回答期限) — so "the whole board" has edges the prose denies | that repo prose under notes/ and README.md is in scope and must be hand-edited | a lint code (`event-date-drift`: a literal date in a body/README that equals the old `event_date`), or prose: "notes/ carries derived dates; a reschedule sweeps it too" | no |
| 5 | `furrow search 2026-11-21` | returns **no matches**, although `e-0w7hf`'s meta holds exactly that string — search covers task title+body only, so the one authoritative copy of the date is invisible to the tool that finds dates | that `epic show --json` is the only way to read it | a furrow change: `search`/`-q` free text covering epic titles, bodies and meta values | no |
| 6 | `furrow set --due` (the 91-row shift) | there is no relative-to-its-own-due shift: `--due +7d` is measured from **now** (a snooze), and the `-q` bulk selection applies ONE absolute value to every match. A one-week move of 91 dated tasks cannot be expressed; it has to be typed | that I must compute and type 78 absolute stamps (71 + 7 writes), grouping ids that share an instant | a furrow change: `furrow set -q 'has:due -status:done' --due-shift +7d --yes` — an offset applied to each task's existing due | no |
| 7 | converting the stamps | `ls --json` prints `due` as UTC (`2026-11-20T14:59:59Z`) while `--due` parses board-local (Asia/Tokyo); a literal copy would have moved every whole-day deadline to 14:59 JST. I wrote a script to convert 91 of them | that `--due 2026-11-27` means the whole day (23:59:59 +09:00) exactly as the stored values do | a furrow change: `--json` emitting `due` in the board's timezone offset, the way every human view already renders it | no |
| 8 | the 4 `done` dues | t-1swgk/t-w06qv/t-k3rt9/t-3nc93 carry dues in the past; CLAUDE.md says "every `due` … is derived from it", which would shift them, and also "a done task's body is history" — silent on its due | left the 4 done dues untouched (a closed deadline is a record) | a line of prose: "a closed task's due is history too — a reschedule moves only open work" | no |
| 9 | the 7 repeating tasks | `set --due` on a repeating task moves THIS occurrence only and never the anchor; re-anchoring needs `--due … --repeat <rule>` in one write, and the rule I must hand back is the stored raw RRULE — but `furrow vocab repeat-spellings` lists no `until` spelling, so I could not confirm an `UNTIL=` survives the round trip. The stored UNTILs are also `Z`, so t-74ffs's "D-1" (`20261120T235959Z`) is really 11/21 08:59 JST — already one day off | pasting the raw RRULE back with `UNTIL` +7d, keeping the `Z` form and its off-by-9h quirk | a furrow change: `--repeat-until <date>` (or `--due-shift` also moving the rule's UNTIL), plus `repeat-spellings` documenting the raw-RRULE round trip | no |
| 10 | which `UNTIL`s are derived | t-nt65v and t-4zw13 name their anchor in the body (「開催日（会場 epic の meta event_date）」) and t-16hvj explains 10/11 as 「回答期限 10/10 の次の日曜」, but t-r6xpt's UNTIL=12/27 and t-csy5w's 2027-05-20 (= D+180) state no anchor at all | shifted every UNTIL and every icebox due +7d for consistency | a furrow change: a due/until expressed relative to an epic meta key (`event_date+7d`), so derivation is stored, not narrated | no |
| 11 | the overdue / due-today rows | t-16hvj (overdue 9/20) and t-qw8jc (overdue 9/22) are the 2 lint errors on this board, and t-pvpwd/t-1j38n are due today; +7d turns all four green although none of the work happened. A reschedule that erases the chase signal is the wrong kind of tidy | shifted them anyway (the board rule derives every due from the event date) and left a `furrow note` on each saying the chase is still outstanding | a line of prose: "an overdue chase keeps its date through a reschedule — move the work, not the miss" | yes: due-overdue |
| 12 | dates already committed to a third party | t-g61ny says 「A は 10/1(木) 14:00 に下見アポ済み」, t-qw8jc 「返信期限 9/22 と明記済み」, t-cfqge 「申込は 10/4 17:00 まで / 入金は 10/12 まで」 — none of these move because our dinner moved, yet all three are `due` fields the rule says to shift | shifted the dues (they are our own completion deadlines and only relax) and noted on each that the externally-fixed date stands; flagged that t-p3cnk's 入金 due must be re-read from the new booking, not computed | a furrow change: marking a due as externally fixed (exempt from a bulk shift) — or a `fixed-date` label convention stated in prose | no |
| 13 | t-18gd9 | the trial cook is planned for 11/03（祝）, a public holiday picked for a 5-hour block (body: 「11/03 13:00-18:00 で試作」); +7d lands on 11/10(火), an ordinary weekday. Nothing on the board marks the due as holiday-anchored — only the 「（祝）」 inside prose | shifted to 11/10 and noted that the slot is gone, proposing 11/08(日) or splitting the cook over two evenings | a furrow change: a due that carries a required duration/日中枠, so a move can report "the new date has no such slot"; short of that, a lint code for a body naming a weekday the due no longer falls on | no |
| 14 | t-gjxws | the D+7 retro is dated **2026-11-28 20:00** — the new event date. Anything that shifted the dinner but missed one task would have put the retrospective on dinner night, and the board has no check for two things claiming D0 | shifted it to 12/05 with the rest and made it an explicit line in the plan | a lint code: a due colliding with the venue box's `event_date` (a `date-collision` warn) | no |
| 15 | the 3 `done` tasks whose output is now false | t-w06qv (12 名の一次可否 for 11/21), t-1swgk (候補表の軸が 11/21 17:00-22:00), t-3nc93 (問い合わせ送信, whose body says only 「9/14 に A/B/C へ送信」 — the date it carried is in notes/, not the task). `furrow search 11/21` finds the first two; the third is invisible | 2 redo tasks (guest re-poll, venue availability re-check) + 4 dep edges; t-1swgk's 母集団 is subsumed by the venue re-check | a furrow change: a label or field marking a task whose OUTPUT embeds the event date, so a reschedule can list them (`furrow ls -l date-bound`) instead of grepping | no |
| 16 | t-v8km8 (waiting) | the 手伝い 2 名 confirmation rests on 「9/14 に口頭で打診済み」 — an ask made for 11/21. The task is not done, so the redo-as-new-task rule does not apply, and CLAUDE.md's only lever for a dead 前提 is `furrow note` | kept the task, noted the void ask, shifted the due; did not re-open it as new work | a line of prose covering a **waiting** task whose external ask must be re-sent (the current line retires a 前提 but says nothing about the wait itself) | no |
| 17 | the guest count | if the re-poll changes 12 名, three things downstream change: t-21dax's 15 人前 basis, t-19nfz's ③定員 knock-out, and t-0fytb's 案内. The board carries no link from the headcount to the tasks that consume it | left them as-is and wrote the consequence into the re-poll task's body instead | a furrow change: nothing furrow can hold today — a value other tasks read (a board-level variable) is the missing thing; prose alternative: "the headcount lives in t-a014x; tasks that consume it name it in 前提" | no |
| 18 | 16 open bodies with stale absolute dates | CLAUDE.md says a 前提 that stopped being true is retired with `furrow note`, but it also says every D-N in a body is derived from the event date. A note leaves 「D-42（10/10）」 wrong forever; `edit --body` replaces the WHOLE body (every line re-typed) and looks like rewriting the record | `edit --body` for pure date arithmetic, `note` for a 前提 that changed meaning — and did both on the same task where they collide | a line of prose: "stale derived dates are rewritten with `edit --body`; only a 前提 that changed meaning is retired with `note`", or a furrow change: a body find/replace that stamps `updated` | no |
| 19 | notes/*.md | notes/venue-inquiry-template.md holds the 11/21 email body AND a record of what was sent on 9/14; it is `refs` of a **done** task (t-3nc93). Editing it both fixes the template we will re-send and rewrites a record | edited only the quoted email block's dates and left the sent-log table alone | a line of prose: "a notes/ file may be both a template and a log — a reschedule touches the template lines only" | no |
| 20 | notes/site-visit-checklist.md, venue-compare.md | they refer to tasks by a private namespace — `venue-decision`, `venue-quote-c`, `venue-inquiry-3` — that furrow cannot resolve; I mapped them to t-19nfz / t-qw8jc / t-3nc93 by reading titles | that the mapping is what the titles suggest | a board fix: notes/ using `[[t-id]]` like the bodies do; a lint code (`dangling-link`) only covers bodies, and refs are never checked | no |
| 21 | `furrow note e-0w7hf` | the reschedule decision (what moved, when, what was re-asked) needs one canonical home; e-0w7hf's body is two lines (title + "activated") and no field records a decision | appended it to the epic body with `furrow note` | a line of prose: "box-level decisions go in the epic body" — the board never demonstrates it | no |
| 22 | the whole plan | nothing on the board says whether 11/28 is feasible: the venue's availability, the 12 guests', the 手伝い 2 名's, and the 会場費 at a different Saturday are all unknown, so the "bring the board in line" I planned may be re-planned a second time next week | proceeded on the assumption that the move is already agreed with the venue and only the guests need re-asking | a line of prose in the request/board: who has already confirmed the new date — or a task filed for it (which is what the 2 new tasks do) | no |

## Verdict

- `could_act_confidently: false` — the arithmetic is unambiguous (every due
  is an exact D±N offset and both dates are Saturdays), but furrow cannot
  express a relative shift, so the whole move is 78 hand-typed stamps, and
  every judgement that matters — which dues are ours versus a third party's,
  whether an overdue chase resets, what a holiday-anchored slot becomes —
  is guessed from prose that says "every due is derived".
- hesitations: 22
- rows with `yes` in the last column: 1
