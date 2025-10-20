# 17 - 自定义命令和 Hook：打造专属工作流

## 什么是自定义命令？

自定义命令允许你创建项目特定的快捷指令，让 Claude Code 执行预定义的任务。这类似于 Git 的别名功能，但功能更强大。

## 自定义命令基础

### 目录结构

```
your-project/
├── .claude/
│   ├── commands/           # ← 自定义命令目录
│   │   ├── review.md      # 代码审查命令
│   │   ├── test.md        # 测试命令
│   │   ├── deploy.md      # 部署命令
│   │   └── docs.md        # 文档生成命令
│   └── config.json
├── CLAUDE.md
└── src/
```

### 创建第一个命令

**步骤 1：** 创建命令目录

```bash
mkdir -p .claude/commands
```

**步骤 2：** 创建命令文件 `.claude/commands/review.md`

```markdown
# 代码审查命令

请执行完整的代码审查，重点关注：

1. **代码规范**
   - 检查命名规范
   - 检查代码风格
   - 检查注释完整性

2. **安全性**
   - SQL 注入风险
   - XSS 漏洞
   - 权限验证

3. **性能**
   - N+1 查询
   - 不必要的计算
   - 内存泄漏

4. **最佳实践**
   - 设计模式应用
   - 错误处理
   - 日志记录

生成详细的审查报告，包括问题清单和改进建议。
```

**步骤 3：** 使用命令

```bash
$ claude code .

> /review
[Claude 自动执行代码审查...]
```

## 命令参数传递

### 使用 $ARGUMENTS 变量

自定义命令支持动态参数，通过 `$ARGUMENTS` 变量传递。

**示例：创建 `.claude/commands/test.md`**

```markdown
# 运行测试命令

## 任务描述
为以下文件或模块运行测试：

**目标：** $ARGUMENTS

## 执行步骤

1. 识别相关的测试文件
2. 运行单元测试
3. 检查测试覆盖率
4. 如果有失败的测试，分析原因并修复
5. 生成测试报告

## 要求

- 测试必须全部通过
- 覆盖率不低于 80%
- 修复所有失败的断言
- 添加缺失的测试用例
```

**使用方式：**

```bash
# 传递单个参数
> /test UserService

# 传递多个参数（用引号包裹）
> /test "UserService LoginController"

# 传递路径参数
> /test src/modules/user/**
```

### 多参数支持

对于更复杂的参数需求，可以使用 `$ARG1`, `$ARG2`, `$ARG3` 等：

**创建 `.claude/commands/deploy.md`**

```markdown
# 部署命令

## 部署配置

- **环境：** $ARG1
- **版本：** $ARG2
- **分支：** $ARG3

## 执行步骤

1. 验证环境配置
   - 检查环境：$ARG1
   - 确认版本：$ARG2
   - 验证分支：$ARG3

2. 构建项目
   - 运行构建命令
   - 检查构建产物

3. 部署前检查
   - 运行所有测试
   - 检查环境变量
   - 验证数据库连接

4. 执行部署
   - 上传构建产物
   - 重启服务
   - 健康检查

5. 部署后验证
   - 检查服务状态
   - 验证关键功能
   - 监控错误日志

## 回滚计划

如果部署失败，自动回滚到上一个稳定版本。
```

**使用方式：**

```bash
> /deploy production v1.2.0 main
```

## 常用命令示例

### 1. 功能开发命令

**文件：** `.claude/commands/feature.md`

```markdown
# 新功能开发

## 功能描述
$ARGUMENTS

## 开发流程

### 1. 需求分析
- 分析功能需求
- 确定技术方案
- 设计 API 接口

### 2. 代码实现
- 创建必要的文件
- 实现业务逻辑
- 遵循项目规范（参考 CLAUDE.md）

### 3. 测试编写
- 编写单元测试
- 编写集成测试
- 确保覆盖率 >= 80%

### 4. 文档更新
- 更新 API 文档
- 添加代码注释
- 更新 CHANGELOG

### 5. 代码审查
- 自我审查代码
- 检查安全性
- 优化性能

### 6. 提交代码
- 生成规范的 commit 信息
- 创建 Pull Request
```

**使用：**

```bash
> /feature 添加用户头像上传功能
```

### 2. Bug 修复命令

**文件：** `.claude/commands/fix.md`

```markdown
# Bug 修复

## Bug 描述
$ARGUMENTS

## 修复流程

### 1. 问题定位
- 重现 bug
- 分析错误日志
- 定位问题代码

### 2. 根因分析
- 分析问题原因
- 检查相关代码
- 确定修复方案

### 3. 代码修复
- 修改问题代码
- 确保不引入新问题
- 遵循最小改动原则

### 4. 测试验证
- 编写测试用例
- 验证修复效果
- 回归测试

### 5. 文档记录
- 更新 CHANGELOG
- 添加修复说明
- 记录技术债务（如需要）
```

**使用：**

```bash
> /fix 登录页面在移动端显示异常
```

### 3. 重构命令

**文件：** `.claude/commands/refactor.md`

