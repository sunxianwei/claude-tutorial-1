# 04 - MCP 常用集合：开箱即用的配置

本章提供现成的 MCP 配置组合，可以直接复制使用。

## 全栈开发完整配置

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

### 标准开发配置（推荐中级用户）

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

**功能：** 文件管理 + 版本控制 + 依赖管理

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

### DevOps/云部署配置

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
    "docker": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-docker"]
    },
    "kubernetes": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-kubernetes"]
    }
  }
}
```

---

## 快速复制方案

### 方案 A：仅复制文件内容

1. 复制上面对应的 JSON 配置
2. 编辑 `.claude/mcp-servers.json`
3. 粘贴配置
4. 修改数据库连接等参数

### 方案 B：使用 CLI 生成

```bash
# 切换到项目目录
cd your-project

# 自动生成配置

# 或指定具体 MCP
```

### 方案 C：从模板克隆

本指南提供的示例项目已包含完整配置，可以直接参考：

- `examples/frontend-project/` - Vue 配置
- `examples/backend-project/` - Java 配置
- `examples/fullstack-project/` - 完整栈配置

## 配置验证清单

复制配置后，按以下步骤验证：

```bash
# 1. 检查 JSON 语法
cat .claude/mcp-servers.json | jq '.'

# 2. 检查 MCP 服务器是否安装
npm list | grep @modelcontextprotocol

# 3. 启动测试
claude --mcp-check

# 4. 查看已加载的服务
claude --mcp-list
```

## 高级定制

### 添加自定义环境变量

在项目根目录创建 `.env`：

```bash
# .env
DB_PASSWORD=your_password
GITHUB_TOKEN=your_token
API_KEY=your_api_key
```

加载环境变量：

```bash
source .env
claude .
```

### 条件加载 MCP

如果需要在不同环境使用不同 MCP：

```bash
#!/bin/bash
# start-claude.sh

if [ "$ENVIRONMENT" == "development" ]; then
  export MCP_PRESET="development"
  claude --config .claude/mcp-dev.json .
else
  claude --config .claude/mcp-prod.json .
fi
```

## 下一章

👉 **[第 5 章：SubAgents 使用](05-子代理使用.md)** - 智能代理系统

---

**时间提示：** 本章阅读 5 分钟（快速参考）⏱️
