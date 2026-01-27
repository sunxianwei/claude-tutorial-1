# Claude Code 2.1 迁移指南

> 从 Claude Code 1.x 升级到 2.1 的完整指南

## 📋 概述

Claude Code 2.1 带来了多项重大更新，本指南帮助你快速迁移到新版本并充分利用新功能。

## 🆕 主要变化

### 1. Skills 系统（取代自定义命令）

**变化：** 自定义命令功能已合并到 Skills 系统中。

#### 影响范围
- `.claude/commands/` 目录中的文件仍然有效
- 但推荐迁移到新的 Skills 系统

#### 迁移步骤

**旧方式（1.x）：**
```
.claude/commands/
├── review.md
├── deploy.md
└── test.md
```

**新方式（2.1）：**
```
.claude/skills/
├── review/
│   └── SKILL.md
├── deploy/
│   └── SKILL.md
└── test/
    └── SKILL.md
```

**迁移示例：**

```bash
# 1. 创建 Skills 目录
mkdir -p .claude/skills/review

# 2. 转换命令文件为 Skill
# 旧文件：.claude/commands/review.md
cat .claude/commands/review.md
```

```markdown
# Code Review

审查代码并提供建议：
1. 检查代码规范
2. 查找潜在问题
3. 提供优化建议
```

```bash
# 新文件：.claude/skills/review/SKILL.md
cat > .claude/skills/review/SKILL.md << 'EOF'
---
name: review
description: Comprehensive code review with standards checking
disable-model-invocation: true
allowed-tools: Read, Grep
---

# Code Review

审查代码并提供建议：
1. 检查代码规范
2. 查找潜在问题
3. 提供优化建议
4. 生成审查报告
EOF
```

**批量迁移脚本：**

```bash
#!/bin/bash
# migrate-commands-to-skills.sh

echo "🔄 迁移自定义命令到 Skills..."

# 遍历所有命令文件
for cmd_file in .claude/commands/*.md; do
  # 提取文件名（不含扩展名）
  cmd_name=$(basename "$cmd_file" .md)
  
  # 创建 Skill 目录
  mkdir -p ".claude/skills/$cmd_name"
  
  # 复制并转换为 SKILL.md
  echo "---" > ".claude/skills/$cmd_name/SKILL.md"
  echo "name: $cmd_name" >> ".claude/skills/$cmd_name/SKILL.md"
  echo "description: Auto-migrated from commands" >> ".claude/skills/$cmd_name/SKILL.md"
  echo "---" >> ".claude/skills/$cmd_name/SKILL.md"
  echo "" >> ".claude/skills/$cmd_name/SKILL.md"
  cat "$cmd_file" >> ".claude/skills/$cmd_name/SKILL.md"
  
  echo "✅ 迁移 $cmd_name"
done

echo "✅ 迁移完成！"
echo "📝 建议：手动检查并优化 Skills 的前置元数据"
```

---

### 2. MCP 管理命令（简化配置）

**变化：** 新增命令行工具管理 MCP 服务器。

#### 旧方式（1.x）

手动编辑 `.claude/mcp-servers.json`：

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "."]
    }
  }
}
```

#### 新方式（2.1）⭐

使用命令行工具：

```bash
# 添加 MCP
claude mcp add filesystem -- npx @modelcontextprotocol/server-filesystem .

# 查看所有 MCP
claude mcp list

# 测试 MCP
claude mcp test filesystem

# 删除 MCP
claude mcp remove filesystem
```

#### 迁移建议

**选项 1：继续使用配置文件**
- 现有配置文件仍然有效
- 适合团队协作（配置文件可提交到版本控制）

**选项 2：迁移到命令行工具**
- 更简单直观
- 自动验证配置
- 适合个人开发

**混合方案（推荐）：**
```bash
# 项目级 MCP：使用配置文件（提交到版本控制）
# .claude/mcp-servers.json

