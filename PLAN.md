# PLAN: learning-lab foundations

The working plan for setting up this repo and ai-common's `learning` package. To continue in a
new session, read this file top to bottom, pick the first unticked item whose dependencies are
ticked, and tick it (`- [x]`) once it is **verified** done. Then add a row to the progress log.

**Scope:** foundations only. Don't start a learning path, write lab content or import a matrix
until the owner asks.

**This file is temporary.** The last item (Z1) deletes it. By then everything it describes
lives in `README.md`, `AGENTS.md` and `docs/`.

**Rules that hold throughout:**
- The AI never writes lab code. It writes repo tooling only: `scripts/prereqs.sh` and the CI
  workflow are allowed.
- Git: the owner authorised (2026-11-25) branches, commits, PRs and merges for this plan's
  items, including the ai-common tag. Anything else still asks first. The owner does the first
  push of learning-lab's `main` (M3).
- **Sources:** every online source used for a topic, track or lab (docs, RFCs, articles,
  roadmaps, videos) is added to the **References** section of the relevant README
  (`labs/<track>/README.md` or `labs/<track>/<lab>/README.md`).
- Everything works on **both** platforms in the same change: Omarchy (Linux, Docker) and
  Windows 11 (Git Bash, Podman).

## Checklist

Owner: **AI** or **YOU**. `needs:` lists the items that must be ticked first.

### Done in the first round (2026-11-24)
- [x] **P0** Create `learning-lab/` and this plan
- [x] **A1–A4** ai-common `packages/learning` 0.1.0 (7 skills + `socratic-reviewer`, model and effort in the frontmatter), template, docs. PR #4 merged
- [x] **M2** ai-common tag `v0.2.0` pushed
- [x] **M1** GitHub repo `LasterBergamot/learning-lab` created (public, empty)
- [x] **B1, B2, D1** First skeleton: wiki-style `docs/`, `.claude/` setup, templates, issue forms (G reworks it)
- [x] **D2** `apm install` workflow + learning `#v0.2.0`, `apm audit` clean (H1 redoes it at `v0.3.0`)

### Stream F: ai-common v0.3.0 (subagent, in `../ai-common`)
- [x] **F1** (AI) Context lookup in every workflow and learning skill: `.agents/context/<file>` first, then `.claude/context/<file>`, so lineup keeps working unchanged
- [x] **F2** (AI) `roadmap-sync` reads the `**Status:**` lines (design §5) instead of the wiki/GitHub issues and rewrites the Mermaid `class` lines in READMEs between the markers. Remove the wiki wording from all learning skills and the template
- [x] **F3** (AI) New skill `prereq-check` (opus/high), design §6. `plan-lab` and `socratic-tutor` run it whenever a track or lab is picked up
- [x] **F4** (AI) `session-log` ends by proposing a checkpoint commit and push (asks first; design §7). All learning skills keep the two-platform rule (design §2). Every skill that uses an online source (`prereq-check`, `socratic-tutor`, `plan-lab`, `assessment-prep`, `session-log`) adds it to the References section of the relevant README
- [x] **F5** (AI) Tool-agnostic (design §8):
  - neutral wording in the skill bodies, with Claude-only keys left in the frontmatter only
  - check what the `agent-skills`, `gemini` and `codex` targets deploy, and whether `apm compile` can produce `AGENTS.md` from an `instructions` primitive without clobbering a handwritten one
  - a new `templates/AGENTS.md`; `templates/CLAUDE.md` becomes a stub that imports it
  - `docs/APM.md`: decision 6 replaced, and USING/AUTHORING updated
- [x] **F6** (AI) Verify with a scratch install for targets `claude` and `agent-skills`, `apm audit` clean, `lineup/.claude/skills` unaffected. needs: F1–F5
- [x] **F7** (AI, after go-ahead) Branch, commit, PR, merge, tag `v0.3.0`, push the tag. needs: F6

