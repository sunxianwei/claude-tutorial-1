# 25 - 教程验证与测试清单

> 本文档提供完整的验证清单，确保教程内容准确可用

## ✅ 验证说明

本教程内容分为以下三类：

### 1. ✅ 已验证内容

基于官方文档和包管理器验证的内容：
- 所有 MCP 包名已在 npm 和 GitHub 验证
- 所有官方链接已验证可访问
- 命令语法已与官方文档核对

### 2. 📝 理论内容

基于官方文档的理论说明：
- 功能介绍和概念解释
- 工作流程和最佳实践
- 使用场景和示例

### 3. ⚠️ 需要实测的内容

需要在实际环境中测试的内容：
- MCP 服务器的实际连接
- 命令的执行结果
- IDE 集成的实际效果
- 示例项目的完整运行

---

## 📋 完整验证清单

### 第 1 部分：基础功能验证

#### ✅ 安装验证

```bash
# 1. 检查 Node.js 版本
node --version  # 应该 >= 18.0.0

# 2. 检查 npm 版本
npm --version  # 应该 >= 8.0.0

# 3. 安装 Claude Code（如果尚未安装）
npm install -g @anthropic-ai/claude-code

# 4. 验证安装
claude --version  # 应该显示版本号

# 5. 检查帮助信息
claude --help  # 应该显示命令列表
```

**预期结果**:
- [ ] Node.js 版本正确
- [ ] npm 可正常使用
- [ ] Claude Code 安装成功
- [ ] 版本信息正确显示
- [ ] 帮助信息完整

---

#### ✅ 基本命令验证

```bash
# 创建测试目录
mkdir claude-test
cd claude-test

# 初始化 Git（某些 MCP 需要）
git init

# 启动 Claude Code
claude .
```

**在 Claude Code 中测试**:

```
# 测试 1: 基本对话
用户: 你好，请介绍一下你自己

# 测试 2: 文件列表
用户: 列出当前目录的所有文件

# 测试 3: 创建文件
用户: 创建一个 README.md 文件，内容是 "Hello World"

# 测试 4: 读取文件
用户: 读取 README.md 文件的内容

# 测试 5: 退出
用户: Ctrl+D 或 /exit
```

**预期结果**:
- [ ] Claude 正常响应对话
- [ ] 可以列出文件
- [ ] 可以创建文件
- [ ] 可以读取文件
- [ ] 可以正常退出

---

### 第 2 部分：MCP 配置验证

#### ✅ Filesystem MCP

```bash
# 添加 Filesystem MCP
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .

# 验证配置
cat .claude/mcp-servers.json

# 启动 Claude Code
claude .
```

**测试用例**:
```
用户: 列出项目中所有的 .md 文件
用户: 创建 docs/ 目录
用户: 在 docs/ 目录创建 test.md 文件
```

**预期结果**:
- [ ] MCP 配置成功
- [ ] 可以搜索文件
- [ ] 可以创建目录
- [ ] 可以创建文件

---

#### ✅ Git MCP

```bash
# 确保在 Git 仓库中
git status

# 添加 Git MCP
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .

# 启动 Claude Code
claude .
```

**测试用例**:
```
用户: 查看最近 5 次 Git 提交
用户: 查看当前分支
用户: 查看未提交的文件
```

**预期结果**:
- [ ] 可以查看提交历史
- [ ] 可以查看分支信息
- [ ] 可以查看状态

---

#### ✅ Context7 MCP

```bash
# 添加 Context7 MCP
claude mcp add context7 -- npx -y @upstash/context7-mcp

# 启动 Claude Code
claude .
```

**测试用例**:
```
用户: 使用 Context7 查询 React 文档
用户: 查询 axios 的请求拦截器配置
```

**预期结果**:
- [ ] MCP 安装成功
- [ ] 可以查询文档
- [ ] 返回准确的文档内容

**注意**: Context7 需要网络连接

---

#### ✅ GitHub MCP

