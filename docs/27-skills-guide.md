# 27 - Skills 完全指南:扩展 Claude Code 的能力

## 什么是 Skills?

**Skills(技能)** 是 Claude Code 2.1 版本引入的强大功能,它让你可以教会 Claude 新的能力。通过创建包含指令的 `SKILL.md` 文件,Claude 会将其添加到工具包中,在相关时自动使用,或者你可以通过 `/skill-name` 直接调用。

### Skills vs 自定义命令

在 Claude Code 2.1 中,**自定义斜杠命令已合并到 Skills 中**:
- `.claude/commands/review.md` 文件和 `.claude/skills/review/SKILL.md` 技能都会创建 `/review` 命令
- 现有的 `.claude/commands/` 文件继续有效
- Skills 提供了更多可选功能:支持文件的目录、控制调用方式的前置元数据、自动加载能力

### Skills 遵循开放标准

Claude Code Skills 遵循 [Agent Skills](https://agentskills.io) 开放标准,该标准适用于多个 AI 工具。同时 Claude Code 扩展了该标准,增加了调用控制、子代理执行和动态上下文注入等功能。

## 核心概念

```
┌─────────────────────────────────────────┐
│  你的任务需求                             │
└────────────────┬────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────┐
│  Claude Code 分析任务                    │
│  - 检查相关的 Skills                     │
│  - 根据 description 决定是否自动加载      │
└────────────────┬────────────────────────┘
                 │
        ┌────────┴────────┐
        ▼                 ▼
   自动调用          用户调用 /skill-name
   (by Claude)       (by User)
        │                 │
        └────────┬────────┘
                 ▼
        ┌────────────────┐
        │ 执行 Skill 指令 │
        │ 完成任务        │
        └────────────────┘
```

## 快速开始:创建你的第一个 Skill

### 示例:代码解释 Skill

这个示例创建一个教 Claude 使用视觉图表和类比来解释代码的技能。

#### 步骤 1:创建技能目录

```bash
# 个人技能(在所有项目中都可用)
mkdir -p ~/.claude/skills/explain-code

# 或项目技能(仅在当前项目中可用)
mkdir -p .claude/skills/explain-code
```

#### 步骤 2:编写 SKILL.md

创建 `~/.claude/skills/explain-code/SKILL.md`:

```markdown
---
name: explain-code
description: Explains code with visual diagrams and analogies. Use when explaining how code works, teaching about a codebase, or when the user asks "how does this work?"
---

When explaining code, always include:

1. **Start with an analogy**:
   Compare the code to something from everyday life

2. **Draw a diagram**:
   Use ASCII art to show the flow, structure, or relationships

3. **Walk through the code**:
   Explain step-by-step what happens

4. **Highlight a gotcha**:
   What's a common mistake or misconception?

Keep explanations conversational. For complex concepts, use multiple analogies.
```

#### 步骤 3:测试技能

你可以通过两种方式测试:

**方式 1:让 Claude 自动调用**
```bash
claude .
> How does this authentication code work?
# Claude 会根据 description 自动加载 explain-code 技能
```

**方式 2:直接使用技能名称调用**
```bash
claude .
> /explain-code src/auth/login.ts
```

## Skills 存放位置

Skills 的存放位置决定了谁可以使用它:

| 位置 | 路径 | 适用范围 |
|------|------|---------|
| **企业级** | 参阅托管设置 | 组织中的所有用户 |
| **个人级** | `~/.claude/skills/<skill-name>/SKILL.md` | 你的所有项目 |
| **项目级** | `.claude/skills/<skill-name>/SKILL.md` | 仅此项目 |
| **插件级** | `<plugin>/skills/<skill-name>/SKILL.md` | 启用插件的位置 |

**优先级**: 项目技能 > 个人技能(同名时项目级覆盖个人级)

### 自动发现嵌套目录

当你在子目录中处理文件时,Claude Code 会自动从嵌套的 `.claude/skills/` 目录中发现技能。

**示例(单仓库设置)**:
```
monorepo/
├── packages/
│   ├── frontend/
│   │   ├── .claude/skills/     # 前端特定技能
│   │   │   └── react-review/
│   │   └── src/
│   └── backend/
│       ├── .claude/skills/     # 后端特定技能
│       │   └── api-review/
│       └── src/
└── .claude/skills/             # 全局技能
    └── commit-msg/
```

## Skill 文件结构

每个 Skill 是一个以 `SKILL.md` 作为入口点的目录:

```
my-skill/
├── SKILL.md           # 主要指令(必需)
├── template.md        # Claude 要填写的模板
├── examples/
│   └── sample.md      # 示例输出
└── scripts/
    └── validate.sh    # Claude 可以执行的脚本
```

`SKILL.md` 包含主要指令并且是必需的。其他文件是可选的,让你构建更强大的技能。

## 配置 Skills

### SKILL.md 文件格式

Skills 通过 `SKILL.md` 顶部的 YAML 前置元数据和随后的 markdown 内容进行配置。

```markdown
---
name: skill-name
description: What this skill does
disable-model-invocation: false
user-invocable: true
---

# Your skill instructions here
具体的指令内容...
```

### 前置元数据字段参考

所有字段都是可选的,建议至少提供 `description`。

| 字段 | 必需 | 描述 |
|------|------|------|
| `name` | 否 | 技能的显示名称。如果省略,使用目录名称。仅小写字母、数字和连字符(最多64个字符)。 |
| `description` | 推荐 | 技能的作用以及何时使用它。Claude 使用它来决定何时应用该技能。如果省略,使用 markdown 内容的第一段。 |
| `argument-hint` | 否 | 自动完成期间显示的提示。示例:`[issue-number]` 或 `[filename] [format]`。 |
| `disable-model-invocation` | 否 | 设置为 `true` 以防止 Claude 自动加载此技能。用于你想使用 `/name` 手动触发的工作流。默认:`false`。 |
| `user-invocable` | 否 | 设置为 `false` 以从 `/` 菜单中隐藏。用于用户不应直接调用的背景知识。默认:`true`。 |
| `allowed-tools` | 否 | 此技能处于活动状态时 Claude 可以使用而无需请求权限的工具。示例:`Read, Grep, Shell`。 |
| `model` | 否 | 此技能处于活动状态时要使用的模型。 |
| `context` | 否 | 设置为 `fork` 以在分叉的子代理上下文中运行。 |
| `agent` | 否 | 设置 `context: fork` 时要使用的子代理类型。 |
| `hooks` | 否 | 限定于此技能生命周期的钩子。 |

### 字符串替换变量

Skills 支持动态值的字符串替换:

| 变量 | 描述 |
|------|------|
| `$ARGUMENTS` | 调用技能时传递的所有参数。如果内容中不存在 `$ARGUMENTS`,参数将作为 `ARGUMENTS: <value>` 追加。 |
| `${CLAUDE_SESSION_ID}` | 当前会话 ID。用于日志记录、创建特定于会话的文件或将技能输出与会话关联。 |

**示例**:

```markdown
---
name: session-logger
description: Log activity for this session
---

Log the following to logs/${CLAUDE_SESSION_ID}.log:
$ARGUMENTS
```

## Skill 内容类型

思考你想如何调用 Skills 有助于指导包含的内容:

### 1. 参考内容型 Skills

添加 Claude 应用于当前工作的知识。约定、模式、风格指南、领域知识。

**示例:API 约定**

```markdown
---
name: api-conventions
description: API design patterns for this codebase
---

When writing API endpoints:
- Use RESTful naming conventions
- Return consistent error formats
- Include request validation
- Add OpenAPI/Swagger documentation
- Implement proper HTTP status codes
- Use pagination for list endpoints
```

### 2. 任务内容型 Skills

为 Claude 提供特定操作的分步说明。通常使用 `/skill-name` 直接调用。

**示例:部署流程**

```markdown
---
name: deploy
description: Deploy the application to production
context: fork
disable-model-invocation: true
---

Deploy the application:

1. Run the test suite
   ```bash
   npm run test
   ```

2. Build the application
   ```bash
   npm run build
   ```

3. Push to the deployment target
   ```bash
   ./scripts/deploy.sh production
   ```

4. Verify the deployment succeeded
   ```bash
   curl https://api.production.com/health
   ```

5. Send notification to Slack
```

## 控制谁调用 Skills

默认情况下,你和 Claude 都可以调用任何没有设置 `disable-model-invocation: true` 的技能。

### 场景 1:仅用户可调用(手动工作流)

添加 `disable-model-invocation: true` 来防止 Claude 自动运行:

```markdown
---
name: deploy
description: Deploy the application to production
disable-model-invocation: true
---
```

**适用场景**: 有副作用的操作,如 `/commit`、`/deploy`、`/send-slack-message`

### 场景 2:仅 Claude 可调用(背景知识)

设置 `user-invocable: false` 以从 `/` 菜单中隐藏:

```markdown
---
name: legacy-system-context
description: Explains how the legacy system works
user-invocable: false
---
```

**适用场景**: 不能作为命令操作的背景知识

### 调用和上下文加载总结

| 前置元数据 | 你可以调用 | Claude 可以调用 | 何时加载到上下文 |
|-----------|----------|---------------|---------------|
| (默认) | ✅ | ✅ | 描述始终在上下文中,调用时加载完整技能 |
| `disable-model-invocation: true` | ✅ | ❌ | 描述不在上下文中,你调用时加载完整技能 |
| `user-invocable: false` | ❌ | ✅ | 描述始终在上下文中,调用时加载完整技能 |

## 添加支持文件

Skills 可以在其目录中包含多个文件,让 `SKILL.md` 保持简洁。

```
code-review-skill/
├── SKILL.md              # 概述和导航
├── checklist.md          # 详细检查清单
├── examples/
│   ├── good-example.md   # 好的代码示例
│   └── bad-example.md    # 不好的代码示例
└── scripts/
    └── lint-check.sh     # 自动化脚本
```

**在 SKILL.md 中引用**:

```markdown
## Review Process
Follow the steps in [checklist.md](checklist.md)

## Examples
- Good practices: [good-example.md](examples/good-example.md)
- Anti-patterns: [bad-example.md](examples/bad-example.md)

## Automated Checks
Run [lint-check.sh](scripts/lint-check.sh) first
```

**最佳实践**: 保持 `SKILL.md` 在 500 行以下,将详细的参考材料移到单独的文件。

## 将参数传递给 Skills

你和 Claude 都可以在调用技能时传递参数。

**示例:修复 Issue**

```markdown
---
name: fix-issue
description: Fix a GitHub issue
disable-model-invocation: true
argument-hint: [issue-number]
---

Fix GitHub issue $ARGUMENTS following our coding standards.

1. Read the issue description from GitHub
2. Understand the requirements
3. Implement the fix
4. Write tests
5. Create a commit with message "fix: #$ARGUMENTS"
```

**使用方式**:
```bash
/fix-issue 123
# Claude 收到: "Fix GitHub issue 123 following our coding standards..."
```

**注意**: 如果使用参数调用技能但技能不包含 `$ARGUMENTS`,Claude Code 会自动将 `ARGUMENTS: <your input>` 追加到技能内容末尾。

## 限制工具访问

使用 `allowed-tools` 字段来限制技能处于活动状态时 Claude 可以使用哪些工具。

**示例:只读模式**

```markdown
---
name: safe-reader
description: Read files without making changes
allowed-tools: Read, Grep, Glob, LS
---

Analyze the codebase without making any modifications.
Only read and report findings.
```

**可用工具**: `Read`, `Write`, `StrReplace`, `Delete`, `Shell`, `Grep`, `Glob`, `LS` 等

## 高级功能

### 注入动态上下文

使用 `!` 语法在技能内容发送给 Claude 之前运行 shell 命令:

```markdown
---
name: pr-summary
description: Summarize changes in a pull request
context: fork
agent: Explore
allowed-tools: Shell(gh:*)
---

## Pull request context
- PR diff:
  !`gh pr diff`

- PR comments:
  !`gh pr view --comments`

- Changed files:
  !`gh pr diff --name-only`

## Your task
Summarize this pull request with:
1. Main changes
2. Potential issues
3. Review recommendations
```

**工作原理**:
1. 每个 `!`command`" 立即执行(在 Claude 看到任何内容之前)
2. 输出替换技能内容中的占位符
3. Claude 接收具有实际数据的完全呈现的提示

### 在子代理中运行 Skills

添加 `context: fork` 让技能在隔离的子代理中运行:

```markdown
---
name: deep-research
description: Research a topic thoroughly
context: fork
agent: Explore
---

Research $ARGUMENTS thoroughly:

1. Find relevant files using Glob and Grep
2. Read and analyze the code
3. Summarize findings with specific file references
4. Identify patterns and best practices
5. Highlight potential improvements
```

**适用场景**:
- 深度代码库探索
- 复杂分析任务
- 需要隔离环境的操作

**注意**: `context: fork` 仅对具有明确说明的技能有意义。

### 启用扩展思考(Thinking Mode)

在技能内容中的任何地方包含单词 `ultrathink` 以启用扩展思考:

```markdown
---
name: complex-refactor
description: Perform complex refactoring with deep analysis
---

ultrathink

Analyze the codebase architecture and propose refactoring:
1. Identify design patterns
2. Analyze dependencies
3. Propose improvements
4. Consider trade-offs
```

## 实战案例

### 案例 1:代码审查 Skill

```markdown
---
name: code-review
description: Comprehensive code review following team standards
allowed-tools: Read, Grep, Shell(git:*)
---

# Code Review Process

## 1. Code Quality
- [ ] Follows coding standards
- [ ] Proper naming conventions
- [ ] No code duplication
- [ ] Adequate comments

## 2. Functionality
- [ ] Meets requirements
- [ ] Handles edge cases
- [ ] Proper error handling

## 3. Testing
- [ ] Has unit tests
- [ ] Test coverage >= 80%
- [ ] Tests are meaningful

## 4. Security
- [ ] No SQL injection risks
- [ ] Proper authentication/authorization
- [ ] No hardcoded secrets

## 5. Performance
- [ ] No N+1 queries
- [ ] Efficient algorithms
- [ ] Proper indexing

## Output Format
Provide:
1. Summary
2. Issues found (with severity)
3. Suggestions for improvement
4. Approval recommendation
```

### 案例 2:文档生成 Skill

```markdown
---
name: gen-docs
description: Generate comprehensive API documentation
allowed-tools: Read, Write, Grep
---

# API Documentation Generator

For $ARGUMENTS, generate:

## 1. Overview
- Purpose and functionality
- Key features
- Dependencies

## 2. API Reference
For each endpoint:
- **Method & Path**: `GET /api/v1/users`
- **Description**: What it does
- **Parameters**: Type, required, description
- **Request Body**: Schema and example
- **Response**: Schema and example
- **Error Codes**: Possible errors

## 3. Examples
- cURL example
- JavaScript/TypeScript example
- Response example

## 4. Authentication
- Required auth method
- Example auth headers

Save as: `docs/api/${API_NAME}.md`
```

### 案例 3:测试生成 Skill

```markdown
---
name: gen-tests
description: Generate comprehensive test suite
allowed-tools: Read, Write, Shell(npm:*)
---

# Test Generator

For $ARGUMENTS, generate:

## 1. Unit Tests
- Happy path scenarios
- Edge cases
- Error scenarios
- Mock external dependencies

## 2. Test Structure
```javascript
describe('ModuleName', () => {
  describe('methodName', () => {
    it('should handle normal case', () => {
      // Test implementation
    });
    
    it('should handle edge case', () => {
      // Test implementation
    });
    
    it('should throw error on invalid input', () => {
      // Test implementation
    });
  });
});
```

## 3. Test Coverage
- Aim for >= 80% coverage
- Cover all public methods
- Test error paths

## 4. Run Tests
After generation, run:
```bash
npm run test
```
```

### 案例 4:数据库迁移 Skill

```markdown
---
name: create-migration
description: Create database migration files
allowed-tools: Write, Shell(npx:*)
argument-hint: [migration-name]
---

# Database Migration Generator

Create migration for: $ARGUMENTS

## 1. Analyze Requirements
- Identify table changes
- Define columns and types
- Consider indexes and constraints

## 2. Generate Up Migration
```sql
-- Up Migration
CREATE TABLE IF NOT EXISTS table_name (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_table_field ON table_name(field);
```

## 3. Generate Down Migration
```sql
-- Down Migration
DROP INDEX IF EXISTS idx_table_field;
DROP TABLE IF EXISTS table_name;
```

## 4. Save Files
- `migrations/YYYYMMDDHHMMSS_${MIGRATION_NAME}_up.sql`
- `migrations/YYYYMMDDHHMMSS_${MIGRATION_NAME}_down.sql`

## 5. Verification
- Review SQL syntax
- Check for potential data loss
- Ensure rollback works
```

## 限制 Claude 的 Skill 访问

默认情况下,Claude 可以调用任何没有设置 `disable-model-invocation: true` 的技能。

### 方法 1:通过权限系统禁用所有技能

在 `/permissions` 中拒绝 Skill 工具:

```
# Add to deny rules:
Skill
```

### 方法 2:允许或拒绝特定技能

```
# Allow only specific skills
Skill(commit)
Skill(review-pr:*)

# Deny specific skills
Skill(deploy:*)
```

**权限语法**:
- `Skill(name)` - 精确匹配
- `Skill(name:*)` - 带有任何参数的前缀匹配

### 方法 3:隐藏单个技能

在前置元数据中添加 `disable-model-invocation: true`。

**注意**: `user-invocable` 字段仅控制菜单可见性,不控制 Skill 工具访问。

## 共享 Skills

### 项目 Skills
将 `.claude/skills/` 提交到版本控制:
```bash
git add .claude/skills/
git commit -m "Add project skills"
```

### 插件形式分发
在你的插件中创建 `skills/` 目录:
```
my-plugin/
├── package.json
└── skills/
    ├── skill-1/
    │   └── SKILL.md
    └── skill-2/
        └── SKILL.md
```

### 企业级托管
通过托管设置部署组织范围内的 Skills。

## 生成视觉输出

Skills 可以捆绑并运行脚本,生成交互式可视化输出。

**示例:代码库可视化工具**

```markdown
---
name: codebase-visualizer
description: Generate an interactive collapsible tree visualization of your codebase
allowed-tools: Shell(python:*)
---

# Codebase Visualizer

Generate an interactive HTML tree view that shows your project's file structure.

## Usage
Run the visualization script from your project root:
```bash
python ~/.claude/skills/codebase-visualizer/scripts/visualize.py .
```

This creates `codebase-map.html` and opens it in your browser.

## Features
- **Collapsible directories**: Click folders to expand/collapse
- **File sizes**: Displayed next to each file
- **Colors**: Different colors for file types
- **Directory totals**: Shows aggregate size of each folder
```

配套的 `scripts/visualize.py` 可以生成自包含的 HTML 可视化。

## 故障排除

### Skills 未触发

**检查**:
1. 描述是否包含用户会自然说的关键字
2. 使用 `claude .` 进入交互模式,输入 `list skills` 查看是否列出
3. 尝试直接调用: `/skill-name`
4. 检查是否设置了 `disable-model-invocation: true`

### Skills 触发过于频繁

**解决方案**:
1. 使描述更具体,更精确
2. 如果只想手动调用,添加 `disable-model-invocation: true`

### Claude 看不到我的所有 Skills

**原因**: Skills 描述可能超过字符预算(默认15,000字符)

**解决方案**:
1. 运行 `/context` 检查警告
2. 设置环境变量增加限制:
   ```bash
   export SLASH_COMMAND_TOOL_CHAR_BUDGET=30000
   ```

## 最佳实践

### 1. 清晰的描述
描述应该明确说明何时使用该 Skill:
```markdown
description: Use when user asks to deploy to production, requests deployment, or says "ship it"
```

### 2. 分步指令
将复杂任务分解为明确的步骤:
```markdown
1. First, do X
2. Then, do Y
3. Finally, verify Z
```

### 3. 包含示例
在 Skills 中包含示例输出或代码:
````markdown
## Example Output
```json
{
  "status": "success",
  "message": "Deployment completed"
}
```
````

### 4. 使用支持文件
大型参考文档不需要在每次调用时加载:
```markdown
For complete API details, see [reference.md](reference.md)
```

### 5. 限制工具访问
只授予必要的工具权限:
```markdown
allowed-tools: Read, Grep, Glob
```

### 6. 测试你的 Skills
创建后立即测试:
```bash
# 测试自动调用
claude . "trigger condition from description"

# 测试手动调用
/skill-name test-argument
```

### 7. 保持简洁
- `SKILL.md` 少于 500 行
- 专注于核心指令
- 将详细内容移到支持文件

### 8. 版本控制
将项目 Skills 纳入版本控制:
```bash
git add .claude/skills/
git commit -m "feat: add code-review skill"
```

## 下一步

**相关资源**:
- [子代理指南](05-subagents.md) - 将任务委派给专门的代理
- [自定义命令和 Hook](17-custom-commands.md) - 围绕工具事件自动化工作流
- [规则文件系统](06-rules-file.md) - 管理 CLAUDE.md 文件以获得持久上下文
- [权限管理](16-permissions.md) - 控制工具和技能访问

---

**时间提示**: 本章阅读 20 分钟,实践 30 分钟 ⏱️
**难度**: ⭐⭐
