# 03 - MCP 配置指南：扩展 Claude Code 的能力

## 什么是 MCP？

**MCP (Model Context Protocol)** 是一个标准协议,允许 Claude AI 通过定义明确的接口来访问外部工具和数据源。

### MCP 解决的问题

| 问题 | 传统方式 | MCP 方式 |
|-----|--------|--------|
| 数据库访问 | 手动写 SQL 脚本 | Claude 直接操作 |
| API 调用 | 复制粘贴 API 文档 | Claude 自动理解接口 |
| 文件系统 | 受限于 File Watch | 完整的读写权限 |
| 命令执行 | 手动运行 bash | Claude 智能编排命令 |
| 云服务 | 需要手动认证 | 自动化集成 |

## MCP 核心概念

### 架构图

```
┌─────────────────────────────────────────┐
│         Claude Code (CLI)                 │
├─────────────────────────────────────────┤
│         MCP 客户端                        │
├─────────────────────────────────────────┤
│     MCP 服务器 (Transport Layer)          │
│  ┌──────────┬──────────┬──────────┐      │
│  │ StdIO    │  SSE     │   HTTP   │      │
│  └──────────┴──────────┴──────────┘      │
├─────────────────────────────────────────┤
│       资源和工具定义层                     │
│  ┌──────────┬──────────┬──────────┐      │
│  │资源(URI) │  工具    │  提示词   │      │
│  └──────────┴──────────┴──────────┘      │
├─────────────────────────────────────────┤
│    实际的外部系统                         │
│  ┌──────────┬──────────┬──────────┐      │
│  │  数据库  │   API    │  文件系统 │      │
│  └──────────┴──────────┴──────────┘      │
└─────────────────────────────────────────┘
```

## MCP 配置步骤

### 方式 1：使用命令行快速添加（推荐）⭐

Claude Code 提供了命令行工具快速管理 MCP 服务器：

```bash
# 添加 MCP 服务器
claude mcp add <服务器名称> -- <npm 包命令>

# 删除 MCP 服务器
claude mcp remove <服务器名称>

# 列出所有已安装的 MCP 服务器
claude mcp list

# 查看 MCP 服务器详情
claude mcp get <服务器名称>
```

**实战示例：**

```bash
# 添加 Context7 文档查询服务
claude mcp add context7 -- npx @upstash/context7-mcp

# 添加文件系统访问
claude mcp add filesystem -- npx @modelcontextprotocol/server-filesystem .

# 添加 Git 集成
claude mcp add git -- npx @modelcontextprotocol/server-git --repository .

# 添加数据库访问
claude mcp add postgres -- npx @modelcontextprotocol/server-postgres

# 删除不需要的 MCP 服务器
claude mcp remove context7

# 查看已安装的服务器
claude mcp list
```

**优势：**
- ✅ 自动配置到 `.claude/mcp-servers.json`
- ✅ 自动验证配置正确性
- ✅ 无需手动编辑 JSON 文件
- ✅ 支持命令补全和错误提示

### 方式 2：手动配置文件

如果你需要更精细的控制,可以手动编辑配置文件。

#### 步骤 1：创建 MCP 配置文件

在项目根目录创建或编辑 `.claude/mcp-servers.json`：

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "/path/to/project"]
    }
  }
}
```

#### 步骤 2：安装 MCP 服务器

根据你要使用的 MCP 服务器安装依赖：

```bash
# 文件系统 MCP
npm install --save-dev @modelcontextprotocol/server-filesystem

# 数据库 MCP（MySQL/PostgreSQL）
npm install --save-dev @modelcontextprotocol/server-postgres

