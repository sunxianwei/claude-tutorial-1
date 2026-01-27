#!/bin/bash

# 命令修复脚本
# 批量修复 docs/ 目录下所有文档中的错误命令

echo "🔧 开始修复 docs/ 目录下的所有命令错误..."
echo ""

# 备份目录
BACKUP_DIR="docs_backup_$(date '+%Y%m%d_%H%M%S')"
echo "📦 创建备份目录: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
cp -r docs/* "$BACKUP_DIR/"
echo "✅ 备份完成"
echo ""

FIXED_COUNT=0
FIXED_FILES=0

# 遍历所有 Markdown 文件
for file in docs/*.md; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    
    # 计算文件中的错误数量
    file_errors=$(grep -c "claude-code" "$file" | grep -v "npm install" | grep -v "@anthropic-ai/claude-code" || echo "0")
    
    if [ "$file_errors" != "0" ]; then
      echo "修复: $filename ($file_errors 处错误)"
      
      # 使用 sed 批量替换（macOS 版本）
      # 替换 claude-code 为 claude code（排除特殊情况）
      sed -i '' \
        -e 's/\`claude-code \./`claude code ./g' \
        -e 's/\`claude-code init\`/`claude code init`/g' \
        -e 's/\`claude-code --version\`/`claude code --version`/g' \
        -e 's/\`claude-code --show-rules\`/`claude code --show-rules`/g' \
        -e 's/\`claude-code --debug\`/`claude code --debug`/g' \
        -e 's/\`claude-code --create-template\`/`claude code --create-template`/g' \
        -e 's/^\(claude-code \.\)/claude code ./g' \
        -e 's/^\(claude-code init\)/claude code init/g' \
        -e 's/^\(claude-code --\)/claude code --/g' \
        -e 's/\s\(claude-code \.\)/ claude code ./g' \
        -e 's/\s\(claude-code init\)/ claude code init/g' \
        -e 's/\s\(claude-code --\)/ claude code --/g' \
        "$file"
      
      # 统计修复数量
      FIXED_FILES=$((FIXED_FILES + 1))
      FIXED_COUNT=$((FIXED_COUNT + file_errors))
    fi
  fi
done

echo ""
echo "✅ 修复完成！"
echo "📊 统计："
echo "   - 修复文件数: $FIXED_FILES"
echo "   - 修复错误数: 约 $FIXED_COUNT 处"
echo ""
echo "📦 备份位置: $BACKUP_DIR"
echo ""
echo "⚠️  注意：以下命令可能需要人工确认:"
echo "   - claude code --show-rules"
echo "   - claude code --debug"
echo "   - claude code --create-template"
echo ""
echo "建议运行 ./check-commands.sh 重新检查"