### Stream G: learning-lab restructure (subagents, in parallel with F)
- [x] **G1** (AI) Remove `.github/workflows/wiki-sync.yml` and `scripts/sync_wiki.py`, the wiki wording and the `[[...]]` links (they become relative Markdown links). (YOU, optional: turn off Wikis in the repo settings)
- [x] **G2** (AI) Move `docs/Track-*.md` to `labs/<track>/README.md`. The root `README.md` becomes the router: what this is, how it works, prerequisites (`scripts/prereqs.sh`), the progress overview graph, a link to every track README, and working across machines. `docs/` keeps the cross-cutting pages: Setup, Platforms, Isolation, How-I-Learn, Tool-Landscape, Glossary, Review-Queue, Assessments
- [x] **G3** (AI) A **References** section (online sources) in the lab and track templates and every track README; the `**Status:**` convention (design §5) in `labs/_template/README.md`, the track READMEs and the root overview, with markers and `classDef`s
- [x] **G4** (AI) New tracks `identity` and `testing` (design §9): track READMEs with graphs of planned labs. Testing leaves the Architecture track. Update `docs/Learning-Paths` content (moved into the root README), `docs/Tool-Landscape.md` and the track ids in the context files
- [x] **G5** (AI) `AGENTS.md` as the main router (tutor rules, no-code, two-platform rule, pick-up check, commit checkpoints). `CLAUDE.md` becomes `@AGENTS.md` + the Claude-only extras (output style, deny rules). Move `.claude/context/` to `.agents/context/`. needs: F1 design agreed (folder names)
- [x] **G6** (AI) `scripts/prereqs.sh` (design §3): `--check` (default), `--install` (asks per tool), `--ci`. `docs/Setup.md` walks through it for both platforms
- [x] **G7** (AI) CI `.github/workflows/check.yml`, a matrix of `ubuntu-latest` and `windows-latest` (shell: bash):
  - `bash -n` and `prereqs.sh --ci`
  - relative Markdown links resolve
  - every lab README has a valid `**Status:**` line
  - every track README is linked from the root README

### Join
- [x] **H1** (AI) `apm.yml` targets `claude` + `agent-skills`; packages `#v0.3.0`; `apm install`, `apm audit` clean. needs: F7, G5
- [x] **H2** (AI) Review everything against this plan; run the G7 checks locally; run `prereqs.sh --check` on Omarchy. needs: G1–G7, H1
- [x] **H3** (AI, after go-ahead) `git init -b main`, first commit (this PLAN.md included, so the plan travels). needs: H2
- [ ] **M3** (YOU) `git remote add origin git@github.com:LasterBergamot/learning-lab.git && git push -u origin main`. needs: H3
- [ ] **H4** (AI) On GitHub: CI green on both OSes, the Mermaid graphs render in the READMEs. In a new session started in `learning-lab/`: "write me a FastAPI hello world" gets questions back, and creating `labs/x/main.py` is denied. needs: M3
- [ ] **M5** (YOU, optional) On Windows 11: clone, `bash scripts/prereqs.sh --check` in Git Bash, report back
- [ ] **C1–C2** (AI, optional, after go-ahead) GitHub labels, milestone and board. Issues are extras; progress lives in the READMEs
- [ ] **Z1** (AI, after go-ahead) Delete `PLAN.md`, remove its router rows from `README.md`, `AGENTS.md` and `CLAUDE.md`, commit; (YOU) push. needs: everything above except the optional items

## Progress log

| Date | Item | Result |
|------|------|--------|
| 2026-11-24 | P0 | Folder and PLAN.md created |
| 2026-11-24 | A1–A4, M2 | ai-common `packages/learning` 0.1.0, PR #4 merged (31c17cf), tag v0.2.0 |
| 2026-11-24 | B1, B2, D1, D2 | First skeleton (28 wiki pages, `.claude/` setup); apm install at v0.2.0, audit clean |
| 2026-11-25 | F1–F7 | ai-common PR #5 merged (580731e), tag v0.3.0: .agents/context lookup, neutral wording, prereq-check, Status-line roadmap-sync, sources + checkpoint rules, APM findings in docs/APM.md |
| 2026-11-25 | G1–G7 | Wiki removed; root README router + 20 track READMEs (identity, testing new); AGENTS.md/CLAUDE.md/GEMINI.md; .agents/context; scripts/prereqs.sh; scripts/check_docs.py; CI matrix ubuntu+windows. shellcheck not run (not installed) |
| 2026-11-25 | H1–H3 | apm.yml targets claude + agent-skills at v0.3.0: 14 skills in .claude/skills and .agents/skills, 2 agents, audit clean (33 files); check_docs OK; prereqs --check: kind, kubectl missing on Omarchy (expected, install when needed); git init + first commit |
| 2026-11-25 | Approval | Plan approved; git branches, commits, PRs, merges and the v0.3.0 tag authorised; rule added: online sources go into the relevant README |
| 2026-11-25 | Re-plan | Wiki dropped, router READMEs, Status lines, prereqs.sh, two new tracks, tool-agnostic APM, prereq-check, commit checkpoints, PLAN.md removed at the end |

---

# Design reference

## 1. What the AI may write

| AI writes | Only you write |
|---|---|
| Markdown: READMEs, docs, notes, session logs, Mermaid graphs | Lab code in any language |
| Skills, agents, `AGENTS.md`, the Claude output style | Dockerfiles/Containerfiles, compose, manifests, IaC, Ansible |
| Repo tooling: `scripts/prereqs.sh`, CI, `.gitignore`/`.gitattributes`, issue forms, `apm.yml` | Scripts, configs and certificates inside `labs/**` |

