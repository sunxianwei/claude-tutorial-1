# 进阶篇：Claude Code 深度使用指南

> 适合 1 个月以上使用经验的用户

## 🎯 学习目标

完成进阶篇学习后，你将能够：
- ✅ 配置和管理 MCP 服务器
- ✅ 创建和使用 Skills
- ✅ 使用 SubAgents 提升效率
- ✅ 根据任务选择合适的模型
- ✅ 优化上下文和成本
- ✅ 为团队建立最佳实践
- ✅ 工作效率提升 50-70%

## 📚 学习路线图

```
第 1 周：MCP 集成
  ↓
理解 MCP → 配置服务器 → 创建 Skills
  ↓
第 2 周：高级功能
  ↓
SubAgents → 切换模型 → 精通命令
  ↓
第 3-4 周：优化和实践
  ↓
性能优化 → 团队协作 → 持续改进
  ↓
成为进阶用户
```

## 📖 核心章节

### 🟢 学习资源

#### 0. [参考资料](00-references.md)
**时间：** 30 分钟（选读） | **难度：** ⭐ | **优先级：** 🟢 参考

**内容概要：**
- 30+ 个优质中英文学习资源
- 3 个中文视频教程（含官方演示）
- 12 个中文网页教程和社区文章
- 15 个英文官方文档和社区资源
- 综合最佳实践分析

**为什么有用：** 
- 多角度深入学习 Claude Code
- 了解社区最佳实践
- 学习生产环境实战经验
- 发现高级使用技巧

**推荐阅读：**
- **新手：** 中文视频教程 + 中文官方资源
- **进阶：** 中文社区文章 + 英文官方最佳实践
- **专家：** 英文深度博客 + Reddit 社区讨论

---

### 🔴 MCP 和扩展（第 1 周）

#### 1. [MCP 配置指南](03-mcp-setup.md) ⭐ 已更新
**时间：** 20 分钟 | **难度：** ⭐⭐ | **优先级：** 🔴 重要

**内容概要：**
- MCP 是什么及为什么需要它
- 快速添加 MCP 服务器（命令行方式）
- 常用 MCP 服务器配置
- **新增：MCP 管理最佳实践** ⭐

**为什么重要：** MCP 让 Claude Code 突破限制，接入数据库、API、云服务等外部系统。

**实践任务：**

```bash
# 使用 claude mcp 命令快速配置（2.1 新功能）

# 1. 添加文件系统 MCP
claude mcp add filesystem -- npx @modelcontextprotocol/server-filesystem .

# 2. 添加 Git MCP
claude mcp add git -- npx @modelcontextprotocol/server-git --repository .

# 3. 添加数据库 MCP
claude mcp add postgres -- npx @modelcontextprotocol/server-postgres

# 4. 查看所有 MCP
claude mcp list

# 5. 测试连接
claude mcp test filesystem
```

**学习重点：**
- ✅ MCP 命令行工具使用（2.1 新功能）
- ✅ 配置文件管理策略
- ✅ 版本管理和环境管理
- ✅ 健康检查和故障排查
- ✅ 安全最佳实践

**进阶技巧：**
- 使用 package.json 管理 MCP 版本
- 多环境配置（dev/test/prod）
- 自动化健康检查
- 成本监控和优化

---

#### 2. [MCP 常用集合](04-mcp-common.md)
**时间：** 5 分钟 | **难度：** ⭐ | **优先级：** 🟢 参考

**内容概要：**
- 官方 MCP 资源列表
- 社区 MCP 服务器
- 按场景推荐配置

**为什么有用：** 快速找到适合你项目的 MCP 配置。

**推荐配置：**
- **前端开发：** filesystem + git + context7 + playwright
- **后端开发：** filesystem + git + postgres + gitlab
- **学习研究：** filesystem + context7 + deepwiki + websearch

---

#### 3. [Skills 完全指南](27-skills-guide.md) ⭐ 新增
**时间：** 20 分钟 | **难度：** ⭐⭐ | **优先级：** 🔴 重要

**内容概要：**
- Skills 是什么（Claude Code 2.1 新功能）
- Skills vs 自定义命令
- 创建你的第一个 Skill
- Skills 配置详解
- 实战案例

**为什么重要：** Skills 是 2.1 版本最强大的新功能，让你教会 Claude 新能力。

**实践任务：**

创建代码审查 Skill：

