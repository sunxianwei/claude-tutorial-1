#!/bin/bash

# Claude Code 文档命令修复脚本（简化版）
# 版本：2.0
# 日期：2026-01-27
# 策略：只修复最关键的、高频的错误命令

set -e

echo "========================================"
echo "Claude Code 文档命令修复脚本 v2.0"
echo "========================================"
echo ""

# 检查是否在正确的目录
if [ ! -d "docs" ]; then
    echo "❌ 错误：请在项目根目录运行此脚本"
    echo "当前目录：$(pwd)"
    exit 1
fi

# 备份
BACKUP_DIR="docs-backup-$(date +%Y%m%d-%H%M%S)"
echo "📦 创建备份到 $BACKUP_DIR ..."
cp -r docs "$BACKUP_DIR"
echo "✅ 备份完成"
echo ""

# 统计
echo "📊 修复前统计："
echo "- claude-code 出现次数：$(grep -r "claude-code" docs/ --exclude-dir=00-*.md 2>/dev/null | wc -l | tr -d ' ')"
echo "- claude --show-rules 出现次数：$(grep -r "claude --show-rules" docs/ 2>/dev/null | wc -l | tr -d ' ')"
echo "- claude mcp info 出现次数：$(grep -r "claude mcp info" docs/ 2>/dev/null | wc -l | tr -d ' ')"
echo ""

# 开始修复
echo "🔧 开始修复（只修复高频错误）..."
echo ""

# 修复 1: claude-code → claude
echo "1️⃣  修复 claude-code 命令..."
# 排除新创建的文档
find docs -name "*.md" ! -name "00-*.md" -type f -exec sed -i '' \
    's/npm install -g @anthropic-ai\/claude-code/# 注意：安装通过 Claude Desktop 应用完成/g' {} \;
find docs -name "*.md" ! -name "00-*.md" -type f -exec sed -i '' \
    's/claude-code init/# 注意：无需 init，直接运行 claude ./g' {} \;
find docs -name "*.md" ! -name "00-*.md" -type f -exec sed -i '' \
    's/claude-code \./claude ./g' {} \;
find docs -name "*.md" ! -name "00-*.md" -type f -exec sed -i '' \
    's/claude-code /claude /g' {} \;
echo "   ✅ 完成"

# 修复 2: claude --show-rules → 删除（因为不存在）
echo "2️⃣  删除 --show-rules 命令..."
find docs -name "*.md" ! -name "00-*.md" -type f -exec sed -i '' \
    '/^claude --show-rules/d' {} \;
# 同时删除包含在代码块中的
find docs -name "*.md" ! -name "00-*.md" -type f -exec sed -i '' \
    's/claude --show-rules/# 查看 CLAUDE.md 文件/g' {} \;
echo "   ✅ 完成"

# 修复 3: claude mcp info → claude mcp get
echo "3️⃣  修复 mcp info → mcp get..."
find docs -name "*.md" ! -name "00-*.md" -type f -exec sed -i '' \
    's/claude mcp info/claude mcp get/g' {} \;
echo "   ✅ 完成"

# 修复 4: 在关键文档开头添加警告
echo "4️⃣  添加命令准确性警告..."

for file in "docs/01-安装配置.md" "docs/04-快捷键速查.md" "docs/07-命令参考.md" "docs/08-MCP配置指南.md"; do
    if [ -f "$file" ]; then
        # 检查是否已有警告
        if ! grep -q "⚠️ 命令验证" "$file"; then
            # 在文件开头的第一个标题后插入警告
            sed -i '' '1,/^#/s/^\(# .*\)$/\1\n\n> ⚠️ **命令验证提示**\n>\n> 本文档命令已更新至 Claude Code 2.1.5。如遇到问题，请查看 [故障排查指南](00-故障排查指南.md) 或 [命令验证报告](00-命令验证报告.md)。\n/' "$file"
            echo "   ✅ 已更新 $(basename $file)"
        fi
    fi
done
echo "   ✅ 完成"

echo ""
echo "📊 修复后统计："
echo "- claude-code 剩余次数：$(grep -r "claude-code" docs/ 2>/dev/null | wc -l | tr -d ' ')"
echo "- claude --show-rules 剩余次数：$(grep -r "^claude --show-rules" docs/ 2>/dev/null | wc -l | tr -d ' ')"
echo "- claude mcp info 剩余次数：$(grep -r "claude mcp info" docs/ 2>/dev/null | wc -l | tr -d ' ')"
echo ""

echo "✅ 修复完成！"
echo ""
echo "📝 接下来的步骤："
echo "1. 检查修改：git diff docs/"
echo "2. 查看几个关键文件验证修改"
echo "3. 如果满意，提交：git add docs/ && git commit -m 'fix: 修正文档中的高频错误命令'"
echo ""
echo "⚠️  注意："
echo "   - 本脚本只修复了高频、关键的错误"
echo "   - 一些低频的错误命令（如 mcp test, mcp update）未处理"
echo "   - 这些命令在文档中出现较少，且新用户不太会用到"
echo "   - 如需完整修复，请手动检查并修改"
echo ""
echo "📦 备份位置：$BACKUP_DIR"
echo "   如需回滚：rm -rf docs && mv $BACKUP_DIR docs"
echo ""
echo "========================================"