Enforcement:
- **Any AI tool:** the rules in `AGENTS.md`, plus the same rule in every skill.
- **Claude only:** the `socratic` output style and the `permissions.deny` rules for code
  files under `labs/**`.
- The deny rules don't stop writes through the shell, so the written rule is what counts.

## 2. Two platforms, always in sync

| Concern | Omarchy (Linux VM) | Windows 11 |
|---|---|---|
| Shell | bash | Git Bash (no WSL2 distro) |
| Engine | Docker (`docker compose`) | Podman Desktop; machine on the Hyper-V provider (WSL2 only as the invisible backend on Home) |
| Toolchains | mise, uv | mise, uv (native) |
| Packages | pacman (Omarchy), mise | winget, mise |
| Kubernetes | kind | kind with `KIND_EXPERIMENTAL_PROVIDER=podman` |
| VMs | QEMU/libvirt (nested KVM) | Hyper-V |
| Machine setup | dev-config `install.sh`, ai-common guards | dev-config `install.ps1`, ai-common guards |

The rule: no change lands that covers only one platform. That covers scripts, `docs/Setup.md`,
lab READMEs and teardowns. Each lab README shows **Tested on: Linux/Docker ⬜ Windows/Podman ⬜**.
The G7 CI matrix catches script and doc drift. Lab portability rules (compose spec only, no host
network, no host ports below 1024, relative bind mounts, LF endings) live in the lab template.

## 3. `scripts/prereqs.sh`

- One bash script, Omarchy and Git Bash. Platform detection follows dev-config's `install.sh`
  (`uname -s`: `MINGW*|MSYS*|CYGWIN*` means Windows).
- A table of tools: name, check command, minimum version, install command per platform,
  required or optional. The tools: git, gh, jq, curl, mise, uv, the APM CLI, docker or podman,
  a compose provider, kind, kubectl. Optional per track: java via mise, flutter, opentofu,
  pulumi, aws/gcloud/az CLIs.
- `--check` (the default) prints ✓/✗ with versions. `--install` installs each missing tool
  after a y/N prompt; never sudo without showing the command first. `--ci` checks only what CI
  needs and fails on missing required tools. `--track <id>` adds that track's optional tools.
- It never touches dev-config's or ai-common's installs. It points to them instead.

## 4. Layout after the restructure

```
learning-lab/
├── README.md            router: what, how, prerequisites, progress overview, track links, machines
├── AGENTS.md            AI router for every tool; CLAUDE.md = @AGENTS.md + Claude extras
├── apm.yml/.lock        targets claude + agent-skills; workflow + learning #v0.3.0
├── scripts/prereqs.sh
├── .github/workflows/check.yml, ISSUE_TEMPLATE/
├── .agents/context/     issues, docs, pr-checklist, audit, learning (tool-neutral)
├── .claude/             settings.json, output-styles/, rules/, skills/ + agents/ (deployed)
├── .agents/skills/      deployed by APM for the agent-skills target
├── docs/                Setup, Platforms, Isolation, How-I-Learn, Tool-Landscape, Glossary,
│                        Review-Queue, Assessments
├── labs/
│   ├── _template/       README (with Status line), NOTES, QUESTIONS, TEARDOWN
│   └── <track>/README.md            track page: why, prerequisites, graph, lab table
│       └── <lab>/README.md          one lab
└── assessments/         README, _template/, <subject>/ later
```

## 5. How the `**Status:**` line works

Every lab README carries one line under its title:

```markdown
# JWT internals
**Status:** learning · **Tier:** T1 · **Tested on:** Linux/Docker ✅ Windows/Podman ⬜
```

- **Values:** `todo`, `learning`, `building`, `done`. They map to the milestones: understand →
  `learning`; build, break and fix → `building`; explain it back → `done`.
- **Who changes it:** you, or `session-log` *proposes* the change at the end of a session.
  It is an ordinary committed edit, so the state travels with git to every machine and shows on
  GitHub without any service.
- **The graphs:** each track README and the root README hold a Mermaid graph between
  `<!-- roadmap-sync:start -->` and `<!-- roadmap-sync:end -->`. `roadmap-sync` reads all
  `labs/*/*/README.md` Status lines and rewrites only the `class` lines:
  ```mermaid
  flowchart LR
    jwt[JWT internals] --> oauth[OAuth 2 grants] --> tx[Token exchange]
    classDef todo fill:#eee,stroke:#999,color:#333
    classDef learning fill:#fff3b0,stroke:#c9a400,color:#333
    classDef building fill:#cde4ff,stroke:#2f6fb0,color:#333
    classDef done fill:#c8f0c8,stroke:#2e8b57,color:#333
    class jwt done
    class oauth learning
    class tx todo
  ```
- A track node in the root graph is `done` when all its labs are done, `learning` or
  `building` when any lab has started, and `todo` otherwise.
