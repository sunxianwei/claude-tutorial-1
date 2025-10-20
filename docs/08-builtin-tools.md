# 08 - 内置工具完整列表：所有能力一览

## Claude Code 工具概览

Claude Code 内置了丰富的工具集，让 AI 可以像真正的开发者一样工作。

### 核心工具分类

```
File & Directory Tools (文件工具)
  ├── Read    - 读取文件内容
  ├── Write   - 创建/覆盖文件
  ├── Edit    - 编辑文件内容
  ├── Glob    - 通配符文件查询
  └── Grep    - 内容搜索

Version Control (版本控制)
  ├── Git Init/Clone
  ├── Git Add/Commit
  ├── Git Push/Pull
  ├── Git Branch Management
  └── Git Diff/Log

Execution & Shells (执行工具)
  ├── Bash    - 执行系统命令
  ├── Script  - 运行脚本
  ├── Test    - 运行测试
  └── Build   - 构建程序

Code Analysis (代码分析)
  ├── AST Parse - 代码解析
  ├── Linting  - 代码检查
  ├── Type Check - 类型检查
  └── Coverage - 覆盖率分析

MCP Tools (拓展工具)
  ├── Database Operations
  ├── API Calls
  ├── Cloud Services
  └── Custom Tools
```

## 详细工具说明

### 📄 文件工具

#### 1. Read（读取文件）

**用途：** 读取文件内容进行分析

**使用场景：**
- 分析现有代码
- 查看项目配置
- 理解代码逻辑

**Claude 自动使用：**
```
Claude: "这个项目是做什么的?"
→ Claude 自动读取 README.md, package.json 等关键文件
```

**手动指定：**
```bash
claude code . "分析 src/index.ts 的性能问题"
```

#### 2. Write（创建/覆盖文件）

**用途：** 创建新文件或完全替换文件内容

**使用场景：**
- 生成新组件
- 创建配置文件
- 初始化项目结构

**示例：**
```
Claude 创建一个新文件 UserService.ts:
- 自动判断文件位置和名称
- 基于项目约定编写代码
- 保存到磁盘
```

#### 3. Edit（编辑文件）

**用途：** 对文件进行精细的编辑，不会覆盖整个文件

**使用场景：**
- 添加新方法到类
- 修复 bug
- 重构代码段

**示例：**
```
原始代码:
function add(a, b) {
  return a + b;
}

Claude 要求: 添加参数验证

结果:
function add(a, b) {
  if (typeof a !== 'number' || typeof b !== 'number') {
    throw new Error('参数必须是数字');
  }
  return a + b;
}
```

#### 4. Glob（文件查询）

**用途：** 使用通配符快速查找文件

**支持的模式：**
```bash
*.ts              # 所有 TypeScript 文件
src/**/*.tsx      # 递归查询
{src,test}/*.js   # 多目录查询
```

**Claude 自动使用：**
```
Claude: "列出所有 Vue 组件"
→ Claude 使用 glob 查询 src/**/*.vue
→ 返回所有组件列表
```

#### 5. Grep（内容搜索）

**用途：** 在文件内容中搜索特定文本或正则表达式

**使用场景：**
- 找出所有 TODO 注释
- 查找废弃的 API 调用
- 检查代码中的反模式

**示例：**
```bash
# Claude: "找出所有 console.log 调用"
grep -r "console\.log" src/

# Claude: "找出所有未处理的异常"
grep -r "catch.*{.*}" src/
```

### 🔧 版本控制工具

#### Git Add & Commit

**用途：** 自动化 git 工作流

**Claude 自动使用：**
```
Claude: "为用户模块实现登录功能"
→ Claude 创建/修改文件
→ Claude 自动运行 git add
→ Claude 自动生成提交信息
→ Claude 提交到本地仓库
```

**提交信息示例：**
```
feat(auth): 实现用户登录功能

- 添加 LoginController
- 实现 JWT token 生成
- 添加密码加密逻辑
- 完整的单元测试
```

#### Git Branch Management

**Claude 能做的：**
- ✅ 创建新分支
- ✅ 切换分支
- ✅ 合并分支
- ✅ 删除分支
- ✅ 变基操作

**使用场景：**
```bash
claude code . "在 feature/user-profile 分支上实现用户资料功能"
→ Claude 自动创建分支并切换
→ 完成开发
→ 自动提交
```

#### Git Push & Pull

**Claude 能做的：**
- ✅ Push 代码到远程仓库
- ✅ Pull 最新代码
- ✅ 处理冲突
- ✅ 同步分支

```bash
claude code . --push "完成功能后推送到远程"
```

### ⚡ 执行工具

#### Bash（执行命令）

**用途：** 执行系统命令

