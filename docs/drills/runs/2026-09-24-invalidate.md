# Drill 4 — invalidate

> Venue candidate B has withdrawn (double-booked). Dispose of everything on
> the board that assumed B: tasks that only made sense for B, comparisons
> that included B, and dependencies that ran through it.

## Measured on

- board commit: `ce5f326`
- furrow version: `furrow dev`
- run date / local time: 2026-09-24 18:55 +09:00 (Asia/Tokyo)
- session: fresh, no prior context on this board; read-only (`furrow sync` not
  run — the operator had already synced)

## Plan

Never executed. Write commands were only read through `--help`.

```sh
# 0. orient
furrow sync && furrow brief

# 1. record the withdrawal once, on the task that owns the candidate set
furrow note t-06pzy "2026-09-24: 候補 B がダブルブッキングで辞退。以降の候補は A と C(未返信)の 2 件。
「出席 13 名以上なら定員の狭い B を落とす」条件は消滅。C の打ち切り条件は保留(B 離脱で C が唯一の代替)。"

# 2. equipment inventory: B was the only work left (body says A is 9/9 done)
furrow check t-53ptf 3 --rm          # 「B の食器・カトラリー数を記入」
furrow check t-53ptf 2 --rm          # 「B のオーブン庫内サイズを電話で聞く」(remove the higher index first)
furrow check t-53ptf 4 --reword "A の冷蔵庫/冷凍庫の容量を記入"   # was 「両会場分」; index is 2 after the two removals
furrow retitle t-53ptf 返信済み A 会場の設備インベントリ 9 項目を埋める
furrow done t-53ptf --note "B 辞退により残件は消滅。A の 9 項目は完了済みのため close。C 分は t-nd5a5 で回収する。"

# 3. site visit: two candidates become one
furrow check t-vcb9t 4 --rm          # 「B の下見枠を 10/3 までにもらう」
furrow retitle t-vcb9t 候補 A を現地下見して搬入経路・エレベーター・台車可否を実測する
furrow set t-vcb9t --due 2026-10-01 --effort 2
furrow note t-vcb9t "B 辞退により下見対象は A のみ。10/1(木) 14:00 のアポで完結する。"

# 4. the two rule-gathering bundles shrink from A/B/C to A/C
furrow check t-0dqt7 3 --reword "ゴミの持ち帰り/引き取りを 2 件分記入する"
furrow check t-0dqt7 1 --rm          # 「B の回答(持込料 1,000 円/本)を比較表に転記する」
furrow retitle t-0dqt7 候補 2 件の持ち込み酒可否とゴミ持ち帰り規定を書面で取り付ける
furrow note t-0dqt7 "B 辞退。残りは A(電話回答の書面化待ち)と C(未返信)。B の持込料回答は比較表から落とす。"
furrow retitle t-zf8d6 候補 2 件のキャンセル料段階と延長不可条件を条文で確認して比較表に書く
furrow note t-zf8d6 "B 辞退により対象は A/C の 2 件。B の条文は比較表から落とす。"

# 5. the decision task: no dep edge is removed — see hesitation 6.
#    t-06pzy's only B-carrying dep was t-53ptf, and closing it in step 2
#    satisfies the edge. Only the B-shaped prose and checklist text change.
furrow check t-06pzy 0 --reword "A/C の 5 軸採点表を body に書く"

# 6. C is now the only alternative to A: do not cut it off today, chase it
furrow set t-nd5a5 --due 2026-09-26 --value 5
furrow note t-nd5a5 "B 辞退により C は唯一の代替候補。9/24 の打ち切り条件は取り消し、電話督促に切り替える。"

# 7. booking task counted three candidates
furrow check t-czp8y 3 --reword "落選 1 件に断りの一報を送る"

# 8. verify
furrow lint
furrow show t-06pzy t-53ptf t-vcb9t t-zf8d6 t-0dqt7 t-nd5a5 t-czp8y
furrow sync
```

Done tasks that name B in their bodies (`t-0n6gq`, `t-7s17t`) are deliberately
left untouched: they are the historical record of how the shortlist was built.

## Hesitations

