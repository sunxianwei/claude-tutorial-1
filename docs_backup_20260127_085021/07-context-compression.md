# 07 - 上下文压缩：优化 Token 使用

## 为什么需要上下文压缩？

Claude Code 中一个关键的挑战是管理上下文大小。每次调用 Claude API 时，都会消耗 token：

- **输入 token**（你的上下文）：按使用量计费
- **输出 token**（Claude 的回复）：按使用量计费

### 成本对比

| 情况 | token 消耗 | 成本 |
|-----|----------|------|
| 简单任务 | 1,000 | $0.003 |
| 中等项目分析 | 10,000 | $0.03 |
| 大型项目分析 | 100,000 | $0.30 |
| 优化后的相同项目 | 30,000 | $0.09 |

**使用压缩后可节省 70% 的成本！**

## 压缩策略

### 1. 代码行数压缩

**问题：** 完整代码很长

```javascript
// 原始代码 (500 行)
class UserService {
  constructor(repository) {
    this.repository = repository;
  }

  async getUser(id) {
    const user = await this.repository.findById(id);
    if (!user) {
      throw new Error('User not found');
    }
    return user;
  }

  // ... 其他 495 行代码
}
```

**压缩方法 1：摘要式包含**

```
UserService 类:
- getUser(id): 获取用户信息
- updateUser(id, data): 更新用户
- deleteUser(id): 删除用户
- listUsers(page, limit): 分页列表

[完整代码在 src/services/UserService.ts]
```

**压缩方法 2：选择性加载**

```bash
# 只分析特定文件
claude code . "分析 src/services/UserService.ts 的性能"

# 而不是加载整个项目
claude code . "分析项目性能"
```

### 2. 依赖分析压缩

**问题：** 自动加载所有 node_modules 非常浪费

```json
{
  "contextOptimization": {
    "ignoreNodeModules": true,
    "ignoreDependencyAnalysis": true,
    "onlyAnalyzeUsedDeps": true
  }
}
```

**配置 `.claude/config.json`：**

```json
{
  "contextCompression": {
    "level": "aggressive",
    "rules": {
      "ignoreNodeModules": true,
      "ignoreBuildArtifacts": true,
      "maxFileSize": 10000,
      "maxFilesPerDirectory": 50,
      "summarizeLargeFiles": true
    }
  }
}
```

### 3. 聪明的 .claudeignore

**.claudeignore 文件：**

```
# 依赖目录
node_modules/
.venv/
venv/
env/
vendor/

# 构建产物
dist/
build/
out/
target/
*.class
*.o
*.pyc
__pycache__/
.pytest_cache/

# IDE 和编辑器
.vscode/
.idea/
*.swp
*.swo
*~

# 测试覆盖率报告
coverage/
.nyc_output/

# 日志文件
logs/
*.log

# 临时文件和缓存
tmp/
temp/
.cache/
.DS_Store
*.tmp

# 大型文件
*.tar.gz
*.zip
*.iso
*.mp4
*.mov

# Git 历史（通常不需要）
# 但如果要分析历史可以不忽略
.git/
```

### 4. 条件上下文加载

**根据任务类型加载不同的上下文：**

```bash
#!/bin/bash
# smart-claude.sh

TASK=$1

case "$TASK" in
  "frontend")
    # 只加载前端相关代码
    export CLAUDEIGNORE_EXTRA="src/backend/,src/services/api"
    ;;
  "backend")
    # 只加载后端相关代码
    export CLAUDEIGNORE_EXTRA="src/views/,src/components/"
    ;;
  "fullstack")
    # 加载所有代码
    unset CLAUDEIGNORE_EXTRA
    ;;
esac

claude code . "${@:2}"
```

**使用方式：**

```bash
./smart-claude.sh frontend "创建购物车组件"
./smart-claude.sh backend "优化数据库查询"
./smart-claude.sh fullstack "完整的功能开发"
```

### 5. 使用上下文窗口配置

**在 `.claude/config.json` 中选择合适的窗口大小：**

```json
{
  "contextWindow": "small",
  "maxTokensForContext": 8000
}
```

**窗口大小对比：**

| 大小 | token 上限 | 用途 | 成本 |
|-----|----------|------|------|
| 小 | 4,000 | 简单任务 | 最低 |
| 中 | 8,000 | 一般任务 | 中等 |
| 大 | 16,000 | 复杂任务 | 较高 |
| 超大 | 32,000 | 大型项目 | 最高 |

