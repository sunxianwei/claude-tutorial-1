# 15 - 命令参考：Claude Code 常用命令大全

## 基本命令

### 交互模式（默认）

```bash
# 进入交互式对话模式
claude code .

# 或使用简写
claude .
```

这是最常用的方式，进入后可以与 Claude 持续对话，直到你主动退出。

### 一次性命令（非交互模式）

**用途：** 执行单个任务后立即退出，不需要进入交互模式。

```bash
# 基本语法
claude -p "你的问题或任务"

# 或使用完整命令
claude code -p "你的问题或任务"
```

**使用场景：**

```bash
# 快速查询
claude -p "这个项目的技术栈是什么？"

# 代码审查
claude -p "审查 src/auth/login.ts 的安全性"

# 生成文档
claude -p "为 UserService 生成 API 文档"

# 运行测试
claude -p "运行单元测试并修复失败的测试"

# 快速修复
claude -p "修复 ESLint 报告的所有错误"
```

**优势：**
- ⚡ 快速执行单个任务
- 🔄 可以集成到 CI/CD 脚本
- 📝 适合自动化场景
- 💰 节省 token（不需要维护长对话上下文）

**实战示例：**

```bash
# 在 CI 中使用
#!/bin/bash
echo "🔍 自动代码审查..."
claude -p "审查最近的提交，检查代码规范和潜在问题" > review-report.md

# 批量处理
for file in src/**/*.ts; do
  claude -p "为 $file 添加 JSDoc 注释"
done

# 定时任务
crontab -e
# 每天早上 9 点生成日报
0 9 * * * cd /project && claude -p "生成昨天的工作日报"
```

## 会话管理命令

### resume - 恢复会话

**用途：** 恢复之前的对话会话

```bash
# 在交互模式中使用
/resume

# 查看可恢复的会话列表
/resume list

# 按时间恢复（恢复最近的会话）
/resume

# 按会话 ID 恢复
/resume <session-id>
```

**使用场景：**

```bash
# 场景 1：意外退出后恢复
$ claude code .
> 帮我实现用户登录功能
[进行中...突然断网或退出]

# 重新打开 Claude Code
$ claude code .
> /resume
[自动恢复之前的会话和上下文]
```

**会话列表示例：**

```bash
> /resume list

可用会话：
1. 2025-10-20 14:30 - 用户登录功能开发 (45 条消息)
2. 2025-10-20 10:15 - API 文档生成 (23 条消息)
3. 2025-10-19 16:45 - 性能优化 (67 条消息)

使用 /resume <number> 恢复特定会话
```

### export - 导出会话

**用途：** 导出对话历史为文件

```bash
# 导出当前会话
/export

# 导出为 markdown 格式
/export markdown

# 导出为 JSON 格式
/export json

# 导出到指定文件
/export output.md
```

**使用场景：**

```bash
# 保存工作记录
/export work-log-2025-10-20.md

# 分享给团队
/export feature-discussion.md

# 归档重要会话
/export archive/user-auth-implementation.json
```

**导出内容包括：**
- 💬 完整对话历史
- 📝 生成的代码
- 🔧 执行的命令
- 📊 修改的文件
- ⏱️ 时间戳

## 项目初始化命令

### init - 初始化项目

```bash
# 初始化 Claude Code 配置
claude code init

# 初始化并指定模板
claude code init --template=frontend

# 初始化并跳过交互式问答
claude code init --yes
```

**创建的文件：**

```
项目根目录/
├── .claude/
│   ├── config.json       # Claude Code 配置
│   └── mcp-servers.json  # MCP 服务器配置
├── CLAUDE.md             # 项目规范文件
└── .claudeignore         # 忽略文件列表
```

## 调试和诊断命令

### 版本信息

```bash
# 查看 Claude Code 版本
claude --version
claude -v

# 查看详细版本信息
claude code --version --verbose
```

### 配置检查

```bash
# 检查配置文件
claude code --check-config

# 验证 API 密钥
claude code --check-api-key

# 检查 MCP 服务器状态
claude code --check-mcp
```

### 调试模式

```bash
# 启用详细日志
claude code --debug .

# 启用 MCP 调试
claude code --debug-mcp .

# 查看完整的请求/响应
claude code --verbose .
```

## 高级命令选项

### 模型选择

```bash
# 使用特定模型
claude code --model=claude-opus-4 .

# 使用最新的 Sonnet 模型
claude code --model=claude-sonnet-4-5 .

# 使用快速模型（成本优化）
claude code --model=claude-haiku-4-5 .
```

### 上下文控制

```bash
# 限制上下文窗口大小
claude code --max-tokens=50000 .

# 禁用自动上下文压缩
claude code --no-context-compression .

# 只包含特定文件
claude code --files="src/**/*.ts" .
```

### 输出控制

```bash
# 静默模式（减少输出）
claude code --quiet .

# 仅输出结果（用于脚本）
claude code --output-only .

# JSON 格式输出
claude code --output=json .
```

## 别名和快捷方式

### 创建命令别名

在 `~/.bashrc` 或 `~/.zshrc` 中添加：

```bash
# 快捷命令
alias cc='claude code'
alias ccp='claude code -p'
alias cci='claude code init'

# 常用任务
alias cc-review='claude code -p "代码审查"'
alias cc-test='claude code -p "运行测试并修复失败的用例"'
alias cc-doc='claude code -p "生成 API 文档"'
alias cc-fix='claude code -p "修复所有 lint 错误"'
```

