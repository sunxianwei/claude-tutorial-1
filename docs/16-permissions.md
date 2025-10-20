# 16 - 权限管理：安全与便捷的平衡

## 什么是权限管理？

Claude Code 默认会在执行敏感操作前请求你的确认，这是为了保护你的代码和数据安全。但在某些情况下，你可能需要更灵活的权限控制。

## 权限系统概述

```
┌─────────────────────────────────────────┐
│         Claude Code 权限系统             │
├─────────────────────────────────────────┤
│                                          │
│  ┌────────────┐      ┌────────────┐     │
│  │  默认模式  │      │  跳过模式  │     │
│  │ (安全)     │      │ (便捷)     │     │
│  └────────────┘      └────────────┘     │
│       │                    │             │
│       ▼                    ▼             │
│  需要确认操作          自动执行所有操作   │
│  - 文件删除           ⚠️ 风险较高        │
│  - Git 提交                              │
│  - 系统命令                              │
│  - 敏感数据                              │
│                                          │
└─────────────────────────────────────────┘
```

## 权限分类

### 1. 文件系统权限

**需要确认的操作：**
- ❗ 删除文件
- ❗ 批量修改文件
- ❗ 覆盖重要文件
- ⚠️ 移动文件
- ⚠️ 修改配置文件

**自动允许的操作：**
- ✅ 读取文件
- ✅ 创建新文件
- ✅ 编辑现有文件（在允许列表内）

### 2. Git 操作权限

**需要确认的操作：**
- ❗ git push（推送到远程）
- ❗ git reset --hard（强制重置）
- ❗ git branch -D（强制删除分支）
- ⚠️ git commit（提交更改）
- ⚠️ git merge（合并分支）

**自动允许的操作：**
- ✅ git status
- ✅ git diff
- ✅ git log
- ✅ git add

### 3. 系统命令权限

**需要确认的操作：**
- ❗ rm -rf（删除目录）
- ❗ sudo 命令（超级用户权限）
- ❗ chmod/chown（权限修改）
- ⚠️ npm install -g（全局安装）
- ⚠️ 网络请求

**自动允许的操作：**
- ✅ npm install（本地安装）
- ✅ npm test
- ✅ npm run build

### 4. 数据库操作权限

**需要确认的操作：**
- ❗ DROP TABLE（删除表）
- ❗ TRUNCATE（清空表）
- ❗ DELETE FROM（批量删除）
- ⚠️ UPDATE（更新数据）
- ⚠️ ALTER TABLE（修改结构）

## 查看和管理权限

### 使用 /permissions 命令

在交互模式中，使用 `/permissions` 命令查看和管理权限设置：

```bash
$ claude code .

> /permissions
```

**输出示例：**

```
📋 当前权限设置：

文件操作权限：
  ✅ 读取：已允许
  ✅ 创建：已允许
  ✅ 编辑：已允许
  ⚠️ 删除：需要确认
  ⚠️ 移动：需要确认

Git 操作权限：
  ✅ 查看：已允许
  ✅ 暂存：已允许
  ⚠️ 提交：需要确认
  ❌ 推送：需要确认
  ❌ 强制操作：需要确认

系统命令权限：
  ✅ 读取命令：已允许
  ⚠️ 安装依赖：需要确认
  ❌ 删除操作：需要确认
  ❌ 超级用户：需要确认

数据库权限：
  ✅ 查询：已允许
  ⚠️ 更新：需要确认
  ❌ 删除：需要确认
  ❌ 结构变更：需要确认
```

### 修改权限设置

```bash
# 查看权限
> /permissions

# 允许特定操作
> /permissions allow git.commit

# 拒绝特定操作
> /permissions deny file.delete

# 恢复默认设置
> /permissions reset

# 查看权限历史
> /permissions history
```

## 跳过权限确认

### ⚠️ 使用 --dangerously-skip-permissions

**用途：** 自动批准所有操作，不再请求确认

```bash
# 跳过所有权限确认
claude code --dangerously-skip-permissions .

# 或使用简写
claude code --skip-permissions .
```

**⚠️ 警告：**
- 🚨 极度危险，仅用于受信任的环境
- 🚨 可能导致数据丢失
- 🚨 可能执行意外的破坏性操作
- 🚨 不推荐在生产环境使用

### 安全使用场景

**适合使用的场景：**

```bash
# 1. CI/CD 自动化流程
# .github/workflows/claude-ci.yml
- name: Run Claude Code
  run: claude code --dangerously-skip-permissions -p "运行测试并修复失败的用例"

# 2. Docker 容器中的一次性任务
docker run --rm my-app claude code --dangerously-skip-permissions .

# 3. 测试环境的批量操作
claude code --dangerously-skip-permissions -p "重构所有组件并更新测试"

# 4. 可重现的沙盒环境
sandbox-run "claude code --dangerously-skip-permissions ."
```

**不适合使用的场景：**

```bash
# ❌ 生产环境
claude code --dangerously-skip-permissions . # 危险！

# ❌ 包含重要数据的项目
cd ~/important-project
claude code --dangerously-skip-permissions . # 危险！

# ❌ 多人协作的项目
cd ~/team-project
claude code --dangerously-skip-permissions . # 可能影响他人！
```

## 配置文件权限管理

### .claude/config.json

你可以在项目配置文件中预设权限规则：