| # | stage | what stopped you | what you guessed | what would have removed it | lint catches it? |
|---|---|---|---|---|---|
| 1 | `furrow brief` | The request names "venue candidate B", but nothing on the board is titled, labelled, or identified as B; the letter only appears inside prose. | That B is the second of the A/B/C shortlist recorded in `t-0n6gq`'s body ("上限 30,000 円に収まるのは A/B/C の 3 件"). | A furrow change: no first-class place exists for an external option (a candidate) that several tasks compare, so the letters live in prose only. | no |
| 2 | `furrow brief` | `next` printed "3/5 — 2 hidden by -n", so the orient read did not show the whole venue epic. | That the hidden two mattered; ran an unplanned `furrow ls -e e-jd4kb -n 0`. | A `config.toml` setting: `[next].limit` raised for this board. | no |
| 3 | `furrow search B` | A bare one-letter search is unusable — it matched 手伝い B, BGM, and every Latin B in the board. | That phrase searches would find them all; invented and ran 7 extra searches (`A/B/C`, `A・B`, `A/B`, `B 会場`, `候補 B`, `B の`, `B社`), of which 3 returned nothing. | A furrow change: `search` has no word-boundary or regex mode, and no field-scoped (title-only) mode. | no |
| 4 | after those searches | Nothing tells me the mention list is complete: B is written `A/B/C`, `A・B`, `A/B`, `B の` — four spellings, no label, no shared ref. | That the 8 tasks found (`t-0n6gq`, `t-7s17t`, `t-53ptf`, `t-vcb9t`, `t-zf8d6`, `t-0dqt7`, `t-nd5a5`, `t-06pzy`) are all of them. | A line of prose: "候補 X に触れる task は label `cand-X` を付ける". | no |
| 5 | `furrow ls -e e-jd4kb -n 0` | "Tasks that only made sense for B" — there are none. Every B task is a shared A/B or A/B/C bundle, so there is nothing to `rm`, only text to edit. | That "dispose of" here means edit-in-place and close, not delete. | A line of prose in the request; or a furrow change letting one task carry per-candidate sub-state (the bodies of `t-53ptf` and `t-0dqt7` both complain about exactly this). | no |
| 6 | `furrow dep t-06pzy --list` | "Dependencies that ran through it" — no dep edge is B-specific. All six edges into `t-06pzy` are task→task; B exists only inside bodies and checklist text. | That the B-carrying dependency is `t-06pzy → t-53ptf` (the A/B inventory) and that closing `t-53ptf` satisfies it, so no edge is removed. | A furrow change: a dep cannot be qualified by what it is waiting on, so "this edge exists because of B" is unrepresentable. | no |
| 7 | `furrow show t-53ptf` | Body says 「A は 9 項目完了。B は…空欄」 but all five checklist boxes are unchecked, including A's two. The two records contradict each other, and whether dropping B makes the task closeable depends on which one is true. | That the body wins and A is complete, so the task closes. | A furrow change: nothing reconciles a checklist against the body; `reconcile-gap` only watches deps. Evidence lint is silent: `t-0n6gq` and `t-7s17t` are `done` with 4 unchecked items each and lint reports nothing. | no |
| 8 | planning `furrow check t-53ptf --rm` | Indices are zero-based and shift after each removal; `check --help` documents the index but never says it shifts. Stopped to re-read the help and re-order my two removals. | That removing the higher index first (3, then 2) is correct. | A furrow change: `check --rm` by item text, or stable per-item ids. | no |
| 9 | planning the comparison-table edit | "Comparisons that included B" points at `notes/venue-compare.md` through refs on 4 tasks — and that file does not exist in this checkout (the repo holds only `README.md`, `docs/`, `glyph.toml`). The artefact the request asks me to fix is not reachable. | That the table lives outside the repo, so B's withdrawal can only be recorded on the board via `note`. | A lint code for dangling `file:` refs — `asset-missing` covers assets only and did not fire on these. | no |
| 10 | `furrow revisit --json` | `t-1r7ak`'s ref is `file:.furrow/bodies/venue-03.md:1`, but bodies are named `bodies/<id>.md` (confirmed in `show --json`: `"body": "bodies/t-53ptf.md"`), so this ref can never resolve. | That it means the inventory task `t-53ptf`. | The same dangling-`file:`-ref lint code as row 9. | no |
| 11 | reading the bodies | Bodies cross-reference tasks by slug ordinal (`venue-03`, `venue-05`, `venue-13`), the epic exposes only `meta: slug = venue`, and no per-task ordinal is shown anywhere. Ran an unplanned `furrow ls -e e-jd4kb --json` sorted by `created` to reverse it — and the result contradicts the bodies (created-order makes `venue-06` = `t-vcb9t`, while `t-53ptf`'s body means `t-nd5a5`; created-order makes `venue-13` = `t-czp8y`, while `t-czp8y`'s own body means `t-06pzy`). `venue-05` is used for the contract, the rubbish rules and the equipment table in three different bodies. | That the slug references are unreliable, and that I will not rewrite or follow any of them. | A furrow change: expose each task's slug ordinal in `show`, or make cross-references `[[t-id]]` links, which `dangling-link` already validates. | no |
| 12 | planning `furrow set t-vcb9t --due` | With B gone the visit is A-only, and A's appointment is 10/1 14:00 — but the task's due is tomorrow, 2026-09-25, which was the pressure from B's unbooked slot. Stopped to decide whether the date should move. | That the due moves to 2026-10-01. | A furrow change: the body itself says a start time + duration cannot be held ("furrow は締切 instant しか持てない"), so the due is doing two jobs. | no |
| 13 | planning `furrow retitle` | Three titles hard-code the candidate count (`候補 3 件` ×2, `A/B 2 会場`). Dropping B falsifies the titles, and nothing says whether titles are meant to be maintained or are just the original framing. | That titles are maintained, so all three are retitled. | A line of prose: "件数を含む title は母集団が変わったら retitle する". (`title-scope-marker` exists as a code but does not fire on counts.) | no |
| 14 | planning `t-06pzy` | `t-06pzy`'s body holds two now-void rules — 「C が 9/24 までに返信しなければ A/B の 2 択で決める」 and 「出席 13 名以上なら定員の狭い B を落とす」 — and today IS 9/24 with C still silent (`t-nd5a5` overdue since 9/22). B's withdrawal and C's cut-off collide on the same day: applying both leaves exactly one candidate. The board carries no rule for that collision. | That C's cut-off is suspended, since B's exit makes C the only alternative to A; pushed `t-nd5a5`'s due instead of dropping it. | Nothing removes the judgement, but the signal did reach me: lint reported the overdue C task. | yes: `due-overdue` |
| 15 | planning `t-06pzy` | With B out the pool is A plus an unanswered C. `t-0n6gq` records 「15 名着席可は 4 件、上限 30,000 円に収まるのは A/B/C の 3 件」 — so a fourth seating-capable candidate exists but is over budget. Whether it should be reconsidered is a real question and the board does not carry the candidate itself, only the counts. | That I do not reopen the search; I record the option in the note on `t-06pzy` and leave the decision to the operator. | Board data: the rejected candidates are counted but never named, so there is nothing to reopen. | no |
| 16 | planning `furrow done t-53ptf` | Could not tell whether `done` refuses a task with unchecked checklist items, and writes are forbidden so I could not test. `done --help` does not say. | That it closes anyway, and that `done-unclosed` does not cover this — confirmed indirectly: `t-0n6gq` and `t-7s17t` are already `done` with unchecked items and lint is silent. | A furrow change: `done --help` should state what it does with an incomplete checklist. | no |
| 17 | planning `t-czp8y` | Its checklist says 「落選 2 件に断りの一報を送る」 — a count that assumed three candidates. Whether a candidate that withdrew still needs a rejection note is a judgement the board does not carry. | That B does not need one, so the item becomes 1 件. | A line of prose; or the same per-candidate modelling as row 5. | no |
| 18 | reviewing the done tasks | `t-0n6gq` and `t-7s17t` both state "A/B/C" as fact in their bodies. Stopped to decide whether "dispose of everything that assumed B" reaches the historical record. | That closed bodies are history and are not rewritten. | A line of prose: "done の body は履歴。事実が変わっても書き換えない". | no |
| 19 | final review | Nothing on the board names B's capacity, price, or address, so I cannot check that the surviving pair (A, and an unanswered C) still satisfies the two constraints the shortlist was cut on: 15 seats and ≤30,000 JPY. | That A satisfies both, because it was shortlisted on exactly those axes. | Board data / the row-1 furrow change: candidate attributes live only in a comparison file that is not in the repo. | no |