# Git MCP
npm install --save-dev @modelcontextprotocol/server-git
```

#### 步骤 3：启动 Claude Code

```bash
claude .
```

Claude Code 会自动加载所有配置的 MCP 服务器。

---

## 📚 官方 MCP 资源

**官方仓库和文档：**
- **MCP 官方规范**: https://spec.modelcontextprotocol.io
- **MCP 官方文档**: https://modelcontextprotocol.io
- **官方 MCP 服务器仓库**: https://github.com/modelcontextprotocol/servers
- **Anthropic MCP 文档**: https://docs.anthropic.com/en/docs/build-with-claude/mcp
- **npm MCP 包搜索**: https://www.npmjs.com/search?q=%40modelcontextprotocol

**社区资源：**
- **Awesome MCP Servers**: https://github.com/punkpeye/awesome-mcp-servers
- **MCP 服务器集合**: https://mcp.so
- **社区讨论**: https://github.com/modelcontextprotocol/servers/discussions

---

## 常用 MCP 服务器配置

### 1️⃣ 文件系统 MCP（必装）

**用途：** 给 Claude 完整的项目文件访问权限  
**官方包**: [@modelcontextprotocol/server-filesystem](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem)

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

**Claude 能做的事：**
- ✅ 智能搜索文件
- ✅ 批量读取代码
- ✅ 自动生成文件列表
- ✅ 递归分析目录结构

**命令示例：**
```
Claude: 找出所有包含 "TODO" 的文件
Claude: 生成项目的目录树
Claude: 列出所有 Java 文件并分组
```

### 2️⃣ Git MCP（推荐）

**用途：** 让 Claude 理解代码历史和变更

```json
{
  "mcpServers": {
    "git": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-git", "."]
    }
  }
}
```

**Claude 能做的事：**
- ✅ 查看提交历史
- ✅ 分析代码变更
- ✅ 理解分支结构
- ✅ 生成变更日志
- ✅ 自动创建提交信息

**命令示例：**
```
Claude: 最近改动了什么？
Claude: 这个 bug 是什么时候引入的？
Claude: 生成 CHANGELOG
Claude: 为我提交这些变更
```

### 3️⃣ 数据库 MCP（后端开发必装）

**PostgreSQL 配置：**

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-postgres"],
      "env": {
        "PG_HOST": "localhost",
        "PG_PORT": "5432",
        "PG_DATABASE": "myapp",
        "PG_USER": "postgres",
        "PG_PASSWORD": "${DB_PASSWORD}"
      }
    }
  }
}
```

**Claude 能做的事：**
- ✅ 查看数据库 schema
- ✅ 执行查询
- ✅ 生成迁移脚本
- ✅ 分析查询性能
- ✅ 自动优化 SQL

**命令示例：**
```
Claude: 创建用户表的迁移文件
Claude: 优化这个查询性能
Claude: 列出所有表的关系
```

### 4️⃣ SQLite MCP（前端本地存储）

```json
{
  "mcpServers": {
    "sqlite": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-sqlite", "app.db"]
    }
  }
}
```

### 5️⃣ GitHub MCP（代码托管）

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Claude 能做的事：**
- ✅ 查看 Issue 和 PR
- ✅ 创建 Pull Request
- ✅ 评论讨论
- ✅ 自动同步状态

### 5️⃣ᴮ GitLab MCP（公司代码托管）

**官方包**: [@modelcontextprotocol/server-gitlab](https://github.com/modelcontextprotocol/servers/tree/main/src/gitlab)

```json
{
  "mcpServers": {
    "gitlab": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-gitlab"],
      "env": {
        "GITLAB_URL": "https://gitlab.yourcompany.com",
        "GITLAB_TOKEN": "${GITLAB_TOKEN}",
        "GITLAB_PROJECT_ID": "${PROJECT_ID}"
      }
    }
  }
}
```

**Claude 能做的事：**
- ✅ 查看 Issue、MR（Merge Request）和 Pipeline
- ✅ 创建和管理 MR
- ✅ 查看 CI/CD 状态
- ✅ 同步代码库信息

**使用场景：**
```bash
# 查看待处理的 MR
claude . "列出所有待审查的 MR"

# 创建新的 MR
claude . "基于 feature 分支创建 MR，请求审查"

# 查看 Pipeline 状态
claude . "检查最近的构建状态，找出失败原因"
```

### 5️⃣ᶜ 钉钉通知（需自行实现或使用第三方）

**说明：** 钉钉 MCP 暂无官方实现，可以：

**方案 1: 使用 Bash + Webhook**

在提示词中要求使用 curl 发送钉钉 Webhook:

```bash
claude . "完成用户管理功能后，使用 curl 发送钉钉 Webhook 通知
Webhook URL: ${DINGTALK_WEBHOOK}"
```

**方案 2: 自行实现 MCP 服务器**

参考 [MCP 官方文档](https://modelcontextprotocol.io) 实现钉钉集成

**方案 3: 使用 CI/CD 集成**

在 GitHub Actions 或 GitLab CI 中配置钉钉通知

### 6️⃣ 依赖管理（使用 Bash 替代）

**说明：** NPM MCP 可能不存在官方包，可以通过 bash 命令实现相同功能。

**使用方式：**

```bash
# 直接在提示词中要求使用 bash 命令
claude . "使用 npm 命令检查项目中过期的依赖并更新"
```

**常用命令：**
- `npm outdated` - 查看过期依赖
- `npm audit` - 检查安全漏洞
- `npm update` - 更新依赖

---

## 🌟 高级 MCP 服务器

以下是一些强大的第三方和专业 MCP 服务器，可以极大增强 Claude Code 的能力。

### 7️⃣ Context7 文档查询（强烈推荐）⭐

**用途：** 实时获取最新的库文档和 API 参考，无需离开编辑器

**官方包**: `mcp-server-context7`

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "mcp-server-context7"]
    }
  }
}
```

**Claude 能做的事：**
- ✅ 查询任何 npm 包的最新文档
- ✅ 获取特定版本的 API 参考
- ✅ 搜索代码示例和用法
- ✅ 理解最新的库特性

**使用场景：**
```bash
# 查询 React 最新文档
claude . "使用 Context7 查询 React 18 的 useTransition hook 用法"

