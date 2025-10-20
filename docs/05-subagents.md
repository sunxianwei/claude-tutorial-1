# 05 - SubAgents 使用：智能代理系统

## 什么是 SubAgents？

**SubAgents** 是 Claude Code 中最强大的功能之一。它允许你为特定任务创建专用的 AI 代理，每个代理都有特定的技能、工具和目标。

### 核心概念

```
┌─────────────────────────────────────────┐
│         你的任务需求                      │
└────────────────┬────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────┐
│  Claude Code 任务分析器                  │
│  - 识别任务类型                          │
│  - 分配最适合的 SubAgent                 │
└────────────────┬────────────────────────┘
                 │
        ┌────────┼────────┐
        ▼        ▼        ▼
   ┌────────┐ ┌────────┐ ┌────────┐
   │CodeGen │ │Security│ │Testing │
   │Agent   │ │Agent   │ │Agent   │
   └────────┘ └────────┘ └────────┘
        │        │        │
        └────────┼────────┘
                 ▼
        ┌────────────────┐
        │ 执行并验证结果  │
        └────────────────┘
```

## 查看可用的 SubAgents

### 使用 /agents 命令

在交互模式中，使用 `/agents` 命令查看所有可用的 SubAgents：

```bash
$ claude code .

> /agents
```

**输出示例：**

```
📋 可用的 SubAgents：

内置 Agents：
  🤖 codegen       - 代码生成专家
  🔒 security      - 安全审查专家
  🧪 testing       - 测试专家
  📚 documentation - 文档生成专家
  ♻️  refactor     - 重构优化专家
  👀 review        - 代码审查专家

自定义 Agents（来自 .claude/agents.json）：
  ☕ javaApiDeveloper      - Java API 开发专家
  🎨 vueFrontendDeveloper  - Vue 3 前端开发专家
  🧪 testingExpert        - 测试专家
  ⚡ performanceOptimizer - 性能优化专家

使用方式：
  claude code . --subagent=<agent-name> "你的任务描述"
  或在交互模式中: @<agent-name> 你的任务描述
```

### 查看 Agent 详情

```bash
# 查看特定 Agent 的详细信息
> /agents info codegen

# 输出：
Agent: codegen (代码生成专家)
描述: 快速生成高质量代码
模型: claude-sonnet-4-20250514
工具: filesystem, git, bash
专长:
  - 新功能开发
  - 代码模板生成
  - API 端点创建
  - 组件开发
```

### 在交互模式中使用 @mentions

除了使用 `--subagent` 参数，你还可以在交互模式中使用 `@` 提及 Agent：

```bash
$ claude code .

> @codegen 创建用户登录 API
[使用 CodeGen Agent 执行任务...]

> @security 审查登录代码的安全性
[使用 Security Agent 执行审查...]

> @testing 为登录功能生成测试
[使用 Testing Agent 生成测试...]
```

## 内置 SubAgents

Claude Code 内置了多个专业的代理：

### 1. CodeGen Agent（代码生成）

**用途：** 快速生成高质量代码

**特长：**
- 新功能开发
- 代码模板
- API 端点
- 组件生成

**使用方式：**

```bash
claude code . "使用 CodeGen Agent：为用户管理创建 REST API"

# 或显式指定
claude code . --subagent=codegen "创建登录功能"
```

**示例任务：**

```
# 前端示例
"为购物车功能创建 Vue 组件，包括添加、删除、更新功能"

# 后端示例
"为 Post 模块创建 Spring Boot REST API，包括 CRUD 操作"

# 数据库示例
"生成用户表迁移脚本，包含必要字段"
```

### 2. Security Agent（安全审查）

**用途：** 代码安全分析和改进

**特长：**
- 安全漏洞检测
- 权限验证
- 加密建议
- SQL 注入防护

**使用方式：**

```bash
claude code . --subagent=security "审查登录代码的安全性"
```

**示例任务：**

```
# 代码审查
"检查用户认证的代码，找出安全漏洞"

# 加密建议
"为密码存储改进加密方案"

# 权限分析
"检查 API 权限控制是否足够"
```

### 3. Testing Agent（测试代理）

**用途：** 自动生成测试用例

**特长：**
- 单元测试
- 集成测试
- 测试覆盖率分析
- Mock 数据生成

**使用方式：**

```bash
claude code . --subagent=testing "为 UserService 生成单元测试"
```

**示例任务：**

