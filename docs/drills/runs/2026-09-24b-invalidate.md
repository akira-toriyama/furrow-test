# Drill 4 — invalidate (run 2026-09-24b)

> Venue candidate B has withdrawn (double-booked). Dispose of everything on
> the board that assumed B: tasks that only made sense for B, comparisons
> that included B, and dependencies that ran through it.

## Measured on

- board commit: `49d666c`
- furrow version: `furrow dev`
- run date / local time: 2026-09-24 19:20 +09:00 (Asia/Tokyo)
- session: fresh, no prior context on this board; operator had already synced,
  so this run never called `furrow sync`.

## Plan

Never executed. Reads first, then the writes in dependency order; the
checklist removals are indexed against the shard as read above, so they must
run before any other checklist edit on the same task.

```sh
# --- reads actually run (read-only) ---
furrow brief
furrow ls -e e-jd4kb -n 0
furrow dep --list t-06pzy
furrow lint

# --- 1. the one task whose remaining work was B-only ---
# 完了条件 is "A・B 両方で埋まる"; A is already 9/9, both open items are B's.
furrow done t-53ptf --note "B 会場が重複予約で辞退（2026-09-24 連絡）。本 task の残件（B のオーブン庫内サイズ・B の食器数）はいずれも B 分で、対象母集団は A のみになった。A は 9 項目完了済みのため、生き残った母集団で完了条件を充足とみなして close する。C 分は t-nd5a5 で回収する。"

# --- 2. site visit: A・B の 2 件 -> A の 1 件 ---
furrow check t-vcb9t 4 --rm     # [4] 「B の下見枠を 10/3 までにもらう」
furrow retitle t-vcb9t 候補 1 件を現地下見して搬入経路・エレベーター・台車可否を実測する
furrow note t-vcb9t "B 辞退により下見対象は A のみ。完了条件の「A・B について」は A のみに縮む。B の下見枠取り（10/3 期限）と先方都合待ちは消滅。A は 10/1(木) 14:00 のアポで変更なし。C は未返信のため下見対象外のまま。"

# --- 3. cancellation terms: 候補 3 件 -> 候補 2 件 ---
furrow retitle t-zf8d6 候補 2 件のキャンセル料段階と延長不可条件を条文で確認して比較表に書く
furrow note t-zf8d6 "B 辞退により対象は A/C の 2 件。完了条件の「A/B/C について」は A/C に縮む。B の利用規約確認・キャンセル無料期限の転記は不要。"

# --- 4. drinks / waste rules: 候補 3 件 -> 候補 2 件 ---
furrow check t-0dqt7 1 --rm     # [1] 「B の回答(持込料 1,000 円/本)を比較表に転記する」
furrow retitle t-0dqt7 候補 2 件の持ち込み酒可否とゴミ持ち帰り規定を書面で取り付ける
furrow note t-0dqt7 "B 辞退により対象は A/C の 2 件。B は書面回答済み（持ち込み可・持込料 1,000 円/本、ゴミ規定含む）だったが候補外となったため比較表への転記は不要。事実は記録として本 note に残す。残るは A の書面化依頼と C の返信待ち。"

# --- 5. the decision: A/B/C -> A/C ---
furrow note t-06pzy "B 辞退（2026-09-24、重複予約）により選択肢は A/C の 2 件。前提「出席が 13 名以上に増えた場合は定員の狭い B を落とす」は失効。5 軸採点は A/C で行う。C が未返信のままなら実質 A の単独指名となり、title が約束する「次点」は空欄になる。"

# --- 6. C is no longer droppable: B was the fallback ---
furrow set t-nd5a5 --due 2026-09-26T18:00+09:00
furrow note t-nd5a5 "B 辞退により、本 task の「9/24 までに出なければ C を落として venue-13 を A/B の 2 択に縮める」は成立しなくなった（C を落とすと候補が A の 1 件のみになる）。打ち切りではなく催促へ切り替え、督促期限を 9/26 18:00 に置き直す。"

# --- 7. cross-epic premise that named the A/B pair ---
furrow note t-1r7ak "B 辞退により、前提の「候補2会場の共通最小構成（コンロ2口・オーブン無し）」は成立しない。A（と未返信の C）だけが残るため、先行設計するなら A 単独の設備値を使う。どちらで進めるかは E1 の決定（t-06pzy）に従う。"

# --- 8. a count that lives inside a checklist item ---
furrow check t-czp8y 3 --reword "落選 1 件に断りの一報を送る"
furrow note t-czp8y "B は自ら辞退したため断りの一報は不要。落選連絡の対象は C（採用されなかった場合）の 1 件のみ。"

# --- 9. publish ---
furrow sync
```

