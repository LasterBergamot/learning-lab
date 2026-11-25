# Issue conventions

Read by the `new-issue` skill (from `ai-common`). The skill holds the procedure; this file
holds the values.

- **Repo:** `LasterBergamot/learning-lab`

## Body extras

- **Lab issues** (`type:lab`) follow the `Lab` issue form (`.github/ISSUE_TEMPLATE/lab.yml`):
  lab folder, goal, prerequisites, isolation tier, platforms, resource cost, acceptance.
  Acceptance is observable: "I can explain X without notes", "I built Y", "I broke Y on purpose
  and fixed it", "teardown leaves nothing running".
- **Concept**, **question** and **assessment** issues follow their forms. For the usual
  Problem / Evidence / Proposal / Acceptance body, Problem means "what I don't understand yet"
  and Evidence means "where it came up".
- Prerequisites are **blocked-by** relationships (`addBlockedBy`), so the learning order is
  visible on GitHub, and they match the arrows in the root `README.md` and the track READMEs.
- Issues are optional extras: a lab's progress lives in its README's `**Status:**` line, not in
  the issue state. Keep the two consistent when both exist.

## Labels

- Exactly one `type:*`: `lab`, `concept`, `question`, `epic`, `chore`, `docs`, `assessment`
- Exactly one `track:*` (none for chores): `foundations`, `security`, `identity`, `jvm`,
  `testing`, `python`, `concurrency`, `mobile`, `containers`, `virtualization`, `orchestration`, `observability`,
  `iac`, `cloud`, `eventing`, `data`, `distributed`, `architecture`, `ai`, `classics`
- One `level:*` on labs and concepts: `1-understand`, `2-apply`, `3-build`, `4-teach`
- One `priority:*`: `p0` now, `p1` next up, `p2` some day

## Milestones

- `Repo foundations`: setting up this repo and its tooling (`PLAN.md`).
- No milestones for learning. The order is expressed by blocked-by relationships and the
  prerequisite graphs in the root and track READMEs, not by dates.

## Parent epics

One epic per track (`type:epic` + `track:<id>`, title `Epic: <Track name>`), created on request
when a track is started. None exist yet. Labs and concepts are linked as sub-issues of their
track's epic.

## Board

- Project **"learning-lab"** (owner `LasterBergamot`); its number is set when it is created
  (`gh project list --owner LasterBergamot`). Auto-add is **off**: add each issue with
  `gh project item-add`.
- Fields:
  - **Status:** Todo, Learning, Building, Review, Done (new issues: Todo)
  - **Track:** single select, the track ids above
  - **Level:** single select: 1-understand, 2-apply, 3-build, 4-teach