# 查询特定库的 API
claude . "查询 axios 库的请求拦截器配置方法"

# 获取代码示例
claude . "获取 Vue 3 Composition API 的响应式代码示例"
```

**适用项目：** 所有项目，特别是需要频繁查阅文档的开发场景

---

### 8️⃣ Open WebSearch 网页搜索（信息查询）

**用途：** 让 Claude 能够搜索互联网获取最新信息

**官方包**: `mcp-server-open-websearch`

```json
{
  "mcpServers": {
    "websearch": {
      "command": "npx",
      "args": ["-y", "mcp-server-open-websearch"]
    }
  }
}
```

**Claude 能做的事：**
- ✅ 搜索技术文档和教程
- ✅ 查找最新的技术博客
- ✅ 获取错误信息的解决方案
- ✅ 搜索开源项目和示例

**使用场景：**
```bash
# 搜索错误解决方案
claude . "搜索 'CORS error in React' 的最佳解决方案"

# 查找最佳实践
claude . "搜索 Spring Boot 3.x 的性能优化最佳实践"

# 获取技术对比
claude . "搜索并对比 Pinia vs Vuex 的优缺点"
```

**适用项目：** 需要实时信息查询的所有项目

---

### 9️⃣ Spec Workflow 规范化工作流（项目管理）⭐⭐

**用途：** 结构化的需求、设计、任务管理工作流

**官方包**: `mcp-server-spec-workflow`

```json
{
  "mcpServers": {
    "spec-workflow": {
      "command": "npx",
      "args": ["-y", "mcp-server-spec-workflow"]
    }
  }
}
```

**Claude 能做的事：**
- ✅ 创建和管理需求文档（Requirements）
- ✅ 生成技术设计文档（Design）
- ✅ 拆解和跟踪任务（Tasks）
- ✅ 生成项目结构文档（Structure）
- ✅ 审批流程管理（Approvals）

**工作流程：**

```
1. 需求阶段 (requirements.md)
   ↓
2. 产品设计 (product.md)
   ↓
3. 技术设计 (design.md)
   ↓
4. 架构设计 (structure.md)
   ↓
5. 任务拆解 (tasks.md)
   ↓
6. 实施开发
```

**使用场景：**

```bash
# 初始化项目规范
claude . "使用 Spec Workflow 为'用户认证系统'创建需求文档"

# 生成技术设计
claude . "基于需求文档生成技术设计，包括数据库设计和API设计"

# 拆解任务
claude . "将技术设计拆解为可执行的开发任务列表"

# 跟踪进度
claude . "查看当前项目的任务完成状态"
```

**文档结构：**

```
.spec-workflow/
├── specs/
│   └── user-auth/
│       ├── requirements.md    # 需求文档
│       ├── product.md         # 产品设计
│       ├── design.md          # 技术设计
│       ├── structure.md       # 架构设计
│       └── tasks.md           # 任务列表
└── approvals/                 # 审批记录
```

**适用项目：**
- 需要规范化开发流程的团队项目
- 大型功能开发
- 需要文档化的企业项目

---

### 🔟 DeepWiki 深度文档（技术学习）

**用途：** 获取 GitHub 项目的深度文档和使用指南

**官方包**: `mcp-server-deepwiki`

```json
{
  "mcpServers": {
    "deepwiki": {
      "command": "npx",
      "args": ["-y", "mcp-server-deepwiki"]
    }
  }
}
```

**Claude 能做的事：**
- ✅ 获取 GitHub 项目的完整文档
- ✅ 理解开源项目的架构
- ✅ 学习项目的使用方法
- ✅ 获取代码示例和最佳实践

**使用场景：**

```bash
# 学习开源项目
claude . "使用 DeepWiki 获取 vercel/next.js 的完整文档"

# 理解项目架构
claude . "通过 DeepWiki 分析 facebook/react 的架构设计"

# 获取使用指南
claude . "获取 vuejs/core 的 Composition API 详细使用指南"
```

**支持的格式：**
- GitHub 仓库（owner/repo）
- DeepWiki URL
- 项目关键词

**适用项目：**
- 学习和集成开源项目
- 技术调研
- 参考优秀项目的实现

---

### 1️⃣1️⃣ Playwright 浏览器控制（E2E 测试）⭐

**用途：** 自动化浏览器操作，进行端到端测试

**官方包**: `mcp-server-playwright`

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "mcp-server-playwright"]
    }
  }
}
```

