# Claude Code 完整使用指南

> 从入门到精通：Claude Code 2.1 在实际项目中的应用

**适用人群：** 初级、中级、高级开发者
**预计阅读时间：** 3-4 小时（整体）
**实战应用：** 1-2 周
**版本：** 适配 Claude Code 2.1+

---

## 🚀 快速导航

### 📚 基础篇（适合 0-1 个月使用经验）

适合刚开始使用 Claude Code 的用户，帮助你快速上手和掌握核心功能。

👉 **[查看完整基础篇学习指南](00-basic-tutorial.md)**

| 章节 | 时间 | 难度 | 优先级 |
| ---- | ---- | ---- | ------ |
| [⚠️ 重要说明](14-important-notice.md) | 10 min | ⭐ | 🔴 必读 |
| [01 快速开始](01-quick-start.md) | 5 min | ⭐ | 🔴 必读 |
| [02 安装配置](02-installation.md) | 10 min | ⭐ | 🔴 必读 |
| [06 规则文件系统](06-rules-file.md) | 20 min | ⭐⭐ | 🔴 关键 |
| [08 内置工具列表](08-builtin-tools.md) | 10 min | ⭐ | 🟢 参考 |
| [10 快捷键速查](10-shortcuts.md) | 5 min | ⭐ | 🟢 参考 |
| [11 新项目工作流](11-new-project-workflow.md) | 20 min | ⭐⭐ | 🔴 必读 |

**基础篇总时长：** 约 80 分钟

### 🚀 进阶篇（适合 1 个月以上使用经验）

适合已经熟悉基础功能，希望深度使用 Claude Code 的用户。

👉 **[查看完整进阶篇学习指南](00-advanced-tutorial.md)**

| 章节 | 时间 | 难度 | 优先级 |
| ---- | ---- | ---- | ------ |
| [03 MCP 配置指南](03-mcp-setup.md) | 20 min | ⭐⭐ | 🔴 重要 |
| [04 MCP 常用集合](04-mcp-common.md) | 5 min | ⭐ | 🟢 参考 |
| [05 SubAgents 使用](05-subagents.md) | 15 min | ⭐⭐ | 🟡 重要 |
| [07 上下文压缩](07-context-compression.md) | 15 min | ⭐⭐⭐ | 🟡 推荐 |
| [09 能力扩展](09-extend-ability.md) | 10 min | ⭐⭐⭐ | 🟢 可选 |
| [12 老项目迁移](12-legacy-project-workflow.md) | 20 min | ⭐⭐ | 🟡 推荐 |
| [13 最佳实践](13-best-practices.md) | 15 min | ⭐⭐ | 🟡 重要 |
| [15 命令参考](15-command-reference.md) | 15 min | ⭐⭐ | 🟡 推荐 |
| [16 权限管理](16-permissions.md) | 10 min | ⭐⭐ | 🟡 推荐 |
| [17 自定义命令和 Hook](17-custom-commands.md) | 15 min | ⭐⭐⭐ | 🟢 可选 |
| [18 IDE 集成](18-ide-integration.md) | 10 min | ⭐⭐ | 🟢 参考 |
| [19 历史会话管理](19-session-management.md) | 10 min | ⭐⭐ | 🟢 参考 |
| [20 可视化工具](20-visualization-tools.md) | 15 min | ⭐⭐ | 🟢 可选 |
| [21 老项目开发指南](21-legacy-project-guide.md) | 30 min | ⭐⭐⭐ | 🔴 重要 |
| [22 MCP 实例配置详解](22-mcp-examples-verified.md) | 20 min | ⭐⭐ | 🟡 推荐 |
| [23 按岗位使用场景](23-role-based-scenarios.md) | 25 min | ⭐⭐ | 🟡 推荐 |

**进阶篇总时长：** 约 215 分钟

### ⭐ Claude Code 2.1 新增章节

| 章节 | 时间 | 难度 | 优先级 |
| ---- | ---- | ---- | ------ |
| [00 参考资料](00-references.md) | 30 min | ⭐ | 🟢 参考 |
| [27 Skills 完全指南](27-skills-guide.md) | 20 min | ⭐⭐ | 🔴 重要 |
| [28 切换模型供应商](28-model-providers.md) | 15 min | ⭐⭐ | 🟡 推荐 |

**新增内容总时长：** 约 65 分钟

### 📚 示例项目

- **[新项目演示](../examples/new-project-demo.md)** - 完整的图书管理系统开发案例（JDK1.8 + Vue + Playwright）

---

## 📋 学习路径建议

### 🟢 初学者路径（0-1 个月使用经验）

**目标：** 快速上手，掌握核心功能

**第 1 周：基础入门**
1. **Day 1-2：安装和基础配置**
   - 阅读 [01 快速开始](01-quick-start.md)
   - 阅读 [02 安装配置](02-installation.md)
   - 安装并配置 Claude Code
   - 完成第一次交互

2. **Day 3-4：规则系统**
   - 阅读 [06 规则文件系统](06-rules-file.md)
   - 创建项目的 `CLAUDE.md` 文件
   - 理解规则的作用和写法

3. **Day 5-7：实战演练**
   - 阅读 [11 新项目工作流](11-new-project-workflow.md)
   - 在实际项目中使用 Claude Code
   - 参考 [10 快捷键速查](10-shortcuts.md)
   - 熟悉常用命令

**第 2-4 周：巩固提高**
- 每天使用 Claude Code 完成实际开发任务
- 遇到问题查阅 [08 内置工具列表](08-builtin-tools.md)
- 熟悉常用命令和快捷键

