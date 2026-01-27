# 24 - 截图指南

> 本文档列出教程中需要添加的截图位置和要求

## 📸 截图添加说明

由于 AI 无法直接截取真实的应用界面，本文档提供详细的截图需求清单，供人工添加。

**重要原则：**
- ✅ 截图必须真实，来自实际运行的 Claude Code
- ✅ 截图需要清晰，分辨率建议 1920x1080 或更高
- ✅ 截图内容要与文档描述完全一致
- ✅ 敏感信息（API Key、项目路径等）需要打码
- ❌ 不要使用模拟或伪造的截图

---

## 📋 截图清单

### 第 1 章：快速开始 (docs/01-quick-start.md)

#### 截图 1.1: Claude Code 启动界面
**位置**: 第一次运行 `claude code .` 的效果
**内容要求**:
- 显示 Claude Code 的欢迎信息
- 显示加载的 MCP 服务器
- 显示等待输入的提示符

**建议文件名**: `screenshots/01-startup-screen.png`

**截图时机**: 运行 `claude code .` 后

---

#### 截图 1.2: 第一次对话示例
**位置**: 展示简单的对话交互
**内容要求**:
- 用户提问："列出当前目录的所有文件"
- Claude 的回应和文件列表
- 完整的对话流

**建议文件名**: `screenshots/01-first-conversation.png`

---

### 第 2 章：安装配置 (docs/02-installation.md)

#### 截图 2.1: 安装过程
**位置**: npm 安装 Claude Code
**内容要求**:
- 显示 `npm install -g @anthropic-ai/claude-code` 命令
- 显示安装进度
- 显示安装成功信息

**建议文件名**: `screenshots/02-installation.png`

---

#### 截图 2.2: 版本验证
**位置**: 验证安装成功
**内容要求**:
- 显示 `claude --version` 命令
- 显示版本号

**建议文件名**: `screenshots/02-version-check.png`

---

### 第 3 章：MCP 配置指南 (docs/03-mcp-setup.md)

#### 截图 3.1: MCP 列表
**位置**: 显示已安装的 MCP 服务器
**内容要求**:
- 运行 `claude mcp list` 命令
- 显示所有已配置的 MCP 服务器
- 显示服务器状态（运行中/已停止）

**建议文件名**: `screenshots/03-mcp-list.png`

---

#### 截图 3.2: 添加 MCP 服务器
**位置**: 添加 Context7 MCP
**内容要求**:
- 显示 `claude mcp add context7 -- npx -y @upstash/context7-mcp` 命令
- 显示安装过程
- 显示成功信息

**建议文件名**: `screenshots/03-mcp-add.png`

---

#### 截图 3.3: MCP 配置文件
**位置**: 显示 `.claude/mcp-servers.json` 文件
**内容要求**:
- 在 VS Code 或其他编辑器中打开配置文件
- 显示完整的 JSON 配置
- 至少包含 2-3 个 MCP 服务器配置

**建议文件名**: `screenshots/03-mcp-config-file.png`

---

### 第 5 章：SubAgents 使用 (docs/05-subagents.md)

#### 截图 5.1: /agents 命令
**位置**: 查看可用的 SubAgent
**内容要求**:
- 运行 `/agents` 命令
- 显示所有可用的 agent 列表
- 显示每个 agent 的描述

**建议文件名**: `screenshots/05-agents-list.png`

---

#### 截图 5.2: @mention 使用示例
**位置**: 使用 @codegen 生成代码
**内容要求**:
- 用户输入: "@codegen 创建一个用户登录组件"
- 显示 codegen agent 的回应
- 显示生成的代码

**建议文件名**: `screenshots/05-mention-codegen.png`

---

### 第 6 章：规则文件系统 (docs/06-rules-file.md)

#### 截图 6.1: CLAUDE.md 文件
**位置**: 展示项目的 CLAUDE.md 文件
**内容要求**:
- 在编辑器中打开 CLAUDE.md
- 显示清晰的文件结构
- 包含代码规范、命名约定等内容

**建议文件名**: `screenshots/06-claude-md-file.png`

---

#### 截图 6.2: 规则生效示例
**位置**: Claude 遵循规则生成代码
**内容要求**:
- 显示用户请求
- 显示 Claude 引用规则文件的提示
- 显示符合规范的生成代码

