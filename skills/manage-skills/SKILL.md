---
name: manage-skills
description: ms。用 Skills CLI 安装、更新、创建、改写、列出或彻底删除 agent skills。触发：ms、npx skills、全局安装、卸载残留、plugin.json、skills/ 布局、新建或改写任一 skill；以及判定项目 skill 与个人 skill 的落盘归属。
---

# 管理 Skills

安装 / 更新 / 列表：Skills CLI（`npx skills` / `skills`）。全局删除：本 skill 的 `scripts/remove-global-skill.sh`（勿只跑不带 `-a '*'` 的 `skills remove`，会留残留）。

## 落盘归属（先判）

写 / 改之前先定归属，再动文件：

| 类型 | 何时 | 落盘 | 登记 / 重装 |
|------|------|------|-------------|
| **项目 skill** | 跟着某个产品仓库走（如 `yodo-browser-skill` 的主 skill） | 该仓库 `skills/<skill-name>/SKILL.md` | **不进** `my-skills`；不改个人仓的 `plugin.json`；默认**不全局安装**（用户明确要求再装） |
| **个人 skill** | 跨项目、装进 agent 全局用 | `yanggggjie/my-skills` → `skills/<skill-name>/SKILL.md` | 新建则登记 `plugin.json`；写完立刻重装 |

完成标准：已判定类型；后续只走对应分支。拿不准就问用户一句「这是项目 skill 还是个人 skill？」。

## 写 / 改 skill

按序执行（含改本 skill）：

1. **起草 / 改写** `SKILL.md`。正文怎么写：先读 write-skill（触发词 `ws`）。先梳理 `use-case.txt`、`capability.txt`、`workflow.txt`（写在 skill 同级的 `.temp-txt/`），再写一份 `SKILL.md`。文案默认**简体中文**（含 `description`）；`name` 英文 kebab-case。仅用户明确要求其它语言时切换。  
   完成标准：`skills/.temp-txt/` 里有三份 txt；`skills/<skill-name>/SKILL.md` 已写成；结构与展开符合 `ws`。
2. **落盘**到上表对应路径（目录 `skills/<skill-name>/`，文件名 `SKILL.md`）。三份 txt 留在 `skills/.temp-txt/`，不要放进 skill 目录，也不随 skill 安装。  
   完成标准：文件在判定路径；项目 skill 未误写入 `my-skills`；skill 目录里没有这三份 txt。
3. **登记**（仅**个人 skill** 且新建）：在 `.claude-plugin/plugin.json` 的 `skills` 中追加 `"./skills/<skill-name>"`；没有该文件则按下方参考新建。  
   完成标准：个人 skill 时 `plugin.json` 含该路径；项目 skill 跳过本步。
4. **立刻重装**（仅**个人 skill**；见「安装」，通常本地路径 + `-s <skill-name>`）。项目 skill 默认停在「已落盘」。  
   完成标准：个人 skill → `npx skills ls -g` 可见且 `~/.agents/skills/<name>` 已是本次内容；项目 skill → 未擅自全局安装。
5. **commit / push**（skill 正文 / `plugin.json`）仅在用户明确要求时做。  
   完成标准：未要求则停在归属分支的完成态（个人：已落盘 + 已重装；项目：已落盘）。

## 安装

始终：`-g`、symlink（勿传 `--copy`）、`-a '*'`（Skills CLI 支持的全部 agent）。

```bash
npx skills add <owner/repo> -g -y -a '*'
npx skills add <owner/repo> -g -y -a '*' -s <skill-name>
npx skills add <skills仓库本地路径> -g -y -a '*'
npx skills add <skills仓库本地路径> -g -y -a '*' -s <skill-name>
```

完成标准：`npx skills ls -g` 可见；内容在 `~/.agents/skills/<name>`（canonical）；各 agent 目录多为指向该目录的 symlink。

## 更新

```bash
npx skills update -g              # 全部全局
npx skills update <skill-name> -g # 单个
```

完成标准：退出码 0；内容与上游一致（或已是最新）。

## 列出 / 删除

```bash
npx skills ls -g
```

全局删除（可多个；对 `ls` 仍登记的每个 agent 卸干净，并清 `~/.agents/skills/<name>` 与指向它的 symlink）：

```bash
# 路径：本 skill 目录下；已全局安装时亦可用 ~/.agents/skills/manage-skills/scripts/...
scripts/remove-global-skill.sh <skill-name> [<skill-name>...]
```

完成标准：`npx skills ls -g` 无该名；`~/.agents/skills/<name>` 不存在。

自检：`scripts/remove-global-skill.sh --self-check`（退出码 0）。

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
    .temp-txt/                 # 与 skill 同级；梳理产物，不进 payload
      use-case.txt
      capability.txt
      workflow.txt
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
