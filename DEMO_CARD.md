# 🎯 快速参考卡片 - 现场演示必用

> 打印或保存这份卡片，在演示时快速查阅

---

## 1️⃣ 5 分钟快速演示

### 命令速查

```bash
# 初始化项目
claude-code init

# 使用 Java API 开发专家
claude code . --subagent=javaApiDeveloper "创建用户管理 API"

# 使用 Vue 前端开发专家
claude code . --subagent=vueFrontendDeveloper "创建用户列表页面"

# 使用测试专家
claude code . --subagent=testingExpert "生成完整的单元测试"

# 查看所有可用的 Agent
claude-code --list-agents
```

---

## 2️⃣ 核心概念速记

| 功能 | 说明 | 文件位置 |
|-----|------|--------|
| **规则文件** | 项目规范定义 | `CLAUDE.md` |
| **配置** | 项目配置 | `.claude/config.json` |
| **MCP** | 工具集成 | `.claude/mcp-servers.json` |
| **SubAgent** | 智能代理 | `.claude/agents.json` |
| **忽略文件** | 上下文优化 | `.claudeignore` |

---

## 3️⃣ SubAgent 快速参考

### 4 个内置 Agent

| Agent                  | 用途                 | 命令                                |
| ---------------------- | ------------------ | --------------------------------- |
| `javaApiDeveloper`     | Spring Boot API 开发 | `--subagent=javaApiDeveloper`     |
| `vueFrontendDeveloper` | Vue 3 组件开发         | `--subagent=vueFrontendDeveloper` |
| `testingExpert`        | 测试用例生成             | `--subagent=testingExpert`        |
| `performanceOptimizer` | 性能优化               | `--subagent=performanceOptimizer` |

---

## 4️⃣ 常用 MCP 集成

### 核心 MCP（必装）

```json
{
  "filesystem": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
  },
  "git": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-git", "--repository", "."]
  }
}
```

### 强大的第三方 MCP ⭐

```json
{
  "context7": {
    "command": "npx",
    "args": ["-y", "mcp-server-context7"]
  },
  "websearch": {
    "command": "npx",
    "args": ["-y", "mcp-server-open-websearch"]
  },
  "spec-workflow": {
    "command": "npx",
    "args": ["-y", "mcp-server-spec-workflow"]
  },
  "playwright": {
    "command": "npx",
    "args": ["-y", "mcp-server-playwright"]
  },
  "deepwiki": {
    "command": "npx",
    "args": ["-y", "mcp-server-deepwiki"]
  }
}
```

**使用示例：**
```bash
# Context7 查询文档
claude code . "使用 Context7 查询 React 18 的最新特性"

# WebSearch 搜索信息
claude code . "搜索 Spring Boot 3.x 的最佳实践"

# Spec Workflow 项目管理
claude code . "使用 Spec Workflow 创建用户认证系统的需求文档"

# Playwright E2E 测试
claude code . "使用 Playwright 测试登录流程"

# DeepWiki 学习项目
claude code . "通过 DeepWiki 学习 vercel/next.js 的架构"
```

## 5️⃣ 企业工具集成

### GitLab MCP

```json
{
  "gitlab": {
    "command": "npx",
    "args": ["@modelcontextprotocol/server-gitlab"],
    "env": {
      "GITLAB_URL": "https://gitlab.yourcompany.com",
      "GITLAB_TOKEN": "${GITLAB_TOKEN}"
    }
  }
}
```

**使用：** `claude code . "创建 MR 审查..."`

### 钉钉 MCP

```json
{
  "dingtalk": {
    "command": "npx",
    "args": ["@modelcontextprotocol/server-dingtalk"],
    "env": {
      "DINGTALK_WEBHOOK": "${DINGTALK_WEBHOOK_URL}"
    }
  }
}
```

**使用：** `claude code . "完成功能，发送钉钉通知..."`

---

## 6️⃣ 实战场景

### 场景 1：快速开发 API

```bash
claude code . --subagent=javaApiDeveloper \
  "创建用户认证 API：
   - 登录接口
   - 注册接口
   - 刷新 token
   - JWT 认证"
```

### 场景 2：完整工作流

```bash
claude code . \
  --subagent=javaApiDeveloper \
  --chain="testingExpert,performanceOptimizer" \
  "创建订单管理 API，包含完整的测试和优化"
```

### 场景 3：页面开发

```bash
claude code . --subagent=vueFrontendDeveloper \
  "创建用户管理页面：
   - 列表展示
   - 搜索功能
   - 编辑删除
   - 响应式设计"
```

---

## 7️⃣ 规则文件模板

### 创建 CLAUDE.md

```markdown
# 项目规范

## 代码风格
- 使用 TypeScript 严格模式
- 2 空格缩进
- 注释必须中文

## 测试
- 最低覆盖率 80%
- 使用 Jest/Vitest

## 提交
- Conventional Commits
- 中文提交信息

## 工具
- PostgreSQL 数据库
- GitLab 代码管理
```

---

## 8️⃣ 常见问题速答

| 问题 | 答案 |
|-----|------|
| 如何自定义 Agent? | 编辑 `.claude/agents.json` |
| 如何优化性能? | 配置 `.claudeignore` 和 contextWindow |
| 如何集成钉钉? | 在 mcp-servers.json 中配置 dingtalk MCP |
| 如何创建 MR? | 通过 GitLab MCP 或 `claude code` 直接创建 |
| 何时使用 --chain? | 需要多个处理步骤时（测试→审查→优化） |

---

## 9️⃣ 文档导航

| 需求 | 查看章节 |
|-----|--------|
| 快速了解 | 第 01 章 - 快速开始 |
| 配置环境 | 第 02 章 - 配置指南 |
| 集成工具 | 第 03 章 - MCP 配置 |
| 创建 Agent | 第 05 章 - SubAgents 使用 |
| 项目规范 | 第 06 章 - 规则文件系统 |
| 新项目 | 第 11 章 - 新项目工作流 |

---

## 🎬 演示脚本（15分钟）

```
1. 打开 README.md
   - 展示完整的学习路径

2. 打开第 05 章 - SubAgents 使用
   - 展示 4 个 Agent 的定义
   - 解释每个 Agent 的用途

3. 演示实战例子
   - 现场运行一个命令
   - 展示生成的代码

4. 展示公司工具集成
   - GitLab MCP 配置
   - 钉钉 MCP 配置

5. Q&A
   - 回答参与者的问题
   - 讨论如何在项目中应用
```

---

## 🔗 重要链接

- **MCP 官方**: https://modelcontextprotocol.io
- **MCP 服务器列表**: https://github.com/modelcontextprotocol/servers
- **Claude Code 文档**: https://docs.claude.com/en/docs/claude-code/claude_code_docs_map.md
- **项目 README**: `README.md`
- **完整更新说明**: `UPDATE_SUMMARY.md`

---

## ✅ 演示前检查清单

- [ ] 确认 Claude Code 已安装
- [ ] 确认 API 密钥已配置
- [ ] 打开项目的 `.claude/agents.json`
- [ ] 准备 1-2 个演示任务
- [ ] 测试网络连接（API 调用）
- [ ] 打开文档第 05 章
- [ ] 准备好 UPDATE_SUMMARY.md

---

**提示：** 将此页面加入你的演示 PDF 或打印出来作为参考！
