# MCP 实例配置详解（已验证）

> ✅ 本文档中的所有配置均基于官方文档，并提供详细的验证步骤

## 🔍 验证说明

- ✅ **已验证**: 基于官方文档的准确配置
- ⚠️ **需要环境**: 需要安装特定服务（如 MySQL、Redis）
- 📝 **配置示例**: 提供完整的配置文件示例
- 🧪 **测试步骤**: 提供详细的测试验证步骤

---

## 1. Context7 - 文档查询 ✅

### 官方信息
- **包名**: `mcp-server-context7` 或 `@upstash/context7-mcp`
- **GitHub**: https://github.com/upstash/context7-mcp
- **npm**: https://www.npmjs.com/package/@upstash/context7-mcp
- **用途**: 查询最新的库文档和 API 参考

### 安装方式

```bash
# 使用 Claude Code 命令行
claude mcp add context7 -- npx -y @upstash/context7-mcp

# 或手动配置
```

### 配置文件

**`.claude/mcp-servers.json`**:

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

### 验证步骤

```bash
# 1. 启动 Claude Code
claude code .

# 2. 在对话中测试
> 使用 Context7 查询 React 18 的 useTransition hook 用法

# 3. 预期结果
# Claude 会通过 Context7 获取 React 文档并回答问题
```

### 使用示例

```bash
# 查询 npm 包文档
"使用 Context7 查询 axios 库的请求拦截器配置"

# 查询特定版本
"通过 Context7 获取 Next.js 14 的路由文档"

# 查询代码示例
"从 Context7 获取 Vue 3 Composition API 的响应式示例"
```

---

## 2. MySQL MCP ⚠️

### 官方信息
- **注意**: 官方 MCP 服务器仓库中没有现成的 MySQL MCP
- **替代方案**:
  - 使用 PostgreSQL MCP（官方支持）
  - 自行实现 MySQL MCP
  - 使用通用数据库 MCP（如果有）

### PostgreSQL MCP（官方支持）✅

**包名**: `@modelcontextprotocol/server-postgres`
**GitHub**: https://github.com/modelcontextprotocol/servers/tree/main/src/postgres

#### 前置要求

```bash
# 安装 PostgreSQL
# macOS
brew install postgresql@14
brew services start postgresql@14

# 创建测试数据库
createdb testdb
```

#### 配置文件

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "postgresql://localhost/testdb"
      }
    }
  }
}
```

#### 验证步骤

```bash
# 1. 确保 PostgreSQL 运行
psql -d testdb -c "SELECT version();"

# 2. 配置 MCP
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres

# 3. 设置环境变量
export POSTGRES_CONNECTION_STRING="postgresql://localhost/testdb"

# 4. 启动 Claude Code 测试
claude code .

# 5. 测试查询
> 查询数据库中的所有表
> 创建一个用户表
```

### MySQL 替代方案

如果必须使用 MySQL，可以：

1. **使用 SQLite MCP**（官方支持，更简单）
2. **通过 Bash 命令操作 MySQL**

```bash
# 在 Claude Code 中使用 Bash 操作 MySQL
> 使用 mysql 命令查询数据库：mysql -u root -p -e "SHOW DATABASES;"
```

---

## 3. Redis MCP ⚠️

### 官方信息
- **状态**: 官方仓库中暂无 Redis MCP
- **社区实现**: 可能有第三方实现

### 替代方案

#### 方案 1: 使用 Bash 命令

```bash
# 安装 Redis
brew install redis
brew services start redis

# 在 Claude Code 中使用
> 使用 redis-cli 命令获取所有 key：redis-cli KEYS "*"
> 使用 redis-cli 设置值：redis-cli SET mykey "Hello"
```

#### 方案 2: 自行实现 Redis MCP

参考官方 MCP 服务器实现模板创建自定义 Redis MCP。

---

## 4. GitHub MCP ✅

### 官方信息
- **包名**: `@modelcontextprotocol/server-github`
- **GitHub**: https://github.com/modelcontextprotocol/servers/tree/main/src/github
- **npm**: https://www.npmjs.com/package/@modelcontextprotocol/server-github

### 前置要求

```bash
# 创建 GitHub Personal Access Token
# 访问: https://github.com/settings/tokens/new

# 所需权限:
# - repo (完整仓库访问)
# - workflow (如需操作 Actions)
```

### 配置文件

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

### 环境变量设置

```bash
# macOS/Linux
export GITHUB_TOKEN="ghp_your_token_here"

# Windows
setx GITHUB_TOKEN "ghp_your_token_here"
```

### 验证步骤

```bash
# 1. 设置 Token
export GITHUB_TOKEN="your_token"

# 2. 配置 MCP
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# 3. 启动 Claude Code
claude code .

# 4. 测试功能
> 列出我的 GitHub 仓库
> 查看 username/repo 的最近提交
> 创建一个 issue 在 username/repo
```

### 使用示例

```bash
# 查看仓库信息
"查看我的 GitHub 仓库列表"
"获取 torvalds/linux 仓库的 README"

