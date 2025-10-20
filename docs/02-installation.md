# 02 - 配置指南：让 Claude Code 完全就绪

> 本章假设你已安装 Claude Code。如未安装，请先参考 [第 01 章快速开始](01-quick-start.md)中的安装部分。

## 快速配置（5分钟）

### 步骤 1：配置 API 密钥

#### 环境变量方式（推荐）

```bash
# macOS / Linux
export ANTHROPIC_API_KEY="sk-ant-xxxxxxxxxxxx"

# 永久保存（添加到 ~/.zshrc）
echo 'export ANTHROPIC_API_KEY="sk-ant-xxxxxxxxxxxx"' >> ~/.zshrc
source ~/.zshrc
```

#### VS Code 配置

在 settings.json 中配置：

```json
{
  "anthropic.apiKey": "sk-ant-xxxxxxxxxxxx",
  "anthropic.model": "claude-sonnet-4-20250514"
}
```

### 步骤 2：初始化项目

```bash
cd your-project
claude-code init
```

### 步骤 3：验证配置

```bash
# 测试 Claude Code 是否可用
claude-code --version

# 查看已加载的配置
claude-code --show-rules
```

---

## 深度配置

### Claude Code 配置文件结构

```
your-project/
├── .claude/
│   ├── config.json          # 项目配置
│   ├── mcp-servers.json     # MCP 服务配置
│   ├── shortcuts.json       # 自定义快捷键
│   └── memory.json          # AI 记忆和上下文
├── CLAUDE.md                # 项目规则和指南
└── .claudeignore            # 忽略文件列表
```

### .claude/config.json 详解

```json
{
  "model": "claude-sonnet-4-20250514",
  "temperature": 0.7,
  "maxTokens": 4096,
  "contextWindow": "中",
  "language": "zh-cn",
  "autoCommit": false,
  "contextCompression": {
    "level": "medium",
    "ignoreNodeModules": true,
    "ignoreBuildArtifacts": true
  }
}
```

**关键配置说明：**

- **model**: 使用的模型
  - `claude-opus-4-1-20250805` - 最强，复杂任务
  - `claude-sonnet-4-20250514` - 平衡（推荐）⭐
  - `claude-haiku-4-5-20251001` - 快速便宜

- **temperature**: 创意度 (0-1)
  - `0` - 完全确定性（代码任务推荐）
  - `0.7` - 平衡（默认）
  - `1` - 最创意（创意写作）

- **contextWindow**: 上下文大小
  - `小` - 节省成本，适合小项目
  - `中` - 默认平衡方案（推荐）
  - `大型` - 包含完整项目上下文

### .claudeignore 最佳实践

```
# 依赖和虚拟环境
node_modules/
.venv/
venv/
env/
vendor/
target/

# 构建产物
dist/
build/
out/
*.class
__pycache__/
.pytest_cache/

# IDE 和编辑器
.vscode/
.idea/
*.swp
*.swo
*~

# 系统文件
.DS_Store
.git/

# 临时和日志
logs/
*.log
tmp/
temp/
.cache/
```

### VS Code 工作区配置

在 `.vscode/settings.json` 中配置：

```json
{
  "anthropic": {
    "apiKey": "${env:ANTHROPIC_API_KEY}",
    "model": "claude-sonnet-4-20250514",
    "contextCompression": true,
    "autoSave": true
  },
  "editor.wordWrap": "on",
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode"
}
```

---

## 常见问题排查

### 问题 1：API 密钥无效

**症状：**
```
Error: Invalid API key. Please check ANTHROPIC_API_KEY environment variable.
```

**检查项：**
1. 密钥是否正确复制（注意前缀 `sk-ant-`）
2. 密钥是否过期
3. 是否添加了多余的空格或换行

```bash
# 验证密钥
echo $ANTHROPIC_API_KEY
# 应该输出类似：sk-ant-xxxxxxxxxxxxx
```

### 问题 2：找不到 claude-code 命令

**症状：**
```
claude-code: command not found
```

**解决方案：**
```bash
# 检查全局安装位置
npm config get prefix

# 如果不在 PATH 中，手动添加
export PATH=$PATH:$(npm config get prefix)/bin
```

### 问题 3：模型加载缓慢

**解决方案：**
```bash
# 检查网络连接
ping api.anthropic.com

# 尝试使用更快的模型
# 在 config.json 中改为 claude-haiku-4-5-20251001

# 减小上下文窗口
# 在 config.json 中改为 "contextWindow": "小"
```

---

## 团队协作配置

### 项目级规范文件

在项目根目录创建 `CLAUDE.md`（详见第 06 章）：

```markdown
# 项目规范

## 代码风格
- 使用 TypeScript 严格模式
- 2 空格缩进
- 使用 ESLint 和 Prettier

## 测试要求
- 最低覆盖率 80%
- 使用 Jest 进行单元测试

## 提交规范
- Conventional Commits
- 中文提交信息

## 工具集成
- 使用 GitHub Actions 进行 CI/CD
- PostgreSQL 作为数据库
```

### 环境变量管理

创建 `.env.example`：

```bash
ANTHROPIC_API_KEY=sk-ant-your-key
DB_PASSWORD=your_password
GITHUB_TOKEN=your_token
GITLAB_TOKEN=your_token
DINGTALK_WEBHOOK=your_webhook_url
```

**安全提示：** 添加 `.env` 到 `.gitignore`

```bash
echo ".env" >> .gitignore
echo ".env.local" >> .gitignore
```

---

## 下一步

✅ 配置完成！

选择你要进行的操作：

- 📖 **学习规范** → [第 06 章：规则文件系统](06-rules-file.md)
- 🔧 **扩展工具** → [第 03 章：MCP 配置指南](03-mcp-setup.md)
- 💻 **开始编码** → [第 11 章：新项目工作流](11-new-project-workflow.md)
- 🚀 **快速上手** → [第 01 章：快速开始](01-quick-start.md)

---

**时间提示：** 本章配置需要 5-10 分钟 ⏱️
