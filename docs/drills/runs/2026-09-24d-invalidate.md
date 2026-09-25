# Drill run — invalidate (candidate B withdraws)

Request handed to the session:

> Venue candidate B has withdrawn (double-booked). Dispose of everything on
> the board that assumed B: tasks that only made sense for B, comparisons
> that included B, and dependencies that ran through it.

## 1. Measured on

- board commit: `1429073` (`git rev-parse --short HEAD`, matches the protocol's expected value)
- furrow version: `furrow dev` (`furrow version`)
- run date: 2026-09-24 (Asia/Tokyo). The due band shifts with the calendar: on this
  day `t-1j38n` and `t-pvpwd` are due-today and `t-qw8jc` / `t-16hvj` are overdue,
  and 9/24 is itself the cutoff date written into two bodies — the run reads
  differently on any other day.
- run window: 21:36–21:58 JST (start 21:36, end 21:58).
- session: a Claude Code subagent (Opus), handed only the drill request, the
  protocol rules quoted in it, this repo's `README.md` and `CLAUDE.md`, and the
  board (`.furrow/` through the `furrow` CLI, plus `notes/`). `docs/` and `seed/`
  were not opened. The operator had already run `furrow sync`; `furrow brief` was
  the session-start read and `furrow sync` was never run.
- read-only: no furrow write, no `git` write, no edit to any file but this log.

## 2. Plan

What the session would have run, in this order. Never executed.

Three findings shaped it, and they are why the plan looks nothing like a deletion:

1. **There is no task that only made sense for B.** All 7 `cand-b` tasks also
   carry `cand-a` or `cand-c`. C has a C-only chase task (`t-qw8jc`); B has no
   twin, because B replied on 9/17 so no chase task was ever created. Checked the
   hot board (`ls -l cand-b|cand-a|cand-c`, counts reconciled against `stats`:
   11 / 7 / 5 = every labelled task) and the sibling archive store
   (`search B --archived`, `ls --archived` — both empty). So nothing is removed,
   iceboxed, or `rm`ed. Disposal is a rewrite in place.
2. **No dependency edge ran through B.** All 8 dep sets around the venue box were
   listed; every edge into `t-19nfz` is still needed for A (and C). The plan
   changes zero edges.
3. **B's exit collides with C's cutoff, today.** `t-qw8jc`'s 次の一手 and
   `t-19nfz`'s 前提 both say: if C has not replied by 9/24, drop C and decide
   between A and B. Obeying that today, with B gone, leaves one candidate. The
   plan treats the cutoff as void and chases C instead (hesitation 14).

```sh
# every command runs from the board; the shell's cwd resets between calls
cd /Volumes/workspace/github.com/akira-toriyama/furrow-test

# --- 1. t-3e3px: its whole remaining scope was B's two blanks -------------
# A is 9/9 in notes/venue-compare.md; B's オーブン庫内サイズ and 食器数 were the residue.
furrow note t-3e3px '2026-09-24 B 撤退（ダブルブッキング）。完了条件「9 項目が A・B 両方で埋まる」と現状「B はオーブン庫内サイズと食器数が空欄」を撤回する。対象は返信済み A の 1 件のみ。'
furrow check t-3e3px 4 --reword '冷蔵庫/冷凍庫の容量を A 分記入'   # was 両会場分 — A's half must survive
furrow check t-3e3px 3 --rm                                        # B の食器・カトラリー数を記入
furrow check t-3e3px 2 --rm                                        # B のオーブン庫内サイズを電話で聞く
furrow retitle t-3e3px '返信済み A 1 会場の設備インベントリ 9 項目を埋める'
furrow label t-3e3px --rm cand-b
furrow done t-3e3px --note '結果: A の 9 項目は比較表に記入済み。B が撤退し対象外となったため残件は消滅。C 分は [[t-qw8jc]] が回収する。'

# --- 2. t-g61ny: site visit population 2 -> 1 ----------------------------
furrow note t-g61ny '2026-09-24 B 撤退。前提「下見は A/B の 2 件のまま」を撤回。下見対象は A のみ。C は書面回答だけで [[t-19nfz]] の採点に載せる方針は維持する。'
furrow check t-g61ny 4 --rm                                        # B の下見枠を 10/3 までにもらう
furrow retitle t-g61ny '候補 1 件を現地下見して搬入経路・エレベーター・台車可否を実測する'
furrow set t-g61ny --due 2026-10-01T18:00                          # 10/3 was B's slot deadline; A's appointment is 10/1 14:00
furrow label t-g61ny --rm cand-b

# --- 3. the two 候補 3 件 tasks -> 2 件 (A/C) ----------------------------
furrow note t-rdw97 '2026-09-24 B 撤退。完了条件の対象は A/C の 2 件。B の条文（無料期限 21 日前・延長 30 分 5,000 円・グリストラップ清掃）は転記不要。'
furrow check t-rdw97 1 --reword '何日前に何 % かを 2 件分記入する'
furrow retitle t-rdw97 '候補 2 件のキャンセル料段階と延長不可条件を条文で確認して比較表に書く'
furrow label t-rdw97 --rm cand-b

furrow note t-1j38n '2026-09-24 B 撤退。現状「B は書面回答済み」を撤回。残りは A の書面化依頼と C の回答待ちの 2 件。'
furrow check t-1j38n 4 --reword '入館可能時刻と事前入館料（15:00 入館の可否）を 2 件分、比較表の「入館可能時刻と事前入館料」節に記入する'
furrow check t-1j38n 3 --reword 'ゴミの持ち帰り/引き取りを 2 件分記入する'
furrow check t-1j38n 1 --rm                                        # B の回答(持込料 1,000 円/本)を比較表に転記する
furrow retitle t-1j38n '候補 2 件の持ち込み酒可否とゴミ持ち帰り規定を書面で取り付ける'
furrow label t-1j38n --rm cand-b

# --- 4. decision + booking ----------------------------------------------
furrow note t-19nfz '2026-09-24 B 撤退。前提「出席が 13 名以上に増えた場合は定員の狭い B を落とす」は失効。前提「C が 9/24 までに返信しなければ A/B の 2 択で決める」も失効（B が無く 2 択が成立しない）。ノックアウト条件と 5 軸採点は A/C の 2 件に対して行い、C が落ちれば A の単独指名になる。dep 6 本はいずれも A か C のために残すので変更しない。'
furrow label t-19nfz --rm cand-b

furrow note t-cfqge '2026-09-24 B 撤退。断りの一報は落選 1 件ぶん（A/C のうち選ばれなかった 1 件）。B は先方からの撤退連絡があるため不要。'
furrow check t-cfqge 3 --reword '落選 1 件(A/C のうち選ばれなかった 1 件)に断りの一報を送る'
furrow label t-cfqge --rm cand-b

# --- 5. t-52bk3: the provisional floor WAS B's spec ----------------------
furrow note t-52bk3 '2026-09-24 B 撤退。前提の暫定最小構成「コンロ 2 口・オーブン 1 段＝A/B の下限」は失効（下限は B の数値だった）。決定が D-40 を過ぎる場合の暫定設計は A の実値（コンロ 4 口・オーブン 天板 40×33cm 2 段・冷蔵 400L・冷凍 80L・食洗機あり・作業台 3.6m）で行う。「[[t-3e3px]] の回答が来たら見直す」も消滅。'
furrow label t-52bk3 --rm cand-b

# --- 6. the C cutoff that assumed an A/B fallback ------------------------
furrow note t-qw8jc '2026-09-24 B 撤退。次の一手の「9/24 までに出なければ C を落として [[t-19nfz]] を A/B の 2 択に縮める」は失効：B が無いので C を落とすと候補が A 1 件になる。打ち切らず督促に切り替える。'
furrow set t-qw8jc --due 2026-09-27T18:00   # waiting lane: the due is the chase date

# --- 7. the comparisons (hand-written, outside furrow) -------------------
# notes/venue-compare.md
#   - 状態 / 最終更新 に「2026-09-24 B 撤退（ダブルブッキング）」を 1 行足す
#   - 基本情報（候補 6 件）: B の 状態 を「ダブルブッキングで撤退」に。行は残す(D/E/F と同じ扱い)
#   - 「上限内かつ 15 名着席可かつ調理可は A/B/C の 3 件」→「A/C の 2 件」(2 か所)
#   - 設備 9 項目 / 持ち込み酒とゴミ / 入館可能時刻 / キャンセル料 / 5 軸採点:
#     B 列を削除（候補外は以降の節に列を持たない = D/E/F の前例）
# notes/site-visit-checklist.md
#   - 「対象は候補 2 件（A/B）」→「対象は候補 1 件（A）」
#   - 表の B 列を削除、メモの「B の枠が 10/3 までに出なければ…」行を削除
# notes/venue-inquiry-template.md
#   - B の行の状態に「2026-09-24 撤退（ダブルブッキング）」を追記（done task の成果物なので行は消さない）
# done bodies (t-1swgk, t-3nc93) name A/B/C and are NOT touched: a done body is history.

# --- 8. dependencies: no change -----------------------------------------
# Verified with dep --list on t-3e3px t-g61ny t-rdw97 t-1j38n t-qw8jc t-19nfz
# t-cfqge t-52bk3. No edge existed for B alone. t-52bk3's body names [[t-3e3px]]
# as a handoff with no edge — CLAUDE.md would call that a missing edge, but its
# only reason was B's unanswered oven size, so it is retired in the note above
# rather than added.

# --- 9. verify ----------------------------------------------------------
furrow ls -l cand-b          # expect: (no tasks)
furrow show t-3e3px t-g61ny t-rdw97 t-1j38n t-cfqge t-19nfz t-52bk3 t-qw8jc
furrow lint                  # expect: due-overdue t-16hvj only, t-qw8jc cleared
furrow sync
```

## 3. Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | before `furrow brief` | README points at `docs/drills.md` (the protocol) and `docs/drills/runs/` (sibling logs); both are off-limits, so I had no protocol text and no example of the log's shape | Took the section list in the request as the whole spec | a line of prose: "the run log's sections are exactly the four the request lists; docs/drills.md adds nothing a run needs" | no |
| 2 | `furrow ls -l cand-b` | CLAUDE.md promises "a withdrawal is `furrow ls -l cand-b`". 7 rows came back, but I could not tell whether done/icebox rows were hidden — and a B-only task would most likely be one of those | Ran `ls -l cand-a`, `ls -l cand-c` and `stats` unplanned, reconciled 11/7/5 against the label counts, concluded no lane was hidden | a line of prose in CLAUDE.md: "`ls -l` spans every lane, done and icebox included" | no |
| 3 | `furrow search "B 会場"` | C has a C-only chase task (`t-qw8jc`); by symmetry I expected a B twin and found none. Absence could mean "never existed" or "I searched wrong" | B replied 9/17 so no chase task was ever created; the B-only set is empty | a line in `notes/venue-compare.md`'s 状態: which candidates still have an outstanding chase task | no |
| 4 | `furrow search B` | The bare letter matched ~40 bodies on substring (every "B" inside other words); nothing in the output separated a candidate reference from noise | Read all 40 rows by hand | a furrow change: `search` takes only a case-insensitive substring — a word-boundary or regex mode would have made one query decisive | no |
| 5 | `furrow epic ls && furrow lint && furrow stats` | `lint` exits 2 when it reports an error, which aborted my `&&` chain, so `stats` silently never ran | Re-ran `stats` alone | a line of prose: "`furrow lint` exits 2 on any error — never chain reads behind it with `&&`" | no |
| 6 | `furrow ls -l dropped` (unplanned) | Before picking a verb I needed the board's precedent for "this stopped being real". CLAUDE.md prescribes note/retitle/`check --rm` for a candidate but never says whether anything gets iceboxed or removed | Found `dropped` = icebox + label, used only for *scope* drops (menu ideas). Guessed a withdrawn candidate never removes or iceboxes a task | a line in CLAUDE.md's candidate rule: "a withdrawn candidate rewrites tasks in place; it never removes or iceboxes one" | no |
| 7 | `furrow show t-3e3px` | CLAUDE.md's retirement rule names 前提 lines. `t-3e3px`'s B facts live in 完了条件 and 現状; its only 前提 (about C) is still true, so the rule literally does not reach this task | Treated 完了条件 and 現状 the same as 前提 | a line of prose: "A 完了条件 or 現状 line that stopped being true is retired the same way as a 前提" | no |
| 8 | `furrow show t-3e3px` | With A at 9/9 and B's two blanks gone, the task has no remaining work. CLAUDE.md says a rewritten task "keeps its scope" — it does not say a shrunken task may already be complete, and this is the only `in-progress` task | Closed it with `done --note` after the retitle | a line of prose: "if the surviving population's work is already finished, close the task in the same pass" | no |
| 9 | `furrow show t-3e3px` | Checklist row 4 "冷蔵庫/冷凍庫の容量を**両会場分**記入" is neither A's nor B's. The prescribed verb (`check --rm`) would have destroyed A's half | Ran `furrow check --help` unplanned, found `--reword` — a flag CLAUDE.md never mentions — and reworded instead | CLAUDE.md naming `--reword` beside `--rm` in the candidate rule: a mixed row is reworded, not removed | no |
| 10 | `furrow show t-g61ny` | Its 前提 says C stays paper-only "even if it replies" — a rule written when two site visits existed. With the field now A/C, does C get a visit, so the 搬入 axis is scored on more than one candidate? | No: kept the 前提, retitled to 候補 1 件, and left the 搬入 axis scored on A alone | a line of prose in the body: whether "C は書面回答だけ" survives the field shrinking to two | no |
| 11 | `furrow show t-g61ny` | The due 2026-10-03 18:00 existed only for the row I was removing ("B の下見枠を 10/3 までにもらう"); A's appointment is 10/1 14:00. CLAUDE.md says every due derives from `event_date`, and both dates are D-N of 11/21, so the rule does not decide it | Pulled it to 2026-10-01T18:00 | a line of prose: "a due whose only referent was a removed checklist row is pulled to the surviving work's date" | no |
| 12 | `furrow show t-rdw97` | No row here is B-specific at all — the population sits *inside* rows ("何日前に何 % かを **3 件分**記入する"). The prescribed `check --rm` had no target, so the rule produced no action on a task that plainly needed one | `--reword` each counting row to 2 件分 | same as 9: CLAUDE.md naming `--reword` for rows that count a population | no |
| 13 | `furrow show t-1j38n` | Its 現状 "B は書面回答済み" is now false, in a **live** body. The freeze rule covers only *done* bodies, and the retirement verb is `furrow note`, not an edit — so following the rule leaves a false sentence standing above my note | Appended the note, left the 現状 line untouched | a line of prose: whether a live body's false line is edited or only annotated | no |
| 14 | `furrow show t-qw8jc` | The collision. `t-qw8jc`'s 次の一手 and `t-19nfz`'s 前提 both say "if C has not replied by 9/24, drop C and decide between A/B" — and today is 9/24. With B withdrawn, obeying either sentence leaves exactly one candidate, i.e. sole-sourcing the venue on the same day two candidates vanish | The cutoff assumed an A/B fallback that no longer exists, so it is void: keep C, chase it, keep `t-19nfz`'s dep on `t-qw8jc`, and do not cut anything | a line of prose in `t-qw8jc`'s body: "この打ち切りは A/B の 2 択が残っている前提。候補が 1 件に減る場合は打ち切らず督促する" | no (lint reports `t-qw8jc` only as `due-overdue`, not the void cutoff) |
| 15 | `furrow set t-qw8jc --due …` | If C is chased rather than dropped, the chase date must move — to what? The board carries no basis for a new chase date | 2026-09-27T18:00, aligning with `t-3e3px`'s original due | already there: lint's `due-overdue` names the fix (`furrow set t-qw8jc --due +1d`) | yes: due-overdue |
| 16 | `furrow show t-52bk3` | Its 前提 pins the provisional minimum spec to "コンロ 2 口・オーブン 1 段＝A/B の下限" — those are *B's* numbers. B's exit **loosens** a constraint that 7 downstream tasks read (`t-n5n7w`'s dishwasher branch, `t-6bn1n`, `t-mamd8`, …). Is loosening part of "dispose of everything that assumed B"? | Yes for `t-52bk3` (noted, with A's real numbers written in), no for the 7 downstream tasks: they branch on `t-52bk3`'s result, not on B | a line of prose: how far downstream a retired 前提 is chased | no |
| 17 | `furrow dep --list` sweep (8 tasks) | The request's third clause — "dependencies that ran through it" — has no answer in the graph: not one edge existed for B alone. I re-read the request, then re-checked `t-52bk3`'s body, which names `[[t-3e3px]]` as a handoff with no edge (CLAUDE.md: "a handoff a body names without an edge is a missing edge: add it") | Zero dep changes, and do **not** add that edge — its only reason was B's unanswered oven size, so it is retired rather than created | a furrow change: a dep edge carries no reason, so "this edge exists because of candidate B" has nowhere to live and nothing to invalidate | no |
| 18 | `grep` over `notes/` | `notes/venue-inquiry-template.md` is marked 確定 and is the artifact of a **done** task (`t-3nc93`), and it carries a B row. CLAUDE.md freezes done *bodies*; it says nothing about the note files those tasks produced | Notes are living (add a dated status), done bodies stay frozen — accepting that `venue-compare.md`'s "A/B/C の 3 件" will diverge from `t-1swgk`'s frozen 結果 | a line in CLAUDE.md: "notes/ are living documents; a done task's body is frozen, its note file is not" | no |
| 19 | editing `notes/venue-compare.md` | Does B's row get deleted or kept with a 候補外 status? The file's own precedent is split: D/E/F keep their 基本情報 rows with a reason, and are absent from every later table | Same shape for B: keep the 基本情報 row marked ダブルブッキングで撤退, delete B's column from the other five tables | a line of prose in the file's 状態 stating that convention | no |
| 20 | `furrow label t-3e3px --rm cand-b` | Does the label come off? CLAUDE.md defines `cand-b` as marking the tasks "whose plan is rewritten if that candidate drops out" — so after the rewrite, leaving it makes `ls -l cand-b` keep answering "7 tasks still assume B" to the next session, while removing it drops the only index of what the withdrawal touched | Removed it from all 7; the record lives in each task's note | one sentence in CLAUDE.md's candidate rule: whether the label is cleared on withdrawal or kept as history | no |
| 21 | `furrow retitle t-3e3px` | "返信済み A/B 2 会場" → "A 1 会場" or just "A 会場"? CLAUDE.md's example (候補 3 件 → 2 件) keeps a count, but "1 会場" reads oddly | Kept the count form: "返信済み A 1 会場の…" | a line of prose showing the retitle when a population drops to one | no |
| 22 | `furrow show t-1swgk`, `furrow ls -q 'checks>0'` (both unplanned) | I was about to tick `t-3e3px`'s surviving rows before closing it, then doubted whether ticks mean anything here. A **done** task (`t-1swgk`) is 0/4, and no task on the board has a single ticked row | Checklists carry no progress on this board; close without ticking | `furrow done --help`, which says it outright ("A close settles the TASK, not its checklist: unticked items neither block nor warn") — I had not read it before spending two reads on the question | no |
| 23 | `furrow show t-cfqge` | Row 3 "落選 2 件(A/B/C のうち選ばれなかった 2 件)に断りの一報を送る" counts a population that is still moving: B withdrew (needs no rejection), and if C is later dropped the count falls to 0 and the row dies | Reworded to 落選 1 件 (A/C), knowing it may need rewording again | a furrow change: a checklist row cannot derive a count, so every population change edits row text by hand | no |
| 24 | `furrow set --help`, `note --help`, `done --help` (unplanned) | I did not know the literal `--due` absolute format, and could not write the close step without knowing whether `done` refuses on unticked checks | Read all three helps in one extra round trip | nothing — this is what `--help` is for; recorded because it was an unplanned stop | no |
| 25 | writing this log | The output path is inside `docs/`, the tree I was told not to open: I could not look at a sibling run log, and had to `mkdir -p` the directory blind | Wrote the four sections in the request's order and nothing else | a line of prose giving the log skeleton, so the writer never needs the directory it writes into | no |

## 4. Verdict

- `could_act_confidently: false`
- Why: two of the request's three clauses turned out empty on this board (no
  B-only task, no B-only dep edge) while the disposal that actually matters is
  hand-written prose in `notes/` outside furrow — and the one live decision B's
  exit forces, whether C's 9/24 cutoff still stands, is written on the board twice
  in words that B's withdrawal makes self-contradictory, with nothing to settle it.
- hesitations: 25
- rows where `furrow lint` catches it: 1 (row 15, `due-overdue`)
