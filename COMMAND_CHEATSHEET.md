# Claude Code 2.1 命令速查卡片

> 快速查找常用命令和快捷方式

## 🚀 基础命令

### 启动和初始化

```bash
# 启动交互模式
claude .

# 一次性命令
claude -p "你的任务"
claude -p "生成登录功能"

# 初始化项目
claude init

# 查看版本
claude --version
```

### 配置和调试

```bash
# 检查配置
claude --check-config

# 查看 API Key 状态
claude --check-api-key

# 调试模式
claude --debug .

# 详细输出
claude --verbose .
```

---

## 🎯 交互模式命令

### 基础命令

```bash
/help              # 查看帮助
/clear             # 清空屏幕
/exit              # 退出（或 Ctrl+D）
```

### 会话管理

```bash
/resume            # 恢复最近的会话
/resume list       # 列出所有会话
/resume <id>       # 恢复特定会话

/export            # 导出当前会话
/export output.md  # 导出到指定文件
```

### Skills 管理 ⭐ 2.1 新增

```bash
/skills                    # 列出所有 Skills
/skills info <name>        # 查看 Skill 详情
/skills refresh            # 刷新 Skills 列表

/<skill-name>             # 使用 Skill
/<skill-name> arguments   # 使用 Skill 并传递参数
```

**示例：**
```bash
/skills                    # 查看可用 Skills
/code-review              # 代码审查
/gen-tests UserService    # 生成测试
/deploy production        # 部署到生产
```

### Agents 管理 ⭐ 2.1 新增

```bash
/agents                    # 列出所有 Agents
/agents info <name>        # 查看 Agent 详情

@<agent-name>             # 使用 Agent
@codegen                  # 使用代码生成 Agent
@security                 # 使用安全审查 Agent
@testing                  # 使用测试 Agent
```

**示例：**
```bash
/agents                    # 查看可用 Agents
@codegen 创建用户登录 API  # 生成代码
@security 审查登录代码     # 安全审查
@testing 生成测试         # 生成测试
```

### 上下文和模型 ⭐ 2.1 更新

```bash
/context               # 查看当前上下文信息
/model <name>          # 切换模型
/compact               # 紧凑模式（减少输出）
```

**示例：**
```bash
/context                              # 查看上下文使用情况
/model claude-opus-4-1-20250805      # 切换到 Opus（复杂任务）
/model claude-haiku-4-5-20251001     # 切换到 Haiku（快速响应）
```

---

## 🔧 MCP 管理命令 ⭐ 2.1 新增

### 基础管理

```bash
# 列出所有 MCP 服务器
claude mcp list

# 添加 MCP 服务器
claude mcp add <name> -- <command> [args...]

# 删除 MCP 服务器
claude mcp remove <name>

# 查看详情
claude mcp info <name>
```

### 测试和维护

```bash
# 测试连接
claude mcp test <name>

# 查看日志
claude mcp logs <name>

# 重启服务器
claude mcp restart [name]

# 更新服务器
claude mcp update <name>
```

### 启用/禁用

```bash
# 禁用 MCP 服务器
claude mcp disable <name>

# 启用 MCP 服务器
claude mcp enable <name>
```

### 实战示例

```bash
# 添加文件系统 MCP
claude mcp add filesystem -- npx @modelcontextprotocol/server-filesystem .

# 添加 Git MCP
claude mcp add git -- npx @modelcontextprotocol/server-git --repository .

# 添加数据库 MCP
claude mcp add postgres -- npx @modelcontextprotocol/server-postgres

# 查看所有 MCP
claude mcp list

# 测试连接
claude mcp test filesystem

# 删除不需要的 MCP
claude mcp remove postgres
```

---

## 📁 文件和目录结构

### 项目配置

```
.claude/
├── config.json           # 主配置文件
├── mcp-servers.json      # MCP 配置
├── agents.json           # 自定义 Agents
└── skills/               # Skills 目录 ⭐ 2.1
    └── my-skill/
        └── SKILL.md

CLAUDE.md                 # 项目规则文件
.claudeignore             # 忽略文件列表
```

### 个人配置

```
~/.claude/
├── config.json           # 全局配置
├── mcp-servers.json      # 全局 MCP
└── skills/               # 个人 Skills ⭐ 2.1
    └── my-skill/
        └── SKILL.md
```

---

## 🎨 常用任务命令

### 代码生成

```bash
# 交互模式
claude .
> 创建用户登录功能，包括前端和后端

# 一次性命令
claude -p "为 UserService 创建 CRUD API"

# 使用 SubAgent
> @codegen 创建订单管理模块
```

### 代码审查

```bash
# 使用 Skill
> /code-review src/auth/login.ts

# 使用 SubAgent
> @security 审查所有 API 端点

# 使用 Agent
> @review 完整代码审查
```

### 测试生成

```bash
# 使用 Skill
> /gen-tests UserService

# 使用 SubAgent
> @testing 为登录功能生成完整测试

# 一次性命令
claude -p "为所有 Controller 生成单元测试"
```

### 文档生成

```bash
# 使用 SubAgent
> @documentation 生成 API 文档

# 使用 Skill
> /gen-docs api

# 一次性命令
claude -p "为所有公共方法生成 JSDoc"
```

