---
name: manage-skills
description: ms。用 Skills CLI 安装、更新、创建、改写、列出或彻底删除 agent skills。触发：ms、npx skills、全局安装、卸载残留、plugin.json、skills/ 布局、新建或改写任一 skill、全局安装清单 / my-skills README；以及判定项目 skill 与个人 skill 的落盘归属。
---

# 管理 Skills

安装 / 更新 / 列表：Skills CLI（`npx skills` / `skills`）。全局删除：本 skill 的 `scripts/remove-global-skill.sh`（勿只跑 `skills remove -a universal -a claude-code`，会留残留）。

## 落盘归属（先判）

写 / 改之前先定归属，再动文件：

| 类型 | 何时 | 落盘 | 登记 / 重装 |
|------|------|------|-------------|
| **项目 skill** | 跟着某个产品仓库走（如 `fast-chrome-use` 的主 skill） | 该仓库 `skills/<skill-name>/SKILL.md` | **不进** `my-skills`；不改个人仓的 `plugin.json`；默认**不全局安装**（用户明确要求再装） |
| **个人 skill** | 跨项目、装进 agent 全局用 | `yanggggjie/my-skills` → `skills/<skill-name>/SKILL.md` | 新建则登记 `plugin.json`；写完立刻重装 |

完成标准：已判定类型；后续只走对应分支。拿不准就问用户一句「这是项目 skill 还是个人 skill？」。

## 写 / 改 skill

按序执行（含改本 skill）：

1. **加载** `writing-great-skills`：Read 其 `SKILL.md`；术语按需查同目录 `GLOSSARY.md`。  
   完成标准：本轮已打开该 skill，且后续正文按其原则写（信息层级、完成标准、修剪、leading words）——禁止凭记忆硬写。
2. **起草 / 改写** `SKILL.md`（及需披露的附属文件）。文案默认**简体中文**（含 `description`）；`name` 英文 kebab-case。仅用户明确要求其它语言时切换。  
   完成标准：通过 `writing-great-skills` 的修剪检查（单一事实源、无 no-op、无重复）。
3. **落盘**到上表对应路径（目录 `skills/<skill-name>/`，文件名 `SKILL.md`）。  
   完成标准：文件在判定路径；项目 skill 未误写入 `my-skills`。
4. **登记**（仅**个人 skill** 且新建）：在 `.claude-plugin/plugin.json` 的 `skills` 中追加 `"./skills/<skill-name>"`；没有该文件则按下方参考新建。  
   完成标准：个人 skill 时 `plugin.json` 含该路径；项目 skill 跳过本步。
5. **立刻重装**（仅**个人 skill**；见「安装」，通常本地路径 + `-s <skill-name>`）。项目 skill 默认停在「已落盘」。  
   完成标准：个人 skill → `npx skills ls -g` 可见且 `~/.agents/skills/<name>` 已是本次内容；项目 skill → 未擅自全局安装。
6. **commit / push**（skill 正文 / `plugin.json`）仅在用户明确要求时做。安装清单例外见「全局安装清单」。  
   完成标准：未要求则停在归属分支的完成态（个人：已落盘 + 已重装；项目：已落盘）。

## 安装

始终：`-g`、symlink（勿传 `--copy`）、仅 `-a universal -a claude-code`。

```bash
npx skills add <owner/repo> -g -y -a universal -a claude-code
npx skills add <owner/repo> -g -y -a universal -a claude-code -s <skill-name>
npx skills add <skills仓库本地路径> -g -y -a universal -a claude-code
npx skills add <skills仓库本地路径> -g -y -a universal -a claude-code -s <skill-name>
```

完成标准：`npx skills ls -g` 可见；内容在 `~/.agents/skills/<name>`（Cursor 读 universal）；Claude Code 为指向该目录的 symlink；随后执行「全局安装清单」。

## 更新

```bash
npx skills update -g              # 全部全局
npx skills update <skill-name> -g # 单个
```

完成标准：退出码 0；内容与上游一致（或已是最新）。仅版本滚动、安装命令不变 → 不跑「全局安装清单」。

## 列出 / 删除

```bash
npx skills ls -g
```

全局删除（可多个；对 `ls` 仍登记的每个 agent 卸干净，并清 `~/.agents/skills/<name>` 与指向它的 symlink）：

```bash
# 路径：本 skill 目录下；已全局安装时亦可用 ~/.agents/skills/manage-skills/scripts/...
scripts/remove-global-skill.sh <skill-name> [<skill-name>...]
```

完成标准：`npx skills ls -g` 无该名；`~/.agents/skills/<name>` 不存在；随后执行「全局安装清单」。

自检：`scripts/remove-global-skill.sh --self-check`（退出码 0）。
## 全局安装清单

路径：`yanggggjie/my-skills` 本地仓 `README.md` 的「新机器一键安装」代码块（常见 `~/Code/x/my-skills`）。

**何时做**：全局 `add` / `remove` 使所需 `npx skills add` 集合变化时。仅改 skill 正文且安装命令不变 → 跳过。

按序：

1. 对照 `~/.agents/.skill-lock.json`（必要时 `npx skills ls -g`），重写该代码块：整仓一条；仓库含多余 skill 时用 `-s`；保持 `FLAGS='-g -y -a universal -a claude-code'`。  
   完成标准：代码块能复现当前全局安装集合。
2. 有 diff → 在该仓只提交清单相关改动 → `git push`。无 diff → 不 commit、不 push。  
   完成标准：有变更则 `origin/main` 上 README 已更新；无变更则工作区干净且未 push。

## 发现

```bash
npx skills find <query>
```

找到后按「安装」安装。更完整的发现流程可用 `find-skills`；安装命令不变。

## 参考

### 布局（个人仓与带 plugin 的技能仓）

```
<repo>/
  .claude-plugin/plugin.json   # 个人 skill 仓需要；纯项目仓可无
  skills/
    <skill-name>/
      SKILL.md
      …可选附属文件
```

项目仓常见：只有 `skills/<name>/`，**没有** `.claude-plugin/plugin.json`，也无需为了写 skill 去建它。

### plugin.json 示例（个人仓）

```json
{
  "name": "my-skills",
  "version": "1.0.0",
  "description": "个人 agent skills。",
  "skills": [
    "./skills/gh-repos",
    "./skills/manage-skills"
  ]
}
```
