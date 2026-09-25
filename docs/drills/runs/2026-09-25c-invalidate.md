# Drill run — invalidate (candidate B withdraws)

Request handed to the session: "Venue candidate B has withdrawn (double-booked).
Dispose of everything on the board that assumed B: tasks that only made sense for
B, comparisons that included B, and dependencies that ran through it."

## Measured on

- board commit: `6154cea` (akira-toriyama/furrow-test, repo-local store)
- furrow version: `furrow dev` (built from furrow main at `eb85970`); board schema
  v10 / binary v10, writable
- run: 2026-09-25 (Fri), 17:44–17:50 JST (Asia/Tokyo; the due band shifts with the
  calendar, so the same board reads differently on another day)
- session: a Claude Code subagent on Opus, handed only this request, the drill
  rules, the recording format, the repo's `README.md` and `CLAUDE.md`, and the
  board through the `furrow` CLI, the files under `.furrow/`, and `notes/`.
  No `docs/`, no `seed/`, no prior knowledge of this board.
- the operator had already run `furrow sync`; this run never ran it. Read-only:
  nothing on the board was written.

Scope the reads settled: `furrow ls -l cand-b` returns 8 tasks across
backlog/in-progress/ready/waiting (no `done` row); two further tasks name B
without carrying the label (`t-8yac1`, `t-zapdx`, both `done`); no epic body names
B; three files under `notes/` do. No dependency edge on this board is B-specific,
so the request's third clause ("dependencies that ran through it") has no member —
nothing to `dep --rm`.

## Plan