# 个人 MCP：使用命令行工具
claude mcp add context7 -- npx mcp-server-context7
```

---

### 3. 交互模式新命令

**新增命令：**

```bash
# Skills 管理
/skills                    # 列出所有 Skills
/skills info <name>        # 查看 Skill 详情
/<skill-name>             # 使用 Skill

# Agents 管理
/agents                    # 列出所有 Agents
/agents info <name>        # 查看 Agent 详情
@<agent-name>             # 使用 Agent

# 上下文查看
/context                   # 查看当前上下文信息

# 模型切换
/model <model-name>        # 切换模型

# 紧凑模式
/compact                   # 减少输出冗余
```

#### 迁移影响

**无破坏性变更** - 所有旧命令仍然有效：
- `/help` - 帮助
- `/resume` - 恢复会话
- `/export` - 导出会话
- `/clear` - 清空屏幕

---

### 4. 配置文件更新

**新增配置选项：**

```json
// .claude/config.json
{
  "model": "claude-sonnet-4-20250514",
  "provider": "anthropic",  // 新增：模型供应商
  
  // 新增：后备模型
  "fallbackModels": [
    {
      "provider": "openai",
      "model": "gpt-4-turbo"
    }
  ],
  
  // 新增：Skills 配置
  "skills": {
    "charBudget": 15000,     // Skills 描述字符预算
    "autoLoad": true          // 自动加载 Skills
  },
  
  // 现有配置保持不变
  "temperature": 0.7,
  "maxTokens": 4096
}
```

#### 迁移步骤

1. **备份现有配置**
```bash
cp .claude/config.json .claude/config.json.backup
```

2. **添加新配置项（可选）**
```bash
# 只添加需要的配置，不是必须的
```

3. **验证配置**
```bash
claude --check-config
```

---

## 🚀 快速迁移步骤

### 步骤 1：更新 Claude Code

```bash
# 更新到最新版本
npm update -g @anthropic-ai/claude-code

# 验证版本
claude --version
# 应该显示 2.1.x 或更高
```

### 步骤 2：检查兼容性

```bash
# 进入项目目录
cd your-project

# 测试现有配置
claude --check-config

# 查看 MCP 状态
claude mcp list
```

### 步骤 3：迁移自定义命令（可选）

```bash
# 运行迁移脚本（如果有自定义命令）
bash migrate-commands-to-skills.sh

# 或手动迁移重要命令
```

### 步骤 4：体验新功能

```bash
# 启动 Claude Code
claude .

# 尝试新命令
> /skills
> /agents
> /context
```

### 步骤 5：创建第一个 Skill

```bash
# 创建简单的 Skill
mkdir -p .claude/skills/hello
cat > .claude/skills/hello/SKILL.md << 'EOF'
---
name: hello
description: A simple hello world skill
---

Say hello in a friendly way!
EOF