```bash
# 1. 创建目录
mkdir -p ~/.claude/skills/code-review

# 2. 创建 SKILL.md
cat > ~/.claude/skills/code-review/SKILL.md << 'EOF'
---
name: code-review
description: Comprehensive code review following team standards
allowed-tools: Read, Grep, Shell(git:*)
---

# Code Review Process

## 1. Code Quality
- [ ] Follows coding standards
- [ ] Proper naming conventions
- [ ] No code duplication

## 2. Security
- [ ] No SQL injection risks
- [ ] Proper authentication
- [ ] No hardcoded secrets

## 3. Performance
- [ ] No N+1 queries
- [ ] Efficient algorithms

## Output Format
Provide:
1. Summary
2. Issues found (with severity)
3. Suggestions for improvement
EOF

# 3. 测试 Skill
claude .
> /code-review src/auth/login.ts
```

**学习重点：**
- ✅ 理解 Skills 的工作原理
- ✅ Skills 的前置元数据配置
- ✅ 控制谁可以调用 Skills
- ✅ 添加支持文件
- ✅ 在子代理中运行 Skills
- ✅ 动态上下文注入

**实战案例：**
- 代码审查 Skill
- 文档生成 Skill
- 测试生成 Skill
- 数据库迁移 Skill

---

### 🟡 高级功能（第 2 周）

#### 4. [SubAgents 使用](05-subagents.md)
**时间：** 15 分钟 | **难度：** ⭐⭐ | **优先级：** 🟡 重要

**内容概要：**
- SubAgents 概念和作用
- 内置 SubAgents 介绍
- 自定义 SubAgent
- 链式 Agent 工作流

**为什么重要：** SubAgents 让不同的 AI 专注于特定任务，大幅提升效率。

**实践任务：**

```bash
# 查看可用的 SubAgents
claude .
> /agents

# 使用不同的 Agent
> @codegen 创建用户登录 API
> @security 审查上面的代码
> @testing 为登录功能生成测试
> @documentation 生成 API 文档
```

**学习重点：**
- CodeGen Agent - 代码生成
- Security Agent - 安全审查
- Testing Agent - 测试生成
- Documentation Agent - 文档生成
- Refactor Agent - 代码重构
- Review Agent - 代码审查

**进阶：自定义 SubAgent**

```json
// .claude/agents.json
{
  "customAgents": {
    "javaApiDeveloper": {
      "name": "Java API 开发专家",
      "description": "Spring Boot REST API 开发",
      "model": "claude-sonnet-4-20250514",
      "tools": ["filesystem", "git", "postgres"],
      "instructions": [
        "使用 Spring Boot 3.x 和 Java 21",
        "严格遵循 RESTful 设计原则",
        "测试覆盖率必须 >= 80%"
      ]
    }
  }
}
```

---

#### 5. [切换模型供应商](28-model-providers.md) ⭐ 新增
**时间：** 15 分钟 | **难度：** ⭐⭐ | **优先级：** 🟡 推荐

**内容概要：**
- 支持的模型供应商
- 如何配置不同的模型
- 模型选择建议
- 动态切换策略

**为什么重要：** 根据任务选择合适的模型，可以优化成本和性能。

**支持的供应商：**
- **Anthropic Claude**（默认）- 推理能力强
- **OpenAI GPT** - 代码理解强
- **Azure OpenAI** - 企业合规
- **Google Gemini** - 多模态强
- **AWS Bedrock** - AWS 集成
- **Ollama**（本地）- 隐私和成本

**实践任务：**

```bash
# 使用不同的模型
claude --model claude-opus-4-1-20250805 .      # 复杂任务
claude --model claude-sonnet-4-20250514 .      # 日常开发（推荐）
claude --model claude-haiku-4-5-20251001 .     # 快速响应

# 切换到 OpenAI
claude --model gpt-4-turbo --provider openai .

# 使用本地模型
claude --provider ollama --model codellama .
```

**选择建议：**
| 任务类型 | 推荐模型 |
|---------|---------|
| 复杂系统设计 | Claude Opus 4.1 |
| 日常开发 | Claude Sonnet 4 ⭐ |
| 快速问答 | Claude Haiku 4.5 |
| 代码补全 | GPT-4 Turbo |
| 离线开发 | Ollama + CodeLlama |

---