**Claude 能做的事：**
- ✅ 自动化浏览器操作
- ✅ 执行端到端测试
- ✅ 截图和录屏
- ✅ 表单自动填写
- ✅ 页面性能分析
- ✅ 网页内容抓取

**使用场景：**

```bash
# E2E 测试
claude . "使用 Playwright 创建登录页面的端到端测试"

# UI 测试
claude . "打开 http://localhost:3000 并测试用户注册流程"

# 截图对比
claude . "访问产品页面，截图并与设计稿对比"

# 性能测试
claude . "使用 Playwright 分析首页的加载性能"

# 数据抓取
claude . "访问竞品网站，抓取产品列表数据"
```

**支持的操作：**

```javascript
// 导航
browser.navigate("https://example.com")

// 点击
browser.click("#login-button")

// 输入
browser.type("#username", "testuser")

// 截图
browser.screenshot("homepage.png")

// 等待元素
browser.waitFor("#content")

// 执行 JavaScript
browser.evaluate("document.title")
```

**适用项目：**
- Web 应用测试
- UI 自动化
- 数据爬取
- 性能测试

---

## 📋 按开发场景的 MCP Server 完整列表

> ⚠️ **重要说明**：以下列表已验证真实性，所有 MCP Server 均可在 npm 或官方仓库中找到。更新时间：2026-01-27

### 🎨 需求设计 & 原型开发

| MCP Server | 功能说明 | 验证状态 | 安装命令 |
|-----------|---------|---------|---------|
| **Context7** | 快速查阅技术文档和API手册 | ✅ 验证（Upstash官方） | `npx @upstash/context7-mcp` |
| **DeepWiki** | AI驱动的代码库上下文 | ✅ 验证（官方） | 参考 [mcpservers.org](https://mcpservers.org/servers/devin/deepwiki) |

**配置示例（需求设计阶段）：**

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
```

---

### 💻 前端开发

| MCP Server | 功能说明 | 验证状态 | 安装命令 |
|-----------|---------|---------|---------|
| **Filesystem** | 文件系统访问 | ✅ 官方 | `npx @modelcontextprotocol/server-filesystem` |
| **Git** | 版本控制管理 | ✅ 官方 | `npx @modelcontextprotocol/server-git` |
| **Playwright (微软)** | 浏览器自动化测试 | ✅ 微软官方 | `npx @playwright/mcp` |
| **Playwright (社区)** | E2E测试替代方案 | ✅ 验证 | `npx @executeautomation/playwright-mcp-server` |
| **SQLite** | 本地数据库 | ✅ 官方 | `npx @modelcontextprotocol/server-sqlite` |

**配置示例（React/Vue 前端项目）：**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "git": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-git", "--repository", "."]
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp"]
    },
    "sqlite": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sqlite", "./data/app.db"]
    }
  }
}
```

---

### ☕ 后端开发（Java/SpringBoot 技术栈）

| MCP Server | 功能说明 | 验证状态 | 安装命令 |
|-----------|---------|---------|---------|
| **Filesystem** | 文件系统访问 | ✅ 官方 | `npx @modelcontextprotocol/server-filesystem` |
| **Git** | 版本控制 | ✅ 官方 | `npx @modelcontextprotocol/server-git` |
| **MySQL** | MySQL 数据库管理 | ✅ 验证（v2.0.7） | `npm install -g @benborla29/mcp-server-mysql` |
| **PostgreSQL** | PostgreSQL 数据库 | ✅ 官方 | `npx @modelcontextprotocol/server-postgres` |
| **MongoDB** | MongoDB 数据库 | ✅ 验证（官方MongoDB） | `npx mongodb-mcp-server` |
| **Redis** | Redis 缓存管理 | ✅ 官方（已废弃npm包） | 见下方说明 |
| **Kubernetes** | K8s 微服务部署 | ✅ 验证（v3.2.0） | `npx mcp-server-kubernetes` |
| **RabbitMQ** | 消息队列管理 | ⚠️ Python版本 | 见下方说明 |

#### ⚠️ 重要说明

**Redis MCP Server：**
- 官方 npm 包 `@modelcontextprotocol/server-redis` 已废弃
- 推荐使用官方 GitHub 仓库：[redis/mcp-redis](https://github.com/redis/mcp-redis)
- 或使用社区版本：`@gongrzhe/server-redis-mcp`

**RabbitMQ MCP Server：**
- 目前主要是 **Python 实现**（PyPI: `mcp-server-rabbitmq`）
- npm 版本暂未验证，建议使用 Python 版本
- 安装：`pip install mcp-server-rabbitmq` 或 `uvx mcp-server-rabbitmq`

**Nacos/Spring Cloud：**
- 暂无官方 Nacos MCP Server
- 需要自行开发或等待社区实现

**配置示例（SpringBoot + MySQL + MongoDB）：**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "git": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-git", "--repository", "."]
    },
    "mysql": {
      "command": "npx",
      "args": ["-y", "@benborla29/mcp-server-mysql"],
      "env": {
        "MYSQL_HOST": "localhost",
        "MYSQL_PORT": "3306",
        "MYSQL_DATABASE": "springboot_app",
        "MYSQL_USER": "root",
        "MYSQL_PASSWORD": "${MYSQL_PASSWORD}"
      }
    },
    "mongodb": {
      "command": "npx",
      "args": ["-y", "mongodb-mcp-server"],
      "env": {
        "MONGODB_URI": "mongodb://localhost:27017/myapp"
      }
    },
    "kubernetes": {
      "command": "npx",
      "args": ["-y", "mcp-server-kubernetes"]
    }
  }
}
```

**MySQL MCP Server 详细配置：**

```bash
# 1. 安装 MySQL MCP Server (已验证 v2.0.7)
npm install -g @benborla29/mcp-server-mysql

