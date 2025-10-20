# 19 - 历史会话管理：找回你的对话记录

## 为什么需要会话管理？

在使用 Claude Code 的过程中，你可能会遇到以下情况：

- 🔌 意外断网导致会话中断
- 💻 电脑重启丢失对话上下文
- 📝 需要查看之前的讨论记录
- 🔄 想要继续上次未完成的任务
- 📊 需要导出对话记录作为文档

## 会话系统概述

```
┌─────────────────────────────────────────┐
│      Claude Code 会话管理系统            │
├─────────────────────────────────────────┤
│                                          │
│  自动保存                                │
│  ├── 每条消息                            │
│  ├── 代码修改记录                         │
│  ├── 执行的命令                          │
│  └── 上下文状态                          │
│                                          │
│  会话存储                                │
│  └── ~/.claude/sessions/                │
│      ├── session-2025-10-20-143015.json │
│      ├── session-2025-10-20-101230.json │
│      └── ...                            │
│                                          │
│  操作                                    │
│  ├── /resume     - 恢复会话             │
│  ├── /export     - 导出会话             │
│  ├── /sessions   - 列出所有会话          │
│  └── /delete     - 删除会话             │
│                                          │
└─────────────────────────────────────────┘
```

## 恢复会话：/resume

### 基本用法

```bash
$ claude code .

# 恢复最近的会话
> /resume

# 查看可用的会话列表
> /resume list

# 恢复特定会话
> /resume <session-id>

# 按日期恢复
> /resume 2025-10-20

# 按任务关键词搜索
> /resume search "用户登录"
```

### 会话列表示例

```bash
> /resume list

📋 最近的会话：

1. 2025-10-20 14:30 - 用户登录功能开发
   消息数：45 | 修改文件：8 | 时长：2h 15m
   最后活动：3 分钟前
   状态：✅ 已完成

2. 2025-10-20 10:15 - API 文档生成
   消息数：23 | 修改文件：15 | 时长：1h 30m
   最后活动：4 小时前
   状态：⏸️ 暂停

3. 2025-10-19 16:45 - 性能优化
   消息数：67 | 修改文件：12 | 时长：3h 45m
   最后活动：1 天前
   状态：🔄 进行中

4. 2025-10-19 09:00 - 数据库迁移
   消息数：34 | 修改文件：3 | 时长：1h 00m
   最后活动：1 天前
   状态：✅ 已完成

使用方式：
  /resume 1    - 恢复会话 1
  /resume 2    - 恢复会话 2
  ...
```

### 智能恢复

Claude Code 会智能恢复会话上下文：

```bash
> /resume 1

🔄 正在恢复会话...

✅ 会话已恢复！

📋 会话信息：
  - 开始时间：2025-10-20 14:30
  - 任务：用户登录功能开发
  - 进度：90% 完成

📝 上下文已加载：
  - 修改的文件：8 个
  - 执行的命令：15 条
  - 讨论的话题：JWT 认证、密码加密、会话管理

💡 上次的任务：
  "还需要添加登录失败次数限制和验证码功能"

是否继续？[Y/n]
```

## 导出会话：/export

### 导出格式

```bash
# 导出为 Markdown（默认）
> /export

# 导出为 JSON
> /export --format=json

# 导出为 HTML
> /export --format=html

# 导出为 PDF（需要额外工具）
> /export --format=pdf

# 指定输出文件
> /export output.md

# 导出特定会话
> /export session-2025-10-20-143015
```

### 导出内容示例

**Markdown 格式：**

