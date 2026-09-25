# Drill run — invalidate (venue candidate B withdraws)

## Measured on

- board commit: `9896fee`
- furrow version: `furrow dev`
- run date / local time: 2026-09-25 (Fri), 15:09–15:16 JST
- session: a Claude Code subagent on Opus, handed only the request, the rules,
  this recording format, the repo's `README.md` and `CLAUDE.md`, and the board
  through the `furrow` CLI, the files under `.furrow/`, and `notes/`. No
  `docs/`, no `seed/`, no prior knowledge of this board.
- the operator had already run `furrow sync`; this run never ran it, and wrote
  nothing but this file.
- request: "Venue candidate B has withdrawn (double-booked). Dispose of
  everything on the board that assumed B: tasks that only made sense for B,
  comparisons that included B, and dependencies that ran through it."

## Plan

```sh
cd /Volumes/workspace/github.com/akira-toriyama/furrow-test

# ---- 0. scope
# `cand-b` is the index of the drop (CLAUDE.md: "A venue candidate is a label").
# 7 tasks carry it. None carries it ALONE — `furrow ls -q 'label:cand-b
# -label:cand-a -label:cand-c'` is empty — and no dep edge is B-specific: every
# edge into/out of the cand-b tasks is candidate-agnostic (t-vzyxv/t-yf4vd in,
# t-80nmd/t-0w0h2/t-q3ddv/t-gkpht/t-w1nyn out). So two of the request's three
# clauses have NO members on this board: there is no B-only task to retire and
# no edge to cut. The drop is 7 in-place rewrites + 1 unlabelled task whose
# 前提 flips + the notes/ files that copy them.

# ---- 1. t-fz6xs  A/B inventory -> A only, and it CLOSES in the same pass
#         (CLAUDE.md: "If the survivors' work is already finished, close the
#          task in the same pass" — A's 9 items are filled in the compare table).
furrow retitle t-fz6xs 返信済み A 会場の設備インベントリ 9 項目を埋める
furrow check t-fz6xs 3 --rm   # "B の食器・カトラリー数を記入"        (highest index first)
furrow check t-fz6xs 2 --rm   # "B のオーブン庫内サイズを電話で聞く"
furrow check t-fz6xs 2 --reword "冷蔵庫/冷凍庫の容量を A 分記入"   # 両会場分 = population row -> survivors
furrow check t-fz6xs 2        # A は 400L / 80L を比較表に記入済み
furrow note t-fz6xs "2026-09-25: B が二重予約で辞退。完了条件の「A・B 両方で埋まる」、現状の「B はオーブン庫内サイズと食器数が空欄」、次の一手の B への電話は失効。対象は A の 1 会場のみ。"
furrow label t-fz6xs --rm cand-b
furrow done t-fz6xs --note "結果: A の 9 項目が比較表「設備インベントリ 9 項目」に揃い完了。B は 2026-09-25 に辞退したため未回答 2 項目は追わない。dep 先 t-80nmd(残り 5 本) / t-0w0h2(t-3r4ra 未了) はどちらも ready には上がらない。"

# ---- 2. t-xcrzs  下見 2 件 -> A の 1 件（1 件になるので件数が消えて名前が残る）
furrow retitle t-xcrzs 候補 A を現地下見して搬入経路・エレベーター・台車可否を実測する
furrow check t-xcrzs 4 --rm   # "B の下見枠を 10/3 までにもらう"
furrow note t-xcrzs "2026-09-25: B が二重予約で辞退。完了条件の「A・B について」、次の一手の「B は先方都合待ちで 10/3 までに枠をもらう」、前提の「下見は A/B の 2 件のまま」は失効。下見は A のみ(10/1 木 14:00 アポ済み)で、搬入軸は A の実測だけで採点する。"
furrow label t-xcrzs --rm cand-b

# ---- 3. t-ck1j4  規約確認 3 件 -> 2 件 (A/C)
furrow retitle t-ck1j4 候補 2 件のキャンセル料段階と延長不可条件を条文で確認して比較表に書く
furrow check t-ck1j4 1 --reword "何日前に何 % かを 2 件分記入する"
furrow note t-ck1j4 "2026-09-25: B が二重予約で辞退。完了条件の「A/B/C について」は A/C の 2 件に縮む。比較表「キャンセル料と延長条件」の B 行は辞退マークで据え置き、条文の引用は A/C の 2 件分だけ行う。"
furrow label t-ck1j4 --rm cand-b

