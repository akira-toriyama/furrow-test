# Drill run — reschedule (2026-09-25c)

Request handed to the session:

> The dinner moves one week later, from 2026-11-21 to 2026-11-28. Bring the
> whole board in line: every date, every task whose plan assumed the old
> date, and anything that no longer makes sense at the new one.

## 1. Measured on

| | |
|---|---|
| board commit | `6154cea` (matched the expected HEAD) |
| furrow version | `furrow dev` (built from furrow main at `eb85970`) |
| run date | 2026-09-25 (Fri), 17:43–17:56 JST |
| board zone | `Asia/Tokyo` (`[due].timezone`), layout repo-local, mode shared, schema v10/v10 writable |

The session is a Claude Code subagent on Opus, handed only this request, the
drill rules, the recording format, the repo's `README.md` and `CLAUDE.md`, and
the board through the `furrow` CLI, the files under `.furrow/`, and `notes/`.
No `docs/`, no `seed/`, no prior knowledge of this board. The operator had
already run `furrow sync`; this run never ran it, and wrote nothing but this
file.

One protocol slip to disclose: `mkdir -p docs/drills/runs && ls` printed three
sibling filenames while creating the output directory. No sibling log was
opened.

Board shape as read: 100 tasks, 95 of them dated, 5 boxes, 4 done, 1
in-progress, 4 waiting, 7 repeating series. `furrow lint` reports 4 errors, all
`due-overdue` (`t-4kg8d`, `t-f5pva`, `t-pq4pm`, `t-wbhsk`), and nothing else.

Every one of the 95 dues sits on a clean D-N grid against 2026-11-21 (D-75 …
D+365), which is what makes "+7 days" the whole arithmetic. 2026-11-28 is a
Saturday like 2026-11-21, so every weekday claim in a body (`D-1(金)`,
`週末(D-7 土)`, `毎週土曜`) survives unchanged.

**Frozen (8 dues that do NOT move):**

- 4 done tasks — `t-zapdx`, `t-v5kma`, `t-mxg58`, `t-8yac1` (a done task's due
  "stays as written").
- 3 `固定:` dues — `t-ynhnk` (申込 10/4 17:00, venue-set), `t-nxh9d` (入金
  10/12, venue-set), `t-jtq5t` (11/03, chosen because it is a public holiday).
