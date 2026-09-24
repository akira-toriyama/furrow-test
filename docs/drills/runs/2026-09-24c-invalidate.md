# Drill run — invalidate (2026-09-24c)

## Measured on

- board commit: `f497db3`
- furrow version: `furrow dev` (main at ac777e8)
- run date / local time: 2026-09-24, 21:10–21:30 JST (Asia/Tokyo)
- request: "Venue candidate B has withdrawn (double-booked). Dispose of
  everything on the board that assumed B: tasks that only made sense for B,
  comparisons that included B, and dependencies that ran through it."

## Plan

Never executed. The reads before the first mutation are the ones I actually
ran; everything from `furrow note e-0w7hf` down is the plan.

```sh
# --- reads (run) -------------------------------------------------------
furrow brief
furrow ls -l cand-b                       # 7 tasks
furrow ls -l cand-a; furrow ls -l cand-c  # is any of the 7 B-only? (no)
furrow ls -n 200                          # whole board, looking for unlabelled B
furrow epic show e-0w7hf
furrow show t-3e3px t-g61ny t-rdw97 t-1j38n
furrow show t-52bk3 t-19nfz t-cfqge
furrow show t-z1fry t-jayrp t-qfnd4 t-70evb   # the cand-a-only tasks
furrow dep --list t-3e3px ... t-52bk3     # 7 dep neighbourhoods
furrow lint
cat notes/venue-compare.md; grep -rn 'B' notes/

# --- 1. record the fact where the box can see it ------------------------
furrow note e-0w7hf "2026-09-24 候補 B（世田谷・三軒茶屋）がダブルブッキングで辞退。\
以降の候補は A と C の 2 件。B 列・B 行・B 由来の前提はこの日付で無効。"

# --- 2. t-3e3px: A/B 2 会場 → A のみ。A は 9 項目完了なのでそのまま閉じる ----
furrow check t-3e3px 4 --reword "冷蔵庫/冷凍庫の容量を A 分記入"
furrow check t-3e3px 3 --rm               # 「B の食器・カトラリー数を記入」
furrow check t-3e3px 2 --rm               # 「B のオーブン庫内サイズを電話で聞く」
furrow retitle t-3e3px 返信済み A 会場の設備インベントリ 9 項目を埋める
furrow check t-3e3px 0; furrow check t-3e3px 1; furrow check t-3e3px 2
furrow note t-3e3px "前提の retire: 対象は A/B の 2 会場だったが、B が 9/24 に辞退。\
残る対象は A のみ。C は [[t-qw8jc]] のまま。"
furrow done t-3e3px --note "結果: A の 9 項目は比較表（notes/venue-compare.md）で\
全て記入済み。B 分は辞退により不要になったため、完了条件は A のみで充足。"

# --- 3. t-g61ny: 下見対象 2 件 → A のみ ---------------------------------
furrow check t-g61ny 4 --rm               # 「B の下見枠を 10/3 までにもらう」
furrow retitle t-g61ny 候補 A 会場を現地下見して搬入経路・エレベーター・台車可否を実測する
furrow note t-g61ny "前提の retire: B が 9/24 に辞退したため下見対象は A のみ。\
10/1(木) 14:00 のアポで完結する。B の枠待ちは消滅。"

# --- 4. t-rdw97: 候補 3 件 → 2 件（A/C） --------------------------------
furrow check t-rdw97 1 --reword "何日前に何 % かを 2 件分（A/C）記入する"
furrow retitle t-rdw97 候補 2 件のキャンセル料段階と延長不可条件を条文で確認して比較表に書く
furrow note t-rdw97 "前提の retire: B が 9/24 に辞退。完了条件の対象は A/C の 2 件。\
B のキャンセル条項（21 日前無料・延長 30 分 5,000 円・グリストラップ清掃）は\
比較表に履歴として残すが採点には載せない。"

# --- 5. t-1j38n: 候補 3 件 → 2 件（A/C）--------------------------------
furrow check t-1j38n 4 --reword "入館可能時刻と事前入館料（15:00 入館の可否）を 2 件分、比較表の「入館可能時刻と事前入館料」節に記入する"
furrow check t-1j38n 3 --reword "ゴミの持ち帰り/引き取りを 2 件分記入する"
furrow check t-1j38n 1 --rm               # 「B の回答(持込料 1,000 円/本)を比較表に転記する」
furrow retitle t-1j38n 候補 2 件の持ち込み酒可否とゴミ持ち帰り規定を書面で取り付ける
furrow note t-1j38n "前提の retire: B が 9/24 に辞退。B は書面回答済みだったが対象外。\
残るのは A の書面化依頼と C の未返信。lane は waiting のまま。"

# --- 6. t-19nfz: B 由来の dep を切る ------------------------------------
furrow dep t-19nfz t-a014x --rm
furrow note t-19nfz "前提の retire（B 辞退 9/24）: ①「C が 9/24 までに返信しなければ\
A/B の 2 択」→ A/C の 2 択、C 未返信なら A 一択。②「出席が 13 名以上なら定員の狭い B を\
落とす」→ B が消えたので出席数は採点に効かない。この条項が唯一の根拠だった\
[[t-a014x]] への dep を外した（A 18 席 / C 20 席はいずれも 15 名着席可）。\
5 軸採点は A/C の 2 列で行う。"

# --- 7. t-cfqge: 落選 2 件 → 1 件 ---------------------------------------
furrow check t-cfqge 3 --reword "落選 1 件（A/C のうち選ばれなかった 1 件）に断りの一報を送る"
furrow note t-cfqge "前提の retire: 候補が A/C の 2 件になったため、断りの一報は 1 件。\
B へは辞退の連絡を受けた側なので不要。"

# --- 8. t-52bk3: 暫定最小構成の根拠（B の下限）が消えた ------------------
furrow note t-52bk3 "前提の retire: 「候補 2 会場（A/B）の共通最小構成（コンロ 2 口・\
オーブン 1 段）」は B の下限から引いた数値で、B の 9/24 辞退により根拠が消滅。\
暫定設計をするなら A の実測値（コンロ 4 口・天板 40×33cm 2 段・冷蔵 400L）を使い、\
C が返信したら下限を引き直す。[[t-3e3px]] の B 回答待ちも消滅。"

# --- 9. ラベルを畳む（rewrite 済みの印） --------------------------------
furrow label t-3e3px --rm cand-b
furrow label t-g61ny --rm cand-b
furrow label t-rdw97 --rm cand-b
furrow label t-1j38n --rm cand-b
furrow label t-19nfz --rm cand-b
furrow label t-cfqge --rm cand-b
furrow label t-52bk3 --rm cand-b

# --- 10. 比較表と下見表（furrow の外） ----------------------------------
# notes/venue-compare.md:
#   - 基本情報の B 行の「状態」を「辞退（ダブルブッキング）2026-09-24」に
#   - l.3 / l.18 の「A/B/C の 3 件」を「A/C の 2 件」に
#   - 設備 9 項目・持ち込み酒/ゴミ・入館・キャンセル・5 軸の各表の B 列に
#     「辞退」と入れる（行は履歴として残す）
# notes/site-visit-checklist.md:
#   - l.3 の「対象は候補 2 件（A/B）」→「対象は A のみ」
#   - l.8 の B 列と l.26 の「B の枠が出なければ」行を辞退注記に置換
# notes/venue-inquiry-template.md は送信ログ（done の [[t-3nc93]] の記録）なので触らない
furrow ref t-1j38n --rm file:notes/venue-compare.md:40 --add file:notes/venue-compare.md:41

# --- 11. 反映確認 -------------------------------------------------------
furrow ls -l cand-b        # 期待: 0 件
furrow dep --list t-19nfz  # 期待: depends on 5（t-a014x が消えている）
furrow lint                # 期待: due-overdue 2 のまま（B とは無関係）
furrow sync
```