**Claude 经常使用的命令：**
```bash
# 安装依赖
npm install

# 运行开发服务器
npm run dev

# 运行测试
npm test
jest --coverage

# 构建项目
npm run build

# 代码格式化
npx prettier --write .

# 代码检查
eslint src/

# 查看项目结构
tree -L 2 src/
```

**示例：**
```bash
claude code . "修复所有 linting 错误"
→ Claude 运行 eslint
→ 分析错误
→ 修复代码
→ 重新运行 eslint 验证
```

#### 测试执行

**Claude 能做的：**
- ✅ 运行单元测试
- ✅ 检查测试覆盖率
- ✅ 添加新测试
- ✅ 修复失败的测试

```bash
claude code . "为 UserService 添加单元测试，覆盖率要达到 80%"
→ Claude 自动执行 npm test
→ 分析覆盖率
→ 添加缺失的测试
→ 验证覆盖率目标
```

### 📊 代码分析工具

#### 类型检查

**Claude 能做的：**
- ✅ 检查 TypeScript 类型错误
- ✅ 推荐类型定义
- ✅ 修复类型不匹配

```bash
claude code . "修复所有 TypeScript 错误"
→ Claude 运行 tsc --noEmit
→ 分析类型错误
→ 添加缺失的类型定义
→ 重新验证
```

#### 代码风格检查

**Claude 能做的：**
- ✅ 检查代码风格
- ✅ 自动格式化
- ✅ 修复风格问题

```bash
claude code . "格式化所有代码并修复风格问题"
→ Claude 运行 Prettier
→ Claude 运行 ESLint
→ 自动修复可修复的问题
```

## 工具能力矩阵

| 工具 | 功能 | 应用场景 | 省时比例 |
|-----|------|--------|--------|
| **Read** | 读取文件 | 代码分析 | 20% |
| **Write** | 创建文件 | 新建文件 | 60% |
| **Edit** | 编辑文件 | 修改代码 | 50% |
| **Glob** | 文件查询 | 查找文件 | 80% |
| **Grep** | 内容搜索 | 代码搜索 | 70% |
| **Git** | 版本控制 | 代码提交 | 60% |
| **Bash** | 命令执行 | 构建/测试 | 40% |
| **MCP** | 外部集成 | 数据库操作 | 70% |

## Claude Code 能替代人工的工作

### ✅ 完全可以替代

| 工作 | 替代度 | 说明 |
|-----|-------|------|
| 代码生成 | 90% | 基于需求自动生成高质量代码 |
| 代码格式化 | 100% | 完全自动化 |
| 测试生成 | 85% | 自动生成单元测试 |
| 文档生成 | 80% | 从代码生成文档 |
| Bug 修复 | 70% | 找出并修复常见 bug |
| 代码审查 | 60% | 检查规范和常见问题 |
| Git 操作 | 85% | 自动提交和分支管理 |

### ⚠️ 部分可以替代

| 工作 | 替代度 | 说明 |
|-----|-------|------|
| 架构设计 | 40% | 可提供建议但需要人工决策 |
| 性能优化 | 50% | 可识别问题但需要验证 |
| 安全审计 | 60% | 可检查常见漏洞 |
| 技术选型 | 30% | 可提供建议但需要人工判断 |

### ❌ 不能替代

- 需求理解（需要与用户沟通）
- 最终决策（需要人工审核）
- 实验性设计（需要创意思维）
- 业务价值评估

## 工具使用示例

### 场景 1：完整功能开发

```bash
claude code . --subagent=codegen \
  "创建用户注册 API，包括数据验证、数据库操作、错误处理"

# Claude 自动使用工具流程:
# 1. Glob - 查找现有的用户相关代码
# 2. Read - 读取现有的 UserController 理解模式
# 3. Write - 创建 RegisterController
# 4. Edit - 修改现有的 UserService
# 5. Bash - 运行 npm test
# 6. Git Add & Commit - 提交代码
```

### 场景 2：Bug 修复

```bash
claude code . "修复登录页面输入框无法输入的 bug"

# Claude 自动使用工具流程:
# 1. Grep - 搜索所有包含 "input" 的组件
# 2. Read - 读取 LoginForm.vue 代码
# 3. Edit - 修改代码（添加 v-model）
# 4. Bash - 启动开发服务器并测试
# 5. Git Add & Commit - 提交修复
```

### 场景 3：性能优化

```bash
claude code . "优化 ProductList 组件的性能"

# Claude 自动使用工具流程:
# 1. Read - 读取 ProductList.vue
# 2. Grep - 搜索相关的 API 调用
# 3. Bash - 运行性能分析工具
# 4. Edit - 添加缓存、虚拟滚动等优化
# 5. Bash - 运行性能测试验证优化效果
# 6. Git Commit - 提交优化
```

## 下一章

👉 **[第 9 章：能力扩展](09-extend-ability.md)** - 让 Claude Code 做更多

---

**时间提示：** 本章阅读 10 分钟（快速参考）⏱️