Deliberately NOT touched: `t-0n6gq` and `t-7s17t` (both `done`; their 結果
lines name A/B/C and a done body is history), and the downstream
`blocked-by-venue` / `venue-dependent` tasks `t-dtrn6`, `t-j80mp`, `t-3qax0`,
`t-db1ed`, which assume "the decided venue", not B.

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow brief` | The request names "venue candidate B", but no board entity is a candidate — the brief is Japanese and shows tasks only. | That A/B/C are venue candidates living only in prose and in an off-board comparison table. | a line of prose (CLAUDE.md): "会場候補は A/B/C の 3 件。候補は task ではなく比較表の列であり、board 上に実体を持たない" | no |
| 2 | `furrow search B` | A one-letter name is unsearchable: "B" matched BGM, 手伝い B, 手伝いB=ホール, and every 手伝い 2 名 body. | That I had to enumerate B's references by hand across several phrasings instead. | a furrow change: `search` needs a word-boundary / whole-token mode (`--word`), or a regex form. | no |
| 3 | `furrow brief` | `next (3/5 — 2 hidden by -n: 2 ready)` — I could not tell whether a B-specific task was among the hidden rows. | Ran an unplanned `furrow ls -e e-jd4kb -n 0` to see all 20. | a `config.toml` setting: `[next].limit` raised, or the hidden rows' ids named in the stderr note. | no |
| 4 | `furrow ls -e e-jd4kb -a` | Guessed `-a` meant "include closed"; exit 2, `unknown shorthand flag: 'a'`. | Read `ls --help` and learned `ls` already spans every lane, so no such flag is needed. | a furrow change: put the near-miss flags in the validation envelope's `candidates`, as unknown lanes already do. | no |
| 5 | `furrow ls -e e-jd4kb` | Nothing told me which epic is the venue box; `e-jd4kb`'s title is Japanese and `epic ls` shows no slug. | Guessed from 会場と日程を確定する; confirmed only later, when `epic show` revealed `meta: slug = venue`. | a furrow change: render `meta.slug` in `epic ls` rows. | no |
| 6 | `furrow show t-53ptf` | Bodies cite a private id namespace — `venue-03/05/06/13/15/19`, `menu-01/10/11` — that furrow cannot resolve (`furrow show venue-03` → `not-found`, exit 1). | Reconstructed each reference from the words around it, not from the number. | a furrow change: a configurable body-local alias the store resolves, plus a lint code `unresolved-body-ref`. | no |
| 7 | `furrow show t-1r7ak` | The private numbering contradicts itself. Best-fit index order makes `venue-05` = `t-53ptf`, but `t-dtrn6` cites `venue-05` as 契約確定 and `t-jhcpe` cites it as ゴミ規定と原状回復条件; `t-92sfy` cites `venue-19` as the 週次督促 (`t-qzgp6`), while index 19 is `t-n5431`. | That the numbers are unreliable and only the surrounding prose identifies a task — so `venue-03` in `t-1r7ak` means "the equipment inventory", either `t-53ptf` or `t-db1ed`. | same as #6 | no |
| 8 | reading `refs` on `t-0n6gq` / `t-06pzy` / `t-0dqt7` | `refs: file:notes/venue-compare.md` — the 比較表 is the single artifact carrying B's column, i.e. exactly what "comparisons that included B" asks me to edit. | Ran an unplanned `ls` in the repo root: `notes/` does not exist. The comparison clause of the request cannot be executed at all; my plan can only record its intent in notes. | a lint code: `broken-ref` (a `file:` ref whose path is absent from the repo). | no |
| 9 | reading `refs` on `t-1r7ak` | Its ref is `file:.furrow/bodies/venue-03.md:1` — into furrow's own body store, under an id furrow rejects. | A stale placeholder; ignored it. | same as #8 | no |
| 10 | `furrow search "2 会場"` | The board writes the same count both spaced (`2 会場`, `候補 3 件`) and unspaced (`候補2会場`), so my first sweep missed `t-1r7ak` entirely — the one cross-epic B assumption. | Re-ran the search with the unspaced spelling on a hunch. | a furrow change: normalize CJK/ASCII whitespace when matching in `search`. | no |
| 11 | `furrow dep --list t-06pzy` | The request's third clause — "dependencies that ran through it" — has no referent. All 6 edges into the decision are task→task; none names a candidate, so no edge is B-only and none can be removed. | That there is nothing to do here, which is indistinguishable from having missed an edge. | a furrow change: candidates/options are not modelled, so an edge cannot encode one; disposing of an option would need a first-class option entity (or the convention that each candidate gets its own task). | no |
| 12 | `furrow done t-53ptf` | Its 完了条件 is "9 項目が A・B 両方で埋まる" — a condition naming a party that no longer exists. Dispose the task, or amend it? A is 9/9; both open items are B's. | Closed it, asserting the condition against the surviving population, and recorded why in `--note`. Did not retitle first, since a done body is history. | a line of prose (CLAUDE.md): "完了条件 が失効した相手を名指ししている task は、生き残った母集団で充足とみなして close する（書き換えない）" | no |
| 13 | `furrow retitle t-zf8d6` | Two CLAUDE.md rules fire at once and point opposite ways: "A 前提 line that stopped being true is retired with `furrow note` … never by rescoping the task" vs "A title that carries a count (候補 3 件) is retitled when the population changes". A retitle IS a rescope. | Applied both — retitle the count, retire the 前提 by note — reading the count rule as the narrower, later one. | a line of prose (CLAUDE.md): which rule wins when it is the population itself that changed. | no |
| 14 | `furrow note t-zf8d6` | May I rewrite an OPEN task's 完了条件 line that names B ("A/B/C について …")? CLAUDE.md covers 前提 (note) and done bodies (never rewrite), and says nothing about this. | Appended a note stating the narrowed condition; never used `edit --body`. | a line of prose (CLAUDE.md): "本文の 完了条件 が失効したら note で訂正する（`edit --body` では書き換えない）" | no |
| 15 | `furrow check t-vcb9t 4 --rm` | `--rm` takes a zero-based INDEX, and every removal shifts the indices below it. | Read `check --help`, counted indices off `furrow show` by hand, and kept to one removal per task so no reindexing is needed. | a furrow change: let `check --rm` select by item text, and report the surviving indices in the envelope. | no |
| 16 | `furrow check t-0dqt7 1 --rm` | That item records a fact already obtained — "B の回答(持込料 1,000 円/本)" — so deleting it destroys a record, while leaving it leaves a dead step in a 2-candidate task. | Removed the item and carried the fact into the note. | a line of prose (CLAUDE.md): what happens to facts already gathered about a dropped candidate. | no |
| 17 | deciding what "dispose" looks like | Neither CLAUDE.md nor README says how this board drops something. | Found the convention only by reading an unrelated icebox task, `t-twa64`: `icebox` + label `dropped` + body sections 「やらない理由」「復活条件」 — a template that contradicts the 目的 / 完了条件 / 前提 / 次の一手 one CLAUDE.md prescribes. In the end no task needed it (B's withdrawal shrank tasks rather than killing any outright), but I could not know that until I had the convention. | a line of prose (CLAUDE.md): "落とした task は icebox + label `dropped`、body に やらない理由 と 復活条件 を書く" | no |
| 18 | `furrow set t-nd5a5 --due` | `t-nd5a5`'s escape hatch now points at an empty set: "9/24 までに出なければ C を落として venue-13 を A/B の 2 択に縮める". With B gone, dropping C leaves one candidate. Today IS 9/24, and the board carries no "if both fail" branch. | Reversed the plan: do not drop C, push the chase due to 9/26 18:00, and say so in a note. A guess — escalating instead (phone/second venue sweep) is equally defensible. | a furrow change: the fallback population is prose only; furrow has no conditional dep ("this input may be missing") — the same gap `t-06pzy`'s 逃がし already names. | yes: due-overdue |
| 19 | `furrow note t-06pzy` | Its 前提 "出席が 13 名以上に増えた場合は定員の狭い B を落とす" is moot, and its title promises a 次点 that may not exist once the pool is A plus a silent C. | Note only; the title carries no numeral, so I read the retitle rule as not firing. | a line of prose (CLAUDE.md): whether a promise in a title (次点) counts as a "count" for the retitle rule. | no |
| 20 | `furrow check t-czp8y 3 --reword` | "落選 2 件に断りの一報を送る" carries a count inside a CHECKLIST item; CLAUDE.md's retitle rule covers titles only. | Reworded it to 落選 1 件, extending the title rule to checklist items on my own authority. | a line of prose (CLAUDE.md): extend the count rule to checklist items and body tables, not just titles. | no |
| 21 | `furrow note t-1r7ak` | `t-1r7ak` carries `blocked-by-venue`, but that label means "waiting on the venue decision" — it does not distinguish a task that assumed the A/B PAIR from one that merely awaits a winner. Only free-text search separated them. | Treated the label as insufficient and read every `blocked-by-venue` / `venue-dependent` body in full. | a furrow change (or convention): a label per candidate, so a withdrawal is `ls -l venue-b`. | no |
| 22 | closing the plan | The budget-viable pool is now A plus an unresponsive C. Should the disposal FILE a replacement (re-open the 6-candidate sweep)? CLAUDE.md says redo work is a new task with a dep on the one it replaces. | Filed nothing: the request said dispose, not replace, and a drill plan that invents scope is worse than one that flags it. Flagging it here instead. | a line of prose (CLAUDE.md or drills.md): whether an invalidation that shrinks a decision's input set below its threshold must open a task. | no |

## Verdict

`could_act_confidently: false`

The board can be narrowed but not truly cleaned: B exists only as prose,
title counts and checklist items, so the plan is eight `note`/`retitle`/`check`
edits and one `done`, while the two things the request literally asks for —
the comparison table's B column and "dependencies that ran through B" — are
unreachable (the `notes/venue-compare.md` ref points at a file that is not in
the repo, and no dep edge models a candidate at all).

- hesitations: 22
- rows answering `yes` in the last column: 1 (`due-overdue` on `t-nd5a5`)

`furrow lint` on this board reports only `due-overdue` (`t-nd5a5`, `t-qzgp6`)
and `due-today` (`t-0dqt7`, `t-8q9pg`). Of the 22 stops, exactly one is a
thing lint saw: `t-nd5a5`'s passed cutoff, which is the trigger of the branch
B's withdrawal invalidated. Every other stop — the unresolvable `venue-NN`
namespace, the missing ref target, the contradictory count spellings, the
collision between the 前提 rule and the retitle rule — is invisible to lint.