**建议文件名**: `screenshots/06-rules-in-action.png`

---

### 第 10 章：快捷键速查 (docs/10-shortcuts.md)

#### 截图 10.1: 快捷键使用
**位置**: 展示常用快捷键
**内容要求**:
- 显示 Ctrl+C 取消操作
- 显示 Ctrl+D 退出
- 可以是组合截图

**建议文件名**: `screenshots/10-shortcuts.png`

---

### 第 15 章：命令参考 (docs/15-command-reference.md)

#### 截图 15.1: 非交互模式
**位置**: 使用 `claude -p` 一次性对话
**内容要求**:
- 显示 `claude -p "列出项目结构"` 命令
- 显示输出结果
- 显示命令完成后自动退出

**建议文件名**: `screenshots/15-non-interactive.png`

---

#### 截图 15.2: /resume 命令
**位置**: 恢复历史会话
**内容要求**:
- 运行 `/resume` 命令
- 显示历史会话列表
- 显示会话编号和时间

**建议文件名**: `screenshots/15-resume-list.png`

---

#### 截图 15.3: /export 命令
**位置**: 导出会话历史
**内容要求**:
- 运行 `/export output.md` 命令
- 显示导出成功信息
- （可选）显示导出的文件内容

**建议文件名**: `screenshots/15-export.png`

---

### 第 16 章：权限管理 (docs/16-permissions.md)

#### 截图 16.1: 权限请求提示
**位置**: Claude 请求文件写入权限
**内容要求**:
- 显示权限请求弹窗或提示
- 显示请求的操作类型
- 显示允许/拒绝选项

**建议文件名**: `screenshots/16-permission-request.png`

---

#### 截图 16.2: /permissions 命令
**位置**: 查看权限设置
**内容要求**:
- 运行 `/permissions` 命令
- 显示当前的权限配置
- 显示已授权的操作列表

**建议文件名**: `screenshots/16-permissions-list.png`

---

### 第 17 章：自定义命令和 Hook (docs/17-custom-commands.md)

#### 截图 17.1: 自定义命令文件
**位置**: .claude/commands/ 目录结构
**内容要求**:
- 显示文件资源管理器
- 显示 `.claude/commands/` 目录
- 显示多个 .md 命令文件（如 review.md、deploy.md）

**建议文件名**: `screenshots/17-commands-directory.png`

---

#### 截图 17.2: 使用自定义命令
**位置**: 执行 /review 命令
**内容要求**:
- 用户输入: `/review src/UserController.java`
- 显示命令执行过程
- 显示代码审查结果

**建议文件名**: `screenshots/17-custom-command-usage.png`

---

#### 截图 17.3: Hook 配置文件
**位置**: .claude/hooks.json 文件
**内容要求**:
- 在编辑器中打开 hooks.json
- 显示配置的 hook（如 pre-commit、post-write）
- 显示清晰的 JSON 结构

**建议文件名**: `screenshots/17-hooks-config.png`

---

### 第 18 章：IDE 集成 (docs/18-ide-integration.md)

#### 截图 18.1: VS Code Tasks
**位置**: VS Code 中的 Claude Code 任务
**内容要求**:
- 显示 .vscode/tasks.json 文件
- 显示 Claude Code 相关的任务配置
- 显示任务列表（Ctrl+Shift+P → Tasks: Run Task）

**建议文件名**: `screenshots/18-vscode-tasks.png`

---

#### 截图 18.2: Cursor 集成
**位置**: Cursor 中使用 Claude Code
**内容要求**:
- 显示 Cursor 编辑器界面
- 显示调用 Claude Code 的方式
- 显示对话窗口

**建议文件名**: `screenshots/18-cursor-integration.png`

---

### 第 19 章：历史会话管理 (docs/19-session-management.md)

#### 截图 19.1: ccundo 工具
**位置**: 使用 ccundo 撤销变更
**内容要求**:
- 运行 `ccundo` 命令
- 显示可撤销的操作列表
- 显示选择界面

**建议文件名**: `screenshots/19-ccundo.png`

---

#### 截图 19.2: 会话历史
**位置**: 查看历史会话
**内容要求**:
- 显示 `.claude/sessions/` 目录
- 显示多个会话文件
- 显示文件时间戳