# 管理 Issues
"列出我的所有 open issues"
"在 myrepo 中创建一个 issue: 修复登录 bug"

# 查看 Pull Requests
"查看我创建的所有 PR"
"获取 PR #123 的详细信息"

# 查看提交历史
"查看 main 分支的最近 10 次提交"
```

---

## 5. GitLab MCP ✅

### 官方信息
- **包名**: `@modelcontextprotocol/server-gitlab`
- **GitHub**: https://github.com/modelcontextprotocol/servers/tree/main/src/gitlab

### 前置要求

```bash
# 创建 GitLab Personal Access Token
# 访问: https://gitlab.com/-/profile/personal_access_tokens

# 所需权限:
# - api
# - read_api
# - read_repository
```

### 配置文件

```json
{
  "mcpServers": {
    "gitlab": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-gitlab"],
      "env": {
        "GITLAB_PERSONAL_ACCESS_TOKEN": "${GITLAB_TOKEN}",
        "GITLAB_API_URL": "https://gitlab.com/api/v4"
      }
    }
  }
}
```

### 自托管 GitLab 配置

```json
{
  "mcpServers": {
    "gitlab": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-gitlab"],
      "env": {
        "GITLAB_PERSONAL_ACCESS_TOKEN": "${GITLAB_TOKEN}",
        "GITLAB_API_URL": "https://gitlab.yourcompany.com/api/v4"
      }
    }
  }
}
```

### 验证步骤

```bash
# 1. 设置 Token
export GITLAB_TOKEN="glpat-your_token"

# 2. 配置 MCP
claude mcp add gitlab -- npx -y @modelcontextprotocol/server-gitlab

# 3. 测试
> 列出我的 GitLab 项目
> 查看项目的 CI/CD Pipeline 状态
```

---

## 6. Playwright MCP ✅

### 官方信息
- **包名**: `mcp-server-playwright` 或 `@automatalabs/mcp-server-playwright`
- **GitHub**: https://github.com/automatalabs/mcp-server-playwright
- **npm**: https://www.npmjs.com/package/@automatalabs/mcp-server-playwright

### 前置要求

```bash
# Playwright 会自动安装浏览器
# 首次使用时会下载 Chromium/Firefox/WebKit
```

### 配置文件

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@automatalabs/mcp-server-playwright"]
    }
  }
}
```

### 验证步骤

```bash
# 1. 配置 MCP
claude mcp add playwright -- npx -y @automatalabs/mcp-server-playwright

# 2. 启动 Claude Code
claude code .

# 3. 测试浏览器控制
> 使用 Playwright 打开 https://www.google.com 并截图

# 4. 测试表单操作
> 使用 Playwright 访问 https://example.com，查找所有链接
```

### 使用示例

```bash
# 访问网页
"使用 Playwright 访问 https://github.com"

# 截图
"打开 https://www.baidu.com 并截图保存"

# 表单操作
"访问登录页面，填写用户名和密码（测试环境）"

# 测试流程
"使用 Playwright 测试用户登录流程：
1. 访问 http://localhost:3000/login
2. 填写 username: test
3. 填写 password: test123
4. 点击登录按钮
5. 验证是否跳转到首页"

# 数据抓取
"访问 https://news.ycombinator.com，抓取首页所有新闻标题"
```

---

## 7. Jenkins MCP ⚠️

### 官方信息
- **状态**: 官方仓库中暂无 Jenkins MCP
- **替代方案**: 使用 Jenkins API + Bash

### 替代方案：使用 Jenkins API

```bash
# 安装 Jenkins CLI
brew install jenkins

# 或使用 curl 调用 API
```

### 通过 Bash 操作 Jenkins

```bash
# 在 Claude Code 中使用

# 触发构建
> 使用 curl 触发 Jenkins 构建：
> curl -X POST http://jenkins.example.com/job/my-job/build \
>   --user username:token

# 获取构建状态
> 使用 curl 获取最后一次构建状态：
> curl http://jenkins.example.com/job/my-job/lastBuild/api/json \
>   --user username:token

# 获取构建日志
> 获取 Jenkins 构建 #123 的日志
```

---

## 8. SQLite MCP ✅

### 官方信息
- **包名**: `@modelcontextprotocol/server-sqlite`
- **GitHub**: https://github.com/modelcontextprotocol/servers/tree/main/src/sqlite

### 配置文件

```json
{
  "mcpServers": {
    "sqlite": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sqlite", "./database.db"]
    }
  }
}
```

### 验证步骤

```bash
# 1. 创建测试数据库
sqlite3 test.db "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);"
sqlite3 test.db "INSERT INTO users VALUES (1, 'Alice');"

# 2. 配置 MCP
claude mcp add sqlite -- npx -y @modelcontextprotocol/server-sqlite ./test.db

# 3. 测试
> 查询 users 表的所有数据
> 创建一个 products 表
```

---

## 9. Filesystem MCP ✅（必装）

