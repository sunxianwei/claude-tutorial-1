# 示例项目配置模板

本目录包含可直接使用的示例项目配置。

## 可用配置

### 1. 前端项目配置 (.claude/config.json)

```json
{
  "model": "claude-sonnet-4-20250514",
  "temperature": 0.3,
  "maxTokens": 4096,
  "contextWindow": "中",
  "language": "zh-cn",
  "contextCompression": {
    "level": "medium",
    "ignoreNodeModules": true,
    "ignoreBuildArtifacts": true
  }
}
```

### 2. 后端项目配置 (.claude/config.json)

```json
{
  "model": "claude-sonnet-4-20250514",
  "temperature": 0.2,
  "maxTokens": 8192,
  "contextWindow": "大型",
  "language": "zh-cn"
}
```

### 3. MCP 服务配置 (.claude/mcp-servers.json)

#### 前端项目
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

#### 后端项目（Java）
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
    }
  }
}
```

### 4. .claudeignore 模板

```
# 依赖
node_modules/
.venv/
env/
venv/
vendor/
target/

# 构建产物
dist/
build/
out/
*.class
__pycache__/

# IDE
.vscode/
.idea/
*.swp
*.swo

# 系统
.DS_Store
.git/

# 临时
logs/
*.log
tmp/
```

## 如何使用

1. 复制相应的配置到你的项目
2. 根据你的实际环境修改参数
3. 运行 `claude-code init` 验证配置

---

更多详情见各项目的 README.md