**建议文件名**: `screenshots/19-session-history.png`

---

### 第 20 章：可视化工具 (docs/20-visualization-tools.md)

#### 截图 20.1: Claudia 主界面
**位置**: Claudia 可视化工具
**内容要求**:
- 显示 Claudia 的主界面
- 显示项目列表
- 显示聊天窗口

**建议文件名**: `screenshots/20-claudia-main.png`

---

#### 截图 20.2: Claudia 文件浏览器
**位置**: Claudia 的文件管理功能
**内容要求**:
- 显示文件树
- 显示文件预览
- 显示编辑功能

**建议文件名**: `screenshots/20-claudia-files.png`

---

### 第 22 章：MCP 实例配置详解 (docs/22-mcp-examples-verified.md)

#### 截图 22.1: Context7 MCP 使用
**位置**: 使用 Context7 查询文档
**内容要求**:
- 用户输入: "使用 Context7 查询 React 18 的 useTransition hook"
- 显示 Claude 调用 Context7
- 显示返回的文档内容

**建议文件名**: `screenshots/22-context7-usage.png`

---

#### 截图 22.2: GitHub MCP 集成
**位置**: 使用 GitHub MCP
**内容要求**:
- 用户输入: "列出我的 GitHub 仓库"
- 显示 Claude 调用 GitHub API
- 显示仓库列表

**建议文件名**: `screenshots/22-github-mcp.png`

---

#### 截图 22.3: Playwright MCP 浏览器控制
**位置**: 使用 Playwright 自动化测试
**内容要求**:
- 用户输入: "使用 Playwright 打开 https://example.com 并截图"
- 显示 Claude 控制浏览器
- 显示截图结果

**建议文件名**: `screenshots/22-playwright-mcp.png`

---

### 第 23 章：按岗位使用场景 (docs/23-role-based-scenarios.md)

#### 截图 23.1: 产品经理场景
**位置**: PM 使用 Claude 生成 PRD
**内容要求**:
- 显示 PM 的提示词
- 显示生成的产品需求文档
- 显示文档结构清晰

**建议文件名**: `screenshots/23-pm-scenario.png`

---

#### 截图 23.2: 前端开发场景
**位置**: 前端工程师创建组件
**内容要求**:
- 显示创建 Vue 组件的请求
- 显示生成的组件代码
- 显示测试代码

**建议文件名**: `screenshots/23-frontend-scenario.png`

---

#### 截图 23.3: DevOps 场景
**位置**: DevOps 配置 CI/CD
**内容要求**:
- 显示创建 GitHub Actions 的请求
- 显示生成的 workflow 文件
- 显示清晰的 YAML 配置

**建议文件名**: `screenshots/23-devops-scenario.png`

---

## 📁 截图存储结构

建议创建以下目录结构：

```
screenshots/
├── 01-quick-start/
│   ├── startup-screen.png
│   └── first-conversation.png
├── 02-installation/
│   ├── installation.png
│   └── version-check.png
├── 03-mcp-setup/
│   ├── mcp-list.png
│   ├── mcp-add.png
│   └── mcp-config-file.png
├── 05-subagents/
│   ├── agents-list.png
│   └── mention-codegen.png
├── 06-rules-file/
│   ├── claude-md-file.png
│   └── rules-in-action.png
├── 10-shortcuts/
│   └── shortcuts.png
├── 15-command-reference/
│   ├── non-interactive.png
│   ├── resume-list.png
│   └── export.png
├── 16-permissions/
│   ├── permission-request.png
│   └── permissions-list.png
├── 17-custom-commands/
│   ├── commands-directory.png
│   ├── custom-command-usage.png
│   └── hooks-config.png
├── 18-ide-integration/
│   ├── vscode-tasks.png
│   └── cursor-integration.png
├── 19-session-management/
│   ├── ccundo.png
│   └── session-history.png
├── 20-visualization-tools/
│   ├── claudia-main.png
│   └── claudia-files.png
├── 22-mcp-examples/
│   ├── context7-usage.png
│   ├── github-mcp.png
│   └── playwright-mcp.png
└── 23-role-scenarios/
    ├── pm-scenario.png
    ├── frontend-scenario.png
    └── devops-scenario.png
```