#### 6. [命令参考](15-command-reference.md) ⭐ 已更新
**时间：** 15 分钟 | **难度：** ⭐⭐ | **优先级：** 🟡 推荐

**内容概要：**
- 基本命令
- **新增：MCP 管理命令** ⭐
- **新增：Skills 管理命令** ⭐
- 交互模式命令
- Git 集成命令
- 批处理和脚本

**2.1 新增命令：**

```bash
# MCP 管理
claude mcp list
claude mcp add <name> -- <command>
claude mcp remove <name>
claude mcp test <name>
claude mcp restart

# Skills 管理
/skills
/skills info <skill-name>
/<skill-name> [arguments]

# 交互模式
/agents                    # 列出所有 Agents
/agents info <agent-name>  # 查看 Agent 详情
@<agent-name>             # 使用 Agent
/context                  # 查看上下文
/model <model-name>       # 切换模型
```

---

### 🟢 优化和实践（第 3-4 周）

#### 7. [上下文压缩](07-context-compression.md)
**时间：** 15 分钟 | **难度：** ⭐⭐⭐ | **优先级：** 🟡 推荐

**内容概要：**
- 上下文窗口管理
- 智能压缩策略
- 成本优化技巧

**为什么重要：** 优化上下文可以大幅降低成本，提升响应速度。

**优化技巧：**
- 使用 `.claudeignore` 排除无关文件
- 限制文件范围：`--files="src/**/*.ts"`
- 启用上下文压缩（默认开启）
- 选择合适的模型（Haiku 更便宜）

---

#### 8. [最佳实践](13-best-practices.md)
**时间：** 15 分钟 | **难度：** ⭐⭐ | **优先级：** 🟡 重要

**内容概要：**
- 工作流优化
- 成本控制
- 安全建议
- 团队协作

**核心实践：**
1. **规则文件优先** - 让规则指导 Claude
2. **小步迭代** - 不要一次性要求太多
3. **验证输出** - AI 也会犯错
4. **版本控制** - 提交前审查
5. **成本监控** - 使用 `claude usage` 命令

---

#### 9. [老项目迁移](12-legacy-project-workflow.md)
**时间：** 20 分钟 | **难度：** ⭐⭐ | **优先级：** 🟡 推荐

**内容概要：**
- 渐进式接入策略
- 老项目常见问题
- 迁移步骤指南

**为什么重要：** 大多数开发者需要在现有项目中使用 Claude Code。

---

#### 10. [权限管理](16-permissions.md)
**时间：** 10 分钟 | **难度：** ⭐⭐ | **优先级：** 🟡 推荐

**内容概要：**
- 权限系统概述
- 配置权限规则
- 安全最佳实践

**为什么重要：** 保护重要文件和敏感操作。

---

### 📚 扩展和定制

#### 11. [能力扩展](09-extend-ability.md)
**时间：** 10 分钟 | **难度：** ⭐⭐⭐

**内容概要：**
- Web 搜索集成
- 文档生成和发布
- 集成内部系统
- 自定义工具开发

---

#### 12. [自定义命令和 Hook](17-custom-commands.md)
**时间：** 15 分钟 | **难度：** ⭐⭐⭐

**内容概要：**
- 创建自定义命令
- Hook 系统使用
- 自动化工作流

---

### 🎯 专项深入

#### 13. [老项目开发指南](21-legacy-project-guide.md)
**时间：** 30 分钟 | **难度：** ⭐⭐⭐ | **优先级：** 🔴 重要

**完整的老项目接入方案**

---

#### 14. [MCP 实例配置详解](22-mcp-examples-verified.md)
**时间：** 20 分钟 | **难度：** ⭐⭐

**各种场景的 MCP 配置实例**

---

#### 15. [按岗位使用场景](23-role-based-scenarios.md)
**时间：** 25 分钟 | **难度：** ⭐⭐

**针对不同角色的使用方法**
- 前端开发者
- 后端开发者
- 测试工程师
- DevOps 工程师

---

### 🛠️ 工具和辅助

#### 16. [IDE 集成](18-ide-integration.md)
**时间：** 10 分钟 | **难度：** ⭐⭐

#### 17. [历史会话管理](19-session-management.md)
**时间：** 10 分钟 | **难度：** ⭐⭐

#### 18. [可视化工具](20-visualization-tools.md)
**时间：** 15 分钟 | **难度：** ⭐⭐

---

## 🚀 学习建议

