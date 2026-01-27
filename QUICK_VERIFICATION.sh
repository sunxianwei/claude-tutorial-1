#!/bin/bash

# 快速验证脚本
echo "🔍 快速验证教程文档..."
echo ""

# 测试 1：命令格式
echo "1️⃣ 检查命令格式..."
BAD_CMD=$(grep -r "claude-code " docs/*.md | grep -v "@anthropic" | grep -v "feature/" | grep -v "command not found" | grep -v "docs/claude-code" | wc -l | tr -d ' ')
if [ "$BAD_CMD" -eq "0" ]; then
    echo "   ✅ 命令格式正确（无 claude-code）"
else
    echo "   ❌ 发现 $BAD_CMD 处错误的 claude-code"
fi

# 测试 2：包名格式
echo "2️⃣ 检查包名格式..."
BAD_PKG=$(grep -r "@anthropic-ai/claude code" docs/*.md *.md 2>/dev/null | wc -l | tr -d ' ')
if [ "$BAD_PKG" -eq "0" ]; then
    echo "   ✅ 包名格式正确"
else
    echo "   ❌ 发现 $BAD_PKG 处错误的包名"
fi

# 测试 3：命令可用性
echo "3️⃣ 检查命令可用性..."
if command -v claude &> /dev/null; then
    echo "   ✅ claude 命令可用"
    echo "   📍 位置: $(which claude)"
else
    echo "   ⚠️  claude 命令未安装"
fi

# 测试 4：文档完整性
echo "4️⃣ 检查文档完整性..."
DOC_COUNT=$(ls docs/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "   ✅ 文档总数: $DOC_COUNT 个"

echo ""
echo "✅ 验证完成！"
