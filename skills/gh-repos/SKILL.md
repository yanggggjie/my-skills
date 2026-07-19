---
name: gh-repos
description: 用 gh 浅克隆 GitHub 仓库到 ~/.gh-repos，返回绝对路径供只读探索。在阅读、分析尚未本地检出的 owner/repo 时使用；当其它 skill 需要外部仓库本地路径时使用。
---

# gh-repos

把 GitHub 仓库**浅克隆**到 `~/.gh-repos/<owner>/<repo>`，把绝对路径交给后续搜索与阅读。已存在则复用；除非用户明确要求更新，否则不拉取。

前置：本机已安装并登录 `gh`。

## 获取

1. 从用户输入得到 `owner/repo`（GitHub URL 则抽出 `owner/repo`）。设：

```bash
DIR="$HOME/.gh-repos/<owner>/<repo>"
```

2. 若 `$DIR` 不存在则浅克隆；已存在则跳过：

```bash
mkdir -p "$(dirname "$DIR")"
gh repo clone <owner/repo> "$DIR" -- --depth 1
```

完成标准：`DIR` 是已存在目录的绝对路径（`test -d "$DIR"`），并把它交给后续步骤。

3. 只在该路径下阅读、搜索与总结。完成标准：凡对仓库文件的断言都来自该树（或明确说明未找到）。

## 更新

仅当用户明确要求更新或拉最新时：

```bash
git -C "$DIR" pull --ff-only
```

完成标准：命令成功（或已是最新）；仍返回同一 `$DIR`。
