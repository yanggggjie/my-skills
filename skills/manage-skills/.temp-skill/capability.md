# capability

## 归属管理
归属决定 skill 的目标仓库、插件登记和默认安装行为，这些决策必须共享同一判断。

覆盖：判定 skill 归属、落盘写好的 skill、登记新建的个人 skill、重装改过的个人 skill

## 安装维护
安装、更新与列出都通过 Skills CLI 操作同一套全局安装状态。

覆盖：安装 skill、更新 skill、列出全局 skill

## 删除清理
完整删除需要同时处理 Skills CLI 登记、canonical 目录与各 agent symlink，因此独立成组。

覆盖：彻底删除全局 skill

## 技能发现
发现产生候选或安装入口，材料和目的与具体装机操作不同。

覆盖：发现可安装的 skill
