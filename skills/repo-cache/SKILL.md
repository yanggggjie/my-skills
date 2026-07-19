---
name: repo-cache
description: REQUIRED for any external repo exploration. Use INSTEAD OF gh api or WebFetch when analyzing, reading, or summarizing files in repos you don't have locally (owner/repo pattern).
user-invocable: true
argument-hint: "<command> [repo] [flags]"
---

# Git Repository Cache

Cache external repositories locally for read-only exploration. Uses bare repos + worktrees for efficient storage.

## Quick Start

Run via the script in this skill's directory (path shown in "Base directory for this skill" above):

```bash
"<skill-dir>/repo-cache" get owner/repo
```

Then read files from the returned path.

## Commands

| Command                                            | Description                                   |
| -------------------------------------------------- | --------------------------------------------- |
| `get <repo> [--ref REF] [--shallow / --treeless]`  | Clone or update repo, return working path     |
| `update <repo>`                                    | Fetch latest without resetting worktree       |
| `reset <repo>`                                     | Recreate worktree (removes all local changes) |
| `list`                                             | Show all cached repos                         |
| `prune --days N`                                   | Remove repos not accessed in N days           |
| `rm <repo>`                                        | Remove specific repo from cache               |

## Output

Returns path to working directory:

```text
/Users/you/.cache/repo-cache/work/github.com/owner/repo/main
```

With `--json`:

```json
{
  "repo": "owner/repo",
  "path": "/Users/you/.cache/repo-cache/work/github.com/owner/repo/main",
  "ref": "main",
  "sha": "abc123",
  "clone_type": "full"
}
```

## Flags

| Flag          | Effect                                                          |
| ------------- | --------------------------------------------------------------- |
| `--ref <ref>` | Checkout specific branch/tag (default: default branch)          |
| `--shallow`   | Clone with `--depth 1` (latest code only, no history)           |
| `--treeless`  | Clone with `--filter=blob:none` (commits only, blobs on demand) |
| `--json`      | Output JSON instead of plain path                               |

## Repo Formats

- `owner/repo` → github.com (shorthand)
- `https://github.com/owner/repo`
- `https://gitlab.com/org/project`
- `git@bitbucket.org:team/repo.git`
- Any valid git URL

## Cache Location

```text
~/.cache/repo-cache/
├── bare/                    # Bare repos (persistent)
│   └── github.com/owner/repo.git
└── work/                    # Worktrees (ephemeral)
    └── github.com/owner/repo/main/
```

## Design Notes

- **Read-only intent**: Worktrees are for exploration, not development
- **Full clone by default**: Supports all git operations (blame, log, etc.)
- **Worktree-based**: Multiple refs can be checked out simultaneously
- **GitHub via `gh`**: Uses `gh repo clone` for GitHub auth handling
- **Other hosts via `git`**: Relies on git credential helpers or SSH