# ---- 4. t-w65xk  酒・ゴミの書面 3 件 -> 2 件 (A/C)。lane は waiting のまま
furrow retitle t-w65xk 候補 2 件の持ち込み酒可否とゴミ持ち帰り規定を書面で取り付ける
furrow check t-w65xk 1 --rm   # "B の回答(持込料 1,000 円/本)を比較表に転記する"
furrow check t-w65xk 2 --reword "ゴミの持ち帰り/引き取りを 2 件分記入する"
furrow check t-w65xk 3 --reword "入館可能時刻と事前入館料（15:00 入館の可否）を 2 件分、比較表の「入館可能時刻と事前入館料」節に記入する"
furrow note t-w65xk "2026-09-25: B が二重予約で辞退。現状の「B は書面回答済み」と完了条件の「A/B/C それぞれ」は失効。残りは A の書面化依頼と C の未返信の 2 件で、どちらも先方待ちのため waiting を維持。"
furrow label t-w65xk --rm cand-b

# ---- 5. t-80nmd  決定 task は「なぜ落ちたか」だけを記録する（CLAUDE.md）
furrow note t-80nmd "2026-09-25: B が二重予約で辞退(ノックアウト条件ではなく先方都合)。採点対象は A/C の 2 件、次点はそのうち選ばれなかった 1 件。前提の「出席が 13 名以上に増えた場合は定員の狭い B を落とす」は失効。前提の打ち切り条項「打ち切りは候補が 2 件残る場合に限る — 1 件に落ちる打ち切りはしない」により、候補が 2 件になった今 C の打ち切りは不可 — t-j5rww は打ち切りではなく催促継続へ切り替えた。"
furrow label t-80nmd --rm cand-b

# ---- 6. t-3r4ra  落選 2 件 -> 1 件（母数を数える行は reword、削除しない）
furrow check t-3r4ra 3 --reword "落選 1 件(A/C のうち選ばれなかった 1 件)に断りの一報を送る"
furrow note t-3r4ra "2026-09-25: B が二重予約で辞退。断りの一報は A/C のうち落選した 1 件のみ(B へは辞退連絡の受領返信で足りる)。"
furrow label t-3r4ra --rm cand-b

# ---- 7. t-ybhjh  献立側の暫定設計が A/B の下限を前提にしていた
furrow note t-ybhjh "2026-09-25: B が二重予約で辞退。前提の「候補 2 会場(A/B)の共通最小構成(コンロ 2 口・オーブン 1 段＝A/B の下限)」は失効。会場未確定時の暫定設計は A の実数(コンロ 4 口・オーブン 天板 40×33cm 2 段)を使う。「B は庫内サイズ未回答のため暫定」の留保と t-fz6xs の回答待ちも不要(t-fz6xs は 2026-09-25 close)。"
furrow label t-ybhjh --rm cand-b

# ---- 8. t-j5rww  cand-b を持たないが、B の辞退がこの task の打ち切り条項を反転させる
furrow note t-j5rww "2026-09-25: B が二重予約で辞退し候補は A/C の 2 件。次の一手の「due を 2 日過ぎても返信が無ければ C を落とす」は同じ行の但し書き(落として候補が 2 件残る場合に限る／1 件になるなら打ち切らず due を延ばして催促を続ける)により発動しない — 今 C を落とすと候補が A の 1 件になる。打ち切りではなく催促継続に切り替え、due を t-80nmd の決定日 10/3 より前の 9/29 へ延ばす。目的の「A/B と同じ土俵で」は A のみと読み替える。"
furrow set t-j5rww --due 2026-09-29