# 2. 配置环境变量（.env 文件）
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_DATABASE=springboot_app
MYSQL_USER=root
MYSQL_PASSWORD=your_password

# 3. Claude 能做的事：
# ✅ 查看数据库表结构
# ✅ 执行 SQL 查询
# ✅ 生成 MyBatis Mapper
# ✅ 分析慢查询
# ✅ 生成数据库文档
```

**MongoDB MCP Server 使用示例：**

```bash
# 官方 MongoDB MCP Server (v1.5.0)
# GitHub: mongodb-js/mongodb-mcp-server
# NPM: mongodb-mcp-server

# Claude 命令示例：
Claude: 连接到 MongoDB 并列出所有集合
Claude: 查询 users 集合中的前 10 条记录
Claude: 创建索引优化查询性能
Claude: 分析集合的存储统计信息
```

---

### 🧪 测试开发

| MCP Server | 功能说明 | 验证状态 | 安装命令 |
|-----------|---------|---------|---------|
| **Playwright** | E2E 浏览器测试 | ✅ 微软官方 | `npx @playwright/mcp` |
| **Playwright (社区)** | E2E测试替代 | ✅ 验证 | `npx @executeautomation/playwright-mcp-server` |

**配置示例（E2E 测试）：**

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp"]
    }
  }
}
```

**测试场景示例：**

```bash
# E2E 测试
Claude: 使用 Playwright 测试用户登录流程
Claude: 截图对比当前页面与设计稿
Claude: 测试支付流程并生成测试报告
```

> ⚠️ **其他测试工具说明**：Postman、K6、Selenium、JMeter 等工具的 MCP Server **暂未找到官方或可验证的 npm 包**，建议使用 Playwright 或自行开发 MCP Server。

---

### 🔗 MCP Server 安装链接汇总（已验证）

