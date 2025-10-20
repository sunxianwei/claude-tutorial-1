# 09 - 能力扩展：让 Claude Code 做更多

## 为什么要扩展 Claude Code 的能力？

Claude Code 虽然强大，但也有局限：

- ❌ 默认无法上网搜索
- ❌ 无法集成公司内部系统
- ❌ 无法调用私有 API
- ❌ 无法进行实时数据分析
- ❌ 无法与 Slack/钉钉 集成

通过扩展，我们可以突破这些限制。

## 扩展方案概览

```
┌─────────────────────────────────────────────┐
│  Claude Code (核心功能)                      │
├─────────────────────────────────────────────┤
│              MCP 扩展层                      │
│  ┌────────┬────────┬────────┬────────┐     │
│  │Web搜索 │数据库  │API调用 │消息队列│     │
│  └────────┴────────┴────────┴────────┘     │
├─────────────────────────────────────────────┤
│           自定义工具/插件层                  │
│  ┌────────┬────────┬────────┬────────┐     │
│  │内部API │BI系统  │项目工具│监控告警│     │
│  └────────┴────────┴────────┴────────┘     │
├─────────────────────────────────────────────┤
│          外部集成层                         │
│  ┌────────┬────────┬────────┬────────┐     │
│  │GitHub  │GitLab  │Jira   │Confluence│   │
│  └────────┴────────┴────────┴────────┘     │
└─────────────────────────────────────────────┘
```

## 方案 1：Web 搜索集成

### 用途

让 Claude Code 能够实时搜索互联网获取最新信息。

### 实现方式

#### 使用 Perplexity API（推荐）

```json
{
  "mcpServers": {
    "webSearch": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-web-search"],
      "env": {
        "PERPLEXITY_API_KEY": "${PERPLEXITY_API_KEY}",
        "SEARCH_ENGINE": "perplexity"
      }
    }
  }
}
```

#### 使用 Google Search API

```json
{
  "mcpServers": {
    "webSearch": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-google-search"],
      "env": {
        "GOOGLE_API_KEY": "${GOOGLE_API_KEY}",
        "CUSTOM_SEARCH_ENGINE_ID": "${SEARCH_ENGINE_ID}"
      }
    }
  }
}
```

### 使用场景

```bash
# 搜索最新的框架版本
claude code . "搜索 Vue 3 的最新版本和新特性"

# 查找最佳实践
claude code . "搜索 React 性能优化的最佳实践"

# 解决技术问题
claude code . "搜索如何在 Spring Boot 中集成 WebSocket"
```

## 方案 2：文档生成和发布

### 用途

让 Claude Code 自动生成各种格式的文档并发布到不同平台。

### 实现方式

```bash
# 安装文档生成工具
npm install --save-dev @modelcontextprotocol/server-docs-generator

# 配置支持的输出格式
```

**配置示例：**

```json
{
  "mcpServers": {
    "docGenerator": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-docs-generator"],
      "env": {
        "OUTPUT_FORMATS": "markdown,html,pdf,docx",
        "GITHUB_PAGES_REPO": "${GITHUB_PAGES_REPO}"
      }
    }
  }
}
```

### 使用场景

```bash
# 生成 API 文档
claude code . --docs-format=swagger "为所有 API 生成 Swagger 文档并发布到 API Gateway"

# 生成用户手册
claude code . --docs-format=html "生成用户手册并发布到内部 Wiki"

# 生成变更日志
claude code . --docs-format=markdown "生成 CHANGELOG 并推送到 GitHub"
```

## 方案 3：集成内部系统

### 场景：集成 Jira

```json
{
  "mcpServers": {
    "jira": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-jira"],
      "env": {
        "JIRA_DOMAIN": "https://jira.company.com",
        "JIRA_API_TOKEN": "${JIRA_API_TOKEN}",
        "JIRA_USER_EMAIL": "${JIRA_USER_EMAIL}"
      }
    }
  }
}
```

**使用场景：**

```bash
# 根据 Jira issue 开发功能
claude code . "根据 issue PROJ-123 实现用户管理功能"

# 自动生成 issue 和 commit 链接
claude code . "完成 PROJ-456 任务并创建关联的 PR"

# 生成工作报告
claude code . "总结我这周完成的 issue：PROJ-789, PROJ-790, PROJ-791"
```

### 场景：集成 Slack

```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "${SLACK_BOT_TOKEN}",
        "SLACK_CHANNEL": "#dev-notifications"
      }
    }
  }
}
```

