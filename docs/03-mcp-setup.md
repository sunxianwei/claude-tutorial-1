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

### 步骤 1：创建 MCP 配置文件

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

### 步骤 2：安装 MCP 服务器

根据你要使用的 MCP 服务器安装依赖：

```bash
# 文件系统 MCP
npm install --save-dev @modelcontextprotocol/server-filesystem

# 数据库 MCP（MySQL/PostgreSQL）
npm install --save-dev @modelcontextprotocol/server-postgres

# Git MCP
npm install --save-dev @modelcontextprotocol/server-git
```

### 步骤 3：启动 Claude Code

```bash
claude-code .
```

Claude Code 会自动加载所有配置的 MCP 服务器。

## 常用 MCP 服务器配置

### 1️⃣ 文件系统 MCP（必装）

**用途：** 给 Claude 完整的项目文件访问权限

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

### 6️⃣ NPM/PyPI MCP（依赖管理）

**NPM 配置：**

```json
{
  "mcpServers": {
    "npm": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-npm"]
    }
  }
}
```

**Claude 能做的事：**
- ✅ 查看依赖版本
- ✅ 检查安全漏洞
- ✅ 建议更新
- ✅ 生成 package.json

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

## 下一章

👉 **[第 4 章：MCP 常用集合](04-mcp-common.md)** - 开箱即用的配置示例

---

**时间提示：** 本章阅读 15 分钟，配置 10 分钟 ⏱️