# ---- 9. notes/ （手書きのファイル。同じ change で直す — CLAUDE.md）
#  notes/venue-compare.md
#    行番号を動かさない in-place 書き換えに限る（line 40 より上で行数を変えない）。
#    t-fz6xs の ref は file:notes/venue-compare.md:20、t-w65xk は :40 で、
#    ref は verbatim・存在検査なしなので挿入すると黙ってずれる。
#    L3   状態: 「設備 9 項目の A/B 列は「返信済み A/B 2 会場…」が記入中」
#              -> 「A 列は「返信済み A 会場の設備インベントリ 9 項目を埋める」で確定(2026-09-25 close)。B 列は辞退時点で凍結」
#    L4   最終更新 2026-09-24 -> 2026-09-25。「上限内に収まるのは A/B/C の 3 件」
#              -> 「…3 件だったが B が 2026-09-25 に二重予約で辞退し、現在の候補は A/C の 2 件」
#    L11  B 行の「状態」セル 「一次返信あり」-> 「二重予約で辞退（2026-09-25）」
#              （D/E/F の「候補外」行と同じ扱いで行そのものは残す）
#    L18  「以降の列はこの 3 件だけを埋める」-> 「B 辞退により以降の列は A/C の 2 件だけを埋める」
#    L34  task 名を新タイトルへ、「の途中結果」-> 「の成果(2026-09-25 close)」
#    L35  「B はオーブン庫内サイズ（項目 2）と食器数（項目 5）が空欄。担当は平日 10-18 時のみ。」
#              -> 「B は 2026-09-25 に辞退。未回答 2 項目は空欄のまま凍結し、照会は打ち切り。」
#    L38  HTML コメント内の task 名 -> 「候補 2 件の持ち込み酒可否とゴミ持ち帰り規定を書面で取り付ける」
#    L45  B 行の「受領形式」セル末尾に 「／2026-09-25 辞退」
#    L55  本文中の task 名 -> 新タイトル、「3 件分」-> 「2 件分」
#    L56  B 行 -> 「| B | 17:00-22:00 通し | — | — |」に置換し末尾に「2026-09-25 辞退」
#    L67  B 行の「原状回復の範囲」セル末尾に 「／2026-09-25 辞退」
#    L71  「この節の A/B の値は…「候補 3 件のキャンセル料段階…」が」
#              -> 「この節の A の値は…「候補 2 件のキャンセル料段階…」が」
#    L77-L84  5 軸採点表から B 列を削除（L75「満たさない候補は採点しない」に合わせる。
#              受領済みの B のデータは上の 4 つの表に辞退マーク付きで残る）
#    L85 付近に 1 行追加（挿入は ref の行番号より下）:
#              「- B は 2026-09-25 に二重予約で辞退。採点対象は A/C の 2 件。」
#
#  notes/site-visit-checklist.md
#    L3   状態行の task 名 -> 「候補 A を現地下見して搬入経路・エレベーター・台車可否を実測する」
#    L4   「対象は候補 2 件（A/B）。」-> 「対象は候補 A の 1 件（B は 2026-09-25 に二重予約で辞退）。」
#    L8   表ヘッダから「B（枠待ち・10/3 期限）」列を削除
#    L10-L17 各行末の B セルを削除
#    L26  「B の枠が 10/3 までに出なければ、A のみの実測で…採点する。」
#              -> 「B は 2026-09-25 に辞退。搬入軸は A のみの実測で「会場を 1 件に決定して決定理由と次点を比較表に記録する」が採点する。」
#
#  notes/venue-inquiry-template.md  （done task t-vzyxv の note = 追記のみ、既存行は書き換えない）
#    「## 送信記録」の表の直下に 1 行追加:
#      「- 2026-09-25: B は二重予約で辞退。未回答（オーブン庫内サイズ・食器数）は追わない。追跡は C のみ。」
#    L11（B の送信記録）と L40（旧 task 名）はそのまま残す — done task の note は追記のみ。

