---
name: jira-task
description: Use when the user pastes a Jira ticket ID and title to start work on a task — parses the ticket ID and title from the paste, sets up the correct git branch from an updated develop branch
---

# Jira Task Setup

## Overview

Creates the correct git branch from the ticket ID and title the user pasted. No Jira lookup, no MCP, no CLI. The paste already has everything needed.

## Trigger

User pastes something like:

```
    PI-106

Remove "frist" in project overview
```

Or just a ticket ID like `PI-106`. Both work.

## Steps

### 1. Parse the input

- Ticket ID: first token matching `[A-Z]+-[0-9]+` (e.g. `PI-106`)
- Title: remaining text after the ticket ID, trimmed (e.g. `Remove "frist" in project overview`)
- If no title in paste, derive a short description from the ticket ID alone and ask the user to confirm

### 2. Determine branch prefix

Scan the title for bug keywords: fix, bug, repair, patch, revert, regression, hotfix.

| Condition | Prefix |
|-----------|--------|
| Title contains a bug keyword | `bugfix/` |
| Otherwise | `feature/` |

### 3. Build branch name

Lowercase the title, replace spaces and special characters with hyphens, strip leading/trailing hyphens, max 5 words.

Format: `<prefix><ticket-id>-<short-description>`

Examples:
- `feature/PI-106-remove-frist-project-overview`
- `bugfix/PI-88-fix-login-redirect`

### 4. Update develop and create branch

```bash
git checkout develop
git pull origin develop
git checkout -b <branch-name>
```

### 5. Confirm

Tell the user the branch name and that they are ready to start.

## Rules

- No Jira API, no MCP, no CLI. The paste is the only input needed.
- Always branch from `develop`, never from current branch or main.
- Pull develop before branching.
- Read the project's `README.md` at the start of every task to understand project-specific rules and conventions.