## Verdict

`could_act_confidently: false`

The board tells me B exists only through four spellings of a single letter in
free prose, the comparison table that "included B" is a `file:` ref to a
document absent from the checkout, and no dependency edge is B-specific — so
every disposal decision was inference over text, not a read of board state,
and one of them (whether to also drop C today) changes the whole shape of the
epic.

- hesitations: 19
- lint caught: 1 (row 14, `due-overdue`)

## Disposition summary

| task | lane after | how |
|---|---|---|
| `t-53ptf` | done | two B checklist items removed, one reworded, retitled to A-only, `done --note` |
| `t-vcb9t` | ready (unchanged) | B checklist item removed, retitled to A-only, due moved 09-25 → 10-01 |
| `t-0dqt7` | waiting (unchanged) | B checklist item removed, count reworded, retitled 3 件 → 2 件, note |
| `t-zf8d6` | ready (unchanged) | retitled 3 件 → 2 件, note |
| `t-06pzy` | backlog (unchanged) | withdrawal note, scoring checklist item reworded to A/C; no dep removed |
| `t-nd5a5` | waiting (unchanged) | cut-off suspended: due pushed to 09-26, value raised, note |
| `t-czp8y` | backlog (unchanged) | 「落選 2 件」 checklist item reworded to 1 件 |
| `t-0n6gq`, `t-7s17t` | done (untouched) | historical record, deliberately not rewritten |
