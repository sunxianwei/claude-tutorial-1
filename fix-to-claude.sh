#!/bin/bash

# 将所有 "claude code" 改为 "claude"（除了包名）
# 最终修复脚本

echo "🔧 修复命令格式：claude code → claude"
echo ""

FIXED_COUNT=0

for file in docs/*.md QUICK_START.md MIGRATION_GUIDE_V2.md COMMAND_CHEATSHEET.md; do
  if [ -f "$file" ]; then
    echo "处理: $file"
    
    python3 << EOF
import re

filename = "$file"

with open(filename, 'r', encoding='utf-8') as f:
    content = f.read()

original_content = content

# 1. 替换命令中的 "claude code" 为 "claude"
# 但保留包名 @anthropic-ai/claude-code

# 替换 claude code 命令（但不替换包名）
content = re.sub(r'claude code\s+\.', r'claude .', content)
content = re.sub(r'claude code\s+init', r'claude init', content)
content = re.sub(r'claude code\s+--', r'claude --', content)
content = re.sub(r'claude code\s+-', r'claude -', content)

# 替换反引号中的
content = re.sub(r'\`claude code\s+', r'\`claude ', content)

# 替换句子开头的
content = re.sub(r'^claude code\s+', r'claude ', content, flags=re.MULTILINE)

# 替换行中的（前面有空格）
content = re.sub(r'(\s+)claude code\s+', r'\1claude ', content)

# 特殊：Claude Code（大写 C，作为产品名）保持不变
# 只修复命令

if content != original_content:
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"✅ 已修复")
else:
    print(f"⏭️  无需修改")
EOF
    
  fi
done

echo ""
echo "✅ 批量修复完成"
echo ""
echo "验证修复结果..."
echo ""

# 检查常见命令格式
echo "检查修复后的命令格式："
grep -h "^claude " docs/*.md | head -5
echo ""
grep -h "\`claude " docs/*.md | head -5

echo ""
echo "⚠️  注意：产品名称 'Claude Code' 保持大写不变"
