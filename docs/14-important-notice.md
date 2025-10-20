# ⚠️ 重要说明：Claude Code 功能范围

> 本文档说明教程中提到的功能与 Claude Code 实际能力的对应关系

## 📌 实际可用的 Claude Code 功能

### ✅ 核心功能（已验证）

1. **基本使用**
   ```bash
   # 正确的基本命令
   claude code <directory> "<prompt>"
   claude code . "创建用户管理功能"
   ```

2. **MCP 集成**
   - 通过 `.claude/mcp-servers.json` 配置MCP服务器
   - 支持的官方 MCP 服务器:
     - `@modelcontextprotocol/server-filesystem`
     - `@modelcontextprotocol/server-git`
     - `@modelcontextprotocol/server-postgres`
     - `@modelcontextprotocol/server-sqlite`
     - `@modelcontextprotocol/server-github`

3. **规则文件**
   - 支持 `CLAUDE.md` 项目规则文件
   - 支持 `~/.claude/CLAUDE.md` 全局规则文件

4. **上下文优化**
   - 支持 `.claudeignore` 文件

## ⚠️ 概念性功能说明

以下功能在教程中作为**理想工作流程**展示，但可能不是 Claude Code 的内置功能：

### 1. SubAgent / Agent 系统

教程中的 SubAgent (如 `javaApiDeveloper`, `vueFrontendDeveloper`) 是**概念性的工作流设计**。

**实际使用方式:**
```bash
# 不是这样 ❌
claude code . --subagent=javaApiDeveloper "创建API"

# 而是通过清晰的提示词 ✅
claude code . "作为 Java Spring Boot 专家，创建用户管理 REST API，
包括 Controller、Service、Repository 和测试"
```

**如何实现类似效果:**
- 在 `CLAUDE.md` 中定义详细的项目规范
- 使用清晰、具体的提示词描述角色和需求
- 通过 MCP 提供项目上下文

### 2. 命令行参数

以下参数在教程中提及，但可能不是官方支持的:

```bash
# 这些可能不存在 ⚠️
claude-code init --template react-typescript
claude-code --subagent=architect
claude-code --dry-run . "command"
claude-code --temperature=0.5 . "command"
claude-code --agent-info=xxx
```

**正确的替代方案:**
- 使用配置文件: `.claude/config.json`
- 通过环境变量设置参数
- 直接在提示词中说明需求

### 3. 一些 MCP 服务器包名

以下 MCP 包可能不存在官方实现:

```bash
# 需要验证或自行实现 ⚠️
@modelcontextprotocol/server-dingtalk
@modelcontextprotocol/server-npm
@modelcontextprotocol/server-docker
@modelcontextprotocol/server-kubernetes
@modelcontextprotocol/server-web-search
@modelcontextprotocol/server-docs-generator
@modelcontextprotocol/server-jira
@modelcontextprotocol/server-slack
@modelcontextprotocol/server-prometheus
@modelcontextprotocol/server-github-actions
```

**解决方案:**
1. 查阅 [MCP 官方服务器列表](https://github.com/modelcontextprotocol/servers)
2. 使用社区实现的MCP服务器
3. 根据 [MCP 规范](https://modelcontextprotocol.io) 自行实现

## ✅ 推荐的实际工作流程

### 方案 1: 使用详细的 CLAUDE.md

```markdown
# CLAUDE.md

## 角色定义

当处理后端 API 开发任务时:
- 使用 Spring Boot 3.x 和 Java 21
- 遵循 RESTful 设计原则
- 包含完整的异常处理
- 提供 Swagger 文档注解
- 生成对应的单元测试

当处理前端组件任务时:
- 使用 Vue 3 Composition API
- 使用 TypeScript 严格模式
- 组件必须响应式
- 包含完整的类型定义
- 编写组件测试用例
```

### 方案 2: 使用结构化提示词

```bash
claude code . "
角色: Java Spring Boot 后端专家
任务: 创建用户管理功能
要求:
  - 实现 UserController (REST API)
  - 实现 UserService (业务逻辑)
  - 实现 UserRepository (数据访问)
  - 包含完整的参数验证
  - 包含异常处理
  - 包含 Swagger 注解
  - 编写单元测试(覆盖率>80%)
技术栈: Spring Boot 3.2, JPA, PostgreSQL
"
```

### 方案 3: 使用 MCP 提供上下文

```json
// .claude/mcp-servers.json
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
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_HOST": "localhost",
        "POSTGRES_DB": "myapp"
      }
    }
  }
}
```

## 📚 如何使用本教程

1. **理解概念**: 教程展示的是理想的 AI 辅助开发工作流
2. **实际应用**: 根据 Claude Code 的实际能力调整使用方式
3. **扩展能力**: 通过 MCP、规则文件和清晰的提示词实现类似效果

## 🔗 官方资源

- [Claude Code 官方文档](https://docs.claude.com/en/docs/claude-code)
- [MCP 协议规范](https://modelcontextprotocol.io)
- [MCP 服务器列表](https://github.com/modelcontextprotocol/servers)

## 💡 最佳实践

1. **使用 CLAUDE.md**: 详细定义项目规范和角色
2. **清晰的提示词**: 明确描述任务、要求和上下文
3. **善用 MCP**: 提供项目所需的工具和数据访问
4. **迭代改进**: 根据结果调整提示词和配置

---

**更新日期**: 2025-01-20
**适用版本**: Claude Code 1.0+

**提示**: 如果发现教程中的某个功能实际可用，请提交 Issue 或 PR 更新此文档！