```sh
cd /Volumes/workspace/github.com/akira-toriyama/furrow-test

# ---- 0. scope (these reads were actually run) ----
# furrow ls -l cand-b          # 8 tasks, every lane, no done row
# furrow ls -l cand-a ; furrow ls -l cand-c      # survivors, for the new counts
# furrow show <each of the 8>
# grep -lE '(^|[^A-Za-z])B([^A-Za-z]|$)' .furrow/bodies/*.md   # unlabeled B mentions
# furrow dep <each of the 8> --list              # no B-only edge -> no `dep --rm`
# cat notes/venue-compare.md notes/site-visit-checklist.md notes/venue-inquiry-template.md

# ---- 1. t-q5e6n  inventory A/B (in-progress; survivors' work is already done) ----
furrow retitle t-q5e6n 返信済み A 会場の設備インベントリ 9 項目を埋める
furrow check t-q5e6n 4 --reword "冷蔵庫/冷凍庫の容量を A 分記入"   # population row -> survivors
furrow check t-q5e6n 3 --rm      # B の食器・カトラリー数を記入      (highest index first)
furrow check t-q5e6n 2 --rm      # B のオーブン庫内サイズを電話で聞く
furrow check t-q5e6n 2           # tick the reworded row (its index moved 4 -> 2)
furrow edit t-q5e6n --body - <<'MD'
目的: 献立 epic の制約になる設備を、返信済みの A について数値で押さえる。
完了条件: 9 項目(コンロ口数/オーブン有無と庫内サイズ/冷蔵庫容量/冷凍庫/食器数/カトラリー数/食洗機/作業台長さ/電源口数)が A で埋まる。
現状: A は 9 項目完了(比較表「設備インベントリ 9 項目」の A 列)。
次の一手: なし。A 列は埋まっているので閉じる。
前提: C は未返信のため本 task の対象外。C 分は [[t-f5pva]] で回収する。
逃がし: 担当=自分。会場ごとの部分完了を lane では表せない。
MD
furrow note t-q5e6n "B が候補から外れたため対象を A のみに絞った。B の 2 行と B の未回答前提はここで退役。比較表の B 列は受領済みの値のまま残す。"
furrow label t-q5e6n --rm cand-b      # last write before the close
furrow done t-q5e6n --note "結果: A の設備 9 項目を比較表の A 列に記入済み。B が対象外になったため A のみで完了条件を満たす。B 分は未回収のまま残さない。"

# ---- 2. t-9t7ab  site visit (2 件 -> 1; the count goes, the name stays) ----
furrow retitle t-9t7ab 候補 A を現地下見して搬入経路・エレベーター・台車可否を実測する
furrow check t-9t7ab 4 --rm      # B の下見枠を 10/3 までにもらう
furrow edit t-9t7ab --body - <<'MD'
目的: 図面や写真で分からない搬入動線を実測し、当日の荷物量が通るかを確定させる。
完了条件: A について 経路・階数・エレベーター有無と内寸・台車可否・荷下ろしスペース が写真付きで記録されている。
次の一手: A は 10/1(木) 14:00 に下見アポ済み。当日メジャーと写真で 8 項目を埋める。
固定: A の 10/1(木) 14:00 は先方と合意済みのアポ。日程変更で動かさない。
前提: 搬入荷物はスーツケース 1 + クーラーボックス 2 + 食材コンテナ 2 を想定。実物は仕込み epic の積載([[t-06f99]])で確定するので内寸は余裕を見て測る。
前提: C は未返信のため下見対象外。返信が来ても下見は A の 1 件のままで、C は書面回答だけで [[t-csnqw]] の採点に載せる。
逃がし: 下見は「10/1 14:00 開始・所要 1h」の予定だが、furrow は締切 instant しか持てないため開始日時と所要は body にしか書けない。
MD
furrow note t-9t7ab "B が候補から外れたため下見対象は A の 1 件。B の枠取り行と「下見は A/B の 2 件のまま」の前提は退役。due 10/3 18:00 は元々 B の枠取り期限だが、A の 10/1 は固定アポのため due は動かさない。"
furrow label t-9t7ab --rm cand-b

# ---- 3. t-g5asy  cancellation terms (3 件 -> 2 件) ----
furrow retitle t-g5asy 候補 2 件のキャンセル料段階と延長不可条件を条文で確認して比較表に書く
furrow check t-g5asy 1 --reword "何日前に何 % かを 2 件分記入する"
furrow edit t-g5asy --body - <<'MD'
目的: キャンセル料の発生時期と「22:00 完全撤収・延長不可」を条文で確認し、後から動かせない線を明示する。
完了条件: A/C について キャンセル料の段階・延長の可否と超過料金・原状回復の範囲 が比較表に転記されている。
次の一手: 各社の利用規約ページを開き該当条文を引用で写す。記載が無い項目はメールで一行もらう。
前提: 延長不可は主催側の固定条件として扱う。会場が延長可でも 22:00 で出る。
逃がし: 「キャンセル無料期限」は会場ごとに別日で、決定後に 1 本の締切へ縮む。task 1 件に複数の期限を持てないので候補分は body の表で持つ。
MD
furrow note t-g5asy "B が候補から外れたため対象を A/C の 2 件に縮めた。比較表の B 行は受領済みの値のまま残す。"
furrow label t-g5asy --rm cand-b

# ---- 4. t-4kg8d  BYO alcohol / waste (3 件 -> 2 件; stays in waiting) ----
furrow retitle t-4kg8d 候補 2 件の持ち込み酒可否とゴミ持ち帰り規定を書面で取り付ける
furrow check t-4kg8d 4 --reword "入館可能時刻と事前入館料（15:00 入館の可否）を 2 件分、比較表の「入館可能時刻と事前入館料」節に記入する"
furrow check t-4kg8d 3 --reword "ゴミの持ち帰り/引き取りを 2 件分記入する"
furrow check t-4kg8d 1 --rm      # B の回答(持込料 1,000 円/本)を比較表に転記する  (rm after the rewords)
furrow edit t-4kg8d --body - <<'MD'
目的: 持ち込み酒の可否とゴミ規定を口頭でなく書面(メール本文可)で確定させる。この 2 つは買い出し量と撤収手順の前提になる。
完了条件: A/C それぞれ「持ち込み酒 可/不可(持込料の有無)」「ゴミ 持ち帰り/引き取り」がメール本文で明記された状態。
現状: A は電話で「持ち込み可」と口頭回答済みだが書面が未着。C は未返信。
次の一手: A に「先日の電話の内容を一行メールでください」と依頼する。
前提: 持ち込み不可の会場は候補から落とす(予算上、会場側の酒を買う余地が無い)。
逃がし: 「口頭 OK」と「書面受領」の 2 段階を lane で表せないので checks で代用。2 会場分を 1 task に束ねている。
MD
furrow note t-4kg8d "B が候補から外れたため対象を A/C の 2 件に縮め、B の転記行と「B は書面回答済み」の現状を退役。比較表の B 行は受領済みの値のまま残す。due 9/24 は A の書面化と C の返信の催促日なので動かさない。"
furrow label t-4kg8d --rm cand-b

# ---- 5. t-f5pva  C quote (stays in waiting; only its timeout arithmetic changes) ----
furrow edit t-f5pva --body - <<'MD'
目的: C 会場の見積書と設備回答を取り、A と同じ土俵で比較できる状態にする。
完了条件: C の見積書を受領し、比較表の C 列(料金・設備 9 項目)が埋まっている。可否だけの回答は「あり／なし」で C 列に入れて埋まったとみなし、数値は見積書 PDF を参照先として書く(数値の追加照会は採点に残った候補にだけ行う)。
待ち先: C 会場の問い合わせフォーム宛(9/14 送信、返信期限 9/22 と明記済み)。
現状: 9/22 18:00 に電話で催促済み(担当者不在、折り返し待ち)。due はその催促日。
次の一手: 返信が来たら C 列を埋めて閉じる。回答が [[t-csnqw]] のノックアウト条件に触れたら、閉じる側が C を落とす(cand-c の task を書き直す)。打ち切りは候補が 2 件残る場合に限るという条件により、残る候補が A/C の 2 件になった今、C を打ち切ると 1 件になるため打ち切りはしない。due を延ばして催促を続ける。
前提: 料金は通し料金＋15:00 入館の事前入館料の総額で [[t-csnqw]] のノックアウト③に当てる。見積が総額か事前入館料が別建てかを回答時に確認する。
前提: C は候補中で最安(推定 24,000 円 — 会場費上限 30,000 円＝[[t-mxg58]] の内側)だが設備情報がゼロで、採用可否は未知。
逃がし: 打ち切り期限は due に入れたが、「誰を待っているか」「打ち切ったら何をするか」は body にしか書けない。
MD
furrow note t-f5pva "B が候補から外れ、残る候補は A/C の 2 件。C を打ち切ると 1 件になるため打ち切り条項は発火しなくなった(催促継続に切り替え)。lane と due は据え置き。"
furrow label t-f5pva --rm cand-b

# ---- 6. t-csnqw  the decision task — the ONE task that records why ----
furrow edit t-csnqw --body - <<'MD'
目的: A/C から 1 件を選び、以降の全 epic が乗る前提を固定する。
完了条件: 決定会場と次点、決定理由(設備/費用/搬入/持ち込み酒/キャンセル条件の 5 軸)が比較表に 1 段落で書かれている。
次の一手: 依存 6 件が埋まった時点で 5 軸に重みを付けて採点する。重みは 設備 2・費用 1・搬入 1・酒 1・キャンセル 1。
前提: 採点の前にノックアウト条件で落とす。①オーブン必須（当日仕上げの火入れ料理 [[t-pf9z8]] が会場オーブンを使う）②15 名着席可 ③会場費 30,000 円以内（[[t-mxg58]]。15:00 入館の事前入館料を足した総額で判定する。事前入館料は [[t-4kg8d]] が書面で取り付けて比較表に記入する）④持ち込み酒可（[[t-4kg8d]]。不可だと予算上成立しない）。1 つでも欠ける候補は 5 軸採点に載せずに落とす。
前提: C が [[t-f5pva]] の打ち切り条件に掛かれば残る候補で決める(打ち切りは候補が 2 件残る場合に限る — 1 件に落ちる打ち切りはしない。残る候補が A/C の 2 件になったため、C の打ち切りはもう発火しない。候補が 1 件になったら採点はやめ、その 1 件の採用可否だけを書く)。
逃がし: 決定入力が 6 task に散り dep を 6 本張ったが、「このうち 1 本は欠けてもよい」という条件付き依存を furrow は持てない。
MD
furrow note t-csnqw "候補 B は 2026-09-25 にダブルブッキングで辞退。残る候補は A/C の 2 件。出席が 13 名以上に増えた場合に定員の狭い B を落とすという前提は対象が無くなったため退役。B の辞退は辞退なので落選ではなく、次点・落選理由は残る 2 件だけで書く。"
furrow label t-csnqw --rm cand-b

# ---- 7. t-ynhnk  booking (the decline row counts survivors only) ----
furrow check t-ynhnk 3 --reword "落選 1 件(A/C のうち選ばれなかった 1 件)に断りの一報を送る"
furrow note t-ynhnk "B が候補から外れたため、断りの一報は A/C のうち選ばれなかった 1 件のみ。辞退した B には断りを送らない。"
furrow label t-ynhnk --rm cand-b

# ---- 8. t-0qyaa  cooking-constraint floor (its 前提 says to redraw from survivors) ----
furrow edit t-0qyaa --body - <<'MD'
目的: 献立を「作れる献立」に絞るための物理制約を、数字で1枚にする。
完了条件: コンロ口数 / オーブン / 冷蔵庫容量 / 食器数 / 食洗機 が数値で埋まり、「同時進行できるのは最大N品」「オーブン占有はN分まで」が結論として書かれている。
次の一手: [[t-ec04m]] の確定版インベントリから設備の数値を転記し、[[t-yejfr]] の 15 案に ◯/△/× を付ける。
前提: 会場未確定のうちは着手できない。会場 epic の決定（[[t-csnqw]]）が D-40 を過ぎるなら、候補 A の実数（コンロ 4 口・オーブン 天板 40×33cm 2 段）で先に設計して後から緩める。設備が未回答の C は下限に入れない。
前提: 下限の出どころの候補が落ちたら、残る候補の実数で下限を引き直す。設備が未回答の候補は下限に入れない。
注: 「コンロ2口だから同時調理は2品まで」という資源制約は furrow のモデルに無く、この body の表が唯一の置き場になる。
MD
furrow note t-0qyaa "B が候補から外れたため、共通最小構成 A/B（コンロ 2 口・オーブン 1 段）は A の実数へ引き直した。B の庫内サイズ未回答を理由にした暫定扱いも退役。"
furrow label t-0qyaa --rm cand-b

# ---- 9. the completeness check ----
furrow ls -l cand-b        # must come back EMPTY — that is the check the drop is done
furrow lint                # due-overdue on t-4kg8d/t-f5pva/t-pq4pm/t-wbhsk stays red:
                           # not this session's pick, never snoozed to make lint green
# NOT run, deliberately: `furrow dep ... --rm` — no edge on this board is B-specific
# NOT run, deliberately: `furrow rm` / `set -s icebox` — a drop rewrites in place

# ---- 10. notes/ (hand-kept; furrow sync publishes only .furrow/, so these are committed by hand) ----
# notes/venue-compare.md — its own 運用 line (L5) governs: keep the dropped row and
#   column, put reason+date in 基本情報's 状態 cell, add a dated line under a table
#   that has no 状態 column, and delete a column only in the 5-axis scoring table.
#   L3   quoted title 「返信済み A/B 2 会場の設備インベントリ 9 項目を埋める」 -> 「返信済み A 会場の設備インベントリ 9 項目を埋める」
#   L4   最終更新: 2026-09-24 -> 2026-09-25 (the count 「A/B/C の 3 件」 is a done task's
#        result and is NOT rewritten)
#   L12  基本情報 B row, 状態 cell: 「一次返信あり」 -> 「辞退(ダブルブッキング) 2026-09-25」
#   after L19  add: 「- 2026-09-25: B が辞退。以降の列を埋める候補は A/C の 2 件。」
#   after L33  add: 「- 2026-09-25: B が辞退。B 列は受領済みの値のまま残す。」
#   after L47  add the same dated line (持ち込み酒とゴミ規定 table has no 状態 column)
#   after L58  add the same dated line (入館可能時刻と事前入館料 table)
#   after L69  add the same dated line (キャンセル料と延長条件 table)
#   L40  quoted title 「候補 3 件のキャンセル料段階と…」 -> 「候補 2 件の…」
#   L78-85  delete the B column from the 5 軸採点表 (the one table the 運用 lets you cut)
# notes/site-visit-checklist.md
#   L3   quoted title 「候補 2 件を現地下見して…」 -> 「候補 A を現地下見して…」
#   L4   「対象は候補 2 件（A/B）」 -> 「対象は候補 A の 1 件」
#   after L17  add: 「- 2026-09-25: B が辞退。B 列は空のまま残す。」 (column kept, per the
#        same 運用 applied to this note)
#   L26  「B の枠が 10/3 までに出なければ…」 -> retired by a dated line: 「- 2026-09-25: B 辞退により、
#        搬入軸は A の実測のみで採点する。」
# notes/venue-inquiry-template.md
#   L11  B row, 追跡 cell: 「オーブン庫内サイズと食器数が未回答」 -> 「2026-09-25 辞退(ダブルブッキング)。
#        以降の追跡なし」 (the 返信 cell 「一次返信あり（9/17）」 is a log and stays)
#   L40  quoted title 「候補 3 件のキャンセル料段階と…」 -> 「候補 2 件の…」
#   L3   NOT touched: 「候補 3 件（A/B/C）へ送信済み」 is a done task's result count
```

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow ls -l cand-b` | CLAUDE.md says the drop is `furrow ls -l cand-b` "(every lane, done included)" but names no flag; I did not know whether a bare `ls` hides `done` or the terminal lanes | ran `furrow ls --help` first; a bare `ls` with no `-s` already spans every lane and `-n` defaults to all | a line of prose: "a bare `furrow ls -l cand-x` already spans every lane — there is no `--all`" | no |
| 2 | `furrow ls -l cand-b` (reading the result) | not one `✓` row came back, yet CLAUDE.md's drop rule explicitly covers done tasks ("a drop takes `cand-x` off a done task too") — I could not tell a true absence from a silent narrowing | there are simply no done `cand-b` tasks; the ls help's "a read never narrows silently" backs it | a line of prose in CLAUDE.md: "a candidate label is dropped from done tasks too, when there are any" is already there — what was missing is the board printing "0 done rows matched" | no |
| 3 | `furrow show t-f5pva` | `t-f5pva` is titled 「C 会場から見積書と設備回答を受領して比較表の C 列を埋める」 yet carries `cand-b`; a C-only task looked mislabeled | read the body: its 次の一手 timeout clause counts the SURVIVING candidates, so B's exit rewrites it — the label is correct | a line of prose: "`cand-x` also marks a task whose clause counts the surviving candidates, not only one that names x" | no |
| 4 | mapping the request onto the board | the operator says "tasks that only made sense for B" — which reads as deletion, while CLAUDE.md says a drop "never remove or icebox" | no task on this board is B-only; every one is a population task that shrinks, so the whole request is rewrite-in-place | a line of prose: "「処分/dispose」 never means `rm` or icebox: a drop rewrites, and a task whose survivors are all gone is closed, not removed" (the drop section says it for 落とす but the operator's word here was 'dispose') | no |
| 5 | finding B mentions without the label | CLAUDE.md requires handling "a task with no candidate label whose 前提 names the candidate", but no furrow read finds that: `furrow search B` on a single Latin letter is noise | dropped to `grep -lE '(^\|[^A-Za-z])B([^A-Za-z]\|$)' .furrow/bodies/*.md` and treated it as equivalent | a furrow change: word-boundary matching in `search`/`-q` free text (or a `-w` flag), so a one-letter candidate name is findable without leaving the CLI | no |
| 6 | `furrow show t-8yac1` / `t-zapdx` | two rules collide: "a task with no candidate label whose 前提 names the candidate gets the 前提 retired" vs "A done task's body is history: never rewrite it, never append to it". Both tasks are `done` | the done rule wins — no write at all on either | a line of prose: "the 前提 retirement is for OPEN tasks; a done task's body is history whatever it names" | no |
| 7 | `furrow dep <id> --list` × 8 | the request's third clause is "dependencies that ran through it", and I had no way to ask which edges exist because of a candidate — I read all eight neighborhoods to be sure I cut nothing | no dep edge on this board is B-specific; every edge is a population edge that survives with A/C, so the plan contains no `dep --rm` | a line of prose: "a candidate is a label, never an edge — a drop removes no dependencies" (or `dep --list -l cand-x` as a furrow change) | no |
| 8 | `furrow show t-q5e6n` → `notes/venue-compare.md` | the task's ref is `file:notes/venue-compare.md:20`, but the 設備インベントリ table starts at L21/L23 — the line number points just off the section | treated the ref as approximate and used the section heading as authoritative | a furrow change: refs resolving to a heading/anchor instead of a line number that drifts whenever the note grows | no |
| 9 | before planning `furrow label --rm` | I did not know whether this board constrains its label vocabulary (an allowed set, or `labels_required`) and `furrow config` has no read form | ran `furrow board`: `labels_required: false`, no allow-list printed, so removal is unconstrained | a line of prose naming `furrow board` as the read for label policy (CLAUDE.md never mentions it) | no |
| 10 | `furrow check t-q5e6n …` | `furrow show` prints the checklist rows with no index, and `check` takes a ZERO-based index — I had to open `check --help` and hand-count five rows on four different tasks | display order is index order, 0-based | a furrow change: print the index in `show`'s checklist rows | no |
| 11 | `furrow check t-q5e6n 4 --reword` then `3 --rm` then `2 --rm` | CLAUDE.md gives "highest index first" for removals only; this task needs a reword (row 4), two removals (rows 3, 2) and a tick of the reworded row, whose index moves under the removals | reword at the pre-removal index, then remove highest-first, then tick at the post-removal index (4 → 2) | a line of prose: "do every `--reword` at the pre-removal indexes, then `--rm` from the highest down, then tick" | no |
| 12 | `furrow check t-q5e6n 2` (ticking the reworded 冷蔵庫/冷凍庫 row) | the rule says "a close settles the 完了条件, not the checklist, so a row whose condition never arose stays unticked" — but this row's work DID land for A (the table carries 400L / 80L) while the row is unticked | ticked it, because the table shows the work landed; left the close note silent about it | a line of prose: "tick a row the notes/ table already shows as landed before closing; only a row whose condition never arose stays unticked" | no |
| 13 | `furrow retitle t-q5e6n` | "at one member the count goes and the name stays (候補 A)" fits 候補 3 件 → 候補 A, but this title fuses name and count: 「返信済み A/B 2 会場の…」 | 「返信済み A 会場の設備インベントリ 9 項目を埋める」 — dropped "/B" and the "2", kept 会場 | a line of prose showing the A/B form as a second worked example, not only the 候補 N 件 form | no |
| 14 | `furrow edit t-q5e6n --body -` | `retitle --help` says the title lives in the body's leading `# ` heading too; I was about to write a `# ` heading into the replacement body | checked a raw body file: these bodies have NO leading heading ("a body with no leading heading is left untouched"), so the replacement must not add one | a line of prose: "bodies on this board carry no `# ` heading — a replacement body starts at 目的:" | no |
| 15 | `furrow done t-q5e6n --note` | the label rule sequences "takes `cand-x` off each task as that task's last write (before `done` on a task the drop closes)" — so is the drop's `furrow note` written too, or is the 結果 note the only one? | both: a `furrow note` citing the drop, then `label --rm`, then `done --note` with 結果 | a line of prose: "on a task the drop closes, the drop note and the 結果 are separate writes, the label drop between them" | no |
| 16 | `furrow set t-9t7ab --due` (considered, NOT planned) | `t-9t7ab`'s due 2026-10-03 18:00 IS B's slot deadline — its 固定 line even says "B の 10/3 は自分の締切なので動く" — and the only surviving work is A's 固定 10/1 14:00 appointment. Nothing says whether a drop moves a due that belonged only to the dropped member | left the due and named it in the note; a drop's writes are retitle / reword / note | a line of prose: "a drop never moves a due; a due that belonged only to the dropped member is named in the note, not shifted" | no |
| 17 | `furrow edit t-0qyaa --body -` | its 前提 says to redraw the floor "残る候補の実数で" — but does that mean naming A, or importing A's actual numbers (コンロ 4 口・天板 40×33cm 2 段) from the comparison table into this body? | imported the numbers, since the 前提 says 実数 and the note's A column is complete | a line of prose: "a 前提 that says 実数 takes the survivor's values from the notes/ table, not just the name" | no |
| 18 | `furrow check t-ynhnk 3 --reword` | the row is 「落選 2 件(A/B/C のうち選ばれなかった 2 件)に断りの一報を送る」 — "a dropped candidate is not a 落選: the decline row counts the survivors only" fixes the count, but the row also enumerates A/B/C | rewrote both: 「落選 1 件(A/C のうち選ばれなかった 1 件)に断りの一報を送る」 | a line of prose: an example where the row's enumerated names change with its count, not the count alone | no |
| 19 | `furrow note t-csnqw` | two rules each claim exclusivity for the reason: CLAUDE.md's "the decision task alone records why" and venue-compare.md's 運用 "落ちた理由と日付は基本情報の状態欄にだけ書き" | CLAUDE.md governs TASK bodies, the 運用 governs the note; the reason appears in both places, nowhere else | a line of prose: "the decision task alone records why AMONG TASKS; `notes/` follows its own 運用 line" | no |
| 20 | editing `notes/site-visit-checklist.md` | the "keep the row/column, add a dated line under a table with no 状態 column" 運用 lives only inside `notes/venue-compare.md`; this note has a B column and no such rule of its own | applied venue-compare's 運用 to it (kept the empty B column, added a dated line under the table) | a line of prose under CLAUDE.md's `notes/` section making that 運用 board-wide, or a copy of the 運用 line in every note that carries a candidate column | no |
| 21 | editing `notes/venue-compare.md` L3 | it quotes 「返信済み A/B 2 会場の設備インベントリ 9 項目を埋める」 — a title this pass both retitles AND closes. "A note that copies a body's text follows the body" vs "a task title … it quotes from a done task stays as written" | followed the retitle (it happens while the task is still open); the dated line carries the close | a line of prose: "a quoted title freezes at the moment the task closes — a retitle before the close is followed into the note" | no |
| 22 | editing `notes/venue-compare.md` L4 | 「最終更新: 2026-09-24 … 上限内に収まるのは A/B/C の 3 件」 — the 運用 protects a done task's count from rewriting, but this count sits in the note's own header, not under a done task's bullet | bumped 最終更新 to 2026-09-25, left the count alone, put the new count in the dated line under 基本情報 | a line of prose: the 運用 naming the header line as well as the bullets | no |
| 23 | editing `notes/venue-inquiry-template.md` L11 | "a status cell in one of its tables is updated in place" — but the 送信記録 table's columns are 宛先 / 送信日 / 返信 / 追跡, with no column called 状態 | 追跡 is the status cell; 返信「一次返信あり（9/17）」 is a log of something that happened and stays | a line of prose: "the status cell is the one a task keeps writing — 追跡 here, 状態 in the comparison table" | no |
| 24 | `furrow lint` | two of the eight `cand-b` tasks (`t-f5pva`, `t-4kg8d`) are overdue in `waiting` and red in lint — I could not tell whether the drop owes them a date push, since the drop rewrites exactly those tasks | left both dues; "a session owes only its pick … never snoozed to make lint green", and a chase date is not the drop's business | a line of prose: "a drop never touches a chase due, even on a task it rewrites" | yes: due-overdue |

## Verdict

could_act_confidently: true

Every stop resolved against a rule I could quote from `CLAUDE.md`, a `--help`, or
`notes/venue-compare.md`'s own 運用 line, and the drop came out determinate — 8
tasks rewritten in place, 1 of them closed, 0 dependency edges cut, 3 notes files
edited — but five of the twenty-four (16, 17, 20, 22, 23) were settled with no
governing rule at all, on low-blast-radius lines.

hesitations: 24
lint-caught: 1 of 24 (row 24, `due-overdue`)

Most consequential: row 7 — the request's "dependencies that ran through it" names
a class this board does not have, and guessing the other way would have cut live
edges; row 10 — zero-based checklist indexes with no index printed by `show`, where
an off-by-one deletes the wrong row on four tasks; row 3 — `t-f5pva`'s `cand-b`
label on a C-titled task, whose meaning (the surviving-candidate count) is the one
substantive rewrite a session would otherwise skip entirely.