### 官方信息
- **包名**: `@modelcontextprotocol/server-filesystem`
- **GitHub**: https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem

### 配置文件

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

### 安全配置（限制访问路径）

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/project",
        "/another/allowed/path"
      ]
    }
  }
}
```

---

## 10. Git MCP ✅（推荐）

### 官方信息
- **包名**: `@modelcontextprotocol/server-git`
- **GitHub**: https://github.com/modelcontextprotocol/servers/tree/main/src/git

### 配置文件

```json
{
  "mcpServers": {
    "git": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-git",
        "--repository",
        "."
      ]
    }
  }
}
```

### 验证步骤

```bash
# 1. 确保在 Git 仓库中
git status

# 2. 配置 MCP
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .

# 3. 测试
> 查看 Git 提交历史
> 查看当前分支
> 查看未提交的修改
```

---

## 完整配置示例

### 全栈开发者配置

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
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "${DATABASE_URL}"
      }
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@automatalabs/mcp-server-playwright"]
    }
  }
}
```

### 环境变量配置

```bash
# .env 文件
GITHUB_TOKEN=ghp_your_token_here
GITLAB_TOKEN=glpat_your_token_here
DATABASE_URL=postgresql://localhost/mydb
```

```bash
# 加载环境变量
source .env

# 或在 shell 配置文件中设置
# ~/.bashrc 或 ~/.zshrc
export GITHUB_TOKEN="ghp_your_token_here"
export DATABASE_URL="postgresql://localhost/mydb"
```

---

## 测试所有 MCP 配置

### 测试脚本

创建 `test-mcp.sh`:

```bash
#!/bin/bash

echo "🧪 测试 MCP 配置..."

# 1. 测试 Filesystem
echo "1️⃣ 测试 Filesystem MCP..."
claude code . "列出当前目录的所有文件"

# 2. 测试 Git
echo "2️⃣ 测试 Git MCP..."
claude code . "显示最近 5 次 Git 提交"

# 3. 测试 GitHub（需要 Token）
if [ -n "$GITHUB_TOKEN" ]; then
    echo "3️⃣ 测试 GitHub MCP..."
    claude code . "列出我的 GitHub 仓库前 5 个"
else
    echo "⚠️ 跳过 GitHub MCP（未设置 GITHUB_TOKEN）"
fi

# 4. 测试 Context7
echo "4️⃣ 测试 Context7 MCP..."
claude code . "使用 Context7 查询 React 文档"

# 5. 测试 Playwright
echo "5️⃣ 测试 Playwright MCP..."
claude code . "使用 Playwright 访问 https://example.com 并截图"

echo "✅ 测试完成！"
```

```bash
# 运行测试
chmod +x test-mcp.sh
./test-mcp.sh
```

---

## 故障排查

### 问题 1: npx 找不到包

```bash
# 错误信息
Error: Cannot find package '@modelcontextprotocol/server-xxx'

# 解决方案
# 1. 检查包名是否正确
npm search @modelcontextprotocol/server-xxx

# 2. 尝试全局安装
npm install -g @modelcontextprotocol/server-xxx

# 3. 清理 npm 缓存
npm cache clean --force
```

### 问题 2: 权限错误

```bash
# 错误信息
Permission denied

# 解决方案
# 1. 检查文件权限
ls -la .claude/mcp-servers.json

# 2. 修复权限
chmod 644 .claude/mcp-servers.json

# 3. 检查目录权限
chmod 755 .claude
```

### 问题 3: 环境变量未加载

```bash
# 错误信息
Missing required environment variable

# 解决方案
# 1. 验证环境变量
echo $GITHUB_TOKEN

# 2. 重新加载 shell 配置
source ~/.bashrc  # 或 ~/.zshrc

# 3. 重启终端
```

### 问题 4: MCP 服务器无响应

```bash
# 检查 MCP 状态
claude mcp list

# 查看详细日志
claude code --debug .

# 重启 Claude Code
# Ctrl+C 退出，然后重新启动
```

---

## 验证清单

使用以下清单验证 MCP 配置：

- [ ] Filesystem MCP 可以列出文件
- [ ] Git MCP 可以查看提交历史
- [ ] GitHub MCP 可以访问仓库（如已配置）
- [ ] Context7 MCP 可以查询文档
- [ ] Playwright MCP 可以打开网页
- [ ] 数据库 MCP 可以查询数据（如已配置）
- [ ] 环境变量正确加载
- [ ] 无权限错误
- [ ] 无连接错误

---

## 推荐的 MCP 组合

### 最小配置（适合所有项目）

```bash
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
```

### Web 开发配置

```bash
# 基础
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .

# 文档查询
claude mcp add context7 -- npx -y @upstash/context7-mcp

# E2E 测试
claude mcp add playwright -- npx -y @automatalabs/mcp-server-playwright
```

### 全栈开发配置

```bash
# 基础 + Web 开发
# ... 上面的命令 ...

# 代码托管
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# 数据库
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres
```

---

**✅ 所有配置均基于官方文档，确保准确可用！**
