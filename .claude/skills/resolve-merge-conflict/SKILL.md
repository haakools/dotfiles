---
name: resolve-merge-conflict
description: Use when there is a merge conflict on a feature branch, when a PR shows CONFLICTED files, or when git reports conflict markers in files.
---

# Resolve Merge Conflict

## Core Principle

Always pull the target branch into the feature branch and resolve manually. Never rewrite shared branch history.

## The Only Correct Approach

```bash
git pull origin develop        # or whatever the target branch is
# resolve conflict markers in files
git add <conflicted-files>
git rebase --continue          # if rebasing, otherwise just commit
git push
```

## What NOT To Do

| Wrong | Why |
|-------|-----|
| `git reset --soft` + force push | Rewrites shared history, breaks everyone else's local branch |
| Creating a new branch and cherry-picking | Avoids the problem instead of fixing it |
| Skipping commits with `--skip` | Loses work |

## Resolving Conflict Markers

Find all conflicts first:
```bash
grep -rn "<<<<<<" src/
```

For each file, choose what to keep — ours, theirs, or a manual merge of both. Remove ALL markers (`<<<<<<<`, `=======`, `>>>>>>>`), then `git add` the file.

## Red Flags — STOP

- "Let me just reset and recommit cleanly" → NO. Pull and resolve.
- "Force push is fine on a feature branch" → Only as last resort, never to avoid resolving conflicts.
- "I'll skip this commit" → Only if the commit is truly redundant and its changes are already present.
