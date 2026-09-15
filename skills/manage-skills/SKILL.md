---
name: manage-skills
description: >-
  触发词 ms、manage-skills、npx skills。管理 agent skills 的归属、落盘、插件登记、安装、更新、列出、发现与彻底删除。
  新建或改写正文时先使用 writing-skill；本 skill 不负责设计 SKILL.md 内容。
---

# 职责

`manage-skills` 处理两类任务：

| 任务 | 负责内容 |
|---|---|
| 新建或改写 skill | 判定项目/个人归属、正确落盘、必要登记、按规则重装 |
| 管理已安装 skill | 安装、更新、列出、发现、彻底删除 |

写作与梳理由 `writing-skill` 完成。本 skill 接收写好的 `SKILL.md` 和大改时的 `.temp-skill/`，不重新设计正文。

# 判定归属

新建或改写前，先判断 skill 属于项目还是个人，再动文件。

| 类型 | 判断 | 落盘位置 | 登记与安装 |
|---|---|---|---|
| 项目 skill | 跟随某个产品仓库交付 | 该仓库 `skills/<skill-name>/SKILL.md` | 不进入 `my-skills`，不改个人插件清单，默认不全局安装 |
| 个人 skill | 跨项目使用、安装到 agent 全局 | `my-skills/skills/<skill-name>/SKILL.md` | 新建时登记，写完立即重装 |

无法从仓库和用户要求判断时，只问一句：“这是项目 skill 还是个人 skill？”确认前不落盘。

# 新建或改写

1. 先调用 `writing-skill` 完成梳理与正文。
2. 将 `SKILL.md` 放进判定出的 `skills/<skill-name>/`。
3. 大改产生的 `use-case.md`、`capability.md`、`workflow.md` 保留在目标 `SKILL.md` 同级的 `.temp-skill/`。
4. 保留该 skill 已有的 `scripts/`、模板、参考和其它附属文件。
5. 根据归属执行登记或安装。

项目 skill 到正确仓库落盘后即完成，除非用户明确要求安装。

个人 skill 新建时，在 `.claude-plugin/plugin.json` 的 `skills` 数组中追加：

```json
"./skills/<skill-name>"
```

已有个人 skill 不重复登记。`commit` 和 `push` 只在用户明确要求时执行。

# 安装

默认使用 Skills CLI 全局 symlink 安装：传 `-g`、`-y`，不传 `--copy`。

通用仓库的安装形式：

```bash
npx skills add <owner/repo> -g -y -a '*'
npx skills add <owner/repo> -g -y -a '*' -s <skill-name>
npx skills add <本地仓库绝对路径> -g -y -a '*'
npx skills add <本地仓库绝对路径> -g -y -a '*' -s <skill-name>
```

若目标仓库自己的 `AGENTS.md` 规定了更窄的 agent 范围，以仓库约定为准。例如 `my-skills` 只安装到 `universal` 与 `claude-code`：

```bash
npx skills add /Users/youshiyitian/Code/x/my-skills \
  -g -y \
  -a universal \
  -a claude-code
```

安装完成后检查：

1. `npx skills ls -g` 能看到目标名称。
2. canonical 内容位于 `~/.agents/skills/<skill-name>`。
3. 对应 agent 目录使用 symlink 指向 canonical 目录。
4. 本地重装时，已安装 `SKILL.md` 与仓库当前文件一致。

# 更新与列出

更新全部或单个全局 skill：

```bash
npx skills update -g
npx skills update <skill-name> -g
```

列出当前全局安装状态：

```bash
npx skills ls -g
```

更新完成标准是命令退出码为 `0`，内容已同步或确认已经是最新。

# 发现 skill

按关键词查找：

```bash
npx skills find <query>
```

找到候选后，根据来源和目标 agent 按“安装”执行。需要更完整的发现流程时可使用 `find-skills`，安装规则不变。

# 彻底删除

不要只运行针对部分 agent 的 `skills remove`，否则可能留下登记、canonical 目录或 symlink。

使用本 skill 附带的脚本：

```bash
scripts/remove-global-skill.sh <skill-name> [<skill-name>...]
```

已全局安装时，也可使用：

```bash
~/.agents/skills/manage-skills/scripts/remove-global-skill.sh <skill-name>
```

脚本会：

- 对 Skills CLI 仍登记的 agent 执行删除；
- 清理 `~/.agents/skills/<skill-name>`；
- 清理指向 canonical 目录的残留 symlink；
- 再次检查名称和目录是否仍存在。

运行脚本自检：

```bash
scripts/remove-global-skill.sh --self-check
```

删除完成后，`npx skills ls -g` 不再列出该名称，且 `~/.agents/skills/<skill-name>` 不存在。

# 目录参考

```text
<repo>/
├── .claude-plugin/
│   └── plugin.json
└── skills/
    └── <skill-name>/
        ├── SKILL.md
        ├── .temp-skill/
        │   ├── use-case.md
        │   ├── capability.md
        │   └── workflow.md
        └── <可选附属文件>
```

纯项目 skill 可以没有 `.claude-plugin/plugin.json`。不要为了写项目 skill 而在个人仓登记它。

# 完成标准

- [ ] 新建或改写前已经判定归属。
- [ ] `SKILL.md` 与 `.temp-skill/` 落在正确仓库。
- [ ] 只有新建个人 skill 修改了个人插件清单。
- [ ] 项目 skill 未在用户未授权时全局安装。
- [ ] 个人 skill 写完后已从本地路径重装并核对内容。
- [ ] 删除任务通过专用脚本清除了登记、目录和 symlink。
- [ ] 未在用户未要求时执行 `commit` 或 `push`。