**学习成果检验：**
- ✅ 能够独立使用 Claude Code 完成基础开发任务
- ✅ 理解并能编写规则文件
- ✅ 熟悉常用命令和快捷键

---

### 🟡 进阶用户路径（1-3 个月使用经验）

**目标：** 深度使用，提升效率

**第 1 周：MCP 集成**
1. **Day 1-3：MCP 基础**
   - 阅读 [03 MCP 配置指南](03-mcp-setup.md)
   - 理解 MCP 的概念和作用
   - 配置第一个 MCP 服务器（推荐 filesystem）

2. **Day 4-5：MCP 实战**
   - 阅读 [04 MCP 常用集合](04-mcp-common.md)
   - 配置项目需要的 MCP 服务器
   - 学习 MCP 管理最佳实践

3. **Day 6-7：Skills 系统**
   - 阅读 [27 Skills 完全指南](27-skills-guide.md) ⭐ 新增
   - 创建第一个 Skill
   - 理解 Skills vs 自定义命令

**第 2 周：SubAgents 和高级功能**
1. **Day 1-3：SubAgents**
   - 阅读 [05 SubAgents 使用](05-subagents.md)
   - 配置自定义 SubAgent
   - 学习链式 Agent 工作流

2. **Day 4-5：切换模型**
   - 阅读 [28 切换模型供应商](28-model-providers.md) ⭐ 新增
   - 尝试不同的模型
   - 根据任务选择合适的模型

3. **Day 6-7：命令精通**
   - 阅读 [15 命令参考](15-command-reference.md)（已更新）
   - 学习 Claude Code 2.1 新增命令
   - 掌握 MCP 管理命令

**第 3-4 周：优化和实践**
- 阅读 [13 最佳实践](13-best-practices.md)
- 阅读 [07 上下文压缩](07-context-compression.md)
- 根据项目需求优化配置
- 参考 [23 按岗位使用场景](23-role-based-scenarios.md)

**学习成果检验：**
- ✅ 能够配置和管理 MCP 服务器
- ✅ 能够创建和使用 Skills
- ✅ 能够根据任务选择合适的模型和 SubAgent
- ✅ 工作效率提升 50%+

---

### 🔴 专家级路径（3+ 个月使用经验）

**目标：** 精通所有功能，为团队赋能

**扩展能力**
- 阅读 [09 能力扩展](09-extend-ability.md)
- 阅读 [17 自定义命令和 Hook](17-custom-commands.md)
- 为团队创建自定义工具和工作流

**老项目优化**
- 阅读 [12 老项目迁移](12-legacy-project-workflow.md)
- 阅读 [21 老项目开发指南](21-legacy-project-guide.md)
- 将 Claude Code 引入现有项目

**团队协作**
- 阅读 [16 权限管理](16-permissions.md)
- 阅读 [22 MCP 实例配置详解](22-mcp-examples-verified.md)
- 建立团队级最佳实践
- 培训团队成员

**持续优化**
- 阅读 [20 可视化工具](20-visualization-tools.md)
- 阅读 [19 历史会话管理](19-session-management.md)
- 监控和优化使用成本
- 收集团队反馈并改进

**学习成果检验：**
- ✅ 精通 Claude Code 所有功能
- ✅ 能够为团队定制工作流
- ✅ 能够解决复杂的技术问题
- ✅ 工作效率提升 70%+
- ✅ 成为团队的 Claude Code 专家

---

## ⚡ 5 分钟快速开始

**想立即开始？选择你的场景：**

- 🆕 **新项目开发**: [查看完整案例](../examples/new-project-demo/README.md) - 图书管理系统（JDK1.8 + Vue + Playwright）
- 🔧 **老项目维护**: [查看详细指南](21-legacy-project-guide.md) - 渐进式接入策略

👉 **[快速开始对比指南](../QUICK_START.md)** - 新项目 vs 老项目完整对比

### 通用快速开始

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

👉 **[查看完整外部资源列表](00-references.md)** - 包含 30+ 个优质中英文资源

### 官方资源
- [Claude Code 官方文档](https://docs.claude.com/en/docs/claude-code/claude_code_docs_map.md)
- [Anthropic 官网](https://www.anthropic.com/)
- [Claude Code Best Practices (官方)](https://www.anthropic.com/engineering/claude-code-best-practices)

### 社区精选
- [Claude Code Best Practices 综合分析](https://rosmur.github.io/claudecode-best-practices/)
- [6 Weeks of Claude Code (Puzzmo)](https://blog.puzzmo.com/posts/2025/07/30/six-weeks-of-claude-code/)
- [How I Use Every Claude Code Feature](https://blog.sshh.io/p/how-i-use-every-claude-code-feature)
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

## 📝 更新日志

### v2.1 - 2026-01-27
- ✅ 新增 [00 参考资料](00-references.md) - 30+ 个优质中英文资源
- ✅ 删除内部文档（截图指南、验证清单、完成报告）
- ✅ 优化章节结构，从 29 章精简为 26 章
- ✅ 更新所有章节索引和时间统计

### v2.0 - 2026-01-26
- ✅ 更新至 Claude Code 2.1 版本
- ✅ 新增 [27 Skills 完全指南](27-skills-guide.md)
- ✅ 新增 [28 切换模型供应商](28-model-providers.md)
- ✅ [03 MCP 配置指南](03-mcp-setup.md) 增加管理最佳实践
- ✅ [15 命令参考](15-command-reference.md) 补充 2.1 新增命令
- ✅ 教程重组为基础篇和进阶篇
- ✅ 更新学习路径建议

### v1.1 - 2025-01-20
- 初始版本发布

---

**最后更新：** 2026-01-27
**文档版本：** 2.1
**适配 Claude Code 版本：** 2.1+
