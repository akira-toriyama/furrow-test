# Drill run — reschedule (2026-09-25)

Request: "The dinner moves one week later, from 2026-11-21 to 2026-11-28.
Bring the whole board in line: every date, every task whose plan assumed the
old date, and anything that no longer makes sense at the new one."

## Measured on

- Board commit: `9896fee` (`akira-toriyama/furrow-test`, last board commit
  2026-09-25 12:48 +09:00)
- furrow version: `furrow dev` (schema v10 board / v10 binary — writable)
- Run: 2026-09-25 Fri, 15:08–15:16 JST (board `[due].timezone = Asia/Tokyo`)
- Session: a Claude Code subagent on Opus, handed only this request, the
  drill rules, the recording format, the repo's `README.md` and `CLAUDE.md`,
  and the board through the `furrow` CLI, the files under `.furrow/`, and
  `notes/`. No `docs/`, no `seed/`, no prior knowledge of this board.
- The operator had already run `furrow sync`; this run never ran it. Read-only
  throughout: nothing below was executed.
- Board state read: 100 tasks, 95 carrying a due, 5 epics, 105 bodies, 9
  files under `notes/`. `furrow lint` = 4 errors, all `due-overdue`.

Scope of the change, as measured: `event_date = 2026-11-21` lives once, in
the venue box's meta (`e-4shr4`). 95 tasks carry a due; every one of them
lands on a clean D±N offset from that date (D-75 … D+365). 2026-11-21 and
2026-11-28 are both Saturdays, so a uniform +7d preserves every 「(土)」
「(金)」「週末」 assumption in the bodies — the one exception is t-cgqjx's
11/03（祝）. 35 bodies carry D-N notation (relative — no edit needed); 13
bodies, 1 checklist row and 3 `notes/` files carry an absolute derived date
that does move. Two `done` bodies name 11/21 literally and are history.

## Plan

