# 02 - 安装配置：让 Claude Code 完全就绪

## 系统要求

### 必需条件
- **Node.js**: 16.x 或 18.x+（推荐 18 LTS）
- **npm**: 8.x 或更新版本
- **Git**: 2.30+
- **操作系统**: macOS 10.15+ / Ubuntu 18.04+ / Windows 10+ (WSL2)

### 检查系统

```bash
# 检查 Node.js 版本
node --version    # 应输出 v18.x.x 或 v20.x.x

# 检查 npm 版本
npm --version     # 应输出 8.x.x 或更新

# 检查 Git 版本
git --version     # 应输出 git version 2.30+
```

## 安装步骤

### 步骤 1：安装 Claude Code CLI

```bash
# 使用 npm 全局安装
npm install -g @anthropic-ai/claude-code

# 验证安装成功
claude-code --version

# 查看帮助信息
claude-code --help
```

**国内用户提速：** 如果npm很慢，使用淘宝源：
```bash
npm config set registry https://registry.npmmirror.com
npm install -g @anthropic-ai/claude-code
```

### 步骤 2：获取 API 密钥

1. 访问 [Anthropic Console](https://console.anthropic.com)
2. 登录或创建账号
3. 点击左侧 "API Keys"
4. 点击 "Create Key"
5. 复制生成的密钥

⚠️ **重要安全提示：**
- 密钥只会显示一次，请妥善保管
- 不要在代码中硬编码密钥
- 定期轮换密钥

### 步骤 3：配置 API 密钥

#### 方案 A：环境变量（推荐）

```bash
# macOS / Linux
export ANTHROPIC_API_KEY="sk-ant-xxxxxxxxxxxx"

# 永久保存（添加到 ~/.zshrc 或 ~/.bashrc）
echo 'export ANTHROPIC_API_KEY="sk-ant-xxxxxxxxxxxx"' >> ~/.zshrc
source ~/.zshrc

# Windows (PowerShell)
$env:ANTHROPIC_API_KEY = "sk-ant-xxxxxxxxxxxx"

# Windows (cmd)
set ANTHROPIC_API_KEY=sk-ant-xxxxxxxxxxxx
```

#### 方案 B：VS Code 配置

如果使用 VS Code 插件，在 settings.json 中配置：

```json
{
  "anthropic.apiKey": "sk-ant-xxxxxxxxxxxx",
  "anthropic.model": "claude-haiku-4-5-20251001"
}
```

#### 方案 C：项目级配置（仅作演示用）

在项目根目录创建 `.env` 文件：

```bash
# .env
ANTHROPIC_API_KEY=sk-ant-xxxxxxxxxxxx
```

然后在使用前加载：
```bash
source .env
claude-code .
```

### 步骤 4：初始化项目

```bash
# 进入你的项目目录
cd your-project

# 初始化 Claude Code
claude-code init

# 这会创建：
# - .claude/              # Claude Code 配置目录
# - CLAUDE.md            # 项目指南和规则
```

### 步骤 5：验证安装

```bash
# 测试 Claude Code 是否可用
claude-code --version

# 尝试在项目中使用
claude-code . "Tell me about this project structure"
```

## 配置选项详解

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

### 核心配置项

#### `.claude/config.json`

```json
{
  "model": "claude-haiku-4-5-20251001",
  "temperature": 0.7,
  "maxTokens": 4096,
  "contextWindow": "大型",
  "autoCommit": false,
  "language": "zh-cn"
}
```

**配置说明：**
- `model`: 使用的模型版本
  - `claude-opus-4-1-20250805` - 最强（适合复杂任务）
  - `claude-sonnet-4-20250514` - 平衡（推荐）
  - `claude-haiku-4-5-20251001` - 快速便宜（日常任务）

- `temperature`: 创意度 (0-1)
  - `0` - 完全确定性（代码任务推荐）
  - `0.7` - 平衡（默认）
  - `1` - 最创意（创意写作）

- `maxTokens`: 单次回复最大 token 数
  - 一般 `4096` 即可
  - 复杂任务可设置 `8192`

- `contextWindow`: 上下文大小
  - `小` - 节省成本，适合小项目
  - `中` - 默认平衡方案
  - `大型` - 包含完整项目上下文

#### `.claudeignore`

类似 `.gitignore`，指定哪些文件 Claude 不应该读取：

```
# 依赖目录
node_modules/
.venv/
vendor/

# 构建产物
dist/
build/
*.o
*.class

# 敏感文件
.env*
.aws/
*.key
*.pem
secrets.json

# 临时文件
*.tmp
.DS_Store
```

### VS Code 配置

如果使用 VS Code 扩展，在工作区配置中添加：

```json
{
  "anthropic": {
    "apiKey": "${env:ANTHROPIC_API_KEY}",
    "model": "claude-sonnet-4-20250514",
    "contextCompression": true,
    "autoSave": true
  },
  "editor.wordWrap": "on",
  "editor.formatOnSave": true
}
```

## 常见问题排查

### 问题 1：找不到 claude-code 命令

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

# 永久添加到 ~/.zshrc 或 ~/.bashrc
echo 'export PATH=$PATH:'"$(npm config get prefix)"'/bin' >> ~/.zshrc
```

### 问题 2：API 密钥无效

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

### 问题 3：权限错误

**症状：**
```
Permission denied: .claude/config.json
```

**解决方案：**
```bash
# 修复权限
chmod -R 755 .claude/
chmod 644 CLAUDE.md
```

### 问题 4：性能问题

如果 Claude Code 运行缓慢：

```bash
# 1. 减小上下文
# 在 .claude/config.json 中改为 "contextWindow": "小"

# 2. 优化 .claudeignore
# 添加更多无关目录

# 3. 使用更快的模型
# 改用 claude-haiku-4-5-20251001
```

## 高级配置

### MCP 服务器配置

创建 `.claude/mcp-servers.json`：

```json
{
  "servers": [
    {
      "name": "filesystem",
      "command": "node",
      "args": ["./mcp-servers/filesystem.js"]
    }
  ]
}
```

详见 [第 3 章：MCP 配置指南](03-mcp-setup.md)

### 自定义工具快捷键

创建 `.claude/shortcuts.json`：

```json
{
  "test": "npm test && npm run coverage",
  "build": "npm run clean && npm run build",
  "deploy": "npm run build && npm run deploy:prod"
}
```

### 项目规范

编写 `CLAUDE.md` 定义项目规范：

```markdown
# 项目规范

## 代码风格
- 使用 ESLint 和 Prettier
- 2 空格缩进
- 必须有 TypeScript 类型

## 提交规范
- Conventional Commits
- 中文提交信息

## 文件结构
- src/ - 源代码
- tests/ - 测试代码
- docs/ - 文档
```

详见 [第 6 章：规则文件系统](06-rules-file.md)

## 下一步

✅ 安装配置完成！

选择你要进行的操作：

- 📖 **新手入门** → [新项目工作流](11-new-project-workflow.md)
- 🔧 **扩展功能** → [MCP 配置指南](03-mcp-setup.md)
- 📋 **项目迁移** → [老项目迁移](12-legacy-project-workflow.md)
- 💻 **开始编码** → [内置工具完整列表](08-builtin-tools.md)

---

**时间提示：** 本章阅读 10 分钟，配置 5 分钟 ⏱️
