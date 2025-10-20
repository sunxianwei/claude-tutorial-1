# MCP 包验证说明

> 本文档列出教程中使用的 MCP 包的验证状态

## ✅ 已验证的官方 MCP 包

以下包已确认存在于 npm 或官方仓库:

| 包名 | 状态 | 说明 |
|------|------|------|
| `@modelcontextprotocol/server-filesystem` | ✅ 官方 | 文件系统访问 |
| `@modelcontextprotocol/server-git` | ✅ 官方 | Git 操作 |
| `@modelcontextprotocol/server-postgres` | ✅ 官方 | PostgreSQL 数据库 |
| `@modelcontextprotocol/server-sqlite` | ✅ 官方 | SQLite 数据库 |
| `@modelcontextprotocol/server-github` | ✅ 官方 | GitHub API |
| `@modelcontextprotocol/server-gitlab` | ✅ 官方 | GitLab API |

## 🌟 推荐的第三方 MCP 包

以下是经过验证的强大第三方 MCP 服务器:

| 包名 | 状态 | 说明 | 推荐度 |
|------|------|------|--------|
| `mcp-server-context7` | ✅ 可用 | 实时查询库文档和 API 参考 | ⭐⭐⭐ 强烈推荐 |
| `mcp-server-open-websearch` | ✅ 可用 | 网页搜索，获取最新信息 | ⭐⭐⭐ 强烈推荐 |
| `mcp-server-spec-workflow` | ✅ 可用 | 规范化项目管理工作流 | ⭐⭐⭐ 企业推荐 |
| `mcp-server-deepwiki` | ✅ 可用 | 获取 GitHub 项目深度文档 | ⭐⭐ 推荐 |
| `mcp-server-playwright` | ✅ 可用 | 浏览器自动化和 E2E 测试 | ⭐⭐⭐ 强烈推荐 |

## ⚠️ 需要验证或可能不存在的包

以下包在教程中提及，但需要用户自行验证或实现:

| 包名 | 状态 | 建议 |
|------|------|------|
| `@modelcontextprotocol/server-npm` | ⚠️ 未验证 | 查询 npm 或使用bash命令替代 |
| `@modelcontextprotocol/server-dingtalk` | ⚠️ 未验证 | 可能需要自行实现或使用第三方 |
| `@modelcontextprotocol/server-docker` | ⚠️ 未验证 | 查询官方列表或使用bash命令 |
| `@modelcontextprotocol/server-kubernetes` | ⚠️ 未验证 | 查询官方列表或使用kubectl |
| `@modelcontextprotocol/server-web-search` | ⚠️ 未验证 | 查询社区实现 |
| `@modelcontextprotocol/server-docs-generator` | ⚠️ 未验证 | 可能需要自行实现 |
| `@modelcontextprotocol/server-jira` | ⚠️ 未验证 | 查询社区实现 |
| `@modelcontextprotocol/server-slack` | ⚠️ 未验证 | 查询社区实现 |
| `@modelcontextprotocol/server-prometheus` | ⚠️ 未验证 | 查询社区实现 |
| `@modelcontextprotocol/server-github-actions` | ⚠️ 未验证 | 可能需要自行实现 |

## 🔍 如何验证 MCP 包

### 方法 1: 查询 npm

```bash
npm search @modelcontextprotocol/server-[name]
```

### 方法 2: 查看官方列表

访问: https://github.com/modelcontextprotocol/servers

### 方法 3: 尝试安装

```bash
npm install --save-dev @modelcontextprotocol/server-[name]
```

## 💡 替代方案

如果所需的 MCP 包不存在，可以考虑:

### 方案 1: 使用 Bash 工具

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    }
  }
}
```

然后在提示词中要求 Claude 使用 bash 命令完成操作。

### 方案 2: 自行实现 MCP 服务器

参考: https://modelcontextprotocol.io/docs/building-servers

基本结构:
```typescript
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';

const server = new Server({
  name: 'custom-server',
  version: '1.0.0'
});

// 定义工具
server.tool('myTool', async (params) => {
  // 实现逻辑
  return {result: 'done'};
});

// 启动服务器
const transport = new StdioServerTransport();
await server.connect(transport);
```

### 方案 3: 使用社区实现

搜索 GitHub:
- 关键词: "mcp server [功能名]"
- 过滤: TypeScript/JavaScript

## 📚 推荐的 MCP 组合

### 最小可用集 (适合所有项目)

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
    }
  }
}
```

### 前端开发集（推荐）⭐

```json
{
  "mcpServers": {
    "filesystem": {...},
    "git": {...},
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

### 后端开发集（推荐）⭐

```json
{
  "mcpServers": {
    "filesystem": {...},
    "git": {...},
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_HOST": "localhost",
        "POSTGRES_DB": "mydb"
      }
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "mcp-server-context7"]
    },
    "websearch": {
      "command": "npx",
      "args": ["-y", "mcp-server-open-websearch"]
    }
  }
}
```

### 企业项目开发集（完整）⭐⭐

```json
{
  "mcpServers": {
    "filesystem": {...},
    "git": {...},
    "gitlab": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-gitlab"],
      "env": {
        "GITLAB_URL": "${GITLAB_URL}",
        "GITLAB_TOKEN": "${GITLAB_TOKEN}"
      }
    },
    "postgres": {...},
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

## ⚠️ 重要提醒

1. **验证后使用**: 在生产环境使用前，务必验证MCP包是否真实存在
2. **查看官方文档**: 官方 MCP 包的配置可能与教程示例不同
3. **社区支持**: 加入 MCP 社区获取最新的包列表和使用建议
4. **安全考虑**: 使用第三方 MCP 包前，检查代码质量和安全性

## 🔗 相关资源

- [MCP 官方文档](https://modelcontextprotocol.io)
- [MCP 服务器列表](https://github.com/modelcontextprotocol/servers)
- [MCP SDK](https://github.com/modelcontextprotocol/sdk)
- [构建自定义 MCP 服务器](https://modelcontextprotocol.io/docs/building-servers)

---

**更新日期**: 2025-01-20
**维护**: 如发现新的可用 MCP 包，请提交 PR 更新此文档