# ---- 10. 反映と検証
furrow sync
git add notes/ && git commit -m ":memo:(notes)= candidate B withdrew: rewrite the venue notes to A/C"
git push
furrow ls -l cand-b     # 空になるのが drop 完了の検査（CLAUDE.md）
furrow lint             # 残るのは B と無関係な due-overdue（t-010c2 / t-jdtvf / t-w65xk）
furrow brief
```

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow brief` | next said `3/4 — 1 hidden by -n: 1 ready`; a hidden row could have been a B task | the hidden row is not B-specific; resolved later by `ls -l cand-b` rather than re-running `next -n 0` | furrow change: `brief` should name the ids it hid, not just the count | no |
| 2 | `cat README.md CLAUDE.md` | the request says "Dispose of" but CLAUDE.md says a drop "rewrites every `ls -l cand-x` task in place — retitle, reword, note; never remove or icebox" | "dispose" means the in-place rewrite, not `rm`/`icebox` | a line of prose in CLAUDE.md: 「辞退・取り下げ・破棄と言われても操作は同じ — 書き換えであって削除ではない」 | no |
| 3 | `cat CLAUDE.md` | the drop rule is written for "a candidate that fails a knockout condition (the decision task's 前提)"; a withdrawal is not a knockout condition and has no listed trigger | a withdrawal takes the same path, with the decision task recording why | a line of prose: 「先方都合の辞退もノックアウトと同じ drop 手順を踏む」 | no |
| 4 | `furrow ls -l cand-b` | no task carries `cand-b` alone, so "tasks that only made sense for B" looked like it had no members — but I could not tell whether that was the board or my query | ran `furrow ls -q 'label:cand-b -label:cand-a -label:cand-c'` (empty) to prove it | nothing — the query grammar answered it; the stop was mine | no |
| 5 | `furrow ls -l cand-a` / `-l cand-c` | to learn what the label means in practice I had to list the sibling labels (unplanned) — e.g. 4 teardown tasks carry `cand-a` only, which reads as "these assume A" | those are unaffected: B's exit narrows toward A, it does not rewrite them | nothing; the sibling listings are the cheapest way to read the label's shape | no |
| 6 | `grep .furrow/bodies` | CLAUDE.md says "A task that merely names a candidate carries no label", so the label set is not the whole footprint — I had to grep bodies and titles for B | the grep (9 bodies) plus the 7 labelled tasks is the full footprint | furrow change: a `-q` free-text query that spans bodies reliably — `furrow search 'B 会場'` returned no matches while grep found 9 files | no |
| 7 | `furrow show t-fz6xs` | the retitle rule is written for 「候補 3 件 → 2 件」; this title is 「返信済み A/B 2 会場の…」, a differently-shaped count | applied "at one member the count goes and the name stays" → 「返信済み A 会場の…」 | a line of prose: 「件数は「候補 N 件」以外の形（N 会場・両会場）でも同じ規則で縮める」 | no |
| 8 | `furrow show t-fz6xs` | "If the survivors' work is already finished, close the task in the same pass" — 現状 says 「A は 9 項目完了」 but the checklist still has an unticked row, so I had to open `notes/venue-compare.md` to see whether A really is complete | A's 9 rows are all filled → close it | furrow change: nothing; the board's own 現状 line and the note agree. A `check`-vs-完了条件 mismatch is unavoidable by design | no |
| 9 | `furrow check --help` | `furrow show` prints the checklist without indexes; I did not know whether `check <i>` is 0- or 1-based | opened `--help`: zero-based, and `--rm` shifts everything below | furrow change: `show` should print each checklist row's index | no |
| 10 | `furrow dep --list` (×8) | "dependencies that ran through it" — I expected a B-specific edge to cut and found none; every edge is candidate-agnostic | the clause has no members; B's only graph effect is semantic (row 11) | furrow change: nothing — deps here are between tasks, never between a task and a candidate. The prose line wanted: 「候補は label であって dep ではない。辞退で切る edge は無い」 | no |
| 11 | reading t-80nmd 前提 + t-j5rww 次の一手 | B's exit silently REVERSES C's cutoff: 「打ち切りは候補が 2 件残る場合に限る — 1 件に落ちる打ち切りはしない」, and dropping C now leaves only A. Nothing on t-j5rww points back at the candidate count | C can no longer be cut off; t-j5rww switches to chase-and-extend | furrow change: a conditional/derived dep, or a lint code for "a 前提 whose truth depends on a population that changed"; neither exists | no |
| 12 | `furrow set t-j5rww --due …` | the board carries no chase interval — how far to push the date is nowhere | 2026-09-29 (before t-80nmd's 10/3 decision, matching t-sftpe's due) | a `config.toml` setting: a `[due]` default chase interval for the `waiting` lane | yes: due-overdue |
| 13 | scoping the rewrite | t-j5rww carries no `cand-b`, yet B's withdrawal rewrites its 前提 — CLAUDE.md's completion check (`ls -l cand-b` empty) would have passed with t-j5rww untouched | included it anyway | a line of prose: 「`ls -l cand-x` は書き換えの下限であって全部ではない。他候補の task の 前提 が母数を数えていないか見る」 | no |
| 14 | editing `notes/venue-compare.md` | nothing says whether a withdrawn candidate's row is deleted or annotated | annotate — the 基本情報 table already keeps D/E/F with 「候補外」 reasons, so B stays with 「二重予約で辞退（2026-09-25）」 | a line of prose: 「比較表から落ちた候補の行は消さず、状態欄に落選理由を書いて残す」 | no |
| 15 | editing the 5 軸採点 table | the same question with the opposite answer — L75 says knocked-out candidates are not scored, so an empty B column is noise | drop B's column there, keep B's rows everywhere else | the same prose line as #14, with the scoring table named as the exception | no |
| 16 | after the 4 retitles | the old titles are quoted as prose in `notes/` (venue-compare L3/L34/L38/L55/L71, site-visit L3, inquiry-template L40); furrow has no title-link check | grepped `notes/` for each old title and listed every line in the plan | furrow change: `retitle` should report the `notes/` lines quoting the old title (or a lint code for it) — `dangling-link` only covers `[[id]]` | no |
| 17 | editing `notes/venue-inquiry-template.md` | conflict: it is a DONE task's note ("never rewritten", dated additions only), but its L40 quotes a title I am changing ("a note that copies a body's text follows the body") | left L11/L40 alone, appended one dated line | a line of prose: 「done task の note では追記が書き換えに優先する。古い task 名も履歴として残す」 | no |
| 18 | `furrow ref --help` | t-fz6xs and t-w65xk carry `file:notes/venue-compare.md:20` / `:40`; help says refs are "verbatim, never checked for existence", so any inserted line silently breaks them | constrained every edit above line 40 to an in-place rewrite so no anchor moves | a lint code that resolves `file:line` refs and flags one whose anchor moved | no |
| 19 | `furrow check t-3r4ra 3 --reword` | 「落選 2 件(A/B/C のうち選ばれなかった 2 件)」 is a population count that also NAMES the candidates; the rule's examples are 「3 件分」「両会場分」 | rewrote both halves → 「落選 1 件(A/C のうち選ばれなかった 1 件)」 | nothing; the rule covers it once you read "a row that counts the population" as including named members | no |
| 20 | after t-w65xk's rewrite | t-w65xk stays `waiting` and overdue since 9/24, so `due-overdue` keeps firing on a task I just touched — do I push its date too? | left it: the chase is about A's 書面 and C's silence, not about B | a line of prose: 「B の辞退で触った task の期日は、B が理由でない限り動かさない」 | yes: due-overdue |
| 21 | `furrow vocab lint-codes` | to fill this log's last column I had to enumerate the 53 codes and confirm there is none for a stale candidate label, a stale title quote, or a drifted `file:line` ref | there is none; `furrow lint` on this board reports only `due-overdue` ×4 | nothing — `vocab` answered it; the stop is the protocol's cost | no |
| 22 | `furrow lint --json` | piping `2>&1 \| head` showed only the error envelope, so the findings array looked empty; I re-ran with `2>/dev/null` | stdout really is pure data (the contract says so); my pipe interleaved the streams | nothing; the contract is documented. Cost: one extra command | no |
| 23 | scoping the rewrite | the box e-4shr4's own 前提 (3 candidates) changed — does the epic need a `furrow note`? | no: CLAUDE.md says "the decision task only records why", so t-80nmd carries it | a line of prose naming whether a box's body is part of a drop | no |
| 24 | `furrow board` | I needed to know whether the plan must end with `furrow sync` and a `git commit` for `notes/` | `mode: shared`, so both; `furrow sync` publishes only `.furrow/` | nothing — CLAUDE.md's last bullet says it; `board` confirmed the mode | no |
| 25 | `furrow set t-j5rww --due 2026-09-29` | I did not open `set --help`; I relied on `config.toml`'s comment that "a bare --due date binds the END of that day" in `[due].timezone` | a bare date is accepted and lands 23:59 Asia/Tokyo | nothing; the config comment is the documentation. Cost: a guess I did not verify | no |

## Verdict

could_act_confidently: true — the board names the drop's index (`cand-b`), its
procedure (rewrite in place: retitle, reword, note; never remove), and its
completion check (`ls -l cand-b` empty), so every stop resolved inside the
board without asking the operator; what the plan risks is not correctness but
two style calls (rows 14/15) and one silent reversal I could have missed (row
11).

hesitations: 25
rows answered `yes` in the last column: 2

Most consequential: row 11 — B's exit silently flips C's cutoff clause from
allowed to forbidden on a task that carries no `cand-b` label, so the stated
completion check would pass with the graph's real change unmade; row 2 — the
request's verb ("dispose") points at exactly the two operations the board
forbids (`rm`, `icebox`), and only CLAUDE.md's prose stops a literal reading;
row 8 — whether t-fz6xs closes in the same pass is only decidable by leaving
furrow and reading `notes/venue-compare.md` to see that A's 9 items are done.
