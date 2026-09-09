# use case

## 判定落盘归属
目标：先定这份 skill 是项目还是个人，再动文件
操作：
- 看它是否跟着某个产品仓库走
- 项目 → 该仓库 `skills/<skill-name>/SKILL.md`，不进 my-skills，默认不全局安装
- 个人 → `yanggggjie/my-skills` 的 `skills/<skill-name>/SKILL.md`
可观察结果：已判定类型；后续只走对应分支

## 起草改写
目标：把 skill 写成可执行的 `SKILL.md`
操作：
1. 读 write-skill（含表达规定、小改 / 大改）
2. 对着 `templates/` 写 `skills/temp-skill/<skill-name>/` 三份 md（小改不写）
3. 再写成一份 `SKILL.md`
可观察结果：大改时三份 md 在对应 skill 目录下；`SKILL.md` 结构符合 ws

## 落盘
目标：把 `SKILL.md` 放到判定路径
操作：目录 `skills/<skill-name>/`；三份 md 留在 `skills/temp-skill/<skill-name>/`，不进 skill 目录
可观察结果：文件在判定路径；skill 目录里没有三份 md

## 登记
目标：个人仓新建 skill 时写入 plugin.json
操作：在 `.claude-plugin/plugin.json` 的 `skills` 追加 `"./skills/<skill-name>"`；项目 skill 跳过
可观察结果：个人 skill 时 plugin.json 含该路径

## 重装
目标：个人 skill 写完立刻装进全局
操作：`npx skills add <本地路径> -g -y -a '*' -s <skill-name>`；项目 skill 默认停在已落盘
可观察结果：`npx skills ls -g` 可见且 `~/.agents/skills/<name>` 已是本次内容

## 安装
目标：把 skill 装进全局
操作：始终 `-g`、symlink、`-a '*'`
可观察结果：`npx skills ls -g` 可见

## 更新
目标：把已装的全局 skill 更新到与源一致
操作：`npx skills update -g` 或 `npx skills update <skill-name> -g`
可观察结果：退出码 0

## 列出与删除
目标：查看或卸干净全局 skill
操作：
- 列出：`npx skills ls -g`
- 删除：`scripts/remove-global-skill.sh <skill-name> [...]`
可观察结果：删除后 `ls` 无该名且 `~/.agents/skills/<name>` 不存在

## 发现
目标：按查询找到可装的 skill
操作：`npx skills find <query>`；找到后按安装来装
可观察结果：有可跟的安装命令或已交给安装