```
# 单元测试
"为 calculatePrice 函数生成完整的单元测试"

# 集成测试
"创建用户注册流程的集成测试"

# E2E 测试
"为登录页面创建 Cypress E2E 测试"
```

### 4. Documentation Agent（文档代理）

**用途：** 自动生成和更新文档

**特长：**
- API 文档生成
- 代码注释
- README 更新
- Changelog 生成

**使用方式：**

```bash
claude code . --subagent=documentation "生成 API 文档"
```

**示例任务：**

```
# API 文档
"为所有 Controller 生成 Swagger/OpenAPI 文档"

# 代码注释
"为 UserController 添加详细的 JavaDoc 注释"

# 项目文档
"更新 README，添加项目描述和使用说明"
```

### 5. Refactor Agent（重构代理）

**用途：** 代码重构和优化

**特长：**
- 代码简化
- 性能优化
- 设计模式应用
- 技术债务清理

**使用方式：**

```bash
claude code . --subagent=refactor "优化查询性能"
```

**示例任务：**

```
# 性能优化
"优化 N+1 查询问题"

# 代码清理
"移除重复代码并提取到公共方法"

# 设计改进
"将条件逻辑改为策略模式"
```

### 6. Review Agent（代码审查）

**用途：** 全方位代码审查

**特长：**
- 代码规范检查
- 最佳实践建议
- 性能分析
- 可维护性评估

**使用方式：**

```bash
claude code . --subagent=review "完整代码审查"
```

## 自定义 SubAgent（完整指南）

### 步骤 1：创建 agents.json 配置文件

在 `.claude/agents.json` 中定义自定义代理：

```json
{
  "customAgents": {
    "javaApiDeveloper": {
      "name": "Java API 开发专家",
      "description": "为公司内部系统开发 Spring Boot REST API",
      "model": "claude-sonnet-4-20250514",
      "tools": ["filesystem", "git", "postgres"],
      "instructions": [
        "使用 Spring Boot 3.x 和 Java 21",
        "严格遵循 RESTful 设计原则",
        "实现完整的错误处理和日志记录",
        "添加详细的 Swagger/OpenAPI 文档",
        "包含完整的单元测试（JUnit 5 + Mockito）",
        "测试覆盖率必须 >= 80%",
        "使用 Lombok @RequiredArgsConstructor 进行依赖注入",
        "所有 API 响应使用统一的数据结构",
        "实现请求参数验证和异常处理",
        "记录关键操作的审计日志",
        "考虑性能优化（缓存、查询优化等）",
        "参考本项目的 CLAUDE.md 中定义的规范"
      ],
      "systemPrompt": "你是一位有 10 年 Java 开发经验的高级后端工程师。你熟悉公司的技术栈和开发规范。生成的代码必须符合企业级应用的质量标准。"
    },

    "vueFrontendDeveloper": {
      "name": "Vue 3 前端开发专家",
      "description": "为公司内部系统开发 Vue 3 组件和页面",
      "model": "claude-sonnet-4-20250514",
      "tools": ["filesystem", "git", "npm"],
      "instructions": [
        "使用 Vue 3 Composition API + TypeScript",
        "组件文件名使用 PascalCase",
        "所有 props 都必须有详细的类型定义",
        "使用 scoped style 隔离样式",
        "实现响应式设计，支持移动设备",
        "遵循公司的组件命名规范",
        "添加单元测试（Vitest + Testing Library）",
        "测试覆盖率必须 >= 80%",
        "使用 Pinia 管理全局状态",
        "实现错误边界和加载态",
        "添加详细的代码注释和类型文档",
        "优化性能（memoization、虚拟滚动等）"
      ],
      "systemPrompt": "你是一位有 8 年 Vue 开发经验的前端工程师。你关注用户体验和代码可维护性。生成的代码必须符合现代前端开发的最佳实践。"
    },

    "testingExpert": {
      "name": "测试专家",
      "description": "为项目生成完整的测试用例",
      "model": "claude-sonnet-4-20250514",
      "tools": ["filesystem", "git"],
      "instructions": [
        "分析代码并识别所有关键业务逻辑",
        "生成全面的单元测试用例",
        "包括正常案例、边界案例和异常案例",
        "对于 Java 代码：使用 JUnit 5 + Mockito",
        "对于前端代码：使用 Vitest + Testing Library",
        "每个测试必须有清晰的说明注释",
        "确保测试的可读性和可维护性",
        "添加集成测试脚本",
        "生成测试覆盖率报告",
        "目标覆盖率 >= 80%"
      ],
      "systemPrompt": "你是一位 QA 工程师，具有深厚的测试理论知识。你擅长编写全面、高效的测试用例。"
    },

    "performanceOptimizer": {
      "name": "性能优化专家",
      "description": "分析和优化应用性能",
      "model": "claude-opus-4-1-20250805",
      "tools": ["filesystem", "git", "postgres"],
      "instructions": [
        "分析代码找出性能瓶颈",
        "识别 N+1 查询问题",
        "提出数据库索引优化建议",
        "推荐缓存策略",
        "分析内存使用情况",
        "建议代码重构改进性能",
        "提出前端优化方案（懒加载、代码分割等）",
        "生成性能测试基准",
        "提供详细的优化报告和建议"
      ],
      "systemPrompt": "你是一位性能优化专家，有丰富的大规模系统优化经验。你能识别性能问题并提出科学的优化方案。"
    }
  }
}
```

