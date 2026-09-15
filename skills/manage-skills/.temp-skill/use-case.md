# use case

## 判定 skill 归属
目标：在写文件前确定 skill 属于项目还是个人
操作：
- 判断 skill 是否随某个产品仓库交付
- 项目 skill 指向该仓库 `skills/<skill-name>/SKILL.md`
- 个人 skill 指向 `my-skills/skills/<skill-name>/SKILL.md`
可观察结果：类型、落盘路径、是否登记与重装均已明确

## 落盘写好的 skill
目标：把 `writing-skill` 交付的文件放到正确目录
操作：
- 将 `SKILL.md` 与大改产生的 `.temp-skill/` 保存在判定路径
- 保留目标 skill 的附属脚本和参考文件
可观察结果：文件只出现在正确归属的仓库中

## 登记新建的个人 skill
目标：让个人仓插件清单包含新 skill
操作：
- 在 `.claude-plugin/plugin.json` 的 `skills` 中追加 `./skills/<skill-name>`
- 项目 skill 不修改个人仓清单
可观察结果：新个人 skill 可由插件清单发现

## 重装改过的个人 skill
目标：让本机使用刚落盘的个人 skill
操作：
- 从本地 `my-skills` 路径全局 symlink 安装指定 skill
- 检查全局列表和 canonical 目录内容
可观察结果：已安装内容与本地本次修改一致

## 安装 skill
目标：从仓库或本地路径全局安装一个或全部 skill
操作：
- 使用 `npx skills add`
- 始终传 `-g`、`-y`、`-a '*'`，不传 `--copy`
可观察结果：`npx skills ls -g` 可见，canonical 目录存在

## 更新 skill
目标：让已安装 skill 与其上游一致
操作：
- 使用 `npx skills update -g` 更新全部，或指定名称更新单个
可观察结果：命令退出码为 0，内容已更新或确认最新

## 列出全局 skill
目标：查看本机全局安装的名称、路径与 agent
操作：
- 运行 `npx skills ls -g`
可观察结果：终端列出当前全局 skills

## 彻底删除全局 skill
目标：删除登记、canonical 目录和各 agent symlink
操作：
- 运行 `scripts/remove-global-skill.sh <skill-name> [...]`
- 不用普通的部分 agent 删除替代该脚本
可观察结果：全局列表无该名称且 canonical 目录不存在

## 发现可安装的 skill
目标：按关键词查找 skill
操作：
- 运行 `npx skills find <query>`
- 找到后按安装规则处理
可观察结果：获得候选与安装入口，或完成安装