```bash
# 创建 GitHub Token
# 访问: https://github.com/settings/tokens/new
# 权限: repo, workflow

# 设置环境变量
export GITHUB_TOKEN="your_token_here"

# 添加 GitHub MCP
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# 启动 Claude Code
claude .
```

**测试用例**:
```
用户: 列出我的 GitHub 仓库（前 5 个）
用户: 查看某个仓库的 README
```

**预期结果**:
- [ ] Token 配置成功
- [ ] 可以访问 GitHub API
- [ ] 可以列出仓库
- [ ] 可以读取仓库内容

---

#### ⚠️ PostgreSQL MCP

**前置要求**:
```bash
# macOS
brew install postgresql@14
brew services start postgresql@14

# 创建测试数据库
createdb testdb

# 设置环境变量
export POSTGRES_CONNECTION_STRING="postgresql://localhost/testdb"

# 添加 PostgreSQL MCP
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres

# 启动 Claude Code
claude .
```

**测试用例**:
```
用户: 列出数据库中的所有表
用户: 创建一个 users 表，包含 id, name, email 字段
用户: 查询 users 表的结构
```

**预期结果**:
- [ ] PostgreSQL 正常运行
- [ ] MCP 连接成功
- [ ] 可以查看表
- [ ] 可以创建表
- [ ] 可以查询表结构

---

#### ⚠️ Playwright MCP

```bash
# 添加 Playwright MCP
claude mcp add playwright -- npx -y @automatalabs/mcp-server-playwright

# 启动 Claude Code
claude .
```

**测试用例**:
```
用户: 使用 Playwright 打开 https://example.com
用户: 截图并保存为 example.png
用户: 获取页面标题
```

**预期结果**:
- [ ] Playwright 浏览器启动成功
- [ ] 可以访问网页
- [ ] 可以截图
- [ ] 可以获取页面信息

**注意**: 首次使用会自动下载浏览器

---

### 第 3 部分：高级功能验证

#### ✅ 非交互模式

```bash
# 测试一次性对话
claude -p "列出当前目录的所有文件"

# 测试带参数的命令
claude -p "创建一个 hello.txt 文件，内容是 'Hello, Claude!'"
```

**预期结果**:
- [ ] 命令执行成功
- [ ] 输出结果正确
- [ ] 执行后自动退出

---

#### ✅ 会话管理

```bash
# 启动 Claude Code 并进行对话
claude .
# 进行一些对话...
# Ctrl+D 退出

# 列出历史会话
claude .
/resume

# 选择一个会话恢复
/resume 1

# 导出会话
/export session.md
```

**预期结果**:
- [ ] 可以查看历史会话
- [ ] 可以恢复会话
- [ ] 可以导出会话到文件
- [ ] 导出的文件格式正确

---

#### ✅ 权限管理

```bash
claude .
```

**测试用例**:
```
# 请求写入文件
用户: 创建一个新文件 test.txt

# 应该看到权限请求提示

# 查看权限设置
/permissions

# 测试危险操作（谨慎）
用户: 删除所有 .log 文件
```

**预期结果**:
- [ ] 写入操作有权限提示
- [ ] 可以查看权限设置
- [ ] 危险操作有明确警告

---

#### ⚠️ 自定义命令

```bash
# 创建命令目录
mkdir -p .claude/commands

# 创建测试命令
cat > .claude/commands/hello.md << 'EOF'
# Hello Command

Say hello to $ARGUMENTS
EOF

# 启动 Claude Code
claude .
```

**测试用例**:
```
用户: /hello World
```

**预期结果**:
- [ ] 命令被识别
- [ ] $ARGUMENTS 正确传递
- [ ] 命令执行成功

---

#### ⚠️ Hook 机制

```bash
# 创建 hooks 配置
cat > .claude/hooks.json << 'EOF'
{
  "pre-session": "echo 'Starting session...'",
  "post-write": "echo 'File written: $FILE'"
}
EOF

# 启动 Claude Code
claude .
```

