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

## 自定义 SubAgent

### 创建项目特定的 Agent

在 `.claude/agents.json` 中定义：

```json
{
  "customAgents": {
    "apiDeveloper": {
      "name": "API 开发专家",
      "description": "专门为 Spring Boot 开发 REST API",
      "instructions": [
        "遵循 RESTful 原则",
        "使用 @RestController 和 @RequestMapping",
        "实现完整的错误处理",
        "添加 Swagger 文档",
        "包含单元测试"
      ],
      "tools": ["filesystem", "git", "postgres"],
      "model": "claude-sonnet-4-20250514"
    },
    "frontendDeveloper": {
      "name": "前端开发专家",
      "description": "专门为 Vue.js 开发组件",
      "instructions": [
        "使用 Vue 3 Composition API",
        "遵循命名规范",
        "实现响应式设计",
        "添加单元测试",
        "编写 Storybook 文档"
      ],
      "tools": ["filesystem", "git", "npm"],
      "model": "claude-sonnet-4-20250514"
    }
  }
}
```

### 使用自定义 Agent

```bash
# 使用 API 开发专家
claude code . --subagent=apiDeveloper "创建用户管理 API"

# 使用前端开发专家
claude code . --subagent=frontendDeveloper "创建用户列表组件"
```

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
