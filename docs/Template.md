# Template

Every learning-lab repo is created from
[learning-lab-template](https://github.com/LasterBergamot/learning-lab-template), and
`.github/template-source` records which template it came from. The template holds the
framework: `AGENTS.md`, `docs/`, `scripts/`, `.agents/`, `.claude/`, `.github/`, and the
`_template` folders and track READMEs. Your repo holds your progress: labs, notes, Status
lines, the review queue and assessments.

## Create your repo

1. Click **Use this template** on GitHub, or run:

   ```bash
   gh repo create <your-repo> --template LasterBergamot/learning-lab-template --public --clone
   ```

   `--private` works too. You get one fresh commit with none of the template's history.
2. Keep `.github/template-source` as it is. It is how the sync finds the template.
3. Replace the placeholders: `grep -rn '<owner>/<repo>' .agents docs` finds them. Set `author`
   in `apm.yml`, and add your name to `LICENSE` for your own content.
4. Follow [Setup](Setup.md). Steps 9 and 10 are optional and use the template author's
   private repos.

## Stay in sync

When the template changes, your repo gets the change as a pull request:

- **Automatically:** `.github/workflows/template-sync.yml` runs every Monday, or from the
  Actions tab ("Template sync" → Run workflow). It runs `scripts/template-sync.sh` on a
  `template-sync` branch and opens a PR, or updates the one that is already open.
- **By hand**, on either platform:

  ```bash
  git switch -c template-sync
  bash scripts/template-sync.sh
  ```

  Then push the branch and open the PR.

Three rules keep it working:

- **Merge sync PRs with a merge commit, never squash or rebase.** The merge commit is how git
  knows which template changes you already have. After a squash, the next sync tries to apply
  them again.
- **Framework changes go to the template first**, then come back through a sync. A framework
  change made only in your repo can conflict with the next sync.
- **Resolve conflicts locally.** On a conflict the workflow fails. Run the script by hand, fix
  the files it lists, then `git add` and `git commit`.

### How the first sync works

A repo made with "Use this template" shares no history with the template. On the first sync,
the script finds the template commit whose files match your repo's first commit. It records
that commit with `git merge -s ours`, which joins the histories without changing any files.
From then on every sync is a normal merge. You get only what changed in the template, and
your own content stays as it is.

If your repo wasn't made with "Use this template", or its first commit no longer matches, pass
the template commit you started from: `bash scripts/template-sync.sh --baseline <commit>`.

### Tokens

The workflow uses `GITHUB_TOKEN` by default, which has two limits. It can't push a sync that
changes files under `.github/workflows/`, and the PRs it opens don't start CI. For full syncs,
add a repository secret named `TEMPLATE_SYNC_TOKEN`. Make it a fine-grained personal access
token for your repo, with **Contents**, **Pull requests** and **Workflows** set to read and
write. If you don't add one, enable Settings → Actions → General → "Allow GitHub Actions to
create and approve pull requests", or the workflow can't open the PR.