### 步骤 2：使用自定义 SubAgent

#### 方式 A：单个 Agent 使用

```bash
# 使用 Java API 开发专家
claude code . --subagent=javaApiDeveloper "为用户管理模块创建完整的 REST API"

# 使用 Vue 前端开发专家
claude code . --subagent=vueFrontendDeveloper "创建用户管理页面，包括列表、搜索、编辑功能"

# 使用测试专家
claude code . --subagent=testingExpert "为 UserService 生成完整的单元测试"

# 使用性能优化专家
claude code . --subagent=performanceOptimizer "分析并优化数据库查询性能"
```

#### 方式 B：链式执行多个 Agent

```bash
# 代码生成 → 测试 → 安全审查 → 优化 → 文档
claude code . \
  --subagent=javaApiDeveloper \
  --chain="testingExpert,security,performanceOptimizer,documentation" \
  "创建订单管理 API，包括查询、创建、更新功能"
```

### 步骤 3：完整的实战例子

#### 例子 1：开发用户认证 API

**场景：** 为公司系统添加用户认证接口

**代码生成阶段：**

```bash
claude code . --subagent=javaApiDeveloper \
  "创建用户认证 API，需求如下：

## 功能需求
1. 用户登录 - POST /api/v1/auth/login
   - 输入：username, password
   - 输出：JWT token, user info
   - 密码使用 BCrypt 加密

2. 用户注册 - POST /api/v1/auth/register
   - 输入：username, password, email
   - 输出：user info
   - 验证 email 格式和 username 唯一性

3. 刷新 token - POST /api/v1/auth/refresh
   - 输入：refresh token
   - 输出：new JWT token

## 技术要求
- 使用 Spring Security 实现认证
- JWT token 有效期 1 小时
- Refresh token 有效期 7 天
- 实现速率限制防止暴力破解
- 添加详细的错误处理
- 生成 Swagger 文档
"
```

**测试阶段：**

```bash
claude code . --subagent=testingExpert \
  "为上面生成的 AuthController 和 AuthService 生成完整的测试用例"
```

**优化阶段：**

```bash
claude code . --subagent=performanceOptimizer \
  "分析认证代码的性能，特别是关注：
  - 数据库查询优化
  - 密码验证的性能
  - 缓存策略
  "
```

#### 例子 2：开发用户管理页面

**场景：** 为后台管理系统创建用户管理页面

**代码生成阶段：**

```bash
claude code . --subagent=vueFrontendDeveloper \
  "创建用户管理页面组件，需求如下：

## 功能需求
1. 用户列表展示
   - 表格显示：ID、用户名、邮箱、创建时间、操作
   - 支持分页（每页 20 条）
   - 支持排序和搜索

2. 用户搜索
   - 支持按用户名和邮箱搜索
   - 实时搜索提示

3. 用户操作
   - 编辑用户信息的模态框
   - 删除用户（确认对话）
   - 批量删除

4. 加载和错误状态
   - 显示加载中...
   - 显示错误信息
   - 为空时显示提示

## 技术要求
- 使用 Vue 3 Composition API
- TypeScript 类型检查
- 使用 Element Plus 组件库
- 响应式设计（支持移动设备）
- 性能优化（虚拟滚动）
"
```

**测试阶段：**

```bash
claude code . --subagent=testingExpert \
  "为用户管理页面生成完整的单元测试"
```