#### 官方 MCP Servers
- ✅ [Filesystem](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem) - `npx @modelcontextprotocol/server-filesystem`
- ✅ [Git](https://github.com/modelcontextprotocol/servers/tree/main/src/git) - `npx @modelcontextprotocol/server-git`
- ✅ [PostgreSQL](https://github.com/modelcontextprotocol/servers/tree/main/src/postgres) - `npx @modelcontextprotocol/server-postgres`
- ✅ [SQLite](https://github.com/modelcontextprotocol/servers/tree/main/src/sqlite) - `npx @modelcontextprotocol/server-sqlite`
- ✅ [GitHub](https://github.com/modelcontextprotocol/servers/tree/main/src/github) - `npx @modelcontextprotocol/server-github`
- ✅ [GitLab](https://github.com/modelcontextprotocol/servers/tree/main/src/gitlab) - `npx @modelcontextprotocol/server-gitlab`

#### 社区验证 MCP Servers

**文档 & 搜索：**
- ✅ [Context7](https://github.com/upstash/context7) - `npx @upstash/context7-mcp`（Upstash 官方）
- ✅ [DeepWiki](https://mcpservers.org/servers/devin/deepwiki) - AI 代码库上下文

**数据库：**
- ✅ [MySQL](https://github.com/benborla/mcp-server-mysql) - `npm install -g @benborla29/mcp-server-mysql` (v2.0.7)
- ✅ [MongoDB](https://github.com/mongodb-js/mongodb-mcp-server) - `npx mongodb-mcp-server` (v1.5.0，官方)
- ✅ [Redis](https://github.com/redis/mcp-redis) - 官方 Redis MCP

**测试 & 自动化：**
- ✅ [Playwright (微软)](https://github.com/microsoft/playwright-mcp) - `npx @playwright/mcp`
- ✅ [Playwright (社区)](https://github.com/automata-labs/mcp-server-playwright) - `npx @executeautomation/playwright-mcp-server`

**DevOps：**
- ✅ [Kubernetes](https://github.com/Flux159/mcp-server-kubernetes) - `npx mcp-server-kubernetes` (v3.2.0)

#### 查找更多 MCP Servers

**官方注册表：**
- 🌐 [mcpservers.org](https://mcpservers.org/) - 官方精选列表
- 🌐 [MCPList.ai](https://www.mcplist.ai/) - 775+ 验证服务器
- 🌐 [MCPForge](https://www.mcpforge.org/directory) - 5,390+ 服务器目录
- 🌐 [GitHub Official Servers](https://github.com/modelcontextprotocol/servers) - 官方仓库

> 💡 **提示**：以上所有链接和包名均已验证真实性（验证时间：2026-01-27）。建议在使用前访问对应的 GitHub 仓库或 npm 页面确认最新版本。

---

### 🎯 快速配置脚本（已验证版本）

**Java 后端全栈开发配置：**

```bash
#!/bin/bash
# install-java-mcps.sh - 仅包含验证过的 MCP Servers

echo "🚀 安装 Java 后端开发 MCP Servers（已验证）..."

# 基础工具（官方）
echo "📦 安装基础工具..."
npm install -g @modelcontextprotocol/server-filesystem@latest
npm install -g @modelcontextprotocol/server-git@latest

# 数据库（已验证）
echo "💾 安装数据库 MCP..."
npm install -g @benborla29/mcp-server-mysql@latest
npm install -g mongodb-mcp-server@latest
npm install -g @modelcontextprotocol/server-postgres@latest

# DevOps（已验证）
echo "🐳 安装 DevOps 工具..."
npm install -g mcp-server-kubernetes@latest

echo ""
echo "✅ 安装完成！"
echo "📝 请在 .claude/mcp-servers.json 中配置相关环境变量"
echo ""
echo "⚠️  注意："
echo "   - Redis MCP 请使用官方仓库: github.com/redis/mcp-redis"
echo "   - RabbitMQ MCP 目前为 Python 版本"
echo "   - Nacos 暂无官方 MCP Server"
```

**前端开发配置：**

```bash
#!/bin/bash
# install-frontend-mcps.sh - 仅包含验证过的 MCP Servers

echo "🚀 安装前端开发 MCP Servers（已验证）..."

npm install -g @modelcontextprotocol/server-filesystem@latest
npm install -g @modelcontextprotocol/server-git@latest
npm install -g @modelcontextprotocol/server-sqlite@latest
npm install -g @playwright/mcp@latest
npm install -g @upstash/context7-mcp@latest

echo "✅ 安装完成！"
```

---

## 🎯 推荐的 MCP 组合方案

### 方案 1: 前端全栈开发者

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "git": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-git", "--repository", "."]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "mcp-server-context7"]
    },
    "websearch": {
      "command": "npx",
      "args": ["-y", "mcp-server-open-websearch"]
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "mcp-server-playwright"]
    }
  }
}
```

### 方案 2: 企业项目开发

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "git": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-git", "--repository", "."]
    },
    "gitlab": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-gitlab"],
      "env": {
        "GITLAB_URL": "${GITLAB_URL}",
        "GITLAB_TOKEN": "${GITLAB_TOKEN}"
      }
    },
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_HOST": "localhost",
        "POSTGRES_DB": "myapp"
      }
    },
    "spec-workflow": {
      "command": "npx",
      "args": ["-y", "mcp-server-spec-workflow"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "mcp-server-context7"]
    }
  }
}
```

### 方案 3: 学习和研究

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "mcp-server-context7"]
    },
    "deepwiki": {
      "command": "npx",
      "args": ["-y", "mcp-server-deepwiki"]
    },
    "websearch": {
      "command": "npx",
      "args": ["-y", "mcp-server-open-websearch"]
    }
  }
}
```

---

## 📦 开箱即用的配置示例

### 最小化配置（推荐新手）

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "."]
    },
    "git": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-git", "."]
    }
  }
}
```

**功能：** 文件管理 + 版本控制

---

### Vue + Node.js 完整配置

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "."]
    },
    "git": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-git", "."]
    },
    "npm": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-npm"]
    },
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**功能：** 文件管理 + 版本控制 + 依赖管理 + GitHub 集成

**安装命令：**
```bash
npm install --save-dev @modelcontextprotocol/server-filesystem \
                       @modelcontextprotocol/server-git \
                       @modelcontextprotocol/server-npm \
                       @modelcontextprotocol/server-github
```

---

### Java + PostgreSQL 完整配置

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "."]
    },
    "git": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-git", "."]
    },
    "postgres": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-postgres"],
      "env": {
        "PG_HOST": "localhost",
        "PG_PORT": "5432",
        "PG_DATABASE": "myapp_dev",
        "PG_USER": "postgres",
        "PG_PASSWORD": "${DB_PASSWORD}"
      }
    },
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**功能：** 文件管理 + 版本控制 + 数据库管理 + GitHub 集成

---

### 微服务架构配置

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "."]
    },
    "git": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-git", "."]
    },
    "postgres": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-postgres"],
      "env": {
        "PG_HOST": "localhost",
        "PG_PORT": "5432",
        "PG_DATABASE": "services",
        "PG_USER": "postgres",
        "PG_PASSWORD": "${DB_PASSWORD}"
      }
    },
    "docker": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-docker"]
    }
  }
}
```

---

## MCP 环境变量管理

### 安全配置方案

**创建 `.env` 文件：**

```bash
# .env
DB_PASSWORD=your_password
GITHUB_TOKEN=your_token
API_KEY=your_api_key
```

**在 mcp-servers.json 中引用：**

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-postgres"],
      "env": {
        "PG_PASSWORD": "${DB_PASSWORD}"
      }
    }
  }
}
```