- 1 lapsed repeat — `t-pq4pm` (an overdue repeating task's due is not pushed;
  only its series' `UNTIL` moves).

`t-9t7ab` carries a `固定:` line too, but it fixes a date *inside the body*
(A's 10/1 14:00 appointment); the task's own due (B's self-imposed 10/3) is
derived and moves.

**Moved:** 87 dues (81 plain + 6 repeating series re-anchored), 7 `UNTIL`s, 11
bodies, 3 checklist rows, 4 files under `notes/`, plus 2 new tasks and 2 dep
edges for the things that stopped making sense.

## 2. Plan

```sh
# ============================================================
# 0. Re-read before writing (the operator already synced)
# ============================================================
furrow sync && furrow brief
furrow epic show 会場 --json | jq -r .meta.event_date   # 2026-11-21
furrow ls -n 0 --json > /tmp/board-before.json          # the reschedule's starting read

# ============================================================
# 1. The meta first — the event date lives in ONE place
# ============================================================
furrow epic set 会場 --meta event_date=2026-11-28

# ============================================================
# 2. Derived dues, +7 days (81 writes; bare date = that whole day,
#    datetime = read in the board's Asia/Tokyo)
#    NOT here: t-zapdx t-v5kma t-mxg58 t-8yac1 (done, due frozen),
#              t-ynhnk t-nxh9d t-jtq5t (固定:), t-pq4pm (lapsed repeat).
# ============================================================
furrow set t-f5pva --due 2026-09-29T18:00
furrow set t-4kg8d --due 2026-10-01
furrow set t-wbhsk --due 2026-10-01
furrow set t-g5asy --due 2026-10-03
furrow set t-q5e6n --due 2026-10-04
furrow set t-x1fwz --due 2026-10-04
furrow set t-gf92s --due 2026-10-06
furrow set t-yejfr --due 2026-10-07
furrow set t-csnqw --due 2026-10-10
furrow set t-9t7ab --due 2026-10-10T18:00
furrow set t-ec04m --due 2026-10-17
furrow set t-xmcmx --due 2026-10-17
furrow set t-09yng --due 2026-10-21
furrow set t-0qyaa --due 2026-10-21
furrow set t-j4ykr --due 2026-10-23
furrow set t-tsms6 --due 2026-10-24
furrow set t-hr7sy --due 2026-10-27
furrow set t-3ghx1 --due 2026-10-29
furrow set t-vrj04 --due 2026-10-29
furrow set t-060wj --due 2026-10-31
furrow set t-az36w --due 2026-10-31
furrow set t-e34er --due 2026-10-31
furrow set t-s6kq4 --due 2026-11-03
furrow set t-gczt2 --due 2026-11-04
furrow set t-fbnw2 --due 2026-11-08
furrow set t-dyne3 --due 2026-11-12
furrow set t-v8w4w --due 2026-11-13
furrow set t-nz6ts --due 2026-11-14
furrow set t-a91yt --due 2026-11-14T18:00
furrow set t-ftt62 --due 2026-11-15
furrow set t-jvn40 --due 2026-11-15
furrow set t-e2grh --due 2026-11-16
furrow set t-q6ba3 --due 2026-11-16
furrow set t-0tqq4 --due 2026-11-18
furrow set t-sf3ad --due 2026-11-19
furrow set t-gfjgk --due 2026-11-20
furrow set t-g61ts --due 2026-11-21
furrow set t-j9rv9 --due 2026-11-21
furrow set t-3xbv0 --due 2026-11-21T12:00
furrow set t-ar35z --due 2026-11-21T21:00
furrow set t-z27fh --due 2026-11-22
furrow set t-ea11v --due 2026-11-22T21:00
furrow set t-2z01x --due 2026-11-23T21:00
furrow set t-1kcy5 --due 2026-11-25
furrow set t-7ds3p --due 2026-11-25
furrow set t-3yhzh --due 2026-11-26
furrow set t-r50pc --due 2026-11-26T21:00
furrow set t-zbgbr --due 2026-11-27T11:00
furrow set t-9hwy2 --due 2026-11-27T15:00
furrow set t-tz0ey --due 2026-11-27T18:00
furrow set t-d6xds --due 2026-11-27T21:00
furrow set t-06f99 --due 2026-11-27T22:00
furrow set t-j9wxw --due 2026-11-28T16:00
furrow set t-snf15 --due 2026-11-28T16:00
furrow set t-yedxj --due 2026-11-28T16:20
furrow set t-55eh7 --due 2026-11-28T16:30
furrow set t-8rbd6 --due 2026-11-28T16:40
furrow set t-5fw3k --due 2026-11-28T16:45
furrow set t-5fbnk --due 2026-11-28T16:50
furrow set t-8j45g --due 2026-11-28T17:30
furrow set t-sxmp1 --due 2026-11-28T18:45
furrow set t-ww1dq --due 2026-11-28T19:00
furrow set t-pf9z8 --due 2026-11-28T19:30
furrow set t-csn8h --due 2026-11-28T20:45
furrow set t-bav38 --due 2026-11-28T21:00
furrow set t-r7vqf --due 2026-11-28T21:30
furrow set t-2vdgv --due 2026-11-28T21:40
furrow set t-7jkyg --due 2026-11-28T21:45
furrow set t-5hp1m --due 2026-11-28T21:55
furrow set t-ekwmb --due 2026-11-28T22:00
furrow set t-d0w90 --due 2026-11-29
furrow set t-21dyp --due 2026-11-29T12:00
furrow set t-pcncg --due 2026-12-01T21:00
furrow set t-df150 --due 2026-12-02
furrow set t-wjj50 --due 2026-12-03
furrow set t-1nzwc --due 2026-12-05T20:00
furrow set t-8qx49 --due 2026-12-08
furrow set t-v7b2h --due 2026-12-10
furrow set t-5dr4h --due 2026-12-12
furrow set t-h2fxs --due 2026-12-12
furrow set t-ebx1j --due 2026-12-19

# ============================================================
# 3. Repeating series — --due alone never re-anchors, so due + rule
#    go in ONE write; UNTIL shifts +7 with the occurrence.
# ============================================================
furrow set t-pmnx3 --due 2026-10-24     --repeat 'FREQ=WEEKLY;UNTIL=20261128T235959Z;BYDAY=SA'
furrow set t-msexg --due 2026-11-07T18:00 --repeat 'FREQ=WEEKLY;UNTIL=20261121T235959Z;BYDAY=SA'
furrow set t-f429m --due 2026-11-14     --repeat 'FREQ=WEEKLY;UNTIL=20261127T235959Z;BYDAY=SA'
furrow set t-xsy5a --due 2026-12-06T20:00 --repeat 'FREQ=WEEKLY;UNTIL=20270103T235959Z'
furrow set t-1zkfj --due 2027-05-27     --repeat 'FREQ=MONTHLY;INTERVAL=6'
furrow set t-mdgcy --due 2027-11-28     --repeat 'FREQ=MONTHLY;INTERVAL=12'
# the lapsed occurrence keeps its due (9/20 20:00); only the series end moves.
# 10/18 = the Sunday after the new 回答期限 10/17.
furrow set t-pq4pm --repeat 'FREQ=WEEKLY;UNTIL=20261018T235959Z'

# ============================================================
# 4. Body repairs — derived dates spelled out in prose.
#    `edit --body` replaces the WHOLE file; each command below re-emits the
#    body verbatim with only the noted line changed. D-N text stays as is.
# ============================================================
# t-3xbv0  L3 次の一手: 11/14(土) までに電話 → 11/21(土) までに電話
furrow edit t-3xbv0 --body -
# t-9t7ab  L3 次の一手: B は…10/3 までに枠をもらう → 10/10 までに
#          (L4 固定: の A 10/1(木) 14:00 と L7 逃がし: の 10/1 は据え置き)
furrow edit t-9t7ab --body -
# t-a91yt  L4 前提: 受取は D-1（11/20 金）→ D-1（11/27 金）
furrow edit t-a91yt --body -
# t-f429m  L3 D-14(11/7 土) → D-14(11/14 土)
#          L4 UNTIL に D-1（11/20）→（11/27）／最後の回は D-7（11/14 土）→（11/21 土）
#          L5 1 回目の D-14(11/7 土) → D-14(11/14 土)
furrow edit t-f429m --body -
# t-gczt2  L4 前提: 生鮮は D-1（11/20）受け取り →（11/27）
furrow edit t-gczt2 --body -
# t-gf92s  L4 次の一手: 9/20 の週次督促 → 9/27 の週次督促／9/27 までに → 10/4 までに
#          L6 逃がし: 「9/27 までに返事が無ければ補欠へ」→「10/4 までに」
furrow edit t-gf92s --body -
# t-pmnx3  L3 次の一手: 10/17（土）から開始し → 10/24（土）から開始し
furrow edit t-pmnx3 --body -
# t-pq4pm  L5 逃がし: UNTIL(10/11 — 申告の回答期限 10/10 の次の日曜)
#             → UNTIL(10/18 — 申告の回答期限 10/17 の次の日曜)
#          (L3 次の一手の 9/20(日) 20:00 は失効した回の日付＝据え置き、L4 も無変更)
furrow edit t-pq4pm --body -
# t-wbhsk  L6 前提: 回答期限は D-42（10/10）→ D-42（10/17）
furrow edit t-wbhsk --body -
# t-xmcmx  L3 次の一手: 9/28 までに配布する → 10/5 までに配布する
#             回答期限は 10/10(D-42) → 10/17(D-42)
furrow edit t-xmcmx --body -
# t-xsy5a  L5 メモ: UNTIL=12/27 → UNTIL=1/3
furrow edit t-xsy5a --body -

# ============================================================
# 5. Checklist rows that spell a derived date
#    (t-f5pva item 0 is TICKED history — a new row instead of a reword)
# ============================================================
furrow check t-wbhsk 3 --reword "回答期限を10/17と明記する"
furrow check t-9t7ab 4 --reword "B の下見枠を 10/10 までにもらう"
furrow check t-f5pva --add "9/29 18:00 時点で未着なら電話する"

# ============================================================
# 6. Lines that stopped being true — retired with a note, the line stays
# ============================================================
furrow note t-f5pva '現状 の「due はその催促日」は失効。開催日 11/28 化で due を 9/29 18:00 に移した(9/22 18:00 の電話催促の記録自体は残す)。打ち切り時計「due を 2 日過ぎたら C を落とす」も 9/29 起点に戻り、9/24 に成立していた打ち切り条件は解消。C には新設の日程変更連絡で 11/28 の空きをあらためて問う。'
furrow note t-gf92s '待ち先 の NG 1 名は理由が「11/21 出張」で日付起因。11/28 では空く可能性があるため、補欠で埋める前に日程変更の再打診の回答を待つ。次の一手の督促日は 9/27 / 10/4 に移した。'
furrow note t-ar35z '前提 の「9/14 に口頭で打診済み」は 11/21 前提の打診。開催日が 11/28 に動いたので、会場確定後の再送で 11/28 を明記して取り直す。14:45 入り / 22:00 までの条件自体は変わらない。'
furrow note t-jtq5t '固定 の 11/03 は据え置き(祝日枠)。開催日が 11/28 に動いたので位置は D-18 → D-25 になり、依存する [[t-s6kq4]] の清書 due が同じ 11/03 23:59 に並んだ。固定 の「前倒しになるだけ」は余裕 7 日 → 0 日の意味になったので、清書を 11/03 より前に終える。'
furrow note t-ynhnk '固定 の 申込 10/4 17:00 は 11/21 の予約に対して会場が示した期限。11/28 への変更連絡で取り直すまで据え置く。その間は依存元 [[t-csnqw]] の due(10/10)より前に立つので due-inversion が出るが、これは取り直し待ちの状態であって日付の誤りではない。'
furrow note t-nxh9d '固定 の 入金期限 10/12 も [[t-ynhnk]] と同じく 11/21 の予約に対する提示。11/28 への変更連絡で取り直すまで据え置く。'
furrow note t-9t7ab '固定 の A の 10/1(木) 14:00 アポは据え置き。自分の締切である B の枠取りだけ 10/3 → 10/10 に移した。'
furrow note t-csnqw '採点の前提に「11/28 の空き」が加わった。A/B/C の空き回答は 11/21 に対するもので、日程変更連絡の回答が揃うまで 5 軸採点に入らない。'
furrow note e-1rxdr '開催日を 2026-11-21 → 2026-11-28 に変更(meta event_date が正本)。派生 due 87 件・repeat の UNTIL 7 件・本文 11 件・checklist 3 行・notes 4 ファイルを追随させた。据え置きは done 4 件(t-zapdx/t-v5kma/t-mxg58/t-8yac1)・固定 3 件(t-ynhnk/t-nxh9d/t-jtq5t)・失効した繰り返し 1 件(t-pq4pm)。'

# ============================================================
# 7. What no longer makes sense at 11/28 — two new tasks
#    (done bodies are history, so a stale 完了条件 gets a redo task, not a note)
# ============================================================
# N1: t-ynhnk / t-nxh9d の 固定 が指示する「会場に日程変更を伝えて期限を取り直す」
furrow add "候補 3 件に開催日変更(11/28)を伝えて空き・通し料金と申込/入金の期限を取り直す" \
  -e 会場 -s ready --due 2026-10-01 --value 5 --effort 2 \
  -l cand-a,cand-b,cand-c,venue-selection,external-wait --dep t-8yac1 \
  --body '目的: 11/21 で取った空き・料金・期限は 11/28 では無効。3 件に日程変更を伝え、同じ土俵で取り直す。
完了条件: A/B/C それぞれについて 11/28(土) 17:00-22:00 の空き・通し料金・申込期限・入金期限が書面で再取得され、比較表に日付つきで反映されている。
次の一手: [[t-8yac1]] のテンプレを 11/28 で書き直し、notes/ の問い合わせテンプレに新しい日付節を足してから 3 宛先へ送る。
前提: 申込 10/4 17:00 / 入金 10/12([[t-ynhnk]] [[t-nxh9d]] の 固定)は取り直すまで据え置き。取り直しが 10/4 を過ぎると本予約が一度流れる。
前提: due 2026-10-01 は「[[t-v5kma]] の D-N 再導出」則が過去日(9/21)を出すため、代わりに 固定 期限 10/4 17:00 の手前に置いた。' \
  --check "A に 11/28 の空きと通し料金を再照会する" \
  --check "B に 11/28 の空きと通し料金を再照会する" \
  --check "C に 11/28 の空きと通し料金を再照会する" \
  --check "申込期限と入金期限を 3 件分あらためて書面でもらう" \
  --check "比較表の基本情報に 11/28 時点の状態行を足す"

# N2: t-v5kma(done) の 完了条件「11/21 の可否が記録されている」が失効したので redo
furrow add "開催日 11/28 への変更をゲスト 12 名に伝えて一次可否を取り直す" \
  -e 会場 -s ready --due 2026-10-01 --value 5 --effort 2 \
  -l guest-comms,guests --dep t-v5kma \
  --body '目的: 11/28(土) 17:00-21:00 でゲスト 12 名の可否を取り直し、会場に伝える人数レンジを引き直す。
完了条件: 打診した 12 名全員について 11/28 の OK / NG / 未返信 のいずれかが出欠表に記録されている。
次の一手: LINE グループで日程変更を告知し、[[t-v5kma]] で NG だった 1 名(理由は 11/21 の出張)には個別に空き直しを確認する。
前提: [[t-v5kma]] の「日付は固定条件として動かさない前提で打診した」は失効。done の本文は履歴として触らず、この task が置き換える。
前提: 11/21 で OK だった 9 名も 11/28 では未確定として数え直す。確定は [[t-gf92s]] が閉じる。
前提: due 2026-10-01 は「置き換える task の D-N 再導出」則が過去日(9/17)を出すため、代わりに [[t-gf92s]] の新しい due(10/6)の手前に置いた。' \
  --check "LINE グループに 11/28 への変更を告知する" \
  --check "11/21 に NG だった 1 名に 11/28 の可否を個別に確認する" \
  --check "12 名分の可否を出欠表に記録し直す"

# 新 id を <N1> / <N2> として、決定と人数確定に噛ませる
furrow dep t-csnqw <N1>
furrow dep t-gf92s <N2>

# ============================================================
# 8. notes/ — hand-kept, committed by me (furrow sync publishes only .furrow/)
# ============================================================
# notes/venue-compare.md
#   L4  「最終更新: 2026-09-24」→「最終更新: 2026-09-25」
#   L16 F 行の 状態「当日予約済みで候補外」の直後に日付行を足す:
#       「- 2026-09-25: 開催日 11/21 → 11/28。F の「当日予約済み」は日付起因の
#         落選なので再確認対象だが、15 名着席不可(12 席)でノックアウト②を満たさ
#         ないため候補外のまま。」
#   L37 C 列の待ち行に「11/28 への変更連絡を送り直したため、返信期限は新しい
#       連絡の側で数える」を追記
#   L56-58 入館可能時刻の表の直下に「2026-09-25: 11/28 で取り直し中」の日付行
#   L67-69 キャンセル表の直下に同じ日付行(無料期限は利用日起点なので 11/28 で再計算)
# notes/venue-inquiry-template.md
#   L3  状態行に「2026-09-25 に 11/28 への変更を再送(下の新しい節)」を追記
#   L10-12 送信記録の 追跡 セルを「11/28 で再照会中」に更新(送信日 2026-09-14 はそのまま)
#   L14 以降の「## 本文」は送った文面なので書き換えず、その下に新しい節を足す:
#       「## 本文（2026-09-25 再送・日程変更）」+ 件名 2026-11-28(土) 17:00-22:00 の版
# notes/site-visit-checklist.md
#   L8  表ヘッダ「B（枠待ち・10/3 期限）」→「B（枠待ち・10/10 期限）」
#       (A の「10/1 木 14:00 アポ済み」は 固定 なので据え置き)
#   L26 「B の枠が 10/3 までに出なければ」→「10/10 までに」
# notes/dietary-form.md
#   L5  「回答期限: 2026-10-10（開催日の D-42）」→「2026-10-17（開催日の D-42）」
#       ※ 正本は t-wbhsk 側。上の check --reword / edit --body を先に済ませてから写す
git add notes/ && git commit -m ':memo:(notes)= follow the 11/28 reschedule'

# ============================================================
# 9. Verify and publish
# ============================================================
furrow lint                 # 期待: due-overdue は t-pq4pm(失効した回)のみ赤で残る
                            #       t-ynhnk / t-nxh9d に due-inversion(warn)が出る
furrow ls -n 0 --json | jq -r '.[] | select(.due) | [.id,.due] | @tsv'   # before と突き合わせ
furrow sync
```

## 3. Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow ls -n 0 --json` | CLAUDE.md says a reschedule starts here but not what the read covers — done? icebox? drafts? | that it spans every lane; ran `ls --help` to confirm | prose: "a reschedule starts from `furrow ls -n 0 --json` (every lane, done and icebox included)" | no |
| 2 | `cat .furrow/bodies/*.md` | `ls --json`'s `body` is a PATH, not text, and no command prints bodies in bulk (`show` is one id at a time) — but every derived date lives in prose | read the 100 files directly off disk | furrow change: a `--body` on `ls --json`, so one read carries the prose a reschedule has to grep | no |
| 3 | `ls .furrow/bodies` | 105 body files against 100 tasks — orphans, or something else? | ran `comm` against the id list; the 5 extras are the epic bodies | prose: "epic bodies share `bodies/`" (the `edit --help` text says it, CLAUDE.md does not) | no |
| 4 | `grep -rn '固定:'` | CLAUDE.md warns 固定 is also a verb and only the line prefix is the marker — 15 bodies contain the word, 4 carry the marker | grepped both forms and read all 15 | furrow change: an immovable flag on the due itself instead of a prose marker a grep has to disambiguate | no |
| 5 | `furrow set t-9t7ab --due` | `t-9t7ab` has a `固定:` line, so is its due frozen? The line fixes A's 10/1 appointment and says B's 10/3 "は自分の締切なので動く" | the marker fixes the dates it names, not the task's due; the due moves | prose: "a `固定:` line freezes the dates it names; the task's own due is frozen only if the line says so" | no |
| 6 | `furrow set t-v5kma --due` | "Every `due` … is derived from it" (reschedule) vs "a done task's title, due and 結果 stay as written" (done task) — 4 done tasks sit in the date band | done wins: the 4 done dues stay | prose: the reschedule rule should name done tasks as the second exception beside `固定:` | no |
| 7 | `furrow set t-pq4pm` | the lapsed repeat's due is frozen and "a reschedule moves only its series' UNTIL" — but its 次の一手 names 9/20, and 次の一手 is a derived section | left the due and the 次の一手 line; moved only `UNTIL` and the 逃がし line that quotes it | prose: "on a lapsed repeat the 次の一手 naming that occurrence is a log, not a derived date" | no |
| 8 | `furrow set t-pmnx3 --due … --repeat …` | how a series moves: does `--due` re-anchor it? | ran `set --help`: `--due` alone never re-anchors; due + rule must go in ONE write | prose in CLAUDE.md's reschedule paragraph (the `--help` has it; the board's rulebook does not) | no |
| 9 | same | the stored `UNTIL`s are `Z` instants while the board zone is JST (`UNTIL=20261121T235959Z` is really 11/22 08:59 JST) — rewrite in local, or shift the Z? | shifted the Z instant by 7 days, spelling unchanged | furrow change: render/accept `UNTIL` in the board's `[due].timezone` so a series end reads like every other date on the board | no |
| 10 | `furrow set` ×87 | no relative or bulk due shift exists — `--due +1d` is measured from *now*, and multi-id `set` applies the SAME edit — so the reschedule is 87 hand-typed absolute dates | typed all 87 from a computed table | furrow change: `furrow set --shift +7d -q …`, or a reschedule verb that reads the box's `event_date` and moves every derived due | no |
| 11 | `furrow epic set 会場 --meta …` | CLAUDE.md gives the READ (`epic show 会場 --json \| jq .meta.event_date`) but never the write | ran `epic set --help`; `--meta key=value` | prose: give the write next to the read | no |
| 12 | `furrow ls -n 0 --json` (analysis) | before trusting "+7 everywhere" I wanted proof every due is actually derived | computed the D-N offset of all 95 dues against 2026-11-21 — all on a clean grid | nothing; this was verification | no |
| 13 | `furrow set t-f5pva --due 2026-09-29T18:00` | is a `waiting` chase date derived from the event date at all? Its 現状 says "due はその催促日" — a call already made on 9/22 | yes, derived (it sits exactly on D-60); the 現状 sentence gets retired by note | prose: "a waiting task's chase date is derived; the 現状 line that logged the last chase is not" | no |
| 14 | same | moving it REVIVES candidate C: the 打ち切り condition (due + 2 days, 2 candidates left) was already met on 9/24, and the shift restarts that clock | let it revive — 11/28 availability is re-asked of C anyway — and said so in the note | prose: "a reschedule restarts a 打ち切り clock measured from a due" | no |
| 15 | `furrow set t-csnqw --due 2026-10-10` | this pushes the decision past `t-ynhnk`'s 固定 申込期限 10/4 17:00 — the booking task would be due before the dependency that feeds it | left the inversion standing; the new re-confirm task re-takes the deadline, which is what the 固定 line prescribes | prose: "when a reschedule pushes a dependency past a 固定 due, the inversion stands until the other side answers" | no (`due-inversion` exists but reports nothing on the current board; it would fire only after the write) |
| 16 | `furrow set t-s6kq4 --due 2026-11-03` | `t-jtq5t`'s 固定 due is the SAME instant (11/03 23:59) — 7 days of slack become zero, and its 固定 line claims the move only makes it 前倒し | left both dues, noted the squeeze on `t-jtq5t` | furrow change: `due-inversion` should fire on an equal instant, not only a later one | no |
| 17 | `furrow add` (venue re-confirm) | the 固定 lines say "会場に日程変更を伝えて期限を取り直す" and CLAUDE.md says "a task to confirm it with the other side … is what moves it" — but nothing says the reschedule FILES that task, nor its box, labels or lane | filed it: venue box, `ready`, `cand-a/b/c`, dep on `t-8yac1` | prose: "the reschedule files the confirm-with-the-other-side task for every 固定 date it left in place" | no |
| 18 | `furrow note t-v5kma` | `t-v5kma`'s 前提「日付は固定条件として動かさない前提で打診した」 went stale, and stale lines are retired with `furrow note` — but it is done, and a done body may never be appended to | no note; the redo task carries the retirement (its 完了条件 went stale too) | prose: "a done task's stale line is retired by the redo task that replaces it, never by a note" — the two rules currently point opposite ways | no |
| 19 | `furrow add --due` (both redos) | "its due is the replaced task's D-N re-derived" lands 2026-09-17 (guests) and 2026-09-21 (venues) — both already in the PAST | used 2026-10-01 for both: before `t-ynhnk`'s 固定 10/4 17:00 and before `t-gf92s`'s new 10/6 | prose: "a redo whose re-derived due is already past takes the latest date that still precedes its dependents" | no (`due-overdue` would fire, but only after the write) |
| 20 | `furrow add` (cardinality) | "one task per counterparty, not one per candidate" — A/B/C are three candidates AND three counterparties, so the rule separates nothing here | one task for the three, mirroring `t-8yac1`'s own shape (the redo "inherits that task's … body template") | prose: say which side wins when a candidate IS the counterparty | no |
| 21 | `furrow note t-ar35z` | the helpers were asked on 9/14 for 11/21 — a redo like the guests, or a note? | a note: the task is still open, so the stale-前提 rule applies and the done-task redo rule does not | prose: "a redo replaces a DONE task; an open one takes the note" | no |
| 22 | `furrow check t-wbhsk 3 --reword` | indexes are zero-based positions in the CURRENT list; had to re-list both tasks' rows to find 3 and 4 | read `check --help`, then re-listed the checklists from `ls --json` | furrow change: `check --reword` addressable by matching text, not only by index | no |
| 23 | `furrow check t-f5pva 0 --reword` | the row "9/22 18:00 時点で未着なら電話する" is TICKED and spells a date that moved | left it; added a new row for the new chase date, per "add a row for the next occurrence instead of rewording a ticked one" | prose: put "a ticked row is history" and "a reschedule reworks the rows that spell a derived date" in one place — they are two sections apart | no |
| 24 | `furrow set t-q5e6n --due 2026-10-04` | `t-q5e6n` is in-progress — does a board-wide reschedule bump the one-task-in-flight rule? | no: "retiring a 前提, rewording a row start nothing", and a reschedule starts nothing | prose: name a reschedule in that list explicitly | no |
| 25 | `furrow set t-mdgcy --due` / `t-1zkfj --due` | `t-mdgcy`'s メモ anchors it to event_date + 1 year, but `t-1zkfj` (D+180) carries no anchor and calls the interval 仮置き — is a far-future icebox due derived at all? | both derived; +7 like everything else | prose: "a due on the D-N grid is derived however far out it sits" | no |
| 26 | `notes/venue-compare.md` | candidate F was dropped as 当日予約済み — a date-specific reason, so the reschedule re-checks it | checked: F is 不可(12 席) and 15 名着席可 is a knockout, so it stays out; recorded the re-check as a dated line under the 基本情報 table | nothing — "(one that also fails a knockout stays out)" covered it, but only after I went and verified the knockout list in `notes/` | no |
| 27 | `notes/venue-inquiry-template.md` | its 本文 spells 2026-11-21(土); "a note that copies a body's text follows the body" says rewrite, "a sent text … is appended to, never rewritten" says don't | a new dated 本文 section for the 11/28 re-issue; the 送信記録 status cells updated in place; the 2026-09-14 section untouched | prose: say which of the two rules wins for a sent text that is also a copy | no |
| 28 | `notes/dietary-form.md` | its 回答期限 is a copy of `t-wbhsk`'s — ordering question: file or task first? | the body and its checklist first, then the copy ("what the copy wants and the body lacks goes into the body first") | nothing; the rule resolved it after a re-read | no |
| 29 | `furrow ls -n 0 --json` (undated rows) | 5 icebox tasks carry no due — does the reschedule touch them? | no: `t-2yyk8`'s only date is a relative D-1, and every 復活条件 is capability-based, not calendar-based | prose: "an undated task has nothing to reschedule" | no |
| 30 | `furrow lint` (filling this column) | to answer "lint catches it?" honestly I had to know the full code vocabulary, not just today's 4 findings | ran `lint --help` and `furrow vocab lint-codes`: 53 codes, `due-inversion` among them, none relating a box's `event_date` meta to the dues derived from it | furrow change: a lint code that flags dues off the grid of their box's `event_date` — the one check that would have made this whole drill mechanical | no |

## 4. Verdict

`could_act_confidently: true`

Every stop resolved into a defensible action out of the board's own prose, and
nothing needed was missing — but three of the thirty were coin-flips between
two rules that contradict each other, and one (the redo dues) required
knowingly departing from a written rule because it produces a date in the past.

- hesitations: **30**
- rows where `furrow lint` actually catches it: **0**

Most consequential:

1. **#19** — the one rule that sizes new work ("its due is the replaced task's
   D-N re-derived") outputs 2026-09-17 and 2026-09-21, both already past, so
   the redo dues are mine and not the board's.
2. **#15** — the reschedule itself creates the inversion (`t-csnqw` 10/10 now
   follows `t-ynhnk`'s frozen 10/4), and nothing on the board says whether to
   leave it standing or pull the decision back.
3. **#10** — with no relative or bulk due shift, bringing the board in line is
   87 hand-typed absolute dates on a shared board, every one a chance to
   transcribe wrong.
