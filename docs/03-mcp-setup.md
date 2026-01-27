# 03 - MCP 配置指南：扩展 Claude Code 的能力

## 什么是 MCP？

**MCP (Model Context Protocol)** 是一个标准协议，允许 Claude AI 通过定义明确的接口来访问外部工具和数据源。

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
claude mcp info <服务器名称>
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

如果你需要更精细的控制，可以手动编辑配置文件。

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
claude-code .
```

Claude Code 会自动加载所有配置的 MCP 服务器。

## 常用 MCP 服务器配置

### 📚 官方 MCP 资源

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
claude code . "列出所有待审查的 MR"

# 创建新的 MR
claude code . "基于 feature 分支创建 MR，请求审查"

# 查看 Pipeline 状态
claude code . "检查最近的构建状态，找出失败原因"
```

### 5️⃣ᶜ 钉钉通知（需自行实现或使用第三方）

**说明：** 钉钉 MCP 暂无官方实现，可以：

**方案 1: 使用 Bash + Webhook**

在提示词中要求使用 curl 发送钉钉 Webhook:

```bash
claude code . "完成用户管理功能后，使用 curl 发送钉钉 Webhook 通知
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
claude code . "使用 npm 命令检查项目中过期的依赖并更新"
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
claude code . "使用 Context7 查询 React 18 的 useTransition hook 用法"

# 查询特定库的 API
claude code . "查询 axios 库的请求拦截器配置方法"

# 获取代码示例
claude code . "获取 Vue 3 Composition API 的响应式代码示例"
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
claude code . "搜索 'CORS error in React' 的最佳解决方案"

# 查找最佳实践
claude code . "搜索 Spring Boot 3.x 的性能优化最佳实践"

# 获取技术对比
claude code . "搜索并对比 Pinia vs Vuex 的优缺点"
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
claude code . "使用 Spec Workflow 为'用户认证系统'创建需求文档"

# 生成技术设计
claude code . "基于需求文档生成技术设计，包括数据库设计和API设计"

# 拆解任务
claude code . "将技术设计拆解为可执行的开发任务列表"

# 跟踪进度
claude code . "查看当前项目的任务完成状态"
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
claude code . "使用 DeepWiki 获取 vercel/next.js 的完整文档"

# 理解项目架构
claude code . "通过 DeepWiki 分析 facebook/react 的架构设计"

# 获取使用指南
claude code . "获取 vuejs/core 的 Composition API 详细使用指南"
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
claude code . "使用 Playwright 创建登录页面的端到端测试"

# UI 测试
claude code . "打开 http://localhost:3000 并测试用户注册流程"

# 截图对比
claude code . "访问产品页面，截图并与设计稿对比"

# 性能测试
claude code . "使用 Playwright 分析首页的加载性能"

# 数据抓取
claude code . "访问竞品网站，抓取产品列表数据"
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

## 前端开发 MCP 套装

适合 Vue/React 开发的推荐组合：

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
    }
  }
}
```

**推荐指令集合：**

```bash
# 创建新组件
"claude code . 为购物车功能创建 Vue 组件"

# 优化性能
"claude code . 分析页面性能并优化"

# 管理依赖
"claude code . 更新所有过期的依赖"

# 自动测试
"claude code . 为 UserProfile 组件添加单元测试"
```

## 后端开发 MCP 套装

适合 Java/Spring Boot 开发的推荐组合：

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
        "PG_DATABASE": "myapp",
        "PG_USER": "postgres",
        "PG_PASSWORD": "password"
      }
    }
  }
}
```

**推荐指令集合：**

```bash
# 创建 API 端点
"claude code . 为用户模块创建 REST API"

# 数据库迁移
"claude code . 生成订单表迁移脚本"

# 性能优化
"claude code . 分析慢查询并优化"

# 文档生成
"claude code . 为所有 Controller 生成 Swagger 文档"
```

## 测试开发 MCP 套装

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

**推荐工作流：**

```bash
# 生成测试用例
"claude code . 为 UserService 生成单元测试"

