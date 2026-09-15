# use case

## 判定修改规模
目标：决定只改局部还是重新梳理整份 skill
操作：
- 用户只点名局部且 use case、capability 均不增删时判为小改
- 用户要求整份重写或能力边界发生变化时判为大改
可观察结果：已明确小改或大改；小改不生成三份梳理文件

## 梳理 use case
目标：列出 skill 能独立完成的全部基本目标
操作：
- 读取模板、用户要求、现有 `SKILL.md`、README、脚本和对话点名材料
- 为每条写明目标、操作和可观察结果
- 不把步骤、注意事项或尚未存在的设计误作 use case
可观察结果：`.temp-skill/use-case.md` 存在，每条都可独立完成

## 聚合 capability
目标：把 use case 收成少数有内聚关系的能力组
操作：
- 按经常一起做、共享同一组材料归类
- 只解释为什么收在一组，不描述先后顺序
- 列出每个 capability 覆盖的 use case
可观察结果：`.temp-skill/capability.md` 存在且覆盖项可追溯到 use case

## 绘制 workflow
目标：表达 capability 之间的先后、交接与分支
操作：
- 用 Mermaid flowchart 表达能力之间的关系
- 节点写能力，边写交付物或门闩，分支表示旁路、失败或等待
可观察结果：`.temp-skill/workflow.md` 存在，能从图中读出顺序和交接

## 落笔写成 SKILL.md
目标：写出无需查阅梳理文件即可执行的 skill
操作：
- 大改时读取三份梳理文件，小改时只处理点名小节
- 按内容关系选择 Markdown 结构，不机械展开梳理目录
- 写清 frontmatter，保留现有脚本、参考与附录
- 重复需要执行的操作时写出完整动作，不使用“同上”
可观察结果：目标目录中有完整、自洽、可执行的 `SKILL.md`
