# furrow-test

A sandbox [furrow](https://github.com/akira-toriyama/furrow) board. The work it
tracks is fictional; the board itself is the subject.

## What is on it

One simulated project: renting a kitchen space for a day and serving a
five-course dinner to twelve friends on 2026-11-21. Five epics that depend on
one another, roughly twenty tasks each. It exists to drive furrow at a realistic
scale — dated tasks, checklists, cross-epic dependencies, external waits, a
recurring task — and to record where the tool runs out of room.

## Using it

The store is repo-local, so discovery needs no configuration:

```sh
cd furrow-test
furrow sync && furrow brief
```

`furrow lint` is this board's rulebook. Whether a session that has never seen
the board can act on it without being told the rules in prose is the thing being
measured here.

## Where findings go

Gaps found while driving this board are filed against furrow itself on the
private `akira-toriyama/projects` board, never as tasks here.
