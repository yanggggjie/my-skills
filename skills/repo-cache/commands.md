# repo-cache 命令参考

[`SKILL.md`](SKILL.md) 的披露参考。在做缓存维护、查看输出格式或选择克隆 flag 时再读。

## CLI

```text
repo-cache get <repo> [--ref REF] [--shallow|--treeless] [--json]
repo-cache update <repo>
repo-cache reset <repo> [--ref REF]
repo-cache list
repo-cache prune --days N
repo-cache rm <repo>
```

`get`：克隆（或 fetch）bare 仓库，确保对应 ref 的 worktree，并打印 worktree 路径。

## 输出

默认：一行路径。

```text
/Users/you/.cache/repo-cache/work/github.com/owner/repo/main
```

`--json`：

```json
{
  "repo": "owner/repo",
  "host": "github.com",
  "path": "/Users/you/.cache/repo-cache/work/github.com/owner/repo/main",
  "ref": "main",
  "sha": "abc123",
  "clone_type": "full"
}
```

## 仓库标识

- `owner/repo` → GitHub（可用时走 `gh repo clone`）
- `https://host/…` / `git@host:…` → `git clone`（GitHub 仍优先 `gh`）

## 缓存布局

```text
~/.cache/repo-cache/          # 可用 REPO_CACHE_DIR 覆盖
├── bare/<host>/<path>.git    # 持久 bare
└── work/<host>/<path>/<ref>/ # worktree（ref 中的 `/` 会变成 `-`）
```

默认 `get` 为完整 bare 克隆，便于 blame/log。`--shallow` / `--treeless` 只影响初次 bare 克隆。
