# Claude Code 完整使用指南

> 从入门到精通：Claude Code 2.1 在实际项目中的应用

📚 **完整文档请查看：[docs/README.md](docs/README.md)**

---

## 🚀 快速导航

### 📖 学习指南

| 文档 | 适合人群 | 时间 |
|------|---------|------|
| **[完整使用指南](docs/README.md)** | 所有用户 | 查看目录 |
| **[基础篇](docs/00-basic-tutorial.md)** | 0-1 个月经验 | 90 分钟 |
| **[进阶篇](docs/00-advanced-tutorial.md)** | 1+ 个月经验 | 240 分钟 |
| **[快速开始](QUICK_START.md)** | 立即上手 | 5 分钟 |

### ⭐ Claude Code 2.1 新增功能

| 章节 | 内容 | 优先级 |
|------|------|--------|
| **[Skills 完全指南](docs/27-skills-guide.md)** | 教会 Claude 新能力 | 🔴 必读 |
| **[切换模型供应商](docs/28-model-providers.md)** | 使用不同的 AI 模型 | 🟡 推荐 |
| **[MCP 管理最佳实践](docs/03-mcp-setup.md)** | MCP 命令行工具 | 🔴 重要 |
| **[命令参考更新](docs/15-command-reference.md)** | 2.1 新增命令 | 🟡 推荐 |

### 🎯 快速开始（5 分钟）

```bash
# 1. 安装
npm install -g @anthropic-ai/claude-code

# 2. 配置 API Key
export ANTHROPIC_API_KEY="your-key-here"

# 3. 进入项目并初始化
cd your-project
claude init

# 4. 开始使用
claude .
```

### 📚 示例项目

- **[新项目演示](examples/new-project-demo/)** - 图书管理系统（完整案例）
- **[前端项目](examples/frontend-project/)** - Vue 3 + TypeScript
- **[后端项目](examples/backend-project/)** - Spring Boot 3.x

### 🛠️ 常用资源

- **[命令速查卡片](COMMAND_CHEATSHEET.md)** - 所有命令一页查
- **[迁移指南](MIGRATION_GUIDE_V2.md)** - 从 1.x 升级到 2.1
- **[快速开始对比](QUICK_START.md)** - 新项目 vs 老项目

---

## 💡 核心特性

| 特性 | 说明 | 时间节省 |
|------|------|---------|
| **代码生成** | AI 辅助开发新功能 | 70% ⏱️ |
| **Skills 系统** | 自定义 AI 能力 | 新功能 ⭐ |
| **MCP 扩展** | 集成数据库、API | 80% ⏱️ |
| **SubAgents** | 专业化智能代理 | 65% ⏱️ |
| **规则系统** | 持久化工程规范 | 60% ⏱️ |

---

## 📖 文档结构

```
docs/
├── README.md                    # 完整使用指南（主索引）
├── 00-basic-tutorial.md         # 基础篇导航
├── 00-advanced-tutorial.md      # 进阶篇导航
├── 01-quick-start.md            # 快速开始
├── 02-installation.md           # 安装配置
├── 03-mcp-setup.md              # MCP 配置（含管理最佳实践）
├── ...                          # 更多章节
├── 27-skills-guide.md           # Skills 完全指南 ⭐ 2.1 新增
└── 28-model-providers.md        # 切换模型供应商 ⭐ 2.1 新增
```

---

## 🎯 适合你的学习路径

### 🟢 你是新手？
1. 阅读 [快速开始](docs/01-quick-start.md)（5 分钟）
2. 完成 [安装配置](docs/02-installation.md)（10 分钟）
3. 学习 [规则文件系统](docs/06-rules-file.md)（20 分钟）
4. 实践 [新项目工作流](docs/11-new-project-workflow.md)（20 分钟）

**总时长：** 约 1 小时

### 🟡 你有基础？
1. 查看 [2.1 新功能](#-claude-code-21-新增功能)
2. 学习 [Skills 系统](docs/27-skills-guide.md)（20 分钟）
3. 配置 [MCP 服务器](docs/03-mcp-setup.md)（20 分钟）
4. 尝试 [切换模型](docs/28-model-providers.md)（15 分钟）

**总时长：** 约 1 小时

### 🔴 你是专家？
1. 深入 [最佳实践](docs/13-best-practices.md)
2. 探索 [能力扩展](docs/09-extend-ability.md)
3. 为团队制定规范和培训

---

## 📊 版本信息

| 项目 | 版本 | 更新日期 |
|------|------|---------|
| **教程版本** | v2.0 | 2026-01-26 |
| **适配版本** | Claude Code 2.1+ | - |
| **文档数量** | 30 个章节 | - |
| **总阅读时间** | 约 6 小时 | - |

---

## 🤝 贡献与反馈

发现错误或有改进建议？

- 📝 提交 Issue
- 🔧 发起 Pull Request
- 💬 参与讨论

---

## 📄 许可证

本指南采用 MIT 许可证。

---

**最后更新：** 2026-01-27  
**文档版本：** v2.0  
**适配版本：** Claude Code 2.1+

**📚 [查看完整文档](docs/README.md)**