### Git 操作

```bash
# 智能提交
> 分析变更并生成提交信息

# 查看状态
> 查看 git 状态

# 创建分支
> 创建新分支 feature/user-auth
```

---

## 🔥 快捷键

### 通用快捷键

```
Ctrl+C          取消当前操作
Ctrl+D          退出交互模式
Ctrl+L          清空屏幕（同 /clear）
Tab             命令自动补全
↑/↓            浏览命令历史
```

### 编辑快捷键

```
Ctrl+A          光标移到行首
Ctrl+E          光标移到行尾
Ctrl+U          清除整行
Ctrl+K          删除光标后内容
Ctrl+W          删除前一个单词
```

---

## 📊 模型选择

### 按任务选择

```bash
# 复杂任务 - Claude Opus
claude --model claude-opus-4-1-20250805 .

# 日常开发 - Claude Sonnet（推荐）⭐
claude --model claude-sonnet-4-20250514 .

# 快速响应 - Claude Haiku
claude --model claude-haiku-4-5-20251001 .

# 使用 GPT-4
claude --model gpt-4-turbo --provider openai .

# 本地模型
claude --provider ollama --model codellama .
```

### 在交互模式中切换

```bash
> /model claude-opus-4      # 切换到 Opus
> /model claude-haiku-4     # 切换到 Haiku
> /model gpt-4-turbo        # 切换到 GPT-4
```

---

## 🎯 高效工作流

### 完整功能开发

```bash
# 1. 生成代码
> @codegen 创建用户管理 API

# 2. 生成测试
> @testing 为上面的代码生成测试

# 3. 安全审查
> @security 审查安全性

# 4. 生成文档
> @documentation 生成 API 文档

# 5. 代码审查
> @review 最终审查

# 6. 提交
> 生成提交信息并提交
```

### 快速修复

```bash
# 一次性修复
claude -p "修复所有 ESLint 错误"

# 交互式修复
> 查看 ESLint 错误
> 逐个修复
```

### 代码重构

```bash
# 使用 Refactor Agent
> @refactor 优化 UserService 的查询性能

# 使用 Skill
> /refactor src/services/UserService.java
```

---

## 🔍 调试和诊断

### 查看信息

```bash
# 查看上下文
> /context

# 查看 Skills
> /skills

# 查看 Agents
> /agents

# 查看 MCP 状态
claude mcp list
```

### 测试功能

```bash
# 测试 MCP 连接
claude mcp test filesystem

# 测试模型
claude --test-model claude-sonnet-4

# 检查配置
claude --check-config
```

### 查看日志

```bash
# MCP 日志
claude mcp logs filesystem

# 调试模式
claude --debug .

# 详细输出
claude --verbose .
```

---

## 💡 实用技巧

### 1. 命令别名（添加到 ~/.bashrc 或 ~/.zshrc）

```bash
# 基础别名
alias cc='claude code'
alias ccp='claude -p'
alias ccl='claude mcp list'

# 常用任务
alias cc-review='claude -p "代码审查"'
alias cc-test='claude -p "运行测试并修复"'
alias cc-doc='claude -p "生成文档"'
```

### 2. 批处理脚本

```bash
#!/bin/bash
# auto-workflow.sh

echo "🔍 代码审查..."
claude -p "代码审查" > review.md

echo "🧪 运行测试..."
claude -p "运行测试并修复失败的用例"

echo "📚 生成文档..."
claude -p "更新 API 文档"

echo "✅ 完成！"
```

### 3. Make 集成

```makefile
# Makefile

.PHONY: claude-review claude-test claude-doc

claude-review:
	@claude -p "代码审查" > review-report.md

claude-test:
	@claude -p "运行测试并修复"

claude-doc:
	@claude -p "生成 API 文档"

claude-all: claude-review claude-test claude-doc
	@echo "✅ 所有任务完成"
```

---

## 📚 参考资源

### 完整文档
- 📖 [教程首页](README.md)
- 🆕 [Skills 指南](docs/27-skills-guide.md)
- 🔄 [模型切换](docs/28-model-providers.md)
- 📝 [命令参考](docs/15-command-reference.md)

### 快速入门
- 🚀 [基础篇导航](docs/00-basic-tutorial.md)
- 🎯 [进阶篇导航](docs/00-advanced-tutorial.md)
- 🔄 [迁移指南](MIGRATION_GUIDE_V2.md)

### 在线资源
- 🌐 官方文档：https://code.claude.com/docs
- 💬 社区讨论：GitHub Discussions
- 🐛 问题报告：GitHub Issues

---

## 🆘 紧急救援

### 命令找不到
```bash
npm update -g @anthropic-ai/claude-code
```

### Skills 不显示
```bash
> /skills refresh
```

### MCP 连接失败
```bash
claude mcp restart
claude mcp test <name>
```

### 配置问题
```bash
claude --check-config
```

### 重置配置
```bash
claude init --reset
```

---

**提示：** 按 `Ctrl+F` 搜索本页面查找特定命令

**打印版本：** [下载 PDF](COMMAND_CHEATSHEET.pdf)

**最后更新：** 2026-01-26 | **版本：** 2.1
