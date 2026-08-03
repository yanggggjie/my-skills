---
name: my-memory
description: mm。手动写入或加载 wxa 的 memory（长期记忆）与 progress（项目追踪）。仅用户显式调用。
disable-model-invocation: true
---

# my-memory

| 层 | 目录 | 含义 |
| --- | --- | --- |
| **memory** | `/Users/youshiyitian/Code/wxa/memory/` | 长期记忆：跨需求仍成立的手册与硬规则索引 |
| **progress** | `<当前 wxa>/progress/<slug>/` | 项目追踪：单个需求的目标、路径、现状、日志 |

`<当前 wxa>` 是本轮工作代码所在的 `wxa1`、`wxa2`、`wxa3` 等目录；先由当前工作目录、用户点名路径或对应 `AGENTS.md` 判断。需求跨多个 wxa 时，各树分别维护自己的 progress，不共用目录。

未 invoke 时不改 memory、任一 `<当前 wxa>/progress/`、外层 `AGENTS.md` 的硬规则/索引。

写任何落盘正文前先 Read：

`/Users/youshiyitian/.agents/skills/writing-great-skills/SKILL.md`

（术语不够再 Read 同目录 `GLOSSARY.md`。）完成标准：本轮已打开；按 information hierarchy、progressive disclosure、single source of truth、completion criterion、pruning 落笔。

## Step 0：定分支

1. 已点名 **memory** 或 **progress** → 用该 branch。  
2. 未点名 → **一句推荐**（哪一层 + 理由），等确认或改口；未确认不写入。  
3. 推荐贴信号：`progress/<slug>` /「这个需求 / 当前任务」→ progress；「手册 / 长期 / memory」→ memory。

完成标准：分支已经点名或确认。

## Branch：memory

1. 细则 → `/Users/youshiyitian/Code/wxa/memory/`；短硬规则与索引 → 仅外层 `/Users/youshiyitian/Code/wxa/AGENTS.md`。不改 wxa1/2/3 薄文件（除非改本树路径）。  
   完成标准：目标路径正确。
2. 按 writing-great-skills 写/改：顶层可检查规则与 context pointer；细则 disclose 到 `memory/<文件>.md`。已有中文文件名保留；新建英文 kebab。id = 相对 wxa 根路径。不把 progress 内容写入 memory。改完 pruning。  
   完成标准：目标 md 已更新；新建则外层索引可发现；每一义仅一处权威。
3. 汇总整个需求迭代的累计代码变动时，用 Git 只查看该需求分支的直接提交；排除 merge commit 与其他非直接提交。基线和分支由当前仓库与需求分支确定后，再执行相应的 `git log --no-merges`、`git diff` 等命令。
   完成标准：累计变动仅覆盖该分支直接提交引入的 diff，未混入 merge 或其他提交。

## Branch：progress

1. 先确定 `<当前 wxa>`，再指定或新建 `<当前 wxa>/progress/<slug>/`；读或按模板建 `PROGRESS.md`。  
   - `slug` 用需求的简短英文名，kebab-case；例如「用户评价」→ `user-review`。
   - 每个需求独占一个 `slug` 目录；同一需求的附属进度文件均放在该目录。
   完成标准：当前 wxa、slug 与 `PROGRESS.md` 已定并已 Read。
2. 按 writing-great-skills 更新：`PROGRESS.md` 为入口；细节 disclose 到同目录附属 md。不写 `memory/`。  
   完成标准：`PROGRESS.md` 反映本轮真实状态；附属与入口无重复权威。

## 召回日志

本轮 Read 了 memory 或 progress 文件时，回复靠前一行（无则省略）：

```text
memory-recall: memory:memory/日志查询.md, progress:wxa2/progress/user-review/PROGRESS.md
```

完成标准：有 Read 则有该行；memory id 相对 `/Users/youshiyitian/Code/wxa/`，progress id 相对该目录并包含 wxa 名；前缀为 `memory:` 或 `progress:`。

## PROGRESS.md 模板

```markdown
# <slug>

## 目标

## 路径与分支

## 现状

## 未决

## 日志
```