- A planned lab that has no folder yet counts as `todo`.
- CI (G7) fails on a missing or invalid Status line.

## 6. `prereq-check`: before picking up a track or lab

It runs automatically from `plan-lab` and `socratic-tutor` when you start something new, or
on request.
1. **This repo:**
   - the lab's and track's Prerequisites lists, and the edges in the root and track graphs
   - the Status of every prerequisite
   - your NOTES and open QUESTIONS
   - overdue recall questions in the review queue on those topics
   - readiness in `assessments/` if relevant
2. **The internet:** official docs and well-known learning roadmaps for the topic. It looks for
   prerequisites the repo graph is missing, and for whether a tool is current or superseded.
   It cites sources and says when a tool can't search the web.
3. **Output:** "ready", or a short list of gaps (repo gaps first, then web-suggested ones),
   each with a reason and a link. It proposes graph or prerequisite edits for the gaps worth
   adding.
4. You decide. It never blocks you, and the graph or README edits happen only after you agree.

## 7. Continuing on another machine

- **Committed:**
  - lab code, compose files and `mise.toml` toolchain pins
  - NOTES, QUESTIONS, session logs, Status lines, the review queue, assessments
  - `PLAN.md` (until Z1), `apm.yml`/`apm.lock.yaml` and the deployed skills
- **Never committed** (already in `.gitignore`): keys and keystores, `.env*`, Terraform and
  Pulumi state, kubeconfig, build output, container volumes, `apm_modules/`.
- **Session end:** `session-log` proposes `git add` of the lab, a commit
  (`<track>/<lab>: <what you did>`) and a push. Each time it asks first (global rule).
  Work-in-progress commits are fine.
- **Resume:** `git pull`, then `bash scripts/prereqs.sh --check --track <id>`. The lab's
  `NOTES.md` says where you stopped.
- No state lives only in an AI tool's memory. Everything a session needs is in the repo.

## 8. Tool-agnostic AI setup

- **What APM translates:**
  - `apm install` deploys each skill and agent into every target's folder
    (`.claude/skills/`, `.agents/skills/`, …).
  - `apm compile --target …` builds `AGENTS.md`/`CLAUDE.md`/`GEMINI.md` from `instructions`
    primitives.
- **What it doesn't translate:** Claude-only frontmatter (`model:`, `effort:`, `tools:`), tool
  names written in a skill's text, hooks, output styles and permission rules.
- **So:**
  - Skill bodies use neutral wording ("read the file", "search the web").
  - `model:` and `effort:` stay in the frontmatter: Claude uses them, others ignore them.
  - The rules every tool must follow live in `AGENTS.md`.
  - The Claude-only enforcement is documented as optional.
- **Targets:** `claude` + `agent-skills` now. Adding `gemini` or `codex` later is one line in
  `apm.yml` plus `apm install`. For Gemini CLI, a `GEMINI.md` that points to `AGENTS.md` (or
  its `contextFileName` setting).
- **Context files** move to `.agents/context/`. ai-common skills look there first, then in
  `.claude/context/`.
- **Still Claude-only:** ai-common's guard hooks (another tool would need a payload adapter).

## 9. Tracks

20 tracks, each with a `track:<id>` label and a `labs/<id>/README.md` page:
foundations, security, **identity**, jvm, **testing**, python, concurrency, mobile, containers,
virtualization, orchestration, observability, iac, cloud, eventing, data, distributed,
architecture, ai, classics.

- **identity (Identity and Access).** Prerequisites: `foundations` (HTTP), `security` (TLS).
  - JWT internals: JWS, JWE, JWK and JWKS rotation, claims, validation, `alg` pitfalls
  - OAuth 2 grants: authorization code + PKCE, client credentials, refresh, device flow
  - token exchange (RFC 8693, delegation vs. impersonation)
  - JWT bearer and `private_key_jwt` (RFC 7523)
  - introspection and revocation
  - OIDC: ID token vs. access token
  - sender-constrained tokens: mTLS (RFC 8705), DPoP (RFC 9449)
  - a Spring Security resource server
  - Keycloak in a container as the local IdP
- **testing (Java first).** Prerequisite: `jvm` basics.
  - the pyramid level by level:
    - unit: JUnit 5, AssertJ, Mockito, test-double taxonomy
    - TDD katas (red-green-refactor)
    - property-based (jqwik) and mutation testing (PIT)
    - Spring slice tests
    - integration: Testcontainers, WireMock
    - contract: Pact or Spring Cloud Contract
    - API: REST Assured
    - BDD: Cucumber-JVM, Gherkin
    - end-to-end: Playwright for Java
    - architecture tests: ArchUnit
    - performance: JMH, Gatling
  - the pyramid compared with the trophy and honeycomb shapes
- The other tracks and the tool comparison stay as written in the first round
  (`docs/Tool-Landscape.md`, the track pages).