### 第 1 周：MCP 和 Skills

**Day 1-3：MCP 基础**
1. 阅读 [MCP 配置指南](03-mcp-setup.md)（20 分钟）
2. 配置 3-5 个 MCP 服务器（30 分钟）
3. 测试 MCP 功能（20 分钟）

**Day 4-7：Skills 系统**
1. 阅读 [Skills 完全指南](27-skills-guide.md)（20 分钟）
2. 创建 3 个 Skills（60 分钟）
3. 在实际项目中使用（1-2 小时）

**学习成果：** 掌握 MCP 和 Skills，扩展 Claude Code 能力

### 第 2 周：高级功能

**Day 1-3：SubAgents**
1. 阅读 [SubAgents 使用](05-subagents.md)（15 分钟）
2. 配置自定义 SubAgent（30 分钟）
3. 实践链式 Agent 工作流（45 分钟）

**Day 4-5：切换模型**
1. 阅读 [切换模型供应商](28-model-providers.md)（15 分钟）
2. 配置 2-3 个模型供应商（30 分钟）
3. 测试不同模型的效果（30 分钟）

**Day 6-7：命令精通**
1. 阅读 [命令参考](15-command-reference.md)（15 分钟）
2. 练习新增命令（30 分钟）
3. 创建自动化脚本（45 分钟）

**学习成果：** 精通高级功能，效率大幅提升

### 第 3-4 周：优化和实践

**专项学习：**
- 阅读 [最佳实践](13-best-practices.md)
- 阅读 [上下文压缩](07-context-compression.md)
- 根据岗位阅读 [使用场景](23-role-based-scenarios.md)

**实践优化：**
- 优化项目配置
- 建立团队规范
- 监控使用成本
- 收集效率数据

**学习成果：** 成为进阶用户，工作效率提升 50-70%

---

## ✅ 学习检验清单

### MCP 和扩展
- [ ] 理解 MCP 的概念和作用
- [ ] 能够使用命令行管理 MCP
- [ ] 配置了 3 个以上 MCP 服务器
- [ ] 能够排查 MCP 问题
- [ ] 理解 MCP 管理最佳实践

### Skills 系统
- [ ] 理解 Skills 的工作原理
- [ ] 创建了 3 个以上 Skills
- [ ] 能够配置 Skills 前置元数据
- [ ] 理解 Skills vs 自定义命令
- [ ] 能在项目中有效使用 Skills

### 高级功能
- [ ] 能够使用内置 SubAgents
- [ ] 配置了自定义 SubAgent
- [ ] 尝试了 2 种以上模型供应商
- [ ] 能根据任务选择合适模型
- [ ] 熟练使用 2.1 新增命令

### 优化和实践
- [ ] 实施了上下文优化
- [ ] 建立了成本监控
- [ ] 制定了团队规范
- [ ] 工作效率提升 50% 以上
- [ ] 能解决复杂问题

---

## 🎓 成为专家

完成进阶篇后，你可以：

### 深度专项
- **扩展开发：** 创建自定义 MCP 服务器
- **工作流自动化：** 使用 Hook 系统
- **团队培训：** 培养团队成员
- **最佳实践：** 建立企业级规范

### 持续学习
- 关注 Claude Code 更新
- 参与社区讨论
- 分享使用经验
- 贡献开源项目

---

## 💡 常见问题

### Q1：必须学完所有章节吗？
**A：** 不必须。重点学习 MCP、Skills、SubAgents 和命令参考，其他根据需要选择。

### Q2：学习进阶篇需要多长时间？
**A：** 阅读约 4 小时，实践约 10-20 小时。建议分 3-4 周完成。

### Q3：进阶篇学完能达到什么水平？
**A：** 精通 Claude Code 所有功能，工作效率提升 50-70%，能为团队赋能。

### Q4：如何持续提升？
**A：**
- 每周尝试一个新功能
- 定期优化工作流
- 分享经验和技巧
- 参与社区讨论

---

## 📞 获取帮助

- 📚 **文档首页**：[README.md](../README.md)
- 📖 **基础篇**：[基础教程](00-basic-tutorial.md)
- 🔍 **命令速查**：[命令参考](15-command-reference.md)
- 💬 **社区讨论**：GitHub Discussions

---

**开始学习：** 👉 [MCP 配置指南](03-mcp-setup.md)

**祝你学习愉快！** 🚀