```markdown
# Claude Code 会话记录

**会话 ID：** session-2025-10-20-143015
**开始时间：** 2025-10-20 14:30:15
**结束时间：** 2025-10-20 16:45:30
**时长：** 2h 15m 15s
**总消息数：** 45

---

## 会话摘要

### 任务
用户登录功能开发

### 完成情况
- ✅ 创建登录 API 端点
- ✅ 实现 JWT 认证
- ✅ 添加密码加密
- ✅ 编写单元测试
- ⏸️ 登录失败限制（待完成）

### 修改的文件
1. src/api/auth/login.ts
2. src/api/auth/register.ts
3. src/middleware/auth.ts
4. tests/auth.test.ts
5. ...

---

## 对话记录

### [14:30:15] 用户
帮我实现用户登录功能

### [14:30:20] Claude
我来帮你实现用户登录功能。首先，让我了解一下你的技术栈...

### [14:32:05] 用户
使用 Express + TypeScript + JWT

### [14:32:10] Claude
好的，我将为你创建以下文件：
1. 登录路由
2. JWT 中间件
3. 密码加密工具
...

[完整的对话历史...]

---

## 代码变更

### 文件：src/api/auth/login.ts

```typescript
// 添加的代码
export const login = async (req: Request, res: Response) => {
  // 登录逻辑
}
```

### 文件：tests/auth.test.ts

```typescript
// 测试代码
describe('Login API', () => {
  // 测试用例
})
```

---

## 执行的命令

1. `npm install jsonwebtoken bcrypt`
2. `npm test`
3. `git add src/api/auth/`
4. ...

---

## 统计信息

- **总消息数：** 45
- **代码行数：** 856 行
- **修改文件：** 8 个
- **执行命令：** 15 条
- **测试覆盖率：** 85%
```

## 使用 ccundo 撤销操作

### 什么是 ccundo？

`ccundo` 是一个第三方工具，用于撤销 Claude Code 的修改操作。

### 安装 ccundo

```bash
npm install -g ccundo

# 或使用 -f 强制安装
npm install -f ccundo
```

### 基本用法

```bash
# 撤销最近的一次修改
ccundo

# 撤销最近 3 次修改
ccundo -n 3

# 查看可撤销的操作历史
ccundo list

# 撤销特定的操作
ccundo --id=<operation-id>

# 撤销并保留在暂存区
ccundo --keep-staged
```

### 操作历史示例

```bash
$ ccundo list

📜 可撤销的操作历史：

1. [10:30:15] 修改文件: src/api/auth/login.ts
   + 添加 45 行
   - 删除 12 行

2. [10:28:42] 创建文件: tests/auth.test.ts
   + 添加 128 行

3. [10:25:10] 修改文件: src/middleware/auth.ts
   + 添加 23 行
   - 删除 8 行

使用方式：
  ccundo          - 撤销操作 1
  ccundo -n 2     - 撤销操作 1-2
  ccundo --id=2   - 仅撤销操作 2
```

### 安全撤销

```bash
# 预览撤销操作（不实际执行）
ccundo --dry-run

# 撤销前创建备份
ccundo --backup

# 交互式撤销（逐个确认）
ccundo --interactive
```

## 会话管理高级功能

### 1. 会话标签和分类

```bash
# 为会话添加标签
> /session tag add feature-login

# 按标签搜索会话
> /resume --tag=feature-login

# 查看所有标签
> /session tags
```

### 2. 会话分支

```bash
# 从当前会话创建分支
> /session branch "尝试新的实现方案"

# 切换回主会话
> /session checkout main

# 合并分支
> /session merge branch-name
```

### 3. 会话快照

```bash
# 创建当前会话的快照
> /session snapshot "登录功能完成"

# 恢复到快照
> /session restore snapshot-id

# 查看快照列表
> /session snapshots
```

## 会话存储配置

### 配置存储位置

在 `.claude/config.json` 中：

```json
{
  "sessions": {
    "storePath": "~/.claude/sessions",
    "autoSave": true,
    "saveInterval": 60,
    "maxSessions": 100,
    "compression": true
  }
}
```

### 会话自动清理

```json
{
  "sessions": {
    "retention": {
      "enabled": true,
      "maxAge": 30,
      "maxSize": "1GB",
      "archiveOld": true
    }
  }
}
```

### 会话云同步（概念性）

> ⚠️ **注意**: 以下功能可能不在当前版本中提供

