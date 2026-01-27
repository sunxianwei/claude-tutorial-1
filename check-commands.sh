#!/bin/bash

# 命令检查脚本
# 用于验证 docs/ 目录下所有教程中的命令是否正确

echo "🔍 开始检查 docs/ 目录下的所有命令..."
echo ""

# 创建临时文件存储结果
REPORT_FILE="COMMAND_CHECK_REPORT.md"
echo "# Claude Code 教程命令检查报告" > $REPORT_FILE
echo "" >> $REPORT_FILE
echo "> 检查日期：$(date '+%Y-%m-%d %H:%M:%S')" >> $REPORT_FILE
echo "" >> $REPORT_FILE

# 统计变量
TOTAL_FILES=0
TOTAL_ERRORS=0
TOTAL_WARNINGS=0

# 定义正确的命令模式
CORRECT_COMMANDS=(
  "claude code ."
  "claude code init"
  "claude code --version"
  "claude --version"
  "claude -v"
  "claude -p"
  "claude mcp list"
  "claude mcp add"
  "claude mcp remove"
  "claude mcp info"
  "claude mcp test"
  "claude mcp logs"
  "claude mcp restart"
  "claude mcp update"
  "claude mcp enable"
  "claude mcp disable"
)

# 定义错误的命令模式
WRONG_COMMANDS=(
  "claude-code "
  "claude-code."
  "claude-code init"
  "claude-code --"
)

echo "## 检查统计" >> $REPORT_FILE
echo "" >> $REPORT_FILE

# 遍历所有 Markdown 文件
for file in docs/*.md; do
  if [ -f "$file" ]; then
    TOTAL_FILES=$((TOTAL_FILES + 1))
    filename=$(basename "$file")
    
    echo "检查: $filename"
    
    # 检查错误命令
    file_has_errors=0
    file_errors=""
    
    # 检查 claude-code（错误的连字符形式）
    if grep -n "claude-code" "$file" | grep -v "^#" | grep -v "npm install" | grep -v "@anthropic-ai/claude-code" > /dev/null; then
      matches=$(grep -n "claude-code" "$file" | grep -v "^#" | grep -v "npm install" | grep -v "@anthropic-ai/claude-code")
      while IFS= read -r line; do
        line_num=$(echo "$line" | cut -d: -f1)
        file_errors="${file_errors}\n  - 行 $line_num: 使用了 \`claude-code\`（应为 \`claude code\`）"
        file_has_errors=1
        TOTAL_ERRORS=$((TOTAL_ERRORS + 1))
      done <<< "$matches"
    fi
    
    # 检查可疑的命令（需要人工确认）
    if grep -n "claude code --show-rules" "$file" > /dev/null; then
      matches=$(grep -n "claude code --show-rules" "$file")
      while IFS= read -r line; do
        line_num=$(echo "$line" | cut -d: -f1)
        file_errors="${file_errors}\n  - 行 $line_num: ⚠️ 需要确认: \`claude code --show-rules\` 命令是否存在"
        TOTAL_WARNINGS=$((TOTAL_WARNINGS + 1))
      done <<< "$matches"
    fi
    
    if grep -n "claude code --debug" "$file" > /dev/null; then
      matches=$(grep -n "claude code --debug" "$file")
      while IFS= read -r line; do
        line_num=$(echo "$line" | cut -d: -f1)
        file_errors="${file_errors}\n  - 行 $line_num: ⚠️ 需要确认: \`claude code --debug\` 命令是否存在"
        TOTAL_WARNINGS=$((TOTAL_WARNINGS + 1))
      done <<< "$matches"
    fi
    
    if grep -n "claude code --create-template" "$file" > /dev/null; then
      matches=$(grep -n "claude code --create-template" "$file")
      while IFS= read -r line; do
        line_num=$(echo "$line" | cut -d: -f1)
        file_errors="${file_errors}\n  - 行 $line_num: ⚠️ 需要确认: \`claude code --create-template\` 命令是否存在"
        TOTAL_WARNINGS=$((TOTAL_WARNINGS + 1))
      done <<< "$matches"
    fi
    
    # 如果有错误，添加到报告
    if [ $file_has_errors -eq 1 ]; then
      echo "" >> $REPORT_FILE
      echo "### ❌ $filename" >> $REPORT_FILE
      echo -e "$file_errors" >> $REPORT_FILE
      echo "" >> $REPORT_FILE
    fi
  fi
done

# 写入统计信息
sed -i '' "5i\\
| 项目 | 数量 |\\
|------|------|\\
| 检查文件数 | $TOTAL_FILES |\\
| 发现错误 | $TOTAL_ERRORS |\\
| 需要确认 | $TOTAL_WARNINGS |\\
\\
" $REPORT_FILE

echo ""
echo "✅ 检查完成！"
echo "📊 统计："
echo "   - 检查文件数: $TOTAL_FILES"
echo "   - 发现错误: $TOTAL_ERRORS"
echo "   - 需要确认: $TOTAL_WARNINGS"
echo ""
echo "📝 详细报告已生成: $REPORT_FILE"