**加载 .env 文件：**

```bash
source .env
claude .
```

⚠️ **安全提示：** 不要将 `.env` 提交到 Git，添加到 `.gitignore`

## 测试 MCP 连接

```bash
# 验证 MCP 服务器是否正确加载
claude --mcp-check

# 查看已加载的 MCP 服务器
claude --mcp-list

# 显示详细的调试信息
claude --debug . "test"
```

## 常见 MCP 问题

### 问题 1：MCP 服务器启动失败

```
Error: Failed to start MCP server: filesystem
```

**解决方案：**
```bash
# 检查 MCP 服务器是否安装
npm list @modelcontextprotocol/server-filesystem

# 重新安装
npm install --save-dev @modelcontextprotocol/server-filesystem
```

### 问题 2：数据库连接失败

```
Error: Cannot connect to PostgreSQL
```

**检查清单：**
- ✅ 数据库服务是否运行
- ✅ 连接参数是否正确
- ✅ 环境变量是否加载
- ✅ 防火墙是否开放端口

```bash
# 测试连接
psql -h localhost -U postgres -d myapp -W
```

### 问题 3：权限错误

```
Error: Permission denied
```

**解决方案：**
```bash
# 检查 MCP 配置权限
chmod 644 .claude/mcp-servers.json

# 检查数据库权限
psql -l  # 列出数据库
```

## MCP 管理最佳实践

### 1. MCP 命令行工具

Claude Code 2.1 提供了专门的 MCP 命令行工具，用于管理 MCP 服务器：

```bash
# 列出所有已安装的 MCP 服务器
claude mcp list

# 添加新的 MCP 服务器
claude mcp add <服务器名称> -- <npm 包命令>

# 删除 MCP 服务器
claude mcp remove <服务器名称>

# 查看 MCP 服务器详情
claude mcp get <服务器名称>

# 测试 MCP 服务器连接
claude mcp test <服务器名称>

# 更新 MCP 服务器
claude mcp update <服务器名称>

# 重启所有 MCP 服务器
claude mcp restart
```

#### 实战示例

```bash
# 添加文件系统 MCP
claude mcp add filesystem -- npx @modelcontextprotocol/server-filesystem .

# 添加 Git MCP
claude mcp add git -- npx @modelcontextprotocol/server-git --repository .

# 添加数据库 MCP
claude mcp add postgres -- npx @modelcontextprotocol/server-postgres

# 查看所有 MCP
claude mcp list
# 输出：
# ✅ filesystem - @modelcontextprotocol/server-filesystem
# ✅ git - @modelcontextprotocol/server-git
# ✅ postgres - @modelcontextprotocol/server-postgres

# 删除不需要的 MCP
claude mcp remove postgres

# 测试 MCP 连接
claude mcp test filesystem
# 输出： ✅ filesystem server is running correctly
```

### 2. MCP 配置文件管理

#### 项目级 vs 全局级

```
# 项目级配置（推荐用于特定项目需求）
.claude/mcp-servers.json

# 用户级配置（推荐用于个人常用工具）
~/.claude/mcp-servers.json

# 企业级配置（推荐用于团队统一配置）
通过 IAM 系统托管
```

#### 配置分离策略

将敏感信息和通用配置分离：

```json
// .claude/mcp-servers.json （提交到版本控制）
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-postgres"],
      "env": {
        "PG_HOST": "${PG_HOST}",
        "PG_PORT": "5432",
        "PG_DATABASE": "${PG_DATABASE}",
        "PG_USER": "${PG_USER}",
        "PG_PASSWORD": "${PG_PASSWORD}"
      }
    }
  }
}
```

```bash
# .env （不提交到版本控制，添加到 .gitignore）
PG_HOST=localhost
PG_DATABASE=myapp
PG_USER=postgres
PG_PASSWORD=your_secure_password
```

### 3. MCP 版本管理