**测试用例**:
```
# 启动时应该看到 "Starting session..."

用户: 创建文件 test.txt

# 写入后应该看到 "File written: test.txt"
```

**预期结果**:
- [ ] pre-session hook 执行
- [ ] post-write hook 执行
- [ ] 环境变量正确传递

---

### 第 4 部分：示例项目验证

#### ⚠️ 新项目演示

```bash
# 克隆或下载示例项目
cd examples/new-project-demo

# 查看 README.md 中的开发提示
cat README.md

# 复制完整的开发 Prompt

# 启动 Claude Code
claude .

# 粘贴 Prompt 并执行
```

**预期结果**:
- [ ] Prompt 清晰易懂
- [ ] Claude 理解需求
- [ ] 生成的代码结构正确
- [ ] 包含前端和后端代码
- [ ] 包含测试代码

**验证生成的代码**:
```bash
# 后端验证
cd backend
mvn clean package  # 应该编译成功
mvn test          # 测试应该通过

# 前端验证
cd ../frontend
npm install
npm run build     # 应该构建成功
npm run test      # 测试应该通过
```

---

#### ⚠️ 老项目集成

```bash
# 使用自己的老项目进行测试
cd your-old-project

# 初始化 Claude Code
claude init

# 配置基础 MCP
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .

# 启动 Claude Code
claude .
```

**使用分析 Prompt**:
```
我有一个老项目需要你帮助分析。

请分析：
1. 项目结构
2. 技术栈
3. 代码风格
4. 业务逻辑
5. 潜在问题

现在开始分析吧！
```

**预期结果**:
- [ ] Claude 正确识别项目类型
- [ ] 技术栈分析准确
- [ ] 代码风格分析合理
- [ ] 提供有价值的建议

---

### 第 5 部分：文档准确性验证

#### ✅ 链接验证

检查所有外部链接是否可访问：

```bash
# 使用工具检查链接（可选）
# 或手动检查关键链接
```

**关键链接清单**:
- [ ] https://docs.claude.com/
- [ ] https://www.anthropic.com/
- [ ] https://spec.modelcontextprotocol.io
- [ ] https://modelcontextprotocol.io
- [ ] https://github.com/modelcontextprotocol/servers
- [ ] https://docs.anthropic.com/en/docs/build-with-claude/mcp
- [ ] https://www.npmjs.com/package/@anthropic-ai/claude - [ ] https://github.com/getAsterisk/claudia
- [ ] https://github.com/xuzhenpeng263/claudia-global

---

#### ✅ 包名验证

验证所有 npm 包名是否正确：

```bash
# Filesystem MCP
npm view @modelcontextprotocol/server-filesystem

# Git MCP
npm view @modelcontextprotocol/server-git

# PostgreSQL MCP
npm view @modelcontextprotocol/server-postgres

# SQLite MCP
npm view @modelcontextprotocol/server-sqlite

# GitHub MCP
npm view @modelcontextprotocol/server-github

# GitLab MCP
npm view @modelcontextprotocol/server-gitlab

# Context7 MCP
npm view @upstash/context7-mcp

# Playwright MCP
npm view @automatalabs/mcp-server-playwright
```

**预期结果**:
- [ ] 所有包名正确
- [ ] 包都存在于 npm 上
- [ ] 版本信息可获取

---

### 第 6 部分：配置文件验证

#### ✅ MCP 配置文件

验证 `.claude/mcp-servers.json` 示例：

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "git": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-git", "--repository", "."]
    }
  }
}
```

**验证项**:
- [ ] JSON 格式正确
- [ ] 包名正确
- [ ] 参数正确
- [ ] 环境变量格式正确

---

#### ✅ CLAUDE.md 规则文件

验证示例规则文件：

```bash
# 创建测试规则文件
cat > CLAUDE.md << 'EOF'
# 项目开发规范

## 命名规范
- 类名：大驼峰（UserController）
- 方法名：小驼峰（getUserById）
- 常量：全大写下划线（MAX_SIZE）