# 集成测试
"claude code . 创建登录流程的集成测试"

# 性能测试
"claude code . 为 API 编写负载测试"

# 测试覆盖率
"claude code . 分析测试覆盖率并补充缺失的测试"
```

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
claude-code .
```

⚠️ **安全提示：** 不要将 `.env` 提交到 Git，添加到 `.gitignore`

## 测试 MCP 连接

```bash
# 验证 MCP 服务器是否正确加载
claude-code --mcp-check

# 查看已加载的 MCP 服务器
claude-code --mcp-list

# 显示详细的调试信息
claude-code --debug . "test"
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
claude mcp info <服务器名称>

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
claude code .
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

### 5. MCP 健康检查

#### 定期检查脚本

```bash
#!/bin/bash
# check-mcp-health.sh

echo "🔍 检查 MCP 服务器健康状态..."

# 检查每个 MCP 服务器
for server in filesystem git postgres; do
  echo "Testing $server..."
  if claude mcp test "$server"; then
    echo "✅ $server is healthy"
  else
    echo "❌ $server failed"
    # 尝试重启
    echo "Attempting to restart $server..."
    claude mcp restart "$server"
  fi
done

echo "✅ Health check completed"
```

### 6. MCP 故障排查

#### 常见问题和解决方案

**问题 1： MCP 服务器启动失败**

```bash
# 检查 MCP 日志
claude mcp logs <server-name>

# 查看详细错误信息
claude mcp test <server-name> --verbose

# 重新安装 MCP
claude mcp remove <server-name>
claude mcp add <server-name> -- <command>
```

**问题 2： MCP 连接超时**

```bash
# 增加超时时间
export MCP_TIMEOUT=60000  # 60 秒

# 检查网络连接
ping api.modelcontextprotocol.io

# 检查防火墙设置
```

**问题 3： 环境变量未加载**

```bash
# 验证环境变量
echo $PG_PASSWORD

# 手动加载 .env
source .env
claude code .

# 使用 dotenv
npm install -g dotenv-cli
dotenv -e .env -- claude code .
```

### 7. MCP 性能优化

#### 延迟加载 MCP

```json
{
  "mcpServers": {
    "heavy-tool": {
      "command": "npx",
      "args": ["heavy-mcp-server"],
      "lazyLoad": true,
      "loadTimeout": 10000
    }
  }
}
```

#### 禁用不需要的 MCP

```bash
# 临时禁用 MCP
claude mcp disable postgres

# 重新启用
claude mcp enable postgres

# 查看状态
claude mcp list
```

### 8. MCP 安全最佳实践

#### 1. 使用环境变量存储敏感信息

```bash
# ❌ 不要这样做
{
  "env": {
    "API_KEY": "sk-1234567890abcdef"  # 硬编码
  }
}

# ✅ 应该这样做
{
  "env": {
    "API_KEY": "${API_KEY}"  # 使用环境变量
  }
}
```

#### 2. 限制 MCP 权限

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "./src"],
      "permissions": {
        "read": true,
        "write": false
      }
    }
  }
}
```

### 9. MCP 团队协作

#### 团队配置模板

创建团队共享的 MCP 配置：

```bash
# 项目根目录
.claude/
├── mcp-servers.json          # 基础配置（提交）
├── mcp-servers.dev.json      # 开发环境（提交）
├── mcp-servers.example.json  # 示例配置（提交）
└── README-MCP.md             # MCP 使用文档（提交）

# 不提交
.env                           # 个人环境变量（不提交）
.claude/mcp-servers.local.json # 个人配置覆盖（不提交）
```

## 下一章

👉 **[第 4 章：MCP 常用集合](04-mcp-common.md)** - 开箱即用的配置示例

---

**时间提示：** 本章阅读 20 分钟，配置 15 分钟 ⏱️
