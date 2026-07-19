---
name: repo-cache
description: 把远程 git 仓库缓存到本地 worktree，供只读探索。在阅读、分析或总结尚未检出的 owner/repo（或 git URL）时使用；当其它 skill 需要外部仓库的本地路径时使用。
user-invocable: true
argument-hint: "get <owner/repo> [--ref REF] [--json]"
---

# repo-cache

先把远程仓库**缓存**下来，再只读脚本打印出的路径。该路径是工作树——用于探索，不要在这里做产品提交。

脚本：与本 `SKILL.md` 同目录下的可执行文件 `repo-cache`。

## 获取（默认分支）

1. 运行：

```bash
"<skill-dir>/repo-cache" get <owner/repo>
```

接受 `owner/repo`、`https://…` 或 `git@…`。完成标准：stdout 是一个已存在的目录路径（若加 `--json`，则 JSON 中含可用的 `path` 字段）。

2. 只在该路径下阅读、搜索与总结。完成标准：凡对远程仓库文件的断言，都来自该树（或明确说明未找到）。

## 获取（指定 ref 或克隆形态）

同「获取」，按需加 flag：

| Flag | 何时用 |
| --- | --- |
| `--ref <ref>` | 需要默认分支以外的分支/标签 |
| `--shallow` | 只要最新树，不需要历史 |
| `--treeless` | 要提交信息但不要 blob 体积（`blob:none`） |
| `--json` | 需要结构化的 `path` / `ref` / `sha` |

完成标准：同「获取」——拿到所请求 ref 的可用路径（或 JSON）。

## 维护

用户要求刷新、重置、列出或清理缓存时使用——细节见 [`commands.md`](commands.md)。

| 意图 | 命令 |
| --- | --- |
| 拉取更新但不重置 worktree | `update <repo>` |
| 重建 worktree（丢弃本地改动） | `reset <repo> [--ref REF]` |
| 列出缓存 | `list` |
| 清理过期缓存 | `prune --days N` |
| 删除某一缓存 | `rm <repo>` |
