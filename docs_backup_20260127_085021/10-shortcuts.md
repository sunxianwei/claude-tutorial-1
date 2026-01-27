# 10 - 快捷键速查：高效操作

## Claude Code CLI 快捷命令

### 基础命令

```bash
# 查看帮助
claude-code --help

# 查看版本
claude-code --version

# 显示已加载的规则
claude-code --show-rules

# 显示已加载的 MCP 服务
claude-code --mcp-list

# 调试模式
claude-code --debug . "command"

# 干运行（不实际执行）
claude-code --dry-run . "command"
```

### 初始化和配置

```bash
# 初始化新项目
claude-code init

# 从模板初始化
claude-code init --template react-typescript

# 指定 MCP 预设
claude-code init --mcp-preset=java+postgres

# 生成规则模板
claude-code generate-template --type=rules
```

### 文件和代码操作

```bash
# 读取文件（显式）
claude-code read "src/index.ts"

# 查找文件
claude-code find --pattern="*.vue" --path="src/"

# 搜索代码
claude-code search "TODO" --type="typescript"

# 查看项目结构
claude-code tree --depth=2
```

### Git 操作

```bash
# 显示 git 状态
claude-code git status

# 显示最近提交
claude-code git log --oneline -10

# 显示 diff
claude-code git diff

# 自动提交（带 AI 生成的提交信息）
claude-code commit --auto
```

### 模型和参数

```bash
# 指定模型
claude-code --model="claude-opus-4-1-20250805" . "command"

# 指定温度
claude-code --temperature=0.5 . "command"

# 指定最大 tokens
claude-code --max-tokens=8000 . "command"

# 指定上下文窗口大小
claude-code --context-window=large . "command"
```

### SubAgent 相关

```bash
# 列出所有可用的 SubAgent
claude-code --list-agents

# 使用特定 SubAgent
claude-code --subagent=codegen . "command"

# 链式执行多个 agent
claude-code --subagent=codegen --chain="test,security,doc" . "command"

# 显示 SubAgent 详情
claude-code --agent-info=codegen
```

### MCP 相关

```bash
# 检查 MCP 连接
claude-code --mcp-check

# 显示 MCP 详情
claude-code --mcp-info

# 测试特定 MCP 服务
claude-code --test-mcp=postgres

# 重新加载 MCP 配置
claude-code --reload-mcp
```

## 常用工作流快速命令

### 新功能开发（完整流程）

```bash
#!/bin/bash
# dev-feature.sh

FEATURE=$1

# 1. 代码生成
claude-code --subagent=codegen . "实现 $FEATURE"

# 2. 生成测试
claude-code --subagent=testing . "为上面的代码生成单元测试"

# 3. 安全审查
claude-code --subagent=security . "审查安全性"

# 4. 代码审查
claude-code --subagent=review . "完整代码审查"

# 5. 生成文档
claude-code --subagent=documentation . "生成 API 文档"

# 6. 提交
claude-code commit --auto
```

使用：

```bash
chmod +x dev-feature.sh
./dev-feature.sh "用户认证功能"
```

### Bug 修复工作流

```bash
#!/bin/bash
# fix-bug.sh

BUG_DESC=$1

# 1. 定位 bug
claude-code search "$BUG_DESC"

# 2. 分析代码
claude-code read "path/to/buggy/file.ts"

# 3. 修复
claude-code --subagent=refactor . "修复: $BUG_DESC"

# 4. 生成测试
claude-code --subagent=testing . "为 bug 修复生成回归测试"

# 5. 验证
echo "运行所有测试..."
npm test

# 6. 提交
claude-code commit --auto
```

### 性能优化工作流

```bash
#!/bin/bash
# optimize.sh

# 1. 分析性能
claude-code --subagent=refactor . "分析性能瓶颈"

# 2. 优化
claude-code --subagent=refactor . "优化性能"

# 3. 测试
npm run test:performance

# 4. 对比
claude-code . "对比优化前后的性能数据"

# 5. 提交
claude-code commit --auto
```

### 代码审查工作流

```bash
#!/bin/bash
# code-review.sh

BRANCH=$1

# 1. 获取 diff
claude-code git diff main..$BRANCH

# 2. 执行完整审查
claude-code --subagent=review . "审查 $BRANCH 分支的所有变更"

# 3. 检查测试
npm test

# 4. 检查 coverage
npm run test:coverage

# 5. 生成审查报告
claude-code . "生成详细的代码审查报告"
```

### 项目迁移工作流

```bash
#!/bin/bash
# migrate-project.sh

OLD_TECH=$1
NEW_TECH=$2

# 1. 分析当前项目
claude-code . "分析项目中 $OLD_TECH 的使用情况"

# 2. 生成迁移计划
claude-code . "生成从 $OLD_TECH 迁移到 $NEW_TECH 的详细计划"

# 3. 分步实施
claude-code --subagent=refactor . "执行迁移计划的第一步"

# 4. 测试验证
npm test

# 5. 重复第 3-4 步，直到完成
```

## IDE 集成快捷键（VS Code）

| 快捷键 | 功能 |
|-------|------|
| `Cmd+K Cmd+G` (Mac) / `Ctrl+K Ctrl+G` | 打开 Claude Code |
| `Cmd+L` / `Ctrl+L` | 清空输入框 |
| `Cmd+↑` / `Ctrl+↑` | 上一条命令 |
| `Cmd+↓` / `Ctrl+↓` | 下一条命令 |
| `Cmd+Enter` / `Ctrl+Enter` | 发送命令 |

## 自定义快捷命令

在 `.claude/shortcuts.json` 中定义：

```json
{
  "commands": {
    "dev": "npm run dev",
    "test": "npm test && npm run coverage",
    "build": "npm run clean && npm run build",
    "deploy": "npm run build && npm run deploy:prod",
    "pr": "git push origin HEAD && gh pr create",
    "feature": "./scripts/dev-feature.sh",
    "hotfix": "./scripts/fix-bug.sh"
  }
}
```

使用：

```bash
claude-code . --run-shortcut=dev
claude-code . --run-shortcut=test
claude-code . --run-shortcut=deploy
```

## 高级技巧

### 1. 管道组合

```bash
# 搜索 → 分析 → 优化 → 测试
claude-code search "N+1 query" \
  && claude-code --subagent=refactor . "优化查询" \
  && npm test
```

### 2. 条件执行

```bash
# 如果测试通过，则提交
npm test && claude-code commit --auto
```

### 3. 并行执行

```bash
# 同时运行多个 agent
claude-code --subagent=codegen . "task1" &
claude-code --subagent=testing . "task2" &
wait
```

### 4. 环境变量控制

```bash
# 使用不同的 MCP 配置
MCP_PRESET=development claude-code . "command"
MCP_PRESET=production claude-code . "command"
```

---

**时间提示：** 本章作为快速参考，不需要精读 ⏱️