**使用示例：**

```bash
# 使用别名
cc .                           # 等同于 claude code .
ccp "生成登录功能"              # 等同于 claude code -p "生成登录功能"
cc-review                      # 快速代码审查
```

## 环境变量

### API 密钥配置

```bash
# 设置 API 密钥
export ANTHROPIC_API_KEY="your-key-here"

# 在 ~/.bashrc 或 ~/.zshrc 中永久设置
echo 'export ANTHROPIC_API_KEY="your-key-here"' >> ~/.bashrc
source ~/.bashrc
```

### 代理配置

```bash
# HTTP 代理
export HTTP_PROXY="http://proxy.company.com:8080"
export HTTPS_PROXY="http://proxy.company.com:8080"

# SOCKS5 代理
export ALL_PROXY="socks5://127.0.0.1:1080"
```

### 自定义配置路径

```bash
# 使用自定义配置目录
export CLAUDE_CONFIG_DIR="$HOME/.config/claude"

# 使用自定义规则文件
export CLAUDE_RULES_FILE="./custom-rules.md"
```

## 脚本集成

### Bash 脚本示例

```bash
#!/bin/bash
# auto-review.sh - 自动代码审查脚本

PROJECT_PATH=$1

if [ -z "$PROJECT_PATH" ]; then
  echo "用法: ./auto-review.sh <项目路径>"
  exit 1
fi

cd "$PROJECT_PATH" || exit

echo "🔍 开始自动代码审查..."
claude code -p "审查所有修改的文件，检查：
1. 代码规范
2. 潜在 bug
3. 性能问题
4. 安全漏洞
生成详细的审查报告" > code-review-report.md

echo "✅ 审查完成！报告已保存到 code-review-report.md"
```

### Python 脚本示例

```python
#!/usr/bin/env python3
# auto_commit.py - 智能提交脚本

import subprocess
import sys

def run_command(cmd):
    """执行命令并返回输出"""
    result = subprocess.run(
        cmd,
        shell=True,
        capture_output=True,
        text=True
    )
    return result.stdout, result.stderr, result.returncode

def main():
    print("🤖 使用 Claude Code 生成提交信息...")

    # 使用 Claude Code 分析变更
    cmd = 'claude code -p "分析 git diff，生成符合 Conventional Commits 规范的提交信息"'
    output, error, code = run_command(cmd)

    if code != 0:
        print(f"❌ 错误: {error}")
        sys.exit(1)

    commit_msg = output.strip()
    print(f"📝 提交信息:\n{commit_msg}\n")

    # 确认提交
    confirm = input("确认提交? (y/N): ")
    if confirm.lower() == 'y':
        run_command(f'git commit -m "{commit_msg}"')
        print("✅ 提交成功!")
    else:
        print("❌ 已取消")

if __name__ == "__main__":
    main()
```

### Make 集成

```makefile
# Makefile

.PHONY: claude-review claude-test claude-doc

# 代码审查
claude-review:
	@echo "🔍 开始代码审查..."
	@claude code -p "代码审查" > review-report.md
	@echo "✅ 完成！查看 review-report.md"

# 运行测试
claude-test:
	@echo "🧪 运行测试..."
	@claude code -p "运行所有测试并修复失败的用例"

# 生成文档
claude-doc:
	@echo "📚 生成文档..."
	@claude code -p "为所有公共 API 生成文档"

# 一键完整流程
claude-ci: claude-review claude-test claude-doc
	@echo "✅ CI 流程完成"
```

**使用方式：**

```bash
make claude-review    # 代码审查
make claude-test      # 运行测试
make claude-doc       # 生成文档
make claude-ci        # 完整 CI 流程
```

## 性能优化技巧

### 1. 使用 .claudeignore

```bash
# .claudeignore
node_modules/
dist/
build/
*.log
.git/
coverage/
```

### 2. 限制文件范围

```bash
# 只分析特定目录
claude code --files="src/**/*.ts" .

# 排除测试文件
claude code --exclude="**/*.test.ts" .
```

### 3. 上下文压缩

```bash
# 启用智能上下文压缩（默认）
claude code .

# 手动控制压缩级别
claude code --compression-level=high .
```

## 常见问题排查

### 问题 1：命令找不到

```bash
# 检查安装
npm list -g @anthropic-ai/claude-code

# 重新安装
npm install -g @anthropic-ai/claude-code

# 检查 PATH
echo $PATH
npm config get prefix
```

### 问题 2：API 密钥无效

```bash
# 验证密钥
claude code --check-api-key

# 重新设置
export ANTHROPIC_API_KEY="your-new-key"

# 永久保存
echo 'export ANTHROPIC_API_KEY="your-key"' >> ~/.bashrc
```

### 问题 3：会话恢复失败

```bash
# 清理过期会话
rm -rf ~/.claude/sessions/*.old

# 查看会话文件
ls -la ~/.claude/sessions/

# 手动恢复
claude code --resume-session=<session-id>
```

## 下一章

👉 **[第 16 章：自定义命令和 Hook](16-custom-commands.md)** - 扩展 Claude Code 的能力

---

**时间提示：** 本章阅读 10 分钟，实践 15 分钟 ⏱️
**难度：** ⭐⭐