#### 锁定 MCP 版本（推荐）

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-filesystem@1.2.3",
        "."
      ]
    }
  }
}
```

#### 使用 package.json 管理（更推荐）

```json
// package.json
{
  "devDependencies": {
    "@modelcontextprotocol/server-filesystem": "^1.2.3",
    "@modelcontextprotocol/server-git": "^2.0.0",
    "@modelcontextprotocol/server-postgres": "^1.5.0"
  }
}
```

```json
// .claude/mcp-servers.json
{
  "mcpServers": {
    "filesystem": {
      "command": "node",
      "args": ["./node_modules/@modelcontextprotocol/server-filesystem/dist/index.js", "."]
    }
  }
}
```

**优势：**
- ✅ 版本锁定，团队统一
- ✅ 离线可用
- ✅ 更快的启动速度
- ✅ 更好的依赖管理

### 4. MCP 环境管理

#### 多环境配置

```bash
# 开发环境
.claude/mcp-servers.dev.json

# 测试环境
.claude/mcp-servers.test.json

# 生产环境
.claude/mcp-servers.prod.json
```

```bash
# 使用环境变量选择配置
export CLAUDE_MCP_CONFIG=.claude/mcp-servers.dev.json
claude .
```

#### 环境变量模板

创建 `.env.example` 作为模板：

```bash
# .env.example （提交到版本控制）
# Database
PG_HOST=localhost
PG_PORT=5432
PG_DATABASE=your_database
PG_USER=your_user
PG_PASSWORD=your_password

# GitHub
GITHUB_TOKEN=your_github_token

# GitLab
GITLAB_URL=https://gitlab.yourcompany.com
GITLAB_TOKEN=your_gitlab_token
GITLAB_PROJECT_ID=your_project_id
```

---

## 快速验证 MCP 配置

### 验证已安装的 MCP

```bash
# 列出所有 MCP
claude mcp list

# 查看详细信息
claude mcp get <server-name>
```

### 测试常用 MCP

```bash
# 测试 Filesystem
claude . "列出当前目录的所有 .md 文件"

# 测试 Git
claude . "显示最近 3 次提交"

# 测试 GitHub（需要 Token）
claude . "列出我的前 5 个仓库"

# 测试 Context7
claude . "使用 Context7 查询 React hooks 文档"

# 测试 Playwright
claude . "用 Playwright 访问 https://example.com 并截图"
```

### 验证清单

- [ ] `claude mcp list` 显示所有配置的 MCP
- [ ] Filesystem MCP 可以列出文件
- [ ] Git MCP 可以查看提交（如在 Git 仓库中）
- [ ] 环境变量正确设置（如需要）
- [ ] 无权限错误
- [ ] 无连接错误

---

## 故障排查

### 问题 1: npx 找不到包

```bash
# 错误: Cannot find package '@modelcontextprotocol/server-xxx'

# 解决方案
# 1. 检查包名
npm search @modelcontextprotocol/server-xxx

# 2. 清理缓存
npm cache clean --force

# 3. 使用 -y 强制下载
claude mcp add xxx -- npx -y @modelcontextprotocol/server-xxx
```

### 问题 2: 权限错误

```bash
# 错误: Permission denied

# 解决方案
# 检查文件权限
ls -la .claude/mcp-servers.json

# 修复权限
chmod 644 .claude/mcp-servers.json
chmod 755 .claude
```

### 问题 3: 环境变量未加载

```bash
# 错误: Missing required environment variable

# 解决方案
# 1. 验证环境变量
echo $GITHUB_TOKEN

# 2. 重新加载配置
source ~/.bashrc  # 或 ~/.zshrc

# 3. 重启终端
```

### 问题 4: MCP 服务器无响应

```bash
# 检查状态
claude mcp list

# 查看详细日志
claude --debug .

# 移除并重新添加
claude mcp remove <name>
claude mcp add <name> -- npx -y <package>
```

### 调试技巧

```bash
# 1. 使用 debug 模式
claude --debug .

# 2. 测试单个 MCP
claude mcp get <server-name>

# 3. 检查 JSON 配置
cat .claude/mcp-servers.json | jq .

# 4. 验证 npm 包存在
npm view @modelcontextprotocol/server-xxx
```

---

## 推荐的 MCP 组合

### 最小配置（所有项目）

```bash
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
```

### Web 开发

```bash
# 基础
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .

# 文档查询
claude mcp add context7 -- npx -y @upstash/context7-mcp

# E2E 测试
claude mcp add playwright -- npx -y @automatalabs/mcp-server-playwright
```

### 全栈开发

```bash
# Web 开发 + 数据库 + GitHub
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
claude mcp add context7 -- npx -y @upstash/context7-mcp
claude mcp add github -- npx -y @modelcontextprotocol/server-github
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres
```

---