```markdown
# 代码重构

## 重构目标
$ARGUMENTS

## 重构原则

遵循以下原则：
- SOLID 原则
- DRY（不重复）
- KISS（保持简单）
- YAGNI（避免过度设计）

## 重构步骤

### 1. 分析现状
- 识别代码坏味道
- 评估重构风险
- 制定重构计划

### 2. 编写测试
- 为现有代码补充测试
- 确保测试覆盖关键路径
- 建立重构安全网

### 3. 小步重构
- 逐步进行小的改进
- 每次改动后运行测试
- 保持代码始终可运行

### 4. 验证优化
- 运行所有测试
- 检查性能影响
- 验证功能正确性

### 5. 清理代码
- 删除无用代码
- 更新注释和文档
- 统一代码风格
```

**使用：**

```bash
> /refactor UserService 中的重复代码
```

### 4. 文档生成命令

**文件：** `.claude/commands/docs.md`

```markdown
# 生成文档

## 文档类型
$ARGUMENTS

## 生成规则

### API 文档
- 使用 OpenAPI/Swagger 格式
- 包含请求/响应示例
- 说明错误码

### 代码注释
- JSDoc/JavaDoc 格式
- 描述参数和返回值
- 包含使用示例

### README 更新
- 项目概述
- 安装步骤
- 使用说明
- API 参考

### CHANGELOG
- 遵循 Keep a Changelog 格式
- 分类：Added, Changed, Fixed, Removed
- 包含版本号和日期
```

**使用：**

```bash
> /docs API
> /docs README
> /docs 代码注释
```

## Hook 机制

### 什么是 Hook？

Hook 是在特定事件触发时自动执行的脚本，类似于 Git Hooks。

### Hook 类型

```
┌─────────────────────────────────────────┐
│           Claude Code Hooks              │
├─────────────────────────────────────────┤
│                                          │
│  触发时机              Hook 文件          │
│  ────────────────────────────────       │
│  会话开始前            pre-session       │
│  会话结束后            post-session      │
│  文件读取前            pre-read          │
│  文件写入后            post-write        │
│  命令执行前            pre-command       │
│  命令执行后            post-command      │
│  错误发生时            on-error          │
│                                          │
└─────────────────────────────────────────┘
```

### Hook 目录结构

```
.claude/
├── hooks/
│   ├── pre-session.sh         # 会话开始前
│   ├── post-session.sh        # 会话结束后
│   ├── pre-commit.sh          # 提交前（Git）
│   ├── post-write.sh          # 写入文件后
│   └── on-error.sh            # 错误处理
└── commands/
```

### 创建 Hook

#### 示例 1：pre-session Hook

**文件：** `.claude/hooks/pre-session.sh`

```bash
#!/bin/bash
# 会话开始前的 Hook

echo "🚀 正在初始化 Claude Code 会话..."

# 检查环境
if [ ! -f "package.json" ]; then
  echo "⚠️ 警告：未找到 package.json"
fi

# 检查依赖
if [ -d "node_modules" ]; then
  echo "✅ 依赖已安装"
else
  echo "⚠️ 警告：node_modules 不存在，是否需要运行 npm install?"
fi

# 检查 Git 状态
if [ -d ".git" ]; then
  BRANCH=$(git branch --show-current)
  echo "📍 当前分支: $BRANCH"

  if [ "$BRANCH" = "main" ] || [ "$BRANCH" = "master" ]; then
    echo "⚠️ 警告：你在主分支上工作！"
  fi
fi

# 加载环境变量
if [ -f ".env" ]; then
  source .env
  echo "✅ 环境变量已加载"
fi

echo "✨ 初始化完成！"
```

#### 示例 2：post-write Hook

**文件：** `.claude/hooks/post-write.sh`

```bash
#!/bin/bash
# 文件写入后的 Hook

FILE=$1  # 被写入的文件路径

echo "📝 文件已修改: $FILE"

# 自动格式化
if [[ $FILE == *.ts ]] || [[ $FILE == *.js ]]; then
  echo "🎨 运行 Prettier 格式化..."
  npx prettier --write "$FILE"
fi

# 自动 lint
if [[ $FILE == *.ts ]]; then
  echo "🔍 运行 ESLint 检查..."
  npx eslint "$FILE" --fix
fi

# 自动测试
if [[ $FILE == *.test.ts ]]; then
  echo "🧪 运行相关测试..."
  npx vitest run "$FILE"
fi
```

#### 示例 3：pre-commit Hook

**文件：** `.claude/hooks/pre-commit.sh`

```bash
#!/bin/bash
# Git 提交前的 Hook

echo "🔍 执行提交前检查..."

# 运行 lint
echo "1️⃣ 运行 lint..."
npm run lint
if [ $? -ne 0 ]; then
  echo "❌ Lint 检查失败"
  exit 1
fi

# 运行测试
echo "2️⃣ 运行测试..."
npm test
if [ $? -ne 0 ]; then
  echo "❌ 测试失败"
  exit 1
fi

# 检查敏感信息
echo "3️⃣ 检查敏感信息..."
if git diff --cached | grep -E "API_KEY|PASSWORD|SECRET"; then
  echo "❌ 检测到敏感信息！"
  exit 1
fi

echo "✅ 所有检查通过！"
```