```sh
cd /Volumes/workspace/github.com/akira-toriyama/furrow-test

# ── 0. the single source of the date ─────────────────────────────────────
furrow epic set 会場 --meta event_date=2026-11-28

# ── 1. dues: +7d on all 95 minus 5 exceptions (see Hesitations 11,16) ────
#    exceptions kept as-is: t-yf4vd t-jnpwk t-4q921 t-vzyxv (done: a closed
#    task's promise is settled, its body is history) and t-cgqjx (11/03 is a
#    public holiday, the reason the date was chosen; +7 lands on a Tuesday).
#    grouped by identical new instant — `set` applies one edit to many ids in
#    ONE all-or-nothing write. 83 tasks / 70 writes.
furrow set t-j5rww --due 2026-09-29T18:00
furrow set t-jdtvf t-w65xk --due 2026-10-01
furrow set t-ck1j4 --due 2026-10-03
furrow set t-2x2dm t-fz6xs --due 2026-10-04
furrow set t-sftpe --due 2026-10-06
furrow set t-xqfdm --due 2026-10-07
furrow set t-80nmd --due 2026-10-10
furrow set t-xcrzs --due 2026-10-10T18:00
furrow set t-3r4ra --due 2026-10-11T17:00
furrow set t-0w0h2 t-a8vk5 --due 2026-10-17
furrow set t-a7c0b --due 2026-10-19T15:00
furrow set t-qrdt9 t-ybhjh --due 2026-10-21
furrow set t-qe2ey --due 2026-10-23
furrow set t-2vhac --due 2026-10-24
furrow set t-4d2xj --due 2026-10-27
furrow set t-aj8qa t-bn0js --due 2026-10-29
furrow set t-13gpv t-sfan8 t-wg2vj --due 2026-10-31
furrow set t-0ktw7 --due 2026-11-03
furrow set t-64jgf --due 2026-11-04
furrow set t-nf8ra --due 2026-11-08
furrow set t-wy0h2 --due 2026-11-12
furrow set t-s3834 --due 2026-11-13
furrow set t-9pnfe --due 2026-11-14
furrow set t-nc4we --due 2026-11-14T18:00
furrow set t-3anqr t-m1bqv --due 2026-11-15
furrow set t-p60j5 t-w1nyn --due 2026-11-16
furrow set t-b6xph --due 2026-11-18
furrow set t-kb7be --due 2026-11-19
furrow set t-yy8dm --due 2026-11-20
furrow set t-brj24 t-yf334 --due 2026-11-21
furrow set t-hw9fh --due 2026-11-21T12:00
furrow set t-8a93f --due 2026-11-21T21:00
furrow set t-n8e8f --due 2026-11-22
furrow set t-gsbs3 --due 2026-11-22T21:00
furrow set t-j28bm --due 2026-11-23T21:00
furrow set t-8ahdr t-jwy1p --due 2026-11-25
furrow set t-v1gyc --due 2026-11-26
furrow set t-mgyt3 --due 2026-11-26T21:00
furrow set t-j8agn --due 2026-11-27T11:00
furrow set t-pk6mm --due 2026-11-27T15:00
furrow set t-td2qr --due 2026-11-27T18:00
furrow set t-q3ddv --due 2026-11-27T21:00
furrow set t-aeeq8 --due 2026-11-27T22:00
furrow set t-79re5 t-d2h0w --due 2026-11-28T16:00
furrow set t-b6tyb --due 2026-11-28T16:20
furrow set t-x9aba --due 2026-11-28T16:30
furrow set t-a15em --due 2026-11-28T16:40
furrow set t-94r4a --due 2026-11-28T16:45
furrow set t-efd2y --due 2026-11-28T16:50
furrow set t-yhqd3 --due 2026-11-28T17:30
furrow set t-11fzg --due 2026-11-28T18:45
furrow set t-aq48g --due 2026-11-28T19:00
furrow set t-h2q2q --due 2026-11-28T19:30
furrow set t-gwnnt --due 2026-11-28T20:45
furrow set t-8mew8 --due 2026-11-28T21:00
furrow set t-sa1my --due 2026-11-28T21:30
furrow set t-efmzq --due 2026-11-28T21:40
furrow set t-kce20 --due 2026-11-28T21:45
furrow set t-gkpht --due 2026-11-28T21:55
furrow set t-9r6s3 --due 2026-11-28T22:00
furrow set t-k4mb6 --due 2026-11-29
furrow set t-svtk9 --due 2026-11-29T12:00
furrow set t-s2wae --due 2026-12-01T21:00
furrow set t-391yn --due 2026-12-02
furrow set t-yvq28 --due 2026-12-03
furrow set t-xpc1a --due 2026-12-05T20:00     # D+7 retro — its OLD due was 11/28
furrow set t-c4qx0 --due 2026-12-08
furrow set t-ztvq7 --due 2026-12-10
furrow set t-c696y t-j8vhk --due 2026-12-12
furrow set t-j5102 --due 2026-12-19

# ── 2. the 7 repeating series: --due + --repeat in ONE write re-anchors ──
#    (--due alone moves THIS occurrence only; the anchor never moves.)
#    Each UNTIL is itself derived from the event date, so it moves +7d too.
furrow set t-010c2 --due 2026-09-27T20:00 --repeat 'FREQ=WEEKLY;UNTIL=20261018T235959Z'
furrow set t-65v5b --due 2026-10-24 --repeat 'FREQ=WEEKLY;UNTIL=20261128T235959Z;BYDAY=SA'
furrow set t-q6hhh --due 2026-11-07T18:00 --repeat 'FREQ=WEEKLY;UNTIL=20261121T235959Z;BYDAY=SA'
furrow set t-b81m8 --due 2026-11-14 --repeat 'FREQ=WEEKLY;UNTIL=20261127T235959Z;BYDAY=SA'
furrow set t-q1f6e --due 2026-12-06T20:00 --repeat 'FREQ=WEEKLY;UNTIL=20270103T235959Z'
furrow set t-gx355 --due 2027-05-27 --repeat 'FREQ=MONTHLY;INTERVAL=6'
furrow set t-9an0d --due 2027-11-28 --repeat 'FREQ=MONTHLY;INTERVAL=12'

# ── 3. checklist rows carrying a derived absolute date ──────────────────
furrow check t-jdtvf 3 --reword "回答期限を10/17と明記する"
furrow check t-xcrzs 4 --reword "B の下見枠を 10/10 までにもらう"

# ── 4. bodies whose DERIVED dates moved: edit --body (CLAUDE.md names
#      "a derived date that moved" as the repair case for edit --body).
#      Each is a whole-file replace of the current body with only the dated
#      strings below changed; every other line kept byte-for-byte.
furrow edit t-010c2 --body -   # 9/20(日)→9/27(日) / UNTIL 10/11→10/18 / 回答期限 10/10→10/17
furrow edit t-65v5b --body -   # 10/17（土）から開始→10/24（土）
furrow edit t-a8vk5 --body -   # 配布 9/28→10/5 / 回答期限 10/10(D-42)→10/17(D-42)
furrow edit t-jdtvf --body -   # 回答期限は D-42（10/10）→D-42（10/17）
furrow edit t-sftpe --body -   # 週次督促 9/20→9/27 / 「9/27 までに返事が無ければ」→10/4（2 か所）
furrow edit t-3r4ra --body -   # 申込 10/4 17:00→10/11 17:00 / 入金 10/12→10/19（暫定・H13）
furrow edit t-64jgf --body -   # 生鮮は D-1（11/20）→D-1（11/27）
furrow edit t-nc4we --body -   # 受取は D-1（11/20 金）→D-1（11/27 金）
furrow edit t-b81m8 --body -   # D-14(11/7 土)→(11/14 土)×2 / D-1（11/20）→（11/27）/ D-7（11/14 土）→（11/21 土）
furrow edit t-hw9fh --body -   # 11/14(土) までに電話→11/21(土)
furrow edit t-q1f6e --body -   # UNTIL=12/27→2027/1/3
furrow edit t-xcrzs --body -   # B の枠 10/3→10/10（A の 10/1(木)14:00 は先方と合意済みのアポ: 動かさない・H12）

# ── 5. lines that stopped being TRUE: furrow note (the line itself stays) ─
furrow note t-cgqjx "開催日が 11/28 に移動。この task の due 11/03 は据え置く: 11/03（祝）を 13:00-18:00 の試作枠に充てる前提で、+7 の 11/10 は平日火曜で枠が取れない。D-18→D-25 になり前倒しになるだけで、実測値の引き渡し先（[[t-0ktw7]] / [[t-gsbs3]]）には影響しない。"
furrow note t-j5rww "開催日が 11/28 に移動。checklist[0] の 9/22 18:00 電話催促は実施済みで、この due の +7（9/29 18:00）は「次の催促日」であって過去の催促を書き換えるものではない。打ち切り条件（due を 2 日過ぎて未返信なら C を落とす、ただし候補が 2 件残る場合に限る）も 10/1 にずれる。C には空き再確認（下の新規 task）と同じ便で再送する。"
furrow note t-8a93f "開催日が 11/28 に移動。前提「9/14 に口頭で打診済み」は 11/21 に対する打診で、11/28 の可否は未取得。会場確定を待たず、日付変更だけ先に 2 名へ再送する。返信が 11/28 不可なら皿数削減の判断を menu 側に投げる期限は D-7（11/21）。"
furrow note t-sftpe "開催日が 11/28 に移動。出欠の母集団（OK 9 / NG 1 / 未返信 2）は [[t-jnpwk]] が 11/21 で取ったもので、11/28 では取り直しが要る。再打診は新規 task に分け、この task はその結果を受けて 12 名で閉じる（dep を 1 本追加した）。"
furrow note t-80nmd "開催日が 11/28 に移動。ノックアウト条件に「11/28(土) 17:00-22:00 に空きがあること」が加わる。A/B/C の空きは 11/21 前提の [[t-yf4vd]] / [[t-vzyxv]] でしか取っておらず未確認のため、空き再確認の新規 task を dep に足した。空き無しで落ちた候補は cand-x の書き換え（retitle / reword / note → ラベル外し）で落とす。"
furrow note t-ck1j4 "開催日が 11/28 に移動。キャンセル無料期限は会場規約上「利用 N 日前」の相対値（A=14 日前 / B=21 日前）なので条文の転記内容は変わらないが、暦日は A 11/14・B 11/07 にずれる。本予約（[[t-3r4ra]]）はまだ済んでおらず、今回の日程変更でキャンセル料は発生しない。"
furrow note t-2vhac "開催日が 11/28 に移動。会場費の実額は日付変更後の見積で取り直す（土曜夕方枠の単価が変わらない前提は未確認）。"

# ── 6. redo work = a NEW task with a dep on the one it replaces ──────────
#    ([[t-jnpwk]] / [[t-yf4vd]] are done: their bodies are history, not edited,
#     and t-jnpwk keeps its title 「開催日 11/21 を…」 — it records what was done.)
furrow add "開催日の 11/28(土) 変更をゲスト 12 名に再打診して可否を取り直す" \
  -s ready -e 会場 --due 2026-10-02 \
  -l guest-comms,guests,schedule \
  --dep t-jnpwk \
  --check "12 名に日程変更を個別に通知する" \
  --check "11/21 NG(出張) の 1 名に 11/28 の可否を聞き直す" \
  --check "11/21 OK 9 名の 11/28 可否を取り直す" \
  --check "出欠表を 11/28 基準で作り直す" \
  --body "目的: 開催日が 11/28(土) に移ったため、11/21 で取った一次可否（[[t-jnpwk]]、OK 9 / NG 1 / 未返信 2）を取り直す。
完了条件: 12 名全員について 11/28 の OK / NG / 未返信 のいずれかが出欠表に記録されている。
前提: [[t-jnpwk]] は 11/21 に対する打診で、結果はそのまま使えない（NG 1 名は 11/21 の出張が理由で 11/28 は空いている可能性がある）。done の body は履歴なので書き換えず、この task で取り直す。
次の一手: 会場確定（[[t-80nmd]]）を待たず、日付だけ先に流す。住所は確定後に [[t-wg2vj]] が送る。"

furrow add "候補 A/B/C に 11/28(土) 17:00-22:00 の空きを再確認して比較表に記入する" \
  -s ready -e 会場 --due 2026-10-02 \
  -l cand-a,cand-b,cand-c,external-wait,venue-selection \
  --ref file:notes/venue-compare.md:8 \
  --check "A に 11/28 の空きと通し料金を照会する" \
  --check "B に 11/28 の空きと通し料金を照会する" \
  --check "C に 11/28 の空きと通し料金を照会する（未回答の見積督促と同じ便で）" \
  --check "比較表の基本情報に 11/28 の可否列を足す" \
  --body "目的: 開催日が 11/28(土) に移ったため、A/B/C の空きを取り直す。空きが無い候補は [[t-80nmd]] のノックアウト条件で落ちる。
完了条件: A/B/C それぞれについて 11/28(土) 17:00-22:00 の空き可否と通し料金が比較表に書かれている。
前提: 既存の空き確認は 11/21 前提（[[t-yf4vd]] の母集団条件と [[t-vzyxv]] の問い合わせ）。11/28 の空きはどの候補についても未取得。
前提: 空き無しの候補が出たらその場で cand-x を落とす（落として候補が 1 件になる場合は落とさず、その 1 件の採用可否だけを [[t-80nmd]] に書く — [[t-j5rww]] の打ち切り条件と同じ扱い）。
次の一手: [[t-vzyxv]] の問い合わせテンプレ（notes/venue-inquiry-template.md）の日付だけ差し替えた 1 通を 3 件に送る。"

# the two ids minted above are <NEW-POLL> and <NEW-AVAIL>:
furrow dep t-sftpe <NEW-POLL>     # 出欠 12 名の確定は再打診の後
furrow dep t-80nmd <NEW-AVAIL>    # 会場決定は 11/28 の空き確認の後

# ── 7. notes/ — part of the board; committed by hand, not by furrow sync ─
# notes/dietary-form.md
#   L5  「回答期限: 2026-10-10（開催日の D-42）」 → 「2026-10-17（開催日の D-42）」
#       （写しは正本 [[t-jdtvf]] の body/checklist に従う）
#
# notes/site-visit-checklist.md
#   L8  表頭 「B（枠待ち・10/3 期限）」 → 「B（枠待ち・10/10 期限）」
#       「A（10/1 木 14:00 アポ済み）」は先方と合意済みの実アポなので据え置き
#   L26 「B の枠が 10/3 までに出なければ」 → 「10/10 までに」
#
# notes/venue-inquiry-template.md
#   送信済み文面（L16-L19 の引用ブロック）は書き換えない。末尾に日付付きで追記:
#   「2026-09-25 追記: 開催日が 2026-11-28(土) 17:00-22:00 に変更。上の文面の
#    日付だけ差し替えた再照会を A/B/C の 3 件に送る（空き再確認 task）。
#    2026-09-14 送信分は 11/21 に対する照会で、回答はそのまま使えない。」
#
# notes/venue-compare.md
#   L4  最終更新を 2026-09-25 に更新し、同じ行に
#       「開催日は 2026-11-28(土) に変更。基本情報の 6 件は 11/21 の空き前提で
#        絞り込んだもので、A/B/C の 11/28 の空きは未確認。」を足す
#   L62-L68 キャンセル節は「利用 N 日前」の相対表記なので本文は変更なし
#       （暦日は A 11/14 / B 11/07 にずれる。本予約前なのでキャンセル料は発生しない）
#   他 4 ファイル（budget-80k / handoff / receipts / recipes）は日付を持たない: 変更なし
#
# git add notes/ && git commit   ※ furrow sync は .furrow/ しか publish しない

# ── 8. verify ────────────────────────────────────────────────────────────
furrow sync
furrow lint
furrow epic show 会場 --json | jq -r .meta.event_date   # → 2026-11-28
furrow ls --json | jq -r '.[]|select(.due)|[.id,.due]|@tsv'   # 全 due を再読み
grep -rnE '11/21|11-21|2026-11-21' .furrow/bodies notes/      # 残骸は done の 2 件のみ
furrow brief
```

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow brief` | `next (3/4 — 1 hidden by -n: 1 ready)` — one actionable row hidden, and I did not know whether it carried a date the reschedule touches | that it was safe to defer; ran an unplanned `furrow next -n 0` later (it was t-010c2, the repeating nag — dated) | a furrow change: `brief` should not cap a section it then counts, or should say which id it hid | no |
| 2 | `cat CLAUDE.md` | 「Every `due` and every D-N in a body is derived from it」 is unconditional, but the board plainly carries externally-anchored dues (t-3r4ra's body: 「申込は 10/4 17:00 まで / 入金は 10/12 まで」 are the venue's dates, not the dinner's) | took "every" literally — shifted all of them — and marked the venue-set ones provisional in a note | a line of prose: 「due は既定で開催日由来。相手が決めた期日（会場の申込・入金・返金期限）は例外で、reschedule では動かさず確認 task を立てる」 | no |
| 3 | `furrow epic show 会場 --json` | `event_date` is meta — free-form text nothing dereferences. Nothing in furrow ties a due to it, so "bring the board in line" is entirely manual and unverifiable afterwards | that the meta is documentation only, and that a post-hoc `grep` is the only check | a furrow change: a due expressible relative to an epic meta date (`--due @event_date-42`), so the shift is one write | no |
| 4 | `furrow ls --json` | `furrow brief` listed 4 dated rows; the board carries 95. I stopped to work out whether brief was narrowing or whether only 4 dues existed | that brief's `due` section is a near-term window, not the dated set | a line of prose in README's command notes: 「brief の due 節は直近ぶんだけ。全件は `ls --json`」 | no |
| 5 | `furrow ls --json` (post-processing) | before trusting the 「(土)」「(金)」「週末」 assumptions in 35 bodies I had to check that 11/21 and 11/28 are both Saturdays — an unplanned computation over every due | computed it (both Sat; +7d preserves every weekday) | nothing — this is the check that makes a +7 safe. A furrow change (a relative due) would make it unnecessary | no |
| 6 | `furrow set --help` | there is no "shift this due by N days" primitive: `--due +1d` is measured from **now**, not from the stored due. I re-read the help twice to be sure | that every one of the 90 shifted dues has to be computed and written as an absolute instant — 77 writes | a furrow change: `set --due +7d --relative-to-due` (or `furrow reschedule -q <sel> --shift 7d`), so a whole board moves in one write | no |
| 7 | `furrow set --due … --repeat …` | on a repeating task `--due` moves **this occurrence only** — the anchor never moves. I had to re-read to find that `--due X --repeat <rule>` in ONE write is the re-anchor | used the paired form for all 7 series | the help already says it; the stop was mine. What would remove it: a furrow change making `--due` on a repeating task refuse rather than silently do the narrower thing | no |
| 8 | (composing the 5 UNTILs) | UNTIL is stored as UTC inside an opaque RRULE string (`UNTIL=20261121T235959Z` = 11/22 08:59 JST) while the board's calendar is Asia/Tokyo. Shift the literal, or recompute in JST? | shifted the Z literal by 7 days (preserves the series' own relationship to its anchor) | a furrow change: `--repeat` should accept an UNTIL in the board's zone, or shift with the anchor | no |
| 9 | t-010c2 | its UNTIL is derived at **two hops**: UNTIL 10/11 = the Sunday after 回答期限 10/10, and 10/10 is D-42. Shifting the event date moves it through both | +7 (10/18) happens to satisfy both hops; verified by hand rather than assumed | a line of prose, or the relative-due furrow change from #3 | no |
| 10 | t-gx355 | due 2027-05-20 with `FREQ=MONTHLY;INTERVAL=6`. Six months after 11/21 is 5/21, not 5/20 — the anchor is unstated (D-1? a rounding?) | blind +7 → 2027-05-27, preserving whatever the original offset was | a line of prose in the body: 「開催日の 6 か月後（= D+180）」, the way t-9an0d says 「開催日の 1 年後」 | no |
| 11 | t-cgqjx | 「11/03（祝）に自宅で1人前を試作」 — the date was chosen because it is a public holiday. +7 lands on Tuesday 11/10, a working day, and the body's 13:00-18:00 block stops existing | kept 11/03 (it only gains slack: D-18 → D-25) and wrote a `furrow note` saying why | a line of prose: 「祝日・半休に置いた due は reschedule で動かさない。理由を本文に書いた due は日付側を正とする」 | no |
| 12 | t-xcrzs | 「A は 10/1(木) 14:00 に下見アポ済み」 — an appointment the other side already agreed to, inside a task whose due I am shifting to 10/10 | shifted the due and the B deadline (10/3→10/10), kept the A appointment at 10/1 | a line of prose, or a furrow change: a task cannot hold a start instant, so a booked appointment lives in prose where no shift can see it | no |
| 13 | t-3r4ra / t-a7c0b | 「申込は 10/4 17:00 まで / 入金は 10/12 まで」 are the venue's deadlines. Shifting them +7 asserts the venue agreed to a date change it has not been told about | shifted (board rule) and noted that the venue's own dates outrank the shift once the 11/28 availability answer lands | a shard field or label distinguishing an external deadline; failing that the prose line from #2 | no |
| 14 | t-j5rww | its due **is** a chase date and the chase already happened — checklist[0] 「9/22 18:00 時点で未着なら電話する」 is ticked and 現状 records the call. A blind +7 dates a past phone call into the future | set 9/29 18:00 as a **new** chase date and said so in a note | nothing in the board; the prose line 「waiting の due は追いかける日。過去の催促を書き換えず次の催促日を置く」 | yes: `due-overdue` |
| 15 | (after sizing the shift) | the shift moves all 4 currently-overdue rows into the future, so `furrow lint` goes 4 errors → 0. Is erasing today's only red a legitimate outcome of a reschedule? | yes, but each of the 4 gets a note so the erased red leaves a trace | a lint code that survives the shift (e.g. a "chased-but-unanswered external wait" check independent of the due) | yes: `due-overdue` |
| 16 | (the 4 done tasks) | do `done` tasks' dues shift? They are dated D-75…D-68 and their bodies are history | no — left alone, on the strength of a config.toml comment (「The done lane is always exempt … a closed task's promise is settled」) rather than a board rule | a line of prose in CLAUDE.md: 「done の due は reschedule の対象外（約束は決済済み）」 | no |
| 17 | t-jnpwk (done) | the whole guest poll was 11/21: 「結果: OK 9 / NG 1（11/21 出張）/ 未返信 2」, and 11/21 is in the **title**. The 9 OKs may not hold on 11/28 and the NG may now be free — the board's single largest invalidation, and it sits in a task I must not edit | new re-poll task with a dep on t-jnpwk, body and title untouched, plus a dep t-sftpe → new task | the prose is half there — 「A done task's body is history … Redo work is a new task with a dep on the one it replaces」 — but it does not say whether the TITLE also stays. Wanted: 「done の title も履歴。retitle しない」 | no |
| 18 | t-yf4vd (done) | the venue longlist was screened on 「11/21(土) 17:00-22:00 の通し利用」. A/B/C availability on 11/28 is unknown, and unavailability is a knockout condition in t-80nmd's 前提 | a new availability-recheck task blocking t-80nmd, rather than dropping a candidate now | a line of prose: 「reschedule は会場の空き前提を全部無効にする。空き再確認をノックアウト条件に足してから decision を回す」 | no |
| 19 | `furrow ls -l cand-a/b/c` | does the reschedule itself drop a candidate? The cand-x drop machinery (retitle / reword / note / label removal) is elaborate and fires 「the moment the failing answer lands」 | no drop yet — no failing answer has landed; the recheck task is what can produce one | the prose is clear once found; the stop was in locating it (it is one line inside a 9-line bullet) | no |
| 20 | t-8a93f | 「9/14 に口頭で打診済み」 was for 11/21; the helpers' availability on 11/28 is unknown. New task, or note on the existing waiting task? | a note + the shifted due — the task is still the right one and still waiting on the same two people | a line of prose: 「外部待ちの前提が日付変更で無効になったら task は立て直さず note で前提を差し替える」 | no |
| 21 | `furrow add` | which lane for the two new tasks? `[lanes].default = "inbox"` and `[next].lanes = ["in-progress","ready"]`, so an `add` with no `-s` lands where `next` cannot see it — on the critical path | `-s ready` for both (both are unblocked and both gate the venue decision) | a config key: `[lanes].default` (inbox on this board), or a prose line saying what lane a board-wide correction is filed in | no |
| 22 | `furrow note` vs `edit --body` | CLAUDE.md gives both rules — a falsified 前提 → `note` (the line stays); 「a derived date that moved」 → `edit --body` (repair). Several bodies are both at once (t-sftpe, t-3r4ra, t-xcrzs) | `edit --body` for the dates, `furrow note` for the premises, both on the same task where both apply | a line of prose: 「両方に当たる本文は edit --body で日付を直し、そのうえで note で前提を退役させる」 | no |
| 23 | `furrow check --reword` | t-jdtvf[3] 「回答期限を10/10と明記する」 is a derived date inside a checklist row, but the reword rule in CLAUDE.md is written for a row that counts a **population** (3 件分, 両会場分) | applied `--reword` anyway (the row would otherwise contradict its own body) | a line of prose: 「checklist の行が持つ日付も本文と同じく派生値。ずれたら reword する」 | no |
| 24 | `notes/venue-inquiry-template.md` | it holds the **sent** inquiry text carrying 「2026-11-21(土) 17:00-22:00」, and the rule is that a sent text is appended to, never rewritten. Appending leaves the template that the next inquiry copies still saying 11/21 | appended a dated block carrying the 11/28 wording, left the quoted sent text intact | a line of prose: 「送信済み文面は履歴、次に送る文面は追記ブロックに置く」 — or splitting the note into a sent-log and a live template | no |
| 25 | `notes/venue-compare.md` | the reschedule invalidates 空き for all six candidates, but the table has **no 空き column** — availability is implicit in 「状態: 一次返信あり」. There is nothing to blank | added a dated line under 基本情報 rather than inventing a column, and put the column in the new task's checklist | a line of prose, or a note-side convention for "this table's rows rest on the event date" | no |
| 26 | `grep` over bodies for dates | t-q3ddv line 2 matched my date scan five times — it is 「20:45/21:00/21:20/21:40/21:55/22:00」, clock times, not dates. Had to open the body to clear it | that the whole line is times; no action | nothing on the board — an artifact of scanning prose for dates because no field holds them. The relative-due furrow change from #3 removes the need to scan | no |
| 27 | t-xpc1a | its current due is **2026-11-28 20:00** — the new event date. I stopped to check it was not a special date before treating it as D+7 | D+7 → 2026-12-05. Had I left it, the retrospective would have been scheduled on the dinner itself | nothing; the collision is a coincidence. It is the clearest argument for #6's shift primitive | no |
| 28 | (write order) | 「a reschedule changes the meta first, then the dues」 — but 77 writes later the board is inconsistent for the whole pass, and the guard against abandoning it half-done is nothing but my own turn | one pass, meta first, `furrow lint` + a grep at the end | a furrow change: one write that moves the meta and every derived due together (again #6/#3) | no |

## Verdict

`could_act_confidently: false`

The arithmetic is unambiguous — one meta key, 95 dues all on clean D±N
offsets, +7d preserving every weekday — but the board cannot tell a due
derived from the event date from a date somebody else set (a venue's payment
deadline, a booked site-visit slot, a public holiday), and furrow has no
primitive that shifts a due relative to itself, so a one-week move is 77
hand-computed absolute writes with four judgment calls embedded in them and
no way to verify the result afterwards except `grep`.

- Hesitations: 28
- Rows where `furrow lint` actually reports it: 2 (#14, #15 — both
  `due-overdue`)

Most consequential:

1. **#6** — no shift-by-N primitive, so the whole reschedule is 77 hand-built
   absolute instants, each one a chance to fat-finger a date nothing checks.
2. **#2** — "every due is derived from the event date" is false on this board
   (venue deadlines, a booked appointment, a holiday), and nothing marks the
   exceptions, so the split is guesswork.
3. **#17** — the guest poll that the whole attendance chain rests on is `done`,
   names 11/21 in its title and its result, and must be neither edited nor
   retitled; the reschedule invalidates it and the board offers only "file a
   new task" as the repair.