## 🎨 截图规范

### 1. 技术要求

- **格式**: PNG（推荐）或 JPG
- **分辨率**: 至少 1920x1080
- **DPI**: 至少 144 DPI（视网膜屏）
- **文件大小**: 单张不超过 2MB（使用压缩工具优化）

### 2. 内容要求

- **清晰度**: 文字必须清晰可读
- **完整性**: 包含所有必要的上下文信息
- **一致性**: 同一章节的截图风格保持一致
- **真实性**: 必须来自实际运行的应用

### 3. 安全要求

- **API Key**: 必须完全隐藏或打码
- **个人信息**: 用户名、邮箱等需要模糊化
- **项目路径**: 敏感路径需要替换为通用路径
- **敏感数据**: 数据库连接字符串、密码等必须隐藏

### 4. 标注要求

需要添加标注的截图：
- 使用红色框或箭头指示关键区域
- 添加简短的文字说明
- 标注要清晰但不遮挡主要内容

**标注工具推荐**:
- macOS: Skitch, Snagit
- Windows: Snipping Tool, Greenshot
- 跨平台: ShareX, Flameshot

## 📝 在文档中引用截图

### Markdown 语法

```markdown
![截图描述](../screenshots/章节/文件名.png)
```

### 示例

```markdown
## 启动 Claude Code

运行以下命令启动：

```bash
claude code .
```

启动后会看到如下界面：

![Claude Code 启动界面](../screenshots/01-quick-start/startup-screen.png)

*图 1.1: Claude Code 成功启动*
```

## ✅ 截图验证清单

完成截图后，使用以下清单验证：

- [ ] 所有截图都来自真实运行的应用
- [ ] 截图清晰，文字可读
- [ ] 敏感信息已打码或隐藏
- [ ] 文件名符合命名规范
- [ ] 截图内容与文档描述一致
- [ ] 截图已正确引用到文档中
- [ ] 截图文件大小适中（已压缩）
- [ ] 所有截图都有替代文本（alt text）

## 📊 进度追踪

| 章节 | 需要截图数 | 已完成 | 进度 |
|-----|-----------|--------|------|
| 01 快速开始 | 2 | 0 | 0% |
| 02 安装配置 | 2 | 0 | 0% |
| 03 MCP 配置 | 3 | 0 | 0% |
| 05 SubAgents | 2 | 0 | 0% |
| 06 规则文件 | 2 | 0 | 0% |
| 10 快捷键 | 1 | 0 | 0% |
| 15 命令参考 | 3 | 0 | 0% |
| 16 权限管理 | 2 | 0 | 0% |
| 17 自定义命令 | 3 | 0 | 0% |
| 18 IDE 集成 | 2 | 0 | 0% |
| 19 会话管理 | 2 | 0 | 0% |
| 20 可视化工具 | 2 | 0 | 0% |
| 22 MCP 实例 | 3 | 0 | 0% |
| 23 岗位场景 | 3 | 0 | 0% |
| **总计** | **32** | **0** | **0%** |

---

## 🔧 截图工具推荐

### macOS
- **Command + Shift + 4**: 系统截图
- **Command + Shift + 5**: 录屏和截图工具
- **Skitch**: 标注工具
- **CleanShot X**: 专业截图工具（付费）

### Windows
- **Windows + Shift + S**: 截图工具
- **Snipping Tool**: 系统自带
- **Greenshot**: 开源截图工具
- **ShareX**: 功能强大的截图工具

### Linux
- **Flameshot**: 强大的开源截图工具
- **Shutter**: 功能丰富的截图工具
- **GNOME Screenshot**: GNOME 桌面自带

### 在线压缩工具
- **TinyPNG**: https://tinypng.com/
- **Squoosh**: https://squoosh.app/
- **ImageOptim** (macOS): https://imageoptim.com/

---

## 📞 问题反馈

如果在添加截图过程中遇到问题：

1. 确保 Claude Code 正确安装并运行
2. 检查 MCP 服务器是否正确配置
3. 确保有足够的权限执行命令
4. 查看错误日志获取详细信息

---

**最后更新**: 2025-01-20
**维护者**: 文档团队
**状态**: 📝 等待截图添加