**使用场景：**

```bash
# 代码审查完成后自动通知
claude code . "代码审查完成，自动在 Slack 上通知审查人"

# 测试失败时告警
claude code . "测试失败，发送 Slack 告警"

# 部署成功通知
claude code . "部署完成，发送成功消息到 Slack"
```

## 方案 4：自定义工具开发

### 创建自定义 Claude Code 工具

**项目结构：**

```
custom-mcp/
├── package.json
├── src/
│   ├── index.ts
│   ├── tools/
│   │   ├── customTool1.ts
│   │   ├── customTool2.ts
│   │   └── resources.ts
│   └── utils/
│       └── helpers.ts
└── dist/
```

**示例：公司内部数据库查询工具**

```typescript
// src/tools/companyDB.ts

interface CompanyDBTool {
  queryEmployeeByID: (id: string) => Promise<Employee>;
  getProjectList: () => Promise<Project[]>;
  getCodeReviewQueue: () => Promise<CodeReview[]>;
}

export const companyDBTool: CompanyDBTool = {
  async queryEmployeeByID(id: string) {
    // 连接公司内部数据库
    const result = await internalDB.query(
      'SELECT * FROM employees WHERE id = ?',
      [id]
    );
    return result[0];
  },

  async getProjectList() {
    // 获取所有项目
    return await internalDB.query(
      'SELECT * FROM projects WHERE status = "active"'
    );
  },

  async getCodeReviewQueue() {
    // 获取待审查代码
    return await internalDB.query(
      'SELECT * FROM code_reviews WHERE status = "pending" ORDER BY created_at DESC'
    );
  }
};
```

**配置到 Claude Code：**

```json
{
  "mcpServers": {
    "companyDB": {
      "command": "node",
      "args": ["./dist/index.js"],
      "env": {
        "DB_HOST": "internal-db.company.com",
        "DB_USER": "${DB_USER}",
        "DB_PASSWORD": "${DB_PASSWORD}"
      }
    }
  }
}
```

## 方案 5：监控和告警集成

### 集成 Prometheus 和 Grafana

```json
{
  "mcpServers": {
    "monitoring": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-prometheus"],
      "env": {
        "PROMETHEUS_URL": "http://prometheus.company.com:9090",
        "GRAFANA_API_KEY": "${GRAFANA_API_KEY}"
      }
    }
  }
}
```

**使用场景：**

```bash
# 分析系统性能
claude code . "分析过去 1 小时的系统性能指标，找出瓶颈"

# 生成性能报告
claude code . "生成周报，包括系统稳定性、性能、错误率等指标"

# 优化告警阈值
claude code . "根据最近的数据分析，建议调整告警阈值"
```

## 方案 6：CI/CD 流程集成

### 集成 GitHub Actions

```json
{
  "mcpServers": {
    "gitHubActions": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github-actions"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**使用场景：**

```bash
# 自动触发 CI/CD
claude code . "提交代码并自动触发 GitHub Actions 运行测试"

# 监控构建状态
claude code . "查看最后 10 次构建的状态和日志"

# 自动部署
claude code . "代码通过测试后自动部署到测试环境"
```

## 扩展能力成熟度评估

| 扩展类型 | 难度 | 投入时间 | 收益 | 推荐优先级 |
|---------|------|---------|------|----------|
| Web 搜索 | 低 | 1-2h | 高 | ⭐⭐⭐ |
| 文档生成 | 低 | 2-3h | 中 | ⭐⭐ |
| Jira 集成 | 中 | 4-6h | 中 | ⭐⭐⭐ |
| 自定义工具 | 高 | 8-16h | 高 | ⭐⭐ |
| 监控集成 | 中 | 6-8h | 中 | ⭐⭐ |
| CI/CD 集成 | 中 | 4-6h | 高 | ⭐⭐⭐ |

## 快速开始：Web 搜索扩展

### 步骤 1：注册 Perplexity API

访问 [Perplexity Console](https://console.perplexity.ai)，获取 API Key。

### 步骤 2：配置 MCP

```json
{
  "mcpServers": {
    "webSearch": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-web-search"],
      "env": {
        "PERPLEXITY_API_KEY": "pplx-xxxxxxxxxxxx"
      }
    }
  }
}
```

### 步骤 3：使用

```bash
# 立即使用 web 搜索
claude code . "搜索 TypeScript 5.0 的新特性"
```

---

**时间提示：** 本章阅读 10 分钟，集成 1-4 小时（取决于选择）⏱️
