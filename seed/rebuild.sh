#!/bin/sh
# seed/rebuild.sh — regenerate the live board from seed/. Every id changes, so a
# drill run on the result is a new baseline (docs/drills.md). Boxes come from
# epics.ndjson (add, then deps by title, then the active one), tasks from
# tasks.ndjson in one `add --batch`. config.toml and meta.json are kept; the
# staged deletions and the new shards ride `furrow sync` together.
set -eu
cd "$(dirname "$0")/.."
git rm -rq .furrow/tasks .furrow/bodies .furrow/epics
mkdir -p .furrow/tasks .furrow/bodies .furrow/epics
jq -c . seed/epics.ndjson | while IFS= read -r line; do
  title=$(printf '%s' "$line" | jq -r .title)
  goal=$(printf '%s' "$line" | jq -r '.goal // empty')
  labels=$(printf '%s' "$line" | jq -r '.labels | join(",")')
  set -- furrow epic add "$title" --goal "$goal" -l "$labels"   # the board scope supplies the repo
  for kv in $(printf '%s' "$line" | jq -r '.meta | to_entries[] | "\(.key)=\(.value)"'); do
    set -- "$@" --meta "$kv"
  done
  "$@" >/dev/null
done
jq -c . seed/epics.ndjson | while IFS= read -r line; do
  title=$(printf '%s' "$line" | jq -r .title)
  printf '%s' "$line" | jq -r '.deps[]' | while IFS= read -r dep; do
    furrow epic dep "$title" "$dep" >/dev/null
  done
  if [ "$(printf '%s' "$line" | jq -r .active)" = true ]; then
    furrow epic activate "$title" >/dev/null
  fi
done
furrow add --batch seed/tasks.ndjson --json >/dev/null
furrow lint || true   # the scenario's dated rows are red by design; read, then sync
echo "rebuilt: $(furrow ls -n 0 --json | jq length) tasks — now: furrow sync"