#### 示例 4：on-error Hook

**文件：** `.claude/hooks/on-error.sh`

```bash
#!/bin/bash
# 错误处理 Hook

ERROR_MSG=$1
ERROR_CODE=$2

echo "❌ 发生错误："
echo "   消息: $ERROR_MSG"
echo "   代码: $ERROR_CODE"

# 记录错误日志
LOG_FILE=".claude/error.log"
echo "[$(date)] ERROR $ERROR_CODE: $ERROR_MSG" >> "$LOG_FILE"

# 发送通知（可选）
# curl -X POST "$SLACK_WEBHOOK" -d "{\"text\":\"Claude Code 错误: $ERROR_MSG\"}"

# 清理临时文件
rm -f .claude/tmp/*

echo "🔧 已记录错误并执行清理"
```

### 启用 Hook

```bash
# 1. 创建 Hook 文件
touch .claude/hooks/pre-session.sh

# 2. 添加可执行权限
chmod +x .claude/hooks/pre-session.sh

# 3. 编辑 Hook 内容
vim .claude/hooks/pre-session.sh
```

### Hook 配置

在 `.claude/config.json` 中配置 Hook：

```json
{
  "hooks": {
    "enabled": true,
    "timeout": 30000,
    "pre-session": {
      "enabled": true,
      "script": ".claude/hooks/pre-session.sh"
    },
    "post-write": {
      "enabled": true,
      "script": ".claude/hooks/post-write.sh",
      "patterns": ["**/*.ts", "**/*.js"]
    },
    "pre-commit": {
      "enabled": true,
      "script": ".claude/hooks/pre-commit.sh"
    },
    "on-error": {
      "enabled": true,
      "script": ".claude/hooks/on-error.sh"
    }
  }
}
```

## 高级用法

### 命令组合

创建复合命令，执行多个步骤：

**文件：** `.claude/commands/ci.md`

```markdown
# 持续集成命令

## 执行完整的 CI 流程

### 步骤 1：代码检查
执行 `/review` 命令进行代码审查

### 步骤 2：运行测试
执行 `/test all` 运行所有测试

### 步骤 3：构建项目
```bash
npm run build
```

### 步骤 4：生成报告
- 测试覆盖率报告
- 代码质量报告
- 构建结果报告

### 步骤 5：通知团队
如果所有检查通过，生成成功消息。
如果有失败，生成详细的问题报告。
```

### 条件执行

**文件：** `.claude/commands/auto-fix.md`

```markdown
# 自动修复

## 智能修复流程

1. **运行 lint 检查**
   ```bash
   npm run lint
   ```

2. **如果有错误**
   - 自动修复可修复的问题
   - 生成不可自动修复问题的清单

3. **运行测试**
   ```bash
   npm test
   ```

4. **如果测试失败**
   - 分析失败原因
   - 尝试自动修复
   - 重新运行测试

5. **生成报告**
   - 已修复的问题清单
   - 需要人工处理的问题清单
```

## 实战案例

### 案例 1：前端项目工作流

```bash
# 创建命令
.claude/commands/
├── component.md        # 创建组件
├── page.md            # 创建页面
├── api.md             # 创建 API 调用
└── style.md           # 样式检查
```

**component.md:**

```markdown
# 创建 Vue 组件

## 组件名称
$ARGUMENTS

## 生成内容

1. 组件文件：`src/components/$ARGUMENTS.vue`
2. 测试文件：`src/components/$ARGUMENTS.test.ts`
3. 故事文件：`src/components/$ARGUMENTS.stories.ts`

## 要求

- 使用 Vue 3 Composition API
- TypeScript 类型完整
- 包含完整的 props 验证
- 响应式设计
- 测试覆盖率 >= 80%
```

### 案例 2：后端项目工作流

```bash
.claude/commands/
├── controller.md      # 创建控制器
├── service.md        # 创建服务
├── entity.md         # 创建实体
└── migration.md      # 创建数据库迁移
```

## 最佳实践

### 1. 命名规范

```bash
# 动词开头，清晰描述功能
/create-component
/fix-bug
/deploy-production

# 避免模糊命名
❌ /do-stuff
❌ /cmd1
✅ /run-tests
✅ /generate-docs
```

### 2. 文档完整

每个命令都应该包含：
- 📝 清晰的描述
- 📋 详细的步骤
- ⚙️ 必要的配置
- 💡 使用示例

### 3. 错误处理

```markdown
## 错误处理

如果执行过程中出现错误：
1. 记录错误信息
2. 尝试回滚操作
3. 提供解决建议
4. 保存当前状态
```

### 4. 参数验证

```markdown
## 参数验证

在执行前验证参数：
- $ARGUMENTS 不为空
- 参数格式正确
- 文件/目录存在
- 权限充足
```

## 下一章

👉 **[第 18 章：IDE 集成](18-ide-integration.md)** - 在编辑器中使用 Claude Code

---

**时间提示：** 本章阅读 15 分钟，实践 20 分钟 ⏱️
**难度：** ⭐⭐⭐