Not planned, on purpose: no lane moves (`t-1j38n` / `t-qw8jc` stay `waiting`),
no due changes (every `due` is derived from `event_date`, which B's withdrawal
does not move), no new task, and no rewrite of the four done tasks' bodies.

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow ls -l cand-b` | The 7 rows do not say which of them is B-only; their titles count populations that disagree with each other (`候補 3 件` / `候補 2 件` / `A/B 2 会場`) on the same label set. | That the title's count, not the label set, is the population; `cand-b` alone never means B-only here. | A lint code that flags a title counting N candidates while the task carries M candidate labels (`title-scope-marker` is in `furrow vocab lint-codes` but does not fire on these titles). | no |
| 2 | `furrow ls -l cand-a` / `-l cand-c` | To answer "tasks that only made sense for B" I had to prove a negative, and I do not know the `-q` grammar for label negation, so I hand-diffed three `ls` outputs. | That `cand-b MINUS (cand-a ∪ cand-c)` is empty — no B-only task exists. | A `-q` qualifier for label negation documented in `ls --help`'s query grammar (e.g. `-q '!label:cand-a'`). | no |
| 3 | `furrow ls -n 200` | `furrow brief` prints `next (3/4 — 1 hidden by -n)`; for a board-wide sweep I could not trust any capped read, so I re-read all 100 tasks. | That nothing outside the 7 labelled tasks names B in a way that matters (confirmed by reading bodies later). | A `[next].limit` bump in `config.toml`, or an `ls --all` that states it is uncapped. | no |
| 4 | `furrow search B` | A one-letter search matched ~40 bodies on substring; there is no word-boundary, case, or field restriction, so the search cannot find "tasks that mention B without the label" — which is exactly the CLAUDE.md case ("a task that merely names a candidate carries no label"). | That `grep -rn` over `notes/` plus reading the venue-box bodies covers it. | A furrow change: `search --field title\|body` plus a whole-word/regex mode, so a one-token identifier is searchable. | no |
| 5 | `furrow show t-z1fry t-jayrp t-qfnd4 t-70evb` | `cand-a` sits on four teardown/day-of tasks that have no `cand-b` twin; the label there means "this plan assumes A's facts" (食洗機あり・ゴミ全量持ち帰り), not CLAUDE.md's "rewritten if the candidate drops out". Two meanings of one label. | That B's withdrawal does not touch them (they were already written for A), so they stay untouched. | A line in CLAUDE.md: 「cand-X は『X が落ちたら書き直す task』にだけ付ける。X の設備を前提にした当日 task には付けない」. | no |
| 6 | `furrow show t-3e3px` | `checklist: 0/5` contradicts the body's 現状 line ("A は 9 項目完了") and the compare table, which shows A's 9 rows filled. Nothing on the board records the A work as done. | That the body and the compare table are right and the checklist is stale, so the task is closable once B's rows go. | A line in CLAUDE.md: 「現状 行を書いたら同じ内容を check に反映する」, or a lint code pairing an unticked checklist with a 現状 claim. | no |
| 7 | `furrow retitle t-3e3px` | The title counts `A/B 2 会場`; with B gone the population is 1, and CLAUDE.md's retitle rule gives an example for `3 件 → 2 件` only, not for a count that collapses to one member. | 「返信済み A 会場の設備インベントリ 9 項目を埋める」 — drop the count, name the member. | A line in CLAUDE.md: 「数が 1 に落ちたら件数表記をやめて候補名を書く」. | no |
| 8 | `furrow check t-3e3px … --rm` | Whether a checklist row can be edited rather than deleted, and what happens to the indexes of the rows below a `--rm`. Unplanned `furrow check --help`. | `--reword` first (at the original index), then `--rm` from the highest index down, as the help says. | Nothing — `check --help` answers both; the stop is the cost of not knowing the flag exists. | no |
| 9 | `furrow check t-3e3px 4 --reword` | Row 4 reads 「冷蔵庫/冷凍庫の容量を両会場分記入」: 「両会場」 is a B-derived phrase inside a row that is not B-only, so neither `--rm` nor "leave it" is right. | Reword to 「A 分記入」. | A line in CLAUDE.md telling how checklist rows that quantify over candidates are written (name the members, never 「両」/「全」). | no |
| 10 | `furrow done t-3e3px` | Closing the board's ONLY `in-progress` task leaves the session with nothing in flight, and CLAUDE.md's "one task in flight" rule does not say whether an invalidation sweep may close it. | Close it: with B gone its completion condition is met, and leaving it open would be a task whose remaining work is B's. | A line in CLAUDE.md: 「仕分けで完了条件が充足したら閉じてよい。着手枠とは別」. | no |
| 11 | `furrow retitle t-rdw97` / `t-1j38n` | The titles say `候補 3 件`; the remaining two are A and C, but the title format does not say which two, and the next reader will not know whether 2 means A/B or A/C. | Keep 「候補 2 件」 and name A/C in the note and in 完了条件 via the checklist rewords. | A line in CLAUDE.md: 「件数表記の task は body の 完了条件 に必ず候補名を列挙する」. | no |
| 12 | `furrow dep t-19nfz t-a014x --rm` | The `t-a014x → t-19nfz` edge has no recorded reason; the only justification anywhere is the B clause 「出席が 13 名以上に増えた場合は定員の狭い B を落とす」. Cutting an edge on a body sentence is exactly what CLAUDE.md says NOT to do ("deps are the truth; bodies describe"), but here the body is the only evidence the edge ever had. | Cut it: A (18 席) and C (20 席) both clear 15 名, so headcount no longer gates the decision. | A furrow change: a per-edge reason (`furrow dep <id> <dep> --why "<text>"`) surfaced by `dep --list`, so a withdrawal can be traced through the graph instead of through prose. | no |
| 13 | `furrow note t-19nfz` | The body's 前提 「C が 9/24 までに返信しなければ A/B の 2 択で決める」 fires TODAY (C is overdue since 9/22), and with B gone the decision degenerates to "A alone" — i.e. the task's 5-axis scoring may be moot rather than merely narrowed. | Keep the scope (CLAUDE.md: the task keeps its scope), note the degeneration, do not re-plan the decision. | A line in CLAUDE.md: 「候補が 1 件に落ちた決定 task は採点をやめて決定だけ書く」, or a `due`-driven conditional the model could carry. | no |
| 14 | `furrow note t-52bk3` | Its 前提 pins a provisional floor to B's numbers (コンロ 2 口 = B's) and is the input to seven downstream menu tasks; retiring it removes the floor and nothing replaces it (C is unanswered). | Retire the 前提 with a note and name A's measured numbers as the interim floor, without touching the seven downstream tasks. | A line in CLAUDE.md on what to do when a retired 前提 leaves a downstream chain with no premise (re-derive here vs. block downstream). | no |
| 15 | `furrow check t-cfqge 3 --reword` | The row says 「落選 2 件(A/B/C のうち選ばれなかった 2 件)に断りの一報を送る」; B withdrew, so is B a 落選 owed a 断り, or out of the count? | Out of the count: reword to 落選 1 件, no 断り to B. | A line in CLAUDE.md: 「辞退した候補は落選数に数えない」. | no |
| 16 | `furrow label … --rm cand-b` | Nothing says whether the label is retired after the rewrite. Keeping it leaves `ls -l cand-b` returning 7 tasks for a dead candidate; removing it destroys the record of which tasks the withdrawal touched. | Remove it on all 7, with the per-task notes as the record. | A line in CLAUDE.md: 「候補が落ちたら書き直し完了後に cand-X を外す。履歴は note に残す」. | no |
| 17 | editing `notes/venue-compare.md` | How to dispose of B in the table: delete the column, strike the row, or mark it. The 状態 column reads like a closed vocabulary (`一次返信あり` / `上限超過で候補外` / `条件不適で候補外` / `当日予約済みで候補外`) with no member for "withdrew". | Keep every B row, set 状態 to 「辞退（ダブルブッキング）2026-09-24」, write 辞退 into the B cells of the five downstream tables. | A line in CLAUDE.md or in the table's own header: 「候補の状態は 一次返信あり/未返信/辞退/候補外 のいずれか」. | no |
| 18 | editing `notes/venue-compare.md` | Every edit above line 40 shifts `t-1j38n`'s ref `file:notes/venue-compare.md:40`, and `lint --help` says refs are "NEVER checked for existence" — the rot is silent and lands on a future reader. | Re-point the ref by hand in the same change (`furrow ref --rm … --add …`), guessing +1 line. | A furrow change: refs that anchor to a heading (`file:notes/venue-compare.md#持ち込み酒とゴミ規定`) instead of a line number. | no |
| 19 | reading `notes/venue-compare.md` | The file addresses tasks by a private key namespace furrow cannot resolve — `venue-decision`, `venue-byo-waste-rules`, `venue-quote-c`, `venue-key-handover`, `venue-final-confirm`, `venue-budget-cap` — so I mapped each to an id by title guessing before I could tell which task owns which B cell. | `venue-decision`=t-19nfz, `venue-byo-waste-rules`=t-1j38n, `venue-quote-c`=t-qw8jc, `venue-key-handover`=t-xc1h1, `venue-final-confirm`=t-rzk8j, `venue-budget-cap`=t-k3rt9. | A furrow change: resolvable human keys (an `alias`/`key` field on a task that `show`/`search` accept), or prose forbidding non-id references in `notes/`. | no |
| 20 | editing `notes/venue-inquiry-template.md` | It carries a B row and is the ref of the DONE task `t-3nc93`. CLAUDE.md freezes a done task's body but says nothing about the notes file a done task points at. | Leave it: it is a send log, i.e. history. | A line in CLAUDE.md: 「done task が参照する notes は履歴。書き換えない」. | no |
| 21 | editing `notes/site-visit-checklist.md` | It is not written by furrow and no rule covers it, yet it holds a B column and a decision rule (「B の枠が 10/3 までに出なければ…」) that the withdrawal kills. Nothing tells a session that editing `notes/` is part of "disposing on the board". | Edit it in the same change as the compare table. | A line in CLAUDE.md: 「notes/*.md は board の一部。task を書き換えたら同じ変更で notes も直す」. | no |
| 22 | `furrow note e-0w7hf` | "B withdrew" is a board-level fact with no home: `event_date` lives in the box's `meta`, but candidate state does not, so the fact can only be scattered across seven task notes. | Write it once on the box body with `furrow note e-0w7hf`, then repeat the relevant half per task. | A furrow change: arbitrary `meta` keys settable on an epic (`furrow epic set e-0w7hf --meta cand_b=withdrawn:2026-09-24`) so candidate state has one place, like `event_date`. | no |
| 23 | `furrow lint` | Lint exits 2 with two `due-overdue` errors unrelated to B (`t-16hvj`, `t-qw8jc`), so a green lint cannot be my done-check for this sweep, and I had to decide whether chasing overdue C is part of "dispose of B" (B's withdrawal does make C decisive). | Out of scope: leave both, mention C's weight in the `t-19nfz` note. | A `[lint.severity]` entry (`due-overdue = "warn"`) so the board's steady state is exit 0 and a real error stands out. | yes: due-overdue |
| 24 | `furrow vocab lint-codes` | `title-scope-marker` is in the code vocabulary but appears in no `--help` text, and it is the one code that might have caught the stale `候補 3 件` titles. I could not tell what it checks without leaving the board. | That it does not cover this (it reports nothing on the current board, whose titles already miscount: `t-g61ny` says `候補 2 件` while carrying `cand-a`+`cand-b` only). | A furrow change: `furrow vocab lint-codes --describe`, one line per code. | no |

## Verdict

- `could_act_confidently: false`
- Why: the board can tell me which tasks carry `cand-b` but not which of them
  B alone justified — the one dependency that truly ran through B
  (`t-a014x → t-19nfz`) is discoverable only from a sentence inside a body,
  and the comparison the request names lives in `notes/*.md`, outside
  furrow, addressed by a private key namespace and by line-numbered refs
  that my own edits would rot.
- hesitations: 24
- rows with `yes` in the last column: 1