```json
{
  "permissions": {
    "files": {
      "allowRead": true,
      "allowWrite": true,
      "allowDelete": false,
      "confirmBeforeDelete": true
    },
    "git": {
      "allowCommit": true,
      "allowPush": false,
      "confirmBeforePush": true
    },
    "system": {
      "allowBashCommands": true,
      "allowSudo": false,
      "confirmDestructive": true
    },
    "database": {
      "allowQuery": true,
      "allowUpdate": true,
      "allowDelete": false,
      "confirmBeforeModify": true
    }
  }
}
```

### 白名单和黑名单

#### 文件白名单

```json
{
  "permissions": {
    "files": {
      "allowList": [
        "src/**/*.ts",
        "src/**/*.vue",
        "tests/**/*.test.ts",
        "docs/**/*.md"
      ],
      "denyList": [
        ".env",
        "credentials.json",
        "node_modules/**",
        "dist/**"
      ]
    }
  }
}
```

#### 命令白名单

```json
{
  "permissions": {
    "system": {
      "allowedCommands": [
        "npm install",
        "npm test",
        "npm run build",
        "git status",
        "git add",
        "git commit"
      ],
      "deniedCommands": [
        "rm -rf",
        "sudo *",
        "git push --force"
      ]
    }
  }
}
```

## 权限审计

### 启用审计日志

```json
{
  "permissions": {
    "audit": {
      "enabled": true,
      "logFile": ".claude/audit.log",
      "logLevel": "info",
      "includeContent": false
    }
  }
}
```

### 查看审计日志

```bash
# 查看最近的权限请求
> /permissions audit

# 查看完整审计日志
cat .claude/audit.log

# 筛选特定类型的操作
grep "DELETE" .claude/audit.log
```

**审计日志示例：**

```
2025-10-20 14:30:15 [INFO] Permission requested: file.delete src/old-component.vue
2025-10-20 14:30:18 [INFO] Permission granted: file.delete src/old-component.vue
2025-10-20 14:31:02 [INFO] Permission requested: git.commit
2025-10-20 14:31:05 [INFO] Permission granted: git.commit
2025-10-20 14:32:10 [WARN] Permission requested: git.push
2025-10-20 14:32:15 [WARN] Permission denied: git.push (manual review required)
```

## 权限场景最佳实践

### 场景 1：个人学习项目

**推荐配置：** 宽松模式

```json
{
  "permissions": {
    "files": { "allowAll": true },
    "git": { "allowCommit": true, "confirmBeforePush": true },
    "system": { "allowBashCommands": true }
  }
}
```

### 场景 2：企业生产项目

**推荐配置：** 严格模式

```json
{
  "permissions": {
    "files": {
      "allowRead": true,
      "allowWrite": true,
      "confirmBeforeDelete": true
    },
    "git": {
      "allowCommit": false,
      "allowPush": false,
      "confirmBeforeAll": true
    },
    "system": {
      "allowBashCommands": true,
      "denyDestructive": true
    },
    "audit": {
      "enabled": true,
      "logAll": true
    }
  }
}
```

### 场景 3：CI/CD 自动化

**推荐配置：** 自动化模式

```bash
# 使用环境变量控制
export CLAUDE_SKIP_PERMISSIONS=true
export CLAUDE_AUDIT_ENABLED=true

# 在 CI 脚本中使用
claude code --dangerously-skip-permissions -p "执行测试并生成报告"
```

### 场景 4：多人协作项目

**推荐配置：** 团队模式

```json
{
  "permissions": {
    "files": {
      "allowWrite": true,
      "confirmBeforeDelete": true,
      "protectedPaths": [
        "CLAUDE.md",
        ".claude/**",
        "package.json"
      ]
    },
    "git": {
      "allowCommit": true,
      "confirmBeforePush": true,
      "protectedBranches": ["main", "master", "production"]
    }
  }
}
```

## 常见问题

### Q1: 权限请求太频繁，如何减少？

**方案 1：** 配置允许列表

```json
{
  "permissions": {
    "files": {
      "autoAllowPatterns": ["src/**/*.ts", "tests/**/*.test.ts"]
    }
  }
}
```

**方案 2：** 使用会话权限

```bash
> /permissions session allow file.write
# 当前会话内自动允许文件写入
```

### Q2: 如何临时提升权限？

```bash
# 方式 1：使用命令参数
claude code --elevated-permissions .

# 方式 2：在交互模式中
> /permissions elevate
输入管理员密码: ********
[权限已临时提升 15 分钟]
```

### Q3: 如何恢复被拒绝的操作？

```bash
# 查看被拒绝的操作历史
> /permissions denied

# 重试特定操作
> /permissions retry <operation-id>
```

### Q4: 如何为团队设置统一的权限策略？

创建团队级配置文件 `.claude/team-permissions.json`：

```json
{
  "version": "1.0",
  "team": "development-team",
  "permissions": {
    // 团队统一配置
  }
}
```

提交到 Git，团队成员自动继承。

## 安全建议

### ✅ 推荐做法

1. **保持默认权限设置** - 仅在必要时修改
2. **启用审计日志** - 追踪所有权限操作
3. **定期审查** - 检查 `.claude/audit.log`
4. **使用白名单** - 明确允许的操作范围
5. **团队共识** - 统一权限配置

### ❌ 避免做法

1. **不要在生产环境使用 `--dangerously-skip-permissions`**
2. **不要禁用所有权限检查**
3. **不要在不信任的环境中降低权限**
4. **不要忽略权限警告**
5. **不要共享权限配置给外部**

## 下一章

👉 **[第 17 章：自定义命令和 Hook](17-custom-commands.md)** - 扩展 Claude Code 的功能

---

**时间提示：** 本章阅读 10 分钟，配置 5 分钟 ⏱️
**难度：** ⭐⭐