## 规则文件结合压缩

### 策略 1：精简的 CLAUDE.md

好的规则文件应该简洁，避免重复项目信息：

```markdown
# ✅ 精简的规则文件

## 代码风格
遵循 Airbnb JavaScript 风格指南

## 提交规范
采用 Conventional Commits 标准

详见: docs/guidelines.md
```

```markdown
# ❌ 冗长的规则文件

## 代码风格
- 使用 2 空格缩进
- 不使用 tab
- 行长不超过 80 字符
- 使用 semicolon
- 使用 single quote
- 使用 trailing comma
... (重复项目文档内容)
```

### 策略 2：分层规则

```
CLAUDE.md (项目核心规则)
├── docs/style-guide.md (详细样式指南)
├── docs/api-guide.md (API 指南)
└── docs/database-guide.md (数据库指南)
```

在 CLAUDE.md 中只保留指向详细文档的链接。

### 策略 3：动态规则加载

根据任务加载不同的规则：

```bash
# 创建规则变种
CLAUDE.md              # 基础规则（总是加载）
CLAUDE.frontend.md     # 前端规则
CLAUDE.backend.md      # 后端规则
CLAUDE.testing.md      # 测试规则
```

**加载机制：**

```bash
claude code . --rules-variant=frontend "创建组件"
claude code . --rules-variant=backend "创建 API"
```

## 高级压缩技巧

### 技巧 1：代码摘要文件

创建 `.claude/project-summary.md`：

```markdown
# 项目摘要

## 架构
- 前端: Vue 3 + TypeScript
- 后端: Spring Boot 3.x
- 数据库: PostgreSQL
- 消息队列: RabbitMQ

## 核心模块

### 用户模块
- 文件: src/backend/user/
- 关键类: UserService, UserController
- 数据库表: user_info, user_role

### 订单模块
- 文件: src/backend/order/
- 关键类: OrderService, OrderController
- 关键流程: [创建订单流程图]

## 数据库表结构
[ER 图或表结构说明]

## 关键算法
[重要业务逻辑说明]
```

使用该文件：

```bash
claude code . --context-file .claude/project-summary.md "基于项目摘要实现新功能"
```

### 技巧 2：增量分析

只分析最近变更的代码：

```bash
# 获取最近 3 天修改的文件
git diff --name-only $(git log --since="3 days ago" --pretty=format:"%H" | tail -1)

# 只分析这些文件
claude code . "分析这些最近修改的文件的影响"
```

### 技巧 3：模块化分析

```bash
# 分别分析各个模块
claude code ./src/modules/auth "优化认证模块"
claude code ./src/modules/payment "优化支付模块"
claude code ./src/modules/notification "优化通知模块"

# 总结分析结果
claude code . "基于各模块分析结果，给出全局优化建议"
```

## 测量压缩效果

### 脚本：测量 token 使用

```bash
#!/bin/bash
# measure-tokens.sh

echo "测量 Claude Code token 使用..."

# 未优化
echo "未优化的上下文大小:"
du -sh .

# 优化后
echo "优化后的上下文大小:"
du -sh . --exclude=node_modules --exclude=dist --exclude=.git

# 计算省钱比例
BEFORE=$(du -s . | awk '{print $1}')
AFTER=$(du -s . --exclude=node_modules --exclude=dist --exclude=.git | awk '{print $1}')

echo "节省: $((100 - ($AFTER * 100 / $BEFORE)))%"
```

## 最佳实践

### ✅ 推荐做法

1. **定期更新 .claudeignore**
   ```bash
   # 定期检查什么文件不需要
   git check-ignore --verbose $(find . -type f)
   ```

2. **为大型项目创建摘要**
   ```markdown
   # 项目摘要
   - 核心模块清单
   - 关键类和函数
   - 数据库 schema
   ```

3. **使用规则分层**
   - 公共规则在 CLAUDE.md
   - 特定规则在子目录的 CLAUDE.md

### ❌ 避免做法

1. **不要忽略有用的文件**
   ```bash
   # ❌ 太激进，会丢失重要信息
   .claudeignore 中忽略 src/
   ```

2. **不要规则文件过大**
   ```markdown
   # ❌ 应该分散到多个文件
   一个 CLAUDE.md 包含 10,000+ 行规则
   ```

## 下一章

👉 **[第 8 章：内置工具完整列表](08-builtin-tools.md)** - 所有能力一览

---

**时间提示：** 本章阅读 15 分钟，优化 10 分钟 ⏱️
