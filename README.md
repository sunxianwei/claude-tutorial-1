# Claude Code 完整使用指南

> 从入门到精通：Claude Code 在实际项目中的应用

**适用人群：** 初级、中级开发者
**预计阅读时间：** 2-3 小时（整体）
**实战应用：** 1-2 周

---

## 🚀 快速导航

### 📖 核心文档

> ⚠️ **重要**: 开始前请先阅读 [重要说明](docs/14-important-notice.md) 了解教程中概念性功能与实际功能的区别

| 章节                                             | 时间     | 难度  | 优先级   |
| ---------------------------------------------- | ------ | --- | ----- |
| [⚠️ 重要说明](docs/14-important-notice.md)         | 10 min | ⭐   | 🔴 必读 |
| [01 快速开始](docs/01-quick-start.md)              | 5 min  | ⭐   | 🔴 必读 |
| [02 安装配置](docs/02-installation.md)             | 10 min | ⭐   | 🔴 必读 |
| [03 MCP 配置指南](docs/03-mcp-setup.md)            | 15 min | ⭐⭐  | 🟡 推荐 |
| [04 MCP 常用集合](docs/04-mcp-common.md)           | 5 min  | ⭐   | 🟢 参考 |
| [05 SubAgents 使用](docs/05-subagents.md)        | 15 min | ⭐⭐  | 🟡 重要 |
| [06 规则文件系统](docs/06-rules-file.md)             | 20 min | ⭐⭐  | 🔴 关键 |
| [07 上下文压缩](docs/07-context-compression.md)     | 15 min | ⭐⭐⭐ | 🟡 推荐 |
| [08 内置工具列表](docs/08-builtin-tools.md)          | 10 min | ⭐   | 🟢 参考 |
| [09 能力扩展](docs/09-extend-ability.md)           | 10 min | ⭐⭐⭐ | 🟢 可选 |
| [10 快捷键速查](docs/10-shortcuts.md)               | 5 min  | ⭐   | 🟢 参考 |
| [11 新项目工作流](docs/11-new-project-workflow.md)   | 20 min | ⭐⭐  | 🔴 必读 |
| [12 老项目迁移](docs/12-legacy-project-workflow.md) | 20 min | ⭐⭐  | 🟡 推荐 |
| [13 最佳实践](docs/13-best-practices.md)           | 15 min | ⭐⭐  | 🟡 重要 |

### 📚 示例项目

- **[前端项目示例](examples/frontend-project/)** - Vue 3 + TypeScript 电商管理系统
- **[后端项目示例](examples/backend-project/)** - Java + Spring Boot 3.x 电商管理系统

### 🛠️ 配置模板

- **[配置模板库](templates/CONFIG_TEMPLATES.md)** - 开箱即用的配置

---

## 📋 学习路径建议

### 🟢 初级开发者（0-2 年经验）

1. **第 1 天：基础入门**
   - 读 [01 快速开始](docs/01-quick-start.md)
   - 读 [02 安装配置](docs/02-installation.md)
   - 安装并运行 Claude Code

2. **第 2 天：核心功能**
   - 读 [06 规则文件系统](docs/06-rules-file.md)
   - 创建自己的规范文件
   - 读 [11 新项目工作流](docs/11-new-project-workflow.md)

3. **第 3 天：实战应用**
   - 克隆 [示例项目](examples/)
   - 在实际项目中使用
   - 参考 [10 快捷键](docs/10-shortcuts.md)

### 🟡 中级开发者（2-5 年经验）

1. **快速了解**
   - 浏览 [01-02 章](docs/)
   - 重点读 [03-06 章](docs/)

2. **扩展能力**
   - 读 [03 MCP 配置](docs/03-mcp-setup.md)
   - 配置项目特定的 MCP 服务
   - 读 [05 SubAgents](docs/05-subagents.md)

3. **优化工作流**
   - 读 [07 上下文压缩](docs/07-context-compression.md)
   - 设置团队规范
   - 读 [13 最佳实践](docs/13-best-practices.md)

### 🔴 高级开发者（5+ 年经验）

1. **快速扫描**
   - 快速阅读所有章节
   - 重点关注 [05-09 章](docs/)

2. **高级应用**
   - 扩展 Claude Code 能力
   - 为团队定制工作流
   - 建立最佳实践库

3. **团队赋能**
   - 使用本指南进行团队培训
   - 建立企业级最佳实践
   - 持续优化工作流程

---

## ⚡ 5 分钟快速开始

```bash
# 1. 安装
npm install -g @anthropic-ai/claude-code

# 2. 配置 API 密钥
export ANTHROPIC_API_KEY="your-key-here"

# 3. 进入项目
cd your-project

# 4. 初始化
claude-code init

# 5. 开始使用
claude-code . "帮我创建用户登录功能"
```

---

## 💡 核心概念速览

### Claude Code 能做什么？

| 能力 | 应用 | 时间节省 |
|-----|------|--------|
| **代码生成** | 新功能开发、API 创建、组件生成 | 70% ⏱️ |
| **测试生成** | 单元测试、集成测试、E2E 测试 | 80% ⏱️ |
| **代码审查** | 规范检查、安全审查、性能分析 | 60% ⏱️ |
| **文档生成** | API 文档、代码注释、README | 75% ⏱️ |
| **Bug 修复** | 问题定位、修复方案、验证 | 65% ⏱️ |
| **重构优化** | 性能优化、代码简化、设计改进 | 50% ⏱️ |
| **Git 操作** | 提交、分支、历史管理 | 85% ⏱️ |

### 四大核心功能

1. **📁 文件工具** - 读写编辑任意文件
2. **🔧 MCP 扩展** - 集成数据库、API、云服务
3. **🤖 SubAgent** - 专业化的智能代理
4. **📋 规则系统** - 持久化的工程规范

---

## 📞 常见问题

### Q: 我需要写多少规则文件？

A: 从小开始！
- 开始：仅 30 行的基础规范
- 成长：添加项目特定规则
- 成熟：分层规则体系

### Q: Claude Code 需要联网吗？

A: 需要联网调用 API，但代码不上传，本地安全。

### Q: 支持哪些编程语言？

A: 所有主流语言（Java、Python、JavaScript、Go、Rust 等）

### Q: 成本如何计算？

A: 按 token 数计费。优化后可省 50-70%。

---

## 📈 持续学习资源

### 官方资源
- [Claude Code 官方文档](https://docs.claude.com/en/docs/claude-code/claude_code_docs_map.md)
- [Anthropic 官网](https://www.anthropic.com/)

### 社区资源
- GitHub Discussions
- Stack Overflow 相关标签

### 视频教程
- YouTube 上的 Claude Code 教程
- 官方演示视频

---

## 🤝 如何贡献

发现错误或有改进建议？欢迎提交 Issue 或 Pull Request！

---

## 📄 许可证

本指南采用 MIT 许可证。

---

**最后更新：** 2025-01-20
**文档版本：** 1.1
**适配 Claude Code 版本：** 1.0+
