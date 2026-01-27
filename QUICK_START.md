# 快速开始：Claude Code 2.1 完整指南

> 新项目 vs 老项目 | 基础 vs 进阶 | 5 分钟快速上手

## 🎯 选择你的起点

### 我是新用户（推荐从这里开始）
👉 **[5 分钟快速体验](#5-分钟快速体验)** - 立即体验 Claude Code

### 我要开发新项目
👉 **[新项目开发](#新项目开发)** - 完整案例：图书管理系统

### 我要维护老项目
👉 **[老项目开发](#老项目开发)** - 渐进式接入策略

### 我从 1.x 升级到 2.1
👉 **[迁移指南](MIGRATION_GUIDE_V2.md)** - 完整升级指南

---

## ⚡ 5 分钟快速体验

### 步骤 1：安装 Claude Code（1 分钟）

```bash
# 安装
npm install -g @anthropic-ai/claude-code

# 验证版本（应该是 2.1.x 或更高）
claude --version
```

### 步骤 2：配置 API Key（1 分钟）

```bash
# 设置 API Key
export ANTHROPIC_API_KEY="sk-ant-xxxxxxxxxxxx"

# 或永久保存到 ~/.bashrc 或 ~/.zshrc
echo 'export ANTHROPIC_API_KEY="sk-ant-xxxxxxxxxxxx"' >> ~/.bashrc
source ~/.bashrc
```

**获取 API Key：** https://console.anthropic.com

### 步骤 3：体验 Claude Code（3 分钟）

```bash
# 进入任意项目目录
cd your-project

# 启动 Claude Code
claude .

# 尝试一些命令
> 帮我分析这个项目的技术栈

> 查看有哪些 Skills 可用
> /skills

> 查看有哪些 Agents 可用
> /agents

> 创建一个简单的 Hello World 程序
```

**恭喜！** 🎉 你已经完成了第一次体验。

**下一步：**
- 🆕 开发新项目？→ [新项目开发](#新项目开发)
- 🔧 维护老项目？→ [老项目开发](#老项目开发)
- 📚 系统学习？→ [基础篇导航](docs/00-basic-tutorial.md)

---

## 🆕 新项目开发

### 完整案例：在线图书管理系统

**项目地址：** [examples/new-project-demo/](examples/new-project-demo/)

**技术栈：**
- 后端：Spring Boot 2.7 + JDK 1.8 + MyBatis + MySQL
- 前端：Vue 3 + Element Plus + Axios
- 测试：JUnit 5 + Playwright

### 快速开始（使用 2.1 新功能）⭐

```bash
# 1. 创建项目目录
mkdir book-management-system
cd book-management-system

# 2. 初始化 Claude Code
claude init

# 3. 配置 MCP（使用 2.1 命令行工具）⭐
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
claude mcp add playwright -- npx -y mcp-server-playwright

# 4. 验证 MCP 配置
claude mcp list

# 5. 启动 Claude Code
claude .

# 6. 复制项目 Prompt
# 从 examples/new-project-demo/README.md 复制完整的开发 Prompt

# 7. 粘贴到 Claude Code 并开始开发
```

### 使用 Skills 加速开发（2.1 新功能）⭐

创建项目专用的 Skills：

```bash
# 创建测试生成 Skill
mkdir -p .claude/skills/gen-tests
cat > .claude/skills/gen-tests/SKILL.md << 'EOF'
---
name: gen-tests
description: Generate comprehensive test suite for this project
---

Generate tests following project standards:
- Backend: JUnit 5 + Mockito
- Frontend: Vitest + Testing Library
- E2E: Playwright
- Target coverage: >= 80%
EOF

# 创建代码审查 Skill
mkdir -p .claude/skills/review
cat > .claude/skills/review/SKILL.md << 'EOF'
---
name: review
description: Code review following project standards
---

Review code for:
1. Code quality
2. Security issues
3. Performance problems
4. Test coverage
EOF

# 使用 Skills
claude .
> /gen-tests UserService
> /review src/
```

### 项目包含功能

- ✅ 用户认证（登录/注册）
- ✅ 图书管理（增删改查）
- ✅ 借阅管理
- ✅ 后端 API + 前端页面
- ✅ 单元测试（覆盖率 > 80%）
- ✅ E2E 测试（Playwright）
- ✅ API 文档（Swagger）

**预计开发时间：** 30 分钟

### 2.1 新功能应用示例

#### 使用 SubAgents 加速开发

```bash
claude .

# 1. 生成后端代码
> @codegen 创建图书管理模块的后端 API

# 2. 生成前端代码
> @codegen 创建图书管理的前端页面

# 3. 生成测试
> @testing 为图书模块生成完整测试

# 4. 安全审查
> @security 审查图书管理模块的安全性

# 5. 生成文档
> @documentation 生成图书管理 API 文档
```

#### 使用模型切换优化成本

```bash
# 简单任务使用 Haiku（快速便宜）
claude --model claude-haiku-4-5-20251001 .
> 生成 README 文档

# 复杂任务使用 Opus（强大精准）
claude --model claude-opus-4-1-20250805 .
> 设计图书管理系统的数据库架构
```

**详细指南：** [examples/new-project-demo/README.md](examples/new-project-demo/README.md)

---

## 🔧 老项目开发

### 详细指南

**文档地址**: [docs/21-legacy-project-guide.md](docs/21-legacy-project-guide.md)

### 核心步骤

#### 1. 准备工作（10 分钟）

```bash
# 1. 创建开发分支
git checkout -b feature/claude-code-integration

# 2. 备份当前状态
git add .
git commit -m "feat: 准备接入 Claude Code"

# 3. 初始化 Claude Code
claude init

# 4. 配置 MCP（使用 2.1 命令行工具）⭐
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .

# 5. 验证配置
claude mcp list
claude --check-config
```

#### 2. 项目分析（20 分钟）

**启动 Claude Code**:
```bash
claude .
```

**使用分析 Prompt**（复制以下内容）:

```markdown
我有一个老项目需要你帮助维护和开发新功能。

首先，请帮我分析这个项目的基本情况：

## 分析任务

### 1. 项目结构分析
请分析项目的目录结构，识别：
- 项目类型（Spring Boot、Vue、React 等）
- 主要目录的作用
- 配置文件位置
- 关键文件（入口文件、路由文件、配置文件）

### 2. 技术栈识别
请识别：
- 编程语言和版本
- 主要框架和库
- 构建工具
- 数据库类型
- 第三方依赖

### 3. 代码风格分析
请分析现有代码的风格：
- 命名规范
- 目录组织方式
- 注释风格
- 代码格式化规则

### 4. 业务逻辑概览
通过文件名、目录结构和关键代码，推测：
- 主要业务模块
- 核心功能
- 数据模型

### 5. 问题识别
识别潜在问题：
- 缺失的文档
- 代码质量问题
- 技术债务
- 安全隐患

现在开始分析吧！
```

#### 3. 创建项目规范（30 分钟）

基于分析结果，创建 `CLAUDE.md`。

**模板**: 查看 [docs/21-legacy-project-guide.md](docs/21-legacy-project-guide.md#创建项目规范文件)

**关键内容**:
- ✅ 现有代码的命名规范
- ✅ 项目结构说明
- ✅ 依赖使用规范
- ✅ 特殊约定和注意事项
- ✅ 代码示例（重要！）

#### 4. 渐进式接入（持续）

**策略 1: 按模块接入**
```
选择独立模块 → 完善规范 → 新功能使用 Claude → 积累经验 → 推广
```

**策略 2: 按任务类型接入**
```
简单任务（文档、测试）→ 中等难度（CRUD）→ 复杂任务（核心业务）
```

**策略 3: 双轨制运行**
```
核心开发者先行 → 建立规范 → 培训团队 → 逐步推广
```

### 常见场景 Prompt

#### 场景 1：添加新功能

```markdown
请为本项目开发 [功能描述]。

⚠️ 重要：这是一个老项目，请遵循以下规范：

## 必须遵守的规则

1. **命名规范**
   [根据你的项目填写]

2. **依赖使用**
   [根据你的项目填写]

3. **返回结果**
   [根据你的项目填写]

## 功能需求
[详细描述]

## 实现要求
1. 保持与现有代码风格一致
2. 添加必要的注释
3. 编写单元测试

请开始开发。
```

#### 场景 2：修复 Bug

```markdown
请修复以下 Bug：

## Bug 描述
[详细描述]

## 修复要求

⚠️ 这是 Bug 修复，请注意：
1. 最小化修改
2. 保持原有代码风格
3. 不改变方法签名
4. 充分测试

请开始修复。
```

#### 场景 3：代码重构

```markdown
我想重构 [模块/类/方法]。

## 重构步骤

### 阶段 1：分析现状
### 阶段 2：编写测试
### 阶段 3：执行重构
### 阶段 4：验证结果

⚠️ 重要：小步重构，频繁测试！

请开始重构。
```

### 2.1 新功能在老项目中的应用 ⭐

#### 使用 Skills 标准化老项目工作流

```bash
# 创建老项目专用的 Skills
mkdir -p .claude/skills/legacy-fix
cat > .claude/skills/legacy-fix/SKILL.md << 'EOF'
---
name: legacy-fix
description: Fix bugs in legacy code following project conventions
disable-model-invocation: true
---

⚠️ 这是老项目，修复 Bug 时请注意：

1. **最小化修改** - 只修改必要的代码
2. **保持风格一致** - 遵循现有代码风格
3. **不改变签名** - 不修改公共方法签名
4. **充分测试** - 添加单元测试验证修复
5. **详细注释** - 说明修改原因

Fix the bug in $ARGUMENTS
EOF

# 使用 Skill
claude .
> /legacy-fix UserService.findById 方法空指针异常
```

#### 使用 Agents 分析老项目

```bash
claude .

# 使用 Explore Agent 分析项目结构
> @explore 分析这个项目的架构和技术栈

# 使用 Review Agent 发现问题
> @review 审查项目中的安全问题和技术债务

# 使用 Security Agent 安全审查
> @security 检查项目中的安全漏洞
```

#### 使用命令行管理老项目的 MCP

```bash
# 老项目可能需要特定的 MCP 配置
claude mcp add legacy-db -- npx @modelcontextprotocol/server-postgres
claude mcp add legacy-gitlab -- npx @modelcontextprotocol/server-gitlab

# 测试连接
claude mcp test legacy-db

# 查看所有配置
claude mcp list
```

### 最佳实践

1. **✅ 充分分析** - 深入理解现有代码（使用 @explore Agent）⭐
2. **✅ 详细规范** - 创建完善的 CLAUDE.md（包含代码示例）
3. **✅ 小步前进** - 渐进式接入，不要激进
4. **✅ 测试保障** - 先测试后修改（使用 @testing Agent）⭐
5. **✅ 使用 Skills** - 为老项目创建专用 Skills ⭐
6. **✅ 持续优化** - 不断改进规范和流程

### 常见问题

**Q: Claude 生成的代码风格与项目不一致？**
A: 在 CLAUDE.md 中增加更多代码示例。

**Q: Claude 修改了不应该修改的文件？**
A: 明确指定修改范围："请只修改 UserController.java"。

**Q: 生成的代码破坏了现有功能？**
A: 回滚代码，先补充测试，再进行修改。

**Q: 不知道如何描述需求？**
A: 使用结构化的 Prompt（需求、背景、验收标准）。

**Q: Claude 对项目理解不准确？**
A: 提供更多上下文，参考现有的正确实现。

---

## 对比总结

| 特性 | 新项目 | 老项目 |
|-----|--------|--------|
| **开发速度** | 🚀 极快 | 🐢 较慢 |
| **规范遵循** | ✅ 容易 | ⚠️ 需要适配 |
| **风险** | ✅ 低 | ⚠️ 中高 |
| **测试要求** | ✅ 标准 | 🔴 更严格 |
| **文档需求** | ✅ 标准 | 🔴 更详细 |
| **学习曲线** | ✅ 平缓 | ⚠️ 陡峭 |
| **推荐策略** | 一步到位 | 渐进接入 |

---

## 选择建议

### 适合立即使用新项目方式：

- ✅ 正在启动新项目
- ✅ 项目没有历史包袱
- ✅ 团队对新技术开放
- ✅ 时间充裕

### 适合使用老项目方式：

- ✅ 已有成熟项目
- ✅ 不能大规模重构
- ✅ 需要保持兼容性
- ✅ 团队成员技能差异大

---

## 📚 深入学习

### 选择你的学习路径

#### 🟢 我是新手（0-1 个月经验）
👉 **[基础篇导航](docs/00-basic-tutorial.md)**
- 8 个核心章节
- 约 90 分钟阅读
- 详细的实践任务
- 完整的检验清单

**重点章节：**
1. [快速开始](docs/01-quick-start.md) - 5 分钟了解 Claude Code
2. [安装配置](docs/02-installation.md) - 正确配置环境
3. [规则文件系统](docs/06-rules-file.md) - 最强大的功能
4. [新项目工作流](docs/11-new-project-workflow.md) - 完整开发流程

---

#### 🟡 我已有基础（1+ 个月经验）
👉 **[进阶篇导航](docs/00-advanced-tutorial.md)**
- 19 个进阶章节
- 约 240 分钟阅读
- 深度功能讲解
- 高级技巧和优化

**2.1 新功能必学：**
1. [Skills 完全指南](docs/27-skills-guide.md) ⭐ - 教会 Claude 新能力
2. [切换模型供应商](docs/28-model-providers.md) ⭐ - 优化成本和性能
3. [MCP 配置指南](docs/03-mcp-setup.md) ⭐ - 查看"管理最佳实践"
4. [命令参考](docs/15-command-reference.md) ⭐ - 2.1 新增命令

---

#### 🔴 我从 1.x 升级
👉 **[迁移指南](MIGRATION_GUIDE_V2.md)**
- 完整的升级步骤
- 破坏性变更说明
- 新功能快速上手
- 故障排查指南

**快速迁移（1 小时）：**
```bash
# 1. 更新版本
npm update -g @anthropic-ai/claude-code

# 2. 验证版本
claude --version  # 应该是 2.1.x

# 3. 体验新功能
claude .
> /skills     # 查看 Skills
> /agents     # 查看 Agents
> claude mcp list  # 查看 MCP

# 4. 学习新功能
# 阅读 Skills 和模型切换教程（35 分钟）
```

---

## 🎯 快速参考

### 📖 核心文档
- [README](README.md) - 完整教程目录
- [基础篇导航](docs/00-basic-tutorial.md) - 新手学习路径
- [进阶篇导航](docs/00-advanced-tutorial.md) - 进阶学习路径

### 🆕 2.1 新功能
- [Skills 完全指南](docs/27-skills-guide.md) - 核心新功能
- [切换模型供应商](docs/28-model-providers.md) - 灵活性提升
- [MCP 管理最佳实践](docs/03-mcp-setup.md#mcp-管理最佳实践) - 简化配置
- [命令参考](docs/15-command-reference.md) - 新增命令

### 🛠️ 实用工具
- [命令速查卡片](COMMAND_CHEATSHEET.md) - 所有命令一页查
- [迁移指南](MIGRATION_GUIDE_V2.md) - 1.x 升级到 2.1
- [更新总结](UPDATE_SUMMARY_V2.md) - 详细更新说明

### 📝 示例项目
- [新项目演示](examples/new-project-demo/) - 完整的图书管理系统
- [前端项目示例](examples/frontend-project/) - Vue 3 + TypeScript
- [后端项目示例](examples/backend-project/) - Spring Boot 3.x

---

## 💡 使用技巧

### 命令行别名（提升效率）

```bash
# 添加到 ~/.bashrc 或 ~/.zshrc

# 基础别名
alias cc='claude code'
alias ccl='claude mcp list'
alias ccs='claude . && /skills'

# 常用任务
alias cc-review='claude -p "代码审查"'
alias cc-test='claude -p "运行测试并修复"'
alias cc-doc='claude -p "生成文档"'
```

### 快速脚本

```bash
#!/bin/bash
# auto-workflow.sh - 自动化工作流

claude -p "代码审查" > review.md
claude -p "运行测试并修复"
claude -p "更新 API 文档"
claude -p "生成提交信息并提交"

echo "✅ 工作流完成！"
```

---

## 🆘 需要帮助？

### 常见问题
- 📖 查看 [重要说明](docs/14-important-notice.md)
- 🔍 搜索 [命令速查卡片](COMMAND_CHEATSHEET.md)
- 💬 访问 GitHub Discussions

### 获取支持
- 📝 [提交 Issue](https://github.com/your-repo/issues)
- 💬 [社区讨论](https://github.com/your-repo/discussions)
- 🌐 [官方文档](https://code.claude.com/docs)

---

## 🎉 开始你的旅程

选择适合你的起点：

| 你的情况 | 推荐路径 | 预计时间 |
|---------|---------|---------|
| 完全新手 | [5 分钟快速体验](#5-分钟快速体验) → [基础篇](docs/00-basic-tutorial.md) | 5 min + 4-6 周 |
| 开发新项目 | [新项目开发](#新项目开发) → [Skills 指南](docs/27-skills-guide.md) | 30 min + 2 周 |
| 维护老项目 | [老项目开发](#老项目开发) → [老项目指南](docs/21-legacy-project-guide.md) | 1 h + 4 周 |
| 从 1.x 升级 | [迁移指南](MIGRATION_GUIDE_V2.md) → [进阶篇](docs/00-advanced-tutorial.md) | 1 h + 2 周 |

---

**祝你使用愉快！** 🚀

**版本：** Claude Code 2.1+
**最后更新：** 2026-01-26
