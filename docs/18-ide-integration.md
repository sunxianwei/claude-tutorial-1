# 18 - IDE 集成：在编辑器中使用 Claude Code

## 支持的 IDE

Claude Code 可以与主流 IDE/编辑器无缝集成：

| IDE | 支持程度 | 集成方式 |
|-----|---------|---------|
| **VS Code** | ⭐⭐⭐⭐⭐ | 官方扩展 + 内置终端 |
| **Cursor** | ⭐⭐⭐⭐⭐ | 原生集成 + 扩展 |
| **JetBrains IDEs** | ⭐⭐⭐⭐ | 终端 + 插件 |
| **Vim/Neovim** | ⭐⭐⭐⭐ | 终端集成 |
| **Sublime Text** | ⭐⭐⭐ | 终端插件 |

## VS Code 集成（推荐）

### 方式 1：使用内置终端

最简单的方式是在 VS Code 的集成终端中直接使用 Claude Code：

**步骤 1：打开集成终端**

```
快捷键：Ctrl + ` (或 Cmd + ` on Mac)
或菜单：Terminal → New Terminal
```

**步骤 2：运行 Claude Code**

```bash
claude code .
```

**优势：**
- ✅ 无需额外配置
- ✅ 可以直接看到文件修改
- ✅ 支持热重载
- ✅ 与 Git 无缝集成

### 方式 2：VS Code 任务集成

创建 `.vscode/tasks.json`：

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Claude Code: 启动",
      "type": "shell",
      "command": "claude code .",
      "problemMatcher": [],
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": true,
        "panel": "dedicated"
      }
    },
    {
      "label": "Claude Code: 代码审查",
      "type": "shell",
      "command": "claude code -p '代码审查'",
      "problemMatcher": []
    },
    {
      "label": "Claude Code: 运行测试",
      "type": "shell",
      "command": "claude code -p '运行所有测试'",
      "problemMatcher": []
    },
    {
      "label": "Claude Code: 生成文档",
      "type": "shell",
      "command": "claude code -p '生成 API 文档'",
      "problemMatcher": []
    }
  ]
}
```

**使用方式：**

```
Ctrl+Shift+P (或 Cmd+Shift+P)
→ Tasks: Run Task
→ 选择 "Claude Code: 启动"
```

### 方式 3：键盘快捷键

创建 `.vscode/keybindings.json`：

```json
[
  {
    "key": "ctrl+alt+c",
    "command": "workbench.action.tasks.runTask",
    "args": "Claude Code: 启动"
  },
  {
    "key": "ctrl+alt+r",
    "command": "workbench.action.tasks.runTask",
    "args": "Claude Code: 代码审查"
  },
  {
    "key": "ctrl+alt+t",
    "command": "workbench.action.tasks.runTask",
    "args": "Claude Code: 运行测试"
  }
]
```

**快捷键：**
- `Ctrl+Alt+C` - 启动 Claude Code
- `Ctrl+Alt+R` - 代码审查
- `Ctrl+Alt+T` - 运行测试

### 方式 4：VS Code 扩展（概念性）

> ⚠️ **注意**: 以下为理想的集成方式，实际可用性请参考 [重要说明](14-important-notice.md)

**功能特性：**
- 📝 在编辑器中直接与 Claude 对话
- 🔍 选中代码后右键调用 Claude
- 💡 代码建议和自动完成
- 🔧 一键重构和优化
- 📚 悬停查看文档

## Cursor 集成

Cursor 是基于 VS Code 的 AI 编辑器，与 Claude Code 有天然的兼容性。

### 配置步骤

**步骤 1：安装 Claude Code**

```bash
npm install -g @anthropic-ai/claude-code
```

**步骤 2：在 Cursor 中配置**

打开设置 → Cursor → AI Rules，添加：

```markdown
# Claude Code 集成

当需要复杂的代码生成或重构时，使用 Claude Code CLI 工具：

## 使用方式

在终端运行：
\`\`\`bash
claude code . "你的任务描述"
\`\`\`

## 推荐场景

- 大规模重构
- 批量文件生成
- 复杂的项目级操作
- 需要上下文压缩的场景
```

### Cursor + Claude Code 工作流

**方式 A：Cursor 用于快速编辑，Claude Code 用于复杂任务**

```
快速修改        → Cursor
完整功能开发     → Claude Code
重构优化        → Claude Code
代码审查        → Claude Code
文档生成        → Claude Code
```

**方式 B：组合使用**

1. 使用 Cursor 进行初步设计
2. 使用 Claude Code 实现完整功能
3. 使用 Cursor 进行微调

## JetBrains IDEs 集成

支持 IntelliJ IDEA、PyCharm、WebStorm 等。

### 方式 1：终端工具窗口

**步骤 1：打开终端**

```
快捷键：Alt + F12
或菜单：View → Tool Windows → Terminal
```

**步骤 2：运行 Claude Code**

```bash
claude code .
```

### 方式 2：External Tools

**配置外部工具：**

1. 打开设置：`File → Settings → Tools → External Tools`
2. 点击 `+` 添加新工具
3. 配置如下：

```
Name: Claude Code
Program: claude
Arguments: code .
Working directory: $ProjectFileDir$
```

**使用方式：**

```
右键项目 → External Tools → Claude Code
```

### 方式 3：创建 Run Configuration

1. `Run → Edit Configurations`
2. 点击 `+` → `Shell Script`
3. 配置：