## 代码风格
- 缩进：4 空格
- 每行最多 120 字符
EOF

# 启动 Claude Code
claude .
```

**测试用例**:
```
用户: 创建一个 UserService 类，包含 getUserById 方法
```

**预期结果**:
- [ ] Claude 读取规则文件
- [ ] 生成的代码符合规范
- [ ] 命名正确
- [ ] 格式正确

---

## 📊 验证进度追踪

### 基础功能（必须全部通过）

- [ ] 安装验证
- [ ] 基本命令验证
- [ ] Filesystem MCP
- [ ] Git MCP
- [ ] 非交互模式
- [ ] 会话管理
- [ ] 权限管理

### 高级功能（推荐验证）

- [ ] Context7 MCP
- [ ] GitHub MCP
- [ ] 自定义命令
- [ ] Hook 机制
- [ ] 规则文件系统

### 可选功能（环境允许时验证）

- [ ] PostgreSQL MCP
- [ ] Playwright MCP
- [ ] GitLab MCP
- [ ] 新项目演示
- [ ] 老项目集成

### 文档准确性（必须验证）

- [ ] 链接验证
- [ ] 包名验证
- [ ] 配置文件验证

---

## 🐛 已知问题和限制

### 1. MySQL MCP 不存在
**问题**: 官方没有 MySQL MCP 服务器
**解决方案**: 使用 PostgreSQL MCP 或通过 bash 命令操作 MySQL

### 2. Redis MCP 不存在
**问题**: 官方没有 Redis MCP 服务器
**解决方案**: 通过 bash 命令使用 redis-cli

### 3. Jenkins MCP 不存在
**问题**: 官方没有 Jenkins MCP 服务器
**解决方案**: 使用 curl 调用 Jenkins API

### 4. Playwright 首次使用慢
**问题**: 首次使用需要下载浏览器
**解决方案**: 耐心等待，或提前安装 Playwright

### 5. Context7 需要网络
**问题**: Context7 依赖在线服务
**解决方案**: 确保网络连接正常

---

## ✅ 验证报告模板

完成验证后，填写以下报告：

```markdown
# Claude Code 教程验证报告

**验证日期**: YYYY-MM-DD
**验证人**: 你的名字
**操作系统**: macOS / Windows / Linux
**Node.js 版本**: x.x.x
**Claude Code 版本**: x.x.x

## 基础功能验证

| 功能 | 状态 | 备注 |
|-----|------|------|
| 安装 | ✅ / ❌ | |
| 基本命令 | ✅ / ❌ | |
| Filesystem MCP | ✅ / ❌ | |
| Git MCP | ✅ / ❌ | |

## 高级功能验证

| 功能 | 状态 | 备注 |
|-----|------|------|
| Context7 MCP | ✅ / ❌ | |
| GitHub MCP | ✅ / ❌ | |
| 自定义命令 | ✅ / ❌ | |

## 发现的问题

1. 问题描述...
2. 问题描述...

## 改进建议

1. 建议...
2. 建议...

## 总体评价

- [ ] 教程内容准确
- [ ] 示例可以运行
- [ ] 配置说明清晰
- [ ] 推荐使用
```

---

## 🎯 最终验证目标

**目标**:
- 所有基础功能 100% 可用
- 至少 80% 的高级功能可用
- 所有链接有效
- 所有包名正确
- 配置文件示例可用

**成功标准**:
- ✅ 基础功能全部通过
- ✅ 至少 3 个 MCP 服务器正常工作
- ✅ 文档链接全部有效
- ✅ 示例项目可以运行

---

## 📞 问题反馈

如果在验证过程中发现问题，请：

1. 记录详细的错误信息
2. 记录复现步骤
3. 提供系统环境信息
4. 创建 Issue 或联系维护者

---

**文档版本**: 1.0
**最后更新**: 2025-01-20
**维护者**: 文档团队