### 步骤 4：添加自定义 Agent 到项目

**项目结构：**

```
your-project/
├── .claude/
│   ├── config.json
│   ├── agents.json          # ← 放这里
│   └── mcp-servers.json
├── CLAUDE.md
└── src/
```

**验证配置：**

```bash
# 查看所有可用的 agent
claude-code --list-agents

# 显示特定 agent 的详情
claude-code --agent-info=javaApiDeveloper

# 测试 agent 功能
claude-code --test-agent=javaApiDeveloper
```

### 步骤 5：最佳实践

#### 1. 为每个 Agent 添加明确的角色定义

```json
{
  "systemPrompt": "你是一位资深的 [职位] 工程师，拥有 [年数] 年的经验..."
}
```

#### 2. 在 instructions 中列出具体要求

```json
{
  "instructions": [
    "✅ DO：明确的正向指导",
    "❌ DON'T：需要避免的行为"
  ]
}
```

#### 3. 定期更新 Agent 配置

根据项目进展，不断改进 Agent 的指导，使其更适合项目需求。

#### 4. 结合规则文件使用

在 `CLAUDE.md` 中定义全局规范，Agent 会自动遵守。

---

## 链式 Agent 工作流

### 场景：完整功能开发

```
需求说明
  ↓
[CodeGen] 代码生成
  ↓
[Testing] 添加测试
  ↓
[Security] 安全审查
  ↓
[Documentation] 生成文档
  ↓
[Review] 最终审查
  ↓
完成
```

**自动化脚本：**

```bash
#!/bin/bash
# dev-workflow.sh

PROJECT_PATH=$1
FEATURE_DESC=$2

echo "🚀 开始完整的功能开发流程..."

echo "1️⃣ 代码生成..."
claude code $PROJECT_PATH --subagent=codegen "$FEATURE_DESC"

echo "2️⃣ 生成测试..."
claude code $PROJECT_PATH --subagent=testing "为上面的代码生成完整的单元测试"

echo "3️⃣ 安全审查..."
claude code $PROJECT_PATH --subagent=security "审查安全性"

echo "4️⃣ 生成文档..."
claude code $PROJECT_PATH --subagent=documentation "生成 API 文档"

echo "5️⃣ 最终审查..."
claude code $PROJECT_PATH --subagent=review "完整代码审查"

echo "✅ 流程完成！"
```

**使用方式：**

```bash
chmod +x dev-workflow.sh
./dev-workflow.sh . "为订单模块添加支付功能"
```

## 实战案例

### 案例 1：快速生成 Spring Boot API

```bash
# 使用专家 Agent 创建 API
claude code . --subagent=apiDeveloper --chain="test,security,doc" \
  "创建订单 API，包括查询、创建、更新、删除功能"

# --chain 参数指定自动链式执行的 agent
```

**预期输出：**
- ✅ 完整的 OrderController
- ✅ 单元测试 OrderControllerTest
- ✅ 安全性检查完成
- ✅ Swagger 文档

### 案例 2：Vue 组件完整开发

```bash
claude code . --subagent=frontendDeveloper --chain="test,doc" \
  "创建用户管理页面，包括列表、搜索、编辑、删除功能"
```

**预期输出：**
- ✅ UserManagement.vue 组件
- ✅ 单元测试
- ✅ Storybook 文档
- ✅ 响应式设计

### 案例 3：数据库迁移

```bash
claude code . --subagent=database \
  "创建用户表迁移，包括字段和索引"
```

## SubAgent 配置最佳实践

### 1. 明确的指令

```json
{
  "instructions": [
    "使用 TypeScript 严格模式",
    "100% 测试覆盖率",
    "符合 Airbnb ESLint 规则",
    "包含详细的错误处理"
  ]
}
```

### 2. 合适的工具集

```json
{
  "tools": ["filesystem", "git", "npm", "postgres"]
}
```

### 3. 模型选择

- **Claude Opus 4.1** - 复杂任务（生成完整系统）
- **Claude Sonnet 4** - 平衡选择（大多数任务） ⭐ 推荐
- **Claude Haiku 4.5** - 简单快速任务（成本优化）

## 下一章

👉 **[第 6 章：规则文件系统](06-rules-file.md)** - CLAUDE.md 完全指南

---

**时间提示：** 本章阅读 15 分钟，实践 20 分钟 ⏱️