```
Name: Claude Code
Script text: claude code .
Working directory: $PROJECT_DIR$
```

## Vim/Neovim 集成

### 方式 1：终端模式

```vim
" 在 Vim 中执行 Claude Code
:term claude code .

" 或使用简写
:!claude code .
```

### 方式 2：创建命令

在 `.vimrc` 或 `init.vim` 中添加：

```vim
" Claude Code 命令
command! ClaudeCode :term claude code .
command! ClaudeReview :!claude code -p "代码审查"
command! ClaudeTest :!claude code -p "运行测试"
command! ClaudeDocs :!claude code -p "生成文档"

" 键盘映射
nnoremap <leader>cc :ClaudeCode<CR>
nnoremap <leader>cr :ClaudeReview<CR>
nnoremap <leader>ct :ClaudeTest<CR>
```

**使用方式：**

```
,cc  - 启动 Claude Code
,cr  - 代码审查
,ct  - 运行测试
```

### 方式 3：选中代码处理

```vim
" 将选中的代码发送给 Claude Code 处理
vnoremap <leader>cp :!claude code -p "优化选中的代码"<CR>
```

## 编辑器配置最佳实践

### 1. 文件监听配置

**VS Code (.vscode/settings.json):**

```json
{
  "files.watcherExclude": {
    "**/.claude/**": false
  },
  "files.autoSave": "onFocusChange",
  "editor.formatOnSave": true
}
```

### 2. Git 集成

**启用 Git 自动刷新：**

```json
{
  "git.autoRefresh": true,
  "git.enableSmartCommit": true,
  "git.confirmSync": false
}
```

### 3. 终端配置

**VS Code:**

```json
{
  "terminal.integrated.defaultProfile.osx": "zsh",
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.scrollback": 10000
}
```

## 常见 IDE 工作流

### 工作流 1：VS Code + Claude Code

```
1. 在 VS Code 中打开项目
2. 按 Ctrl+` 打开终端
3. 运行 claude code .
4. 在 Claude Code 中描述需求
5. VS Code 自动刷新显示修改
6. 审查修改并继续迭代
```

### 工作流 2：双窗口模式

```
左侧：编辑器（查看代码）
右侧：终端（运行 Claude Code）

优势：
- 实时查看修改
- 快速切换上下文
- 保持工作连续性
```

### 工作流 3：多终端模式

```
终端 1：Claude Code 交互
终端 2：Git 操作
终端 3：测试运行

适用场景：
- 复杂项目开发
- 需要同时监控多个任务
```

## 调试集成

### VS Code Launch Configuration

创建 `.vscode/launch.json`：

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Claude Code Debug",
      "program": "${workspaceFolder}/node_modules/.bin/claude",
      "args": ["code", "."],
      "console": "integratedTerminal"
    }
  ]
}
```

## 性能优化建议

### 1. 减少文件监听

```json
{
  "files.watcherExclude": {
    "**/node_modules/**": true,
    "**/dist/**": true,
    "**/.git/**": true,
    "**/coverage/**": true
  }
}
```

### 2. 禁用不必要的扩展

在 Claude Code 工作时，暂时禁用：
- 大型 linter 扩展
- 实时格式化扩展
- 自动补全扩展

### 3. 增加内存限制

```json
{
  "typescript.tsserver.maxTsServerMemory": 8192
}
```

## 实战案例

### 案例 1：VS Code + Claude Code 开发 Vue 组件

```
1. VS Code 打开项目
2. 创建新的分支：git checkout -b feature/user-profile
3. 打开终端：Ctrl+`
4. 运行：claude code .
5. 输入：创建用户个人资料组件，包括头像、昵称、简介
6. Claude 生成组件
7. 在 VS Code 中审查代码
8. 继续迭代：添加编辑功能
9. 运行测试：npm test
10. 提交代码：git add . && git commit
```

### 案例 2：IntelliJ IDEA + Claude Code 开发 Spring Boot API

```
1. IDEA 打开项目
2. Alt+F12 打开终端
3. 运行：claude code .
4. 输入：为 User 模块创建 REST API
5. Claude 生成 Controller、Service、Repository
6. IDEA 自动索引新文件
7. 使用 IDEA 的重构工具微调
8. 运行应用测试 API
9. 使用 Claude 生成测试用例
10. 提交代码
```

## 故障排查

### 问题 1：终端无法识别 claude 命令

**解决方案：**

```bash
# 检查 PATH
echo $PATH

# 重新加载配置
source ~/.bashrc  # 或 ~/.zshrc

# 重启 IDE
```

### 问题 2：文件修改不自动刷新

**VS Code 解决方案：**

```json
{
  "files.autoRefresh": true,
  "git.autoRefresh": true
}
```

**JetBrains 解决方案：**

```
File → Settings → Appearance & Behavior → System Settings
→ 启用 "Synchronize files on frame or editor tab activation"
```

### 问题 3：快捷键冲突

**查找并解决冲突：**

1. VS Code: `Ctrl+K Ctrl+S` 打开键盘快捷键设置
2. 搜索冲突的快捷键
3. 重新分配或禁用冲突的绑定

## 下一章

👉 **[第 19 章：历史会话管理](19-session-management.md)** - 找回和管理你的对话历史

---

**时间提示：** 本章阅读 10 分钟，配置 10 分钟 ⏱️
**难度：** ⭐⭐
