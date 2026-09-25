# Drill run — invalidate (venue candidate B withdraws)

## Measured on

- Board commit: `1fca1cb` (akira-toriyama/furrow-test, repo-local store, mode `shared`, schema v10 board / v10 binary — writable)
- furrow version: `furrow dev` (built from furrow main at `eb85970`)
- Run date / local time: 2026-09-25 (Fri) 15:40–15:49 JST (Asia/Tokyo — the board's timezone, so the due band read here is the same one a Tokyo session sees)
- Session: a Claude Code subagent on Opus, handed only the request, the rules, this recording format, the repo's `README.md` and `CLAUDE.md`, and the board through the `furrow` CLI, the files under `.furrow/`, and `notes/`. No `docs/`, no `seed/`, no prior knowledge of this board.
- `furrow sync` had already been run by the operator; this run never ran it. Read-only throughout: nothing below was executed.
- Lint at read time: 4 errors, all `due-overdue` (`t-2sjvt`, `t-4kawk`, `t-hjkxq`, `t-zw0h1`).

Board facts the disposal rests on (measured, not assumed):

- `furrow ls -l cand-b` → 8 tasks: `t-2bjdh` `t-pafaq` `t-ec9cd` `t-2sjvt` `t-4kawk` `t-3m6x2` `t-76q4d` `t-t62zh`.
- **No task carries `cand-b` alone** — every one of the 8 also carries `cand-a` or `cand-c`. The request's "tasks that only made sense for B" has an empty answer, and CLAUDE.md forbids removing or iceboxing a dropped candidate's tasks anyway: the drop is an in-place rewrite.
- **No dependency edge is B-only.** All eight `dep --list` reads show every edge still carrying A or C content; `furrow dep` is not called once in the plan. The request's "dependencies that ran through it" also has an empty answer.
- Archive store and drafts are empty, so nothing hides outside the hot board.
- What B actually touches: 2 titles that count a population, 5 checklist rows (3 B-specific, 2 population counts + 2 more in other tasks), 9 body lines across 7 tasks, and 3 files under `notes/`.

## Plan

```sh
cd /Volumes/workspace/github.com/akira-toriyama/furrow-test

# --- t-3m6x2 決定 task: the ONE place the reason is recorded (CLAUDE.md: the box body records nothing)
furrow note t-3m6x2 "2026-09-25 候補 B が辞退（ダブルブッキング）。残る候補は A と C の 2 件。前提「出席が 13 名以上に増えた場合は定員の狭い B を落とす」は対象が消えたため失効。前提「C が打ち切り条件に掛かれば残る候補で決める（打ち切りは候補が 2 件残る場合に限る）」は、B 辞退で残り 2 件になったため C の打ち切りが成立しなくなった（落とすと 1 件）。目的・完了条件の「A/B/C」は「A/C」として読む。5 軸採点は A/C の 2 列で行う。"
furrow label t-3m6x2 --rm cand-b

# --- t-2bjdh 設備インベントリ: 残るのは A のみ。A の 9 項目は完了済みなので同じ pass で閉じる
furrow retitle t-2bjdh 返信済み A 会場の設備インベントリ 9 項目を埋める
furrow check t-2bjdh 4 --reword "冷蔵庫/冷凍庫の容量を A の分記入"   # 母数 row は残る候補に縮める（削除しない）
furrow check t-2bjdh 4                                              # A の 400L / 冷凍 80L は比較表に記入済み
furrow check t-2bjdh 3 --rm                                         # B の食器・カトラリー数（高い index から）
furrow check t-2bjdh 2 --rm                                         # B のオーブン庫内サイズ
furrow note t-2bjdh "2026-09-25 B 辞退により対象は A のみ。目的・完了条件・現状・逃がしの「A/B」「両会場」は A だけを指す。B の row 2 件は削除、母数 row は A に縮めて記入済みとして tick。"
# notes/venue-compare.md（この task が書いている表。同じ change で編集）
#   L3   状態行: 「設備 9 項目の A/B 列は…記入中」→ 末尾に「（2026-09-25 B 辞退。A 列で確定、B 列は受領済みの値として凍結）」を追記
#   L4   最終更新: 2026-09-24 → 2026-09-25
#   L12  基本情報 B 行の状態セル: 「一次返信あり」→「辞退（ダブルブッキング）2026-09-25」
#   L23-33 設備インベントリの B 列は残す（運用行 L5「受領済みの値は落ちた後も残す」）
#   L36  「B はオーブン庫内サイズ…が空欄」の直後に日付行を追加:
#        「- 2026-09-25 B 辞退。未回答の項目 2・5 は追わない（受領済みの値はそのまま残す）。」
furrow label t-2bjdh --rm cand-b
furrow done t-2bjdh --note "結果: A の設備 9 項目を比較表に記入して確定。B は 2026-09-25 に辞退したため 2 項目（オーブン庫内サイズ・食器数）は未回答のまま追わない。C は対象外のまま [[t-2sjvt]] が回収する。"

# --- t-pafaq 下見: 候補 2 件 → A のみ（件数語を落として名前を残す）
furrow retitle t-pafaq 候補 A を現地下見して搬入経路・エレベーター・台車可否を実測する
furrow check t-pafaq 4 --rm                                         # B の下見枠を 10/3 までにもらう
furrow note t-pafaq "2026-09-25 B 辞退により下見対象は A のみ。完了条件の「A・B について」は A のみ、次の一手と固定行の B に関する記述（枠待ち・10/3 期限）は失効。固定の A 10/1(木) 14:00 は先方と合意済みのアポなので動かさない。due 2026-10-03 18:00 は B の枠取り期限として置いたものだが、根拠が消えても勝手には動かさず [[t-3m6x2]] の決定期日の内側として残す。"
# notes/site-visit-checklist.md（この task の note。同じ change で編集）
#   L4   「対象は候補 2 件（A/B）。」→「対象は候補 A の 1 件。」（C の一文はそのまま）
#   L8   表ヘッダ: 「| # | 項目 | A（10/1 木 14:00 アポ済み） | B（枠待ち・10/3 期限） |」→ B 列を削除
#   L9-17 各行の B セルを削除（測定値は 1 つも入っていない）
#   L26  「- B の枠が 10/3 までに…」の行はそのまま残し、直後に日付行を追加:
#        「- 2026-09-25 B が辞退（ダブルブッキング）。上の B に関する行は失効。下見は A のみで搬入軸を採点する。task 名は「候補 A を現地下見して搬入経路・エレベーター・台車可否を実測する」。」
furrow label t-pafaq --rm cand-b

# --- t-ec9cd キャンセル条項: 候補 3 件 → 2 件
furrow retitle t-ec9cd 候補 2 件のキャンセル料段階と延長不可条件を条文で確認して比較表に書く
furrow check t-ec9cd 1 --reword "何日前に何 % かを 2 件分記入する"
furrow note t-ec9cd "2026-09-25 B 辞退により対象は A/C の 2 件。完了条件の「A/B/C について」は A/C として読む。B の条項（無料期限 21 日前・延長 30 分 5,000 円）は受領済みの値として比較表に残すが、条文の引用確認は行わない。"
# notes/venue-compare.md
#   L68  キャンセル表の B 行はそのまま残す（受領済みの値）
#   L72  「この節の A/B の値は…」の直後に日付行を追加:
#        「- 2026-09-25 B 辞退。条文で確定させる対象は A のみ（C は未回答）。B の値は受領時のまま凍結。」
furrow label t-ec9cd --rm cand-b

# --- t-4kawk 持ち込み酒とゴミ: 候補 3 件 → 2 件（waiting のまま。due は赤のまま動かさない）
furrow retitle t-4kawk 候補 2 件の持ち込み酒可否とゴミ持ち帰り規定を書面で取り付ける
furrow check t-4kawk 4 --reword "入館可能時刻と事前入館料（15:00 入館の可否）を 2 件分、比較表の「入館可能時刻と事前入館料」節に記入する"
furrow check t-4kawk 3 --reword "ゴミの持ち帰り/引き取りを 2 件分記入する"
furrow check t-4kawk 1 --rm                                         # B の回答を比較表に転記する（値は比較表に記入済み）
furrow note t-4kawk "2026-09-25 B 辞退により対象は A/C の 2 件。完了条件の「A/B/C それぞれ」と現状の「B は書面回答済み」は失効。B の受領済みの値（持ち込み可・持込料 1,000 円/本・会場が引き取り）は比較表に残し、転記待ちの row は削除。残る待ちは A の書面化と C の未返信。due 2026-09-24 は A/C への催促日として赤のまま残す（本 session の pick ではないので snooze しない）。"
# notes/venue-compare.md
#   L46  持ち込み酒表の B 行はそのまま残す（受領済みの値）
#   L56  A 行の入館セル内「3 件分を書面で取り付けて記入する」→「2 件分を…」（checklist の reword に追従）
#   L57  B 行の入館セル: 「未回答（…）」→「未回答（2026-09-25 辞退により取り付けない）」
furrow label t-4kawk --rm cand-b

# --- t-2sjvt C の回収: B 辞退で打ち切り条件の算術が変わる（waiting のまま、due も赤のまま）
furrow note t-2sjvt "2026-09-25 B 辞退（残る候補は A/C の 2 件）。目的の「A/B と同じ土俵で」は A と読む。次の一手の打ち切り条項「落としても候補が 2 件残る場合に限る」は成立しなくなった — ここで C を落とすと候補 1 件になるため、打ち切らず due を延ばして催促を続ける側に倒れる。due 2026-09-22 は催促日として赤のまま残し、閉じの読みで名指しする。"
furrow label t-2sjvt --rm cand-b

# --- t-76q4d 本予約: 落選の件数が変わる（辞退は落選ではないので断りを送らない）
furrow check t-76q4d 3 --reword "落選 1 件(A/C のうち選ばれなかった 1 件)に断りの一報を送る"
furrow note t-76q4d "2026-09-25 B 辞退により候補は A/C の 2 件。落選は 1 件になる。辞退した B には断りの一報を送らない（先方都合の取り下げ）。"
furrow label t-76q4d --rm cand-b

# --- t-t62zh 調理制約表（献立 box）: 暫定の最小構成が B の下限だった
furrow note t-t62zh "2026-09-25 B 辞退により前提の「候補 2 会場（A/B）の共通最小構成（コンロ 2 口・オーブン 1 段＝A/B の下限）」は失効。残る候補は A（コンロ 4 口・オーブン 2 段・天板 40×33cm）と C（設備 9 項目すべて未回答）。C の回答が来るまで暫定設計は A の実数で引き直し、未回答の C を下限に含めない。[[t-2bjdh]] の B 回答待ちという書き出しも失効。"
furrow label t-t62zh --rm cand-b

# --- notes/venue-inquiry-template.md（done task t-2db3n の note。日付追記と状態セルの in-place 更新のみ）
#   L11  B 行の追跡セル: 「オーブン庫内サイズと食器数が未回答」
#        →「オーブン庫内サイズと食器数が未回答 / 2026-09-25 辞退（ダブルブッキング）につき追照会なし」
#   （L3 が引用する done task の title はそのまま。本文テンプレも送信記録も書き換えない）

# --- notes/venue-compare.md の 5 軸採点表だけは列を消す（運用行 L5 の明示例外）
#   L78-85 の「| 軸 | 重み | A | B | C |」から B 列を削除（採点対象は A/C の 2 件）
#   L76  採点の説明段落の直後に日付行を追加:
#        「- 2026-09-25 B 辞退（ダブルブッキング）。採点は A/C の 2 件で行う。基本情報・設備・持ち込み酒・キャンセルの各表の B 行/列は受領済みの値として残す。」
#   L19  「上限内かつ…は A/B/C の 3 件」は done task の成果なので書き換えず、直後に日付行を追加:
#        「- 2026-09-25 B が辞退。以降の列を埋める対象は A/C の 2 件。」

# --- 検証（書き終えた後に読むだけ）
furrow ls -l cand-b                 # 空になるのが drop 完了の確認
furrow show t-3m6x2 t-2sjvt t-4kawk # 決定・待ち 2 件の note が入ったか
furrow lint                         # 期待: due-overdue 3 件（t-2bjdh を閉じたので 4 → 3 ではなく、t-2bjdh は overdue でないため 4 件のまま）
furrow sync                         # shared board なので書いた後に同期
git add notes/ && git commit -m ":memo:(notes)= B の辞退を比較表・下見表・問い合わせ記録に反映"
```

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow ls -l cand-b` | The request says "dispose of … tasks that only made sense for B", but CLAUDE.md says a drop "rewrites every `ls -l cand-x` task in place — retitle, reword, note; never remove or icebox". Opposite verbs. | The rulebook wins: nothing is removed or iceboxed; "dispose of" means retire B's content in place. | prose (CLAUDE.md): 「オペレータの「落とす/処分する」は in-place の書き直しを指す。rm も icebox も使わない（依頼が上回るのは pick 順だけ）」 | no |
| 2 | `furrow ls --help` | Whether `ls -l cand-b` had already shown me `done` and archived tasks — a done task carrying `cand-b` is history and must not be rewritten. Unplanned help read. | Nothing: help says every lane incl. `done` is listed and `--archived` is a separate store; checked both, no done/archived `cand-b` task exists. | prose (CLAUDE.md candidate paragraph): 「`ls -l cand-x` は done も含む。done の task は履歴なので書き直さず label だけ外す」 | no |
| 3 | `furrow show t-2bjdh` | The title 「返信済み A/B 2 会場の…」 carries BOTH a count word (2 会場) and the member names (A/B); CLAUDE.md's one-member example is only 「候補 A」, which does not say what happens to a name list. | 「返信済み A 会場の設備インベントリ 9 項目を埋める」 — count word goes, surviving name stays. | prose: 「名前を並べた title は残る候補の名前だけにし、件数語を落とす（返信済み A/B 2 会場 → 返信済み A 会場）」 | no |
| 4 | `furrow show t-3m6x2` | `show` prints deps as bare ids (`deps: t-0298a, t-2bjdh, …`); `t-0298a` meant nothing, and the 前提 「出席が 13 名以上なら定員の狭い B を落とす」 needed to know whether the headcount task was still live. Ran an unplanned `show t-0298a`. | Nothing: read it (waiting, 出席 12 名確定) and retired the 前提 as moot. | furrow change: `show` should render each dep id with its title and lane, the way `dep --list` does. | no |
| 5 | `furrow search 'B 会場'` | `search` found body hits only. Measured: 「下見枠」 (text that exists ONLY in `t-pafaq`'s checklist row) returns `(no matches)`, and `search --help` says it searches "title and Markdown body". B's footprint in checklist rows is invisible to it. | Nothing: fell back to `grep .furrow/tasks/*.json` for checklist text — the "grep dance" the help claims an agent skips. | furrow change: `search` should cover checklist item text (a third `matched_field`). | no |
| 6 | shard scan / `ls --archived` / `ls --drafts` | Whether any task is B-ONLY (the request's first clause), or hides outside the hot board. Three unplanned reads. | Nothing: no task carries `cand-b` alone, archive and drafts are empty. | prose: 「候補ラベルは必ず複数付く（どの task も候補を跨ぐ）ので、1 候補専用の task は存在しない」 | no |
| 7 | `cat notes/venue-compare.md` | Line 5's rule says a dropped candidate's ROW stays with reason+date in the 状態欄 and only the 5 軸採点表 loses its COLUMN — but 設備インベントリ (L23) and 5 軸 (L78) both put candidates in columns, and only 基本情報 has a 状態 column at all. | Keep B's column everywhere but the 5-axis table; write the reason+date into the 基本情報 B row's 状態 cell (L12). | prose (venue-compare.md L5): 「候補が列に並ぶ表でも受領済みの値は残す。理由と日付は基本情報の状態欄にだけ書く」 | no |
| 8 | `cat notes/venue-compare.md` (L19) | 「上限内かつ 15 名着席可かつ調理可は A/B/C の 3 件」 is now 2 件, but it is also done task `t-8vahe`'s recorded finding. Rewrite or append? | Leave the line, append a dated line under the section. | prose: 「done task の成果として書かれた行は書き換えず、日付行で上書きする」 | no |
| 9 | `cat notes/venue-compare.md` (L56-57) | The 入館 table's A and B cells quote `t-4kawk`'s checklist row verbatim (「3 件分を書面で取り付けて記入する」), which the drop rewords to 2 件分. CLAUDE.md's "a note that copies a body's text follows the body" names the BODY, not a checklist row. | Treat a quoted checklist row the same as body text: reword A's cell to 2 件分, set B's cell to 未回答（辞退により取り付けない）. | prose: 「note が写しているのが checklist の文言なら、reword に合わせて同じ change で直す」 | no |
| 10 | `cat notes/site-visit-checklist.md` | This note has no 運用 line of its own for a dropped candidate (that rule lives only in venue-compare.md), and its B column is an EMPTY measurement column for a visit that will never happen — "受領済みの値は残す" has nothing to preserve. | Drop the B column here (unlike venue-compare.md), rewrite L4's 対象, keep L3/L26's quoted task titles as written, add a dated line carrying the new title. | prose (site-visit-checklist.md): its own 運用 line, e.g. 「落ちた候補の列は、受領値があれば残し、空欄なら消す」 | no |
| 11 | `cat notes/venue-inquiry-template.md` | It is a DONE task's note. CLAUDE.md allows dated additions and in-place status-cell updates — but is the 追跡 cell (「オーブン庫内サイズと食器数が未回答」) a status cell I may rewrite, or a log line I may only append to? | Status cell: update it in place to record the withdrawal and that the unanswered items are not chased. | prose: 「done task の note の表で返信/追跡/状態に当たる列は、落ちた候補も in-place で更新する」 | no |
| 12 | `furrow dep --list` ×8 | The request names "dependencies that ran through it", but a dep edge carries no candidate label, so "a dep that exists for B" is unrepresentable. Ran all eight dep lists to see whether any edge went vacuous. | No `furrow dep` call at all: every edge still carries A or C content. | furrow change: an edge cannot be labelled, so a candidate-scoped dependency cannot exist — worth one prose line saying so. | no |
| 13 | `furrow lint` | Ran it unplanned (this log's last column needs it) and to see whether a candidate drop leaves anything lint can see. It reports 4 `due-overdue` and nothing else — no code covers titles, labels, checklist rows, or notes. | Nothing. | furrow change: none available; the drop is invisible to lint by design. | no |
| 14 | `furrow vocab lint-codes` | Looked for a code that would flag a HALF-finished drop (B's rows removed but `cand-b` still on the task). None of the 53 codes covers it. Unplanned. | Nothing: the only check is `ls -l cand-b` coming back empty, as CLAUDE.md says. | furrow change: a `label-orphan` code cannot know a candidate withdrew; the `ls -l` check stays the contract. | no |
| 15 | `furrow check --help` | `furrow show` prints the checklist with NO indexes, and `check` takes a ZERO-based index — I could not tell from `show` which number 「B の下見枠…」 is. Unplanned help read. | Nothing: help gave zero-based + "remove from the highest index down"; re-derived every index from the shard JSON. | furrow change: `furrow show` should print each checklist row's index. | no |
| 16 | `furrow check t-2bjdh 4 --reword` | Whether the reworded population row 「冷蔵庫/冷凍庫の容量を両会場分記入」→A only should ALSO be ticked: it is unticked, but notes/venue-compare.md already carries A's 400L / 冷凍 80L. | Tick it — the work landed — and say so in the close note. | prose: 「件数 row を残る候補に縮めたとき、その分が既に埋まっていれば同じ pass で tick する」 | no |
| 17 | `furrow check t-4kawk 1 --rm` | B's row 「B の回答(持込料 1,000 円/本)を比較表に転記する」 is UNticked, yet venue-compare.md L46 already holds the value and says 受領済み — removing the row deletes the only task-side pointer to a value the table keeps. | Remove the row (a dropped member's rows go) and keep the table value (venue-compare.md L5: 受領済みの値は落ちた後も残す). | prose: 「落ちた候補の受領済み値は表に残し、転記待ちの row は消す」 | no |
| 18 | `furrow check t-76q4d 3 --reword` | 「落選 2 件(A/B/C のうち選ばれなかった 2 件)に断りの一報を送る」 — is a withdrawal a 落選 that still gets a 断り? | No: a withdrawal is the other side's own move. Reworded to 「落選 1 件(A/C のうち選ばれなかった 1 件)」. | prose: 「辞退した候補には断りを送らない。落選数は残った候補で数え直す」 | no |
| 19 | `furrow set t-pafaq --due …` (considered, dropped) | `t-pafaq`'s due 2026-10-03 18:00 IS B's slot deadline (body 固定 line: 「B の 10/3 は自分の締切なので動く」); with B gone the only remaining work is A's 固定 10/1 14:00 appointment, so the due has lost its source. The drop's verb list is retitle/reword/note — no due. | Leave the due, name the loss of its source in the note. | prose: 「候補が落ちて due の根拠が消えた task は due を動かさず、note に根拠の変更を書く」 | no |
| 20 | `furrow note t-2sjvt` | The timeout clause 「落としても候補が 2 件残る場合に限る」: with B gone the survivors are A/C, so dropping C would leave 1 and the timeout can NEVER fire — the chase must continue past an already-red due. Do I extend the due so the chase is honest? | No: record the arithmetic in the note and leave the due red (a session owes only its pick; never snooze to make lint green). | prose: 「候補が減って打ち切り条件が成立しなくなった waiting は、due を延ばさず note に「打ち切り不可」と書く」 — CLAUDE.md's no-snooze line collides with lint's own remedy text, which offers "push the date". | yes: due-overdue |
| 21 | `furrow note t-4kawk` | Same shape: I am rewriting an already-overdue `waiting` task for the drop and touching it anyway — does "rewrite it in place" extend to clearing its red due? | No: leave it red, name it in the closing read. | prose: same line as #20. | yes: due-overdue |
| 22 | `furrow note t-t62zh` | The 前提 pins the interim minimum config to 「A/B の下限（コンロ 2 口・オーブン 1 段）」 — that floor WAS B's numbers. Survivors are A (4 口 / 2 段) and C (equipment column entirely blank), so the board cannot say what the new floor is. | Retire the line in the note without inventing a number; say the floor rests on A's own numbers alone and C stays out until it answers. | prose (t-t62zh body): 「下限の出どころの候補が落ちたら残る候補の実数で引き直す。未回答の候補は下限に入れない」 | no |
| 23 | `furrow note t-3m6x2` | CLAUDE.md: "the decision task alone records why". Does that FORBID the other seven notes from naming the reason (double-booked)? | Yes: only `t-3m6x2` carries 「ダブルブッキングで辞退」; the other notes state what changed in that task and cite the drop. | prose: 「理由は決定 task の note にだけ書く。他は「B 辞退により〜を書き直した」と事実だけ」 | no |
| 24 | `furrow label --help` | Flag spelling for removing a label. Unplanned help read. | Nothing: `--rm`, repeatable, removing an absent label is a no-op. | — (contract read the CLI answers) | no |
| 25 | `furrow retitle --help` | Whether `retitle` also rewrites the body's leading `# ` heading — it matters because notes quote titles and a done task's body is history. Unplanned help read. | Nothing: it updates both, shard is the source of truth. | — (contract read the CLI answers) | no |
| 26 | `furrow done --help` | Whether unticked checklist rows block a close (three would remain on `t-2bjdh` before the rewrite), and whether `--note` is the only way to append 結果 in the same write. Unplanned help read. | Nothing: a close settles the task, not the checklist. | — (contract read the CLI answers) | no |
| 27 | `furrow done t-2bjdh` | Whether A's 9 items really ARE complete — the body's 現状 and notes/venue-compare.md L35 both assert it, and nothing else on the board measures it. Also whether closing an `in-progress` task this session did not start violates one-task-in-flight. | Close it (CLAUDE.md: "If the survivors' work is already finished, close the task in the same pass"; the flight rule counts work you START, and an inbound fact starts nothing). | prose: 「残った候補の分が終わっているかは body の現状ではなく notes/ の表で判定する」 | no |
| 28 | `furrow label t-2bjdh --rm cand-b` | "takes `cand-x` off it once the rewrite is done" — per task or board-wide? And on the task I am closing, does the label come off before or after `done`? | Per task, as that task's last write; on `t-2bjdh`, before the close, so the close is the final write on a body that becomes history. | prose: 「cand-x を外すのは その task の書き直しの最後。閉じる task は done の前に外す」 | no |
| 29 | `furrow note --help` | Argument shape for a multi-line note. Unplanned help read. | Nothing: `<id> <text>`, `-` reads stdin. | — (contract read the CLI answers) | no |

## Verdict

`could_act_confidently: true`

CLAUDE.md names the mechanism (`cand-b` is a label), the procedure (retitle / reword / note in place, label off last, `ls -l cand-b` empty as the completion check) and the reason's single home (the decision task), and the board answered two of the request's three clauses outright — no B-only task, no B-only dep edge — so every stop was about WHICH cell or WHICH index, not about whether to act; the residual risk is concentrated in `notes/`, where three edits rest on guesses the board cannot confirm.

- Hesitations: 29
- Rows answering `yes` in the last column: 2 (both `due-overdue`)

Most consequential: #7 — venue-compare.md's 運用 line covers row-shaped tables but two of its tables put candidates in columns, so what a reader of the comparison sees after the drop is a guess; #5 — `furrow search` misses checklist text, so without an unplanned `grep .furrow/tasks/*.json` three of B's rows would have survived the drop; #15 — `furrow show` prints no checklist indexes while `check` is zero-based and shifts on `--rm`, making every removal in the plan an off-by-one away from deleting a surviving candidate's row.