# 测试
claude .
> /hello
```

---

## ⚠️ 注意事项

### 1. 破坏性变更

**无破坏性变更** - 2.1 版本完全向后兼容 1.x。

### 2. 推荐但非强制的迁移

以下迁移是**推荐**的但**非强制**的：
- ✅ 自定义命令迁移到 Skills（推荐）
- ✅ 使用 MCP 命令行工具（推荐）
- ✅ 尝试新的交互命令（推荐）

### 3. 配置文件位置

确保配置文件在正确位置：
```
项目级：.claude/
用户级：~/.claude/
```

---

## 🎯 迁移检查清单

### 基础迁移
- [ ] 更新 Claude Code 到 2.1+
- [ ] 验证版本：`claude --version`
- [ ] 测试现有项目：`claude .`
- [ ] 检查配置：`claude --check-config`
- [ ] 查看 MCP 状态：`claude mcp list`

### Skills 迁移
- [ ] 了解 Skills 系统
- [ ] 决定是否迁移自定义命令
- [ ] 如迁移，运行迁移脚本
- [ ] 测试迁移后的 Skills
- [ ] 更新团队文档

### MCP 优化
- [ ] 了解 MCP 命令行工具
- [ ] 尝试 `claude mcp` 命令
- [ ] 决定使用配置文件还是命令行
- [ ] 更新团队 MCP 管理流程

### 新功能体验
- [ ] 创建第一个 Skill
- [ ] 尝试新的交互命令
- [ ] 测试 Agent 使用
- [ ] 尝试模型切换（可选）

---

## 📚 学习新功能

### 优先级 1：必学（1-2 天）

**Skills 系统：**
- 阅读 [Skills 完全指南](docs/27-skills-guide.md)（20 分钟）
- 创建 2-3 个 Skills（1 小时）
- 在项目中使用（1-2 小时）

**MCP 命令行工具：**
- 阅读 [MCP 管理最佳实践](docs/03-mcp-setup.md#mcp-管理最佳实践)（10 分钟）
- 尝试 `claude mcp` 命令（30 分钟）

### 优先级 2：推荐（3-5 天）

**模型切换：**
- 阅读 [切换模型供应商](docs/28-model-providers.md)（15 分钟）
- 配置 1-2 个备选模型（30 分钟）
- 根据任务测试不同模型（1 小时）

**新命令：**
- 阅读 [命令参考](docs/15-command-reference.md)（10 分钟）
- 熟悉新的交互命令（30 分钟）

### 优先级 3：可选（按需）

**高级功能：**
- SubAgents 深度使用
- 上下文优化
- 自定义 Agent
- Hook 系统

---

## 🔧 故障排查

### 问题 1：命令找不到

**症状：**
```bash
claude mcp: command not found
```

**解决方案：**
```bash
# 更新到最新版本
npm update -g @anthropic-ai/claude-code

# 或重新安装
npm uninstall -g @anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code
```

### 问题 2：Skills 不显示

**症状：**
```bash
> /skills
No skills available
```

**检查：**
1. Skills 目录是否存在？
   ```bash
   ls -la .claude/skills/
   ls -la ~/.claude/skills/
   ```

2. SKILL.md 文件是否正确？
   ```bash
   cat .claude/skills/my-skill/SKILL.md
   ```

3. 刷新 Skills 列表：
   ```bash
   > /skills refresh
   ```

### 问题 3：MCP 命令报错

**症状：**
```bash
claude mcp list
Error: Cannot read mcp-servers.json
```

**解决方案：**
```bash
# 初始化配置
claude init

# 或手动创建
mkdir -p .claude
echo '{"mcpServers": {}}' > .claude/mcp-servers.json
```

### 问题 4：配置不兼容

**症状：**
```bash
Warning: Unknown config field 'xxx'
```

**解决方案：**
- 2.1 会忽略未知字段，这是警告不是错误
- 可以移除未使用的配置项

---

## 📞 获取帮助

### 文档资源
- 📚 [完整教程首页](README.md)
- 🆕 [Skills 完全指南](docs/27-skills-guide.md)
- 🔄 [模型切换指南](docs/28-model-providers.md)
- 📖 [命令参考](docs/15-command-reference.md)

### 社区支持
- GitHub Issues
- GitHub Discussions
- 官方文档：https://code.claude.com/docs

### 紧急问题
1. 查看 [故障排查](#故障排查) 部分
2. 检查 [常见问题](docs/01-quick-start.md)
3. 在社区提问

---

## 🎉 迁移完成

完成迁移后，你应该能够：
- ✅ 正常使用所有 1.x 功能
- ✅ 使用 Skills 系统
- ✅ 使用 MCP 命令行工具
- ✅ 使用新的交互命令
- ✅ 体验到更好的开发体验

**下一步：**
- 🚀 探索新功能
- 📚 深入学习 [进阶篇](docs/00-advanced-tutorial.md)
- 🎯 优化你的工作流

**祝迁移顺利！** 🎊