```json
{
  "sessions": {
    "sync": {
      "enabled": true,
      "provider": "dropbox",
      "autoSync": true
    }
  }
}
```

## 实战场景

### 场景 1：意外中断后恢复

```bash
# 情况：开发到一半电脑崩溃了

# 重启后
$ claude code .
> /resume

[自动显示最近的会话]
> 恢复会话 1

✅ 会话已恢复！上次你正在实现登录功能...
```

### 场景 2：查看历史记录

```bash
# 需要查看上周的讨论

> /resume search "性能优化"

找到 3 个相关会话：
1. 2025-10-15 - 数据库查询优化
2. 2025-10-16 - 前端渲染优化
3. 2025-10-18 - API 响应优化

> /resume 2
[查看详细内容]

> /export session-2025-10-16.md
[导出为文档]
```

### 场景 3：团队协作

```bash
# 导出会话分享给团队

> /export --format=html team-discussion.html

# 邮件发送给团队成员
# 他们可以查看完整的讨论过程和代码修改
```

### 场景 4：撤销错误操作

```bash
# 情况：Claude 做了不想要的修改

$ ccundo list
[查看最近的操作]

$ ccundo -n 3
[撤销最近的 3 次修改]

# 重新指导 Claude
$ claude code .
> 请重新实现，但是这次...
```

## 会话分析工具

### 生成工作报告

```bash
# 生成本周的工作报告
> /session report --from=2025-10-14 --to=2025-10-20

📊 本周工作报告

时间范围：2025-10-14 至 2025-10-20

总会话数：15
总时长：32h 45m
修改文件：87 个
代码行数：+3,456 / -1,234

主要任务：
1. 用户认证系统 (8h 30m)
2. API 文档生成 (6h 15m)
3. 性能优化 (4h 45m)
4. Bug 修复 (3h 20m)
...
```

### 会话统计

```bash
# 查看会话统计信息
> /session stats

📈 会话统计

本月会话：45 个
平均时长：1h 23m
最长会话：5h 12m
总代码行数：+12,345 / -5,678

常用任务：
- 功能开发：45%
- 代码审查：20%
- Bug 修复：15%
- 文档生成：10%
- 其他：10%

效率指标：
- 测试覆盖率：平均 82%
- 代码质量分：平均 8.5/10
- 任务完成率：90%
```

## 最佳实践

### 1. 定期导出重要会话

```bash
# 每周五导出本周的工作记录
> /session export --from=this-week --format=markdown

# 归档到项目文档
mv session-export.md docs/work-logs/week-42.md
```

### 2. 使用有意义的会话名称

```bash
# 开始新会话时给个描述性的标题
$ claude code . "实现用户权限管理系统"
```

### 3. 定期清理旧会话

```bash
# 删除 30 天前的会话
> /session cleanup --older-than=30days

# 归档而不是删除
> /session archive --older-than=30days
```

### 4. 会话快照策略

```bash
# 重要里程碑时创建快照
> /session snapshot "v1.0 功能完成"
> /session snapshot "重构前的稳定版本"
```

## 故障排查

### 问题 1：无法恢复会话

```bash
# 检查会话文件
ls ~/.claude/sessions/

# 验证会话文件完整性
claude code --check-sessions

# 尝试修复
claude code --repair-sessions
```

### 问题 2：会话文件过大

```bash
# 压缩旧会话
> /session compress --older-than=7days

# 清理不必要的数据
> /session cleanup --remove-duplicates
```

### 问题 3：ccundo 无法安装

```bash
# 清理 npm 缓存
npm cache clean --force

# 重新安装
npm install -g ccundo

# 或使用 npx
npx ccundo
```

## 下一章

👉 **[第 20 章：可视化工具](20-visualization-tools.md)** - 使用 Claudia 等工具增强体验

---

**时间提示：** 本章阅读 10 分钟，实践 15 分钟 ⏱️
**难度：** ⭐⭐
