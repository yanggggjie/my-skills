---
name: my-memory
description: mm。写入或加载 wxa 的 memory（长期记忆）与 progress（项目追踪）。用户输入 mm、或需要写/读 wxa memory 或 progress/<slug> 时调用。
---

# my-memory

| 层 | 目录 | 含义 |
| --- | --- | --- |
| **memory** | `/Users/youshiyitian/Code/wxa/memory/` | 长期记忆：跨需求仍成立的手册与硬规则索引 |
| **progress** | `/Users/youshiyitian/Code/wxa/progress/<slug>/` | 项目追踪：单个需求的目标、git 分支、现状、日志 |

两层都在外层 `/Users/youshiyitian/Code/wxa/`，与 `AGENTS.md` 并列。`slug` 是需求身份。

**绑定：** git 分支名 ↔ 需求。写入该需求 `PROGRESS.md` 的「路径与分支」（仓库名 + git 分支 + 仓内路径）。

**不绑定：** git 分支 ↔ wxa 槽。wxa1–wxa4 只是检出槽。需要某 git 分支的工作路径时，跑：

```sh
/Users/youshiyitian/Code/wxa/memory/wxa-slots.sh [git分支]
```

以**本次 stdout** 为准。禁止把槽位写入 `memory/` 或 `progress/`（含「当前槽」、槽内绝对路径）。progress / 对话里出现过的槽位一律忽略。

未 invoke 时不改 `memory/`、`progress/`、外层 `AGENTS.md` 的硬规则/索引。

## Step 0：定 memory / progress

1. 已点名 **memory** 或 **progress** → 用该 branch。
2. 未点名 → **一句推荐**（哪一层 + 理由），等确认或改口；未确认不写入。
3. 推荐贴信号：`progress/<slug>` /「这个需求 / 当前任务」→ progress；「手册 / 长期 / memory」→ memory。

完成标准：memory / progress 已经点名或确认。

## Branch：memory

1. 细则 → `/Users/youshiyitian/Code/wxa/memory/`；短硬规则与索引 → 仅外层 `/Users/youshiyitian/Code/wxa/AGENTS.md`。不改 wxa1/2/3/4 薄文件（除非改本树路径）。
   完成标准：目标路径正确。
2. 写/改：顶层只放可检查规则与入口路径；细则写到 `memory/<文件>.md`。已有中文文件名保留；新建英文 kebab。id = 相对 wxa 根路径。不把 progress 内容写入 memory。同一事实只写一处。
   完成标准：目标 md 已更新；新建则外层索引可发现；每一义仅一处权威。
3. 汇总整个需求迭代的累计代码变动时，用 Git 只查看该需求 git 分支的直接提交；排除 merge commit 与其他非直接提交。基线和 git 分支由当前仓库与需求绑定的 git 分支确定后，再执行相应的 `git log --no-merges`、`git diff` 等命令。工作树路径来自本轮 `wxa-slots.sh` stdout。
   完成标准：累计变动仅覆盖该 git 分支直接提交引入的 diff；工作路径来自本次脚本，未混入 merge 或其他提交。

## Branch：progress

1. 指定或新建 `/Users/youshiyitian/Code/wxa/progress/<slug>/`；读或按模板建 `PROGRESS.md`。
   - `slug` 用需求的简短英文名，kebab-case；例如「用户评价」→ `user-review`。
   - 每个需求独占一个 `slug`，并绑定其 git 分支名。不写当前槽与槽内绝对路径。
   完成标准：slug 与 `PROGRESS.md` 已定并已 Read；「路径与分支」含 git 分支、不含槽位。
2. 需要工作路径（读代码、改代码、对某槽操作）→ 用该需求绑定的 git 分支跑 `wxa-slots.sh`；路径只取本次 stdout。
   完成标准：本轮已跑脚本；采用的 `wxaN/...` 出现在本次 stdout 中。
3. 更新：`PROGRESS.md` 为入口；细节写到同目录附属 md。不写 `memory/`。同一事实只写一处。
   完成标准：`PROGRESS.md` 反映本轮真实状态；「路径与分支」只记仓库名、git 分支、仓内路径；附属与入口无重复权威。

## 召回日志

本轮 Read 了 memory 或 progress 文件时，回复靠前一行（无则省略）：

```text
memory-recall: memory:memory/日志查询.md, progress:progress/user-review/PROGRESS.md
```

完成标准：有 Read 则有该行；id 相对 `/Users/youshiyitian/Code/wxa/`；前缀为 `memory:` 或 `progress:`。

## PROGRESS.md 模板

```markdown
# <slug>

## 目标

## 路径与分支

- 仓库：
- git 分支：

## 现状

## 未决

## 日志
```
