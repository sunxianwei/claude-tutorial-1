#!/bin/bash

# 命令修复脚本 V2
# 更全面的批量修复

echo "🔧 开始第二轮修复..."
echo ""

FIXED_COUNT=0
FIXED_FILES=0

# 遍历所有 Markdown 文件
for file in docs/*.md; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    
    # 使用 Python 进行更精确的替换
    python3 << EOF
import re

filename = "$file"

with open(filename, 'r', encoding='utf-8') as f:
    content = f.read()

original_content = content

# 替换所有 claude-code 为 claude code（除了 npm install 和 package 名称）
# 1. 替换独立的 claude-code 命令
content = re.sub(r'claude-code(\s)', r'claude code\1', content)

# 2. 替换代码块中的 claude-code
content = re.sub(r'\bclaude-code\.', r'claude code .', content)

# 3. 替换反引号中的 claude-code
content = re.sub(r'\`claude-code\s', r'\`claude code ', content)

# 4. 不替换这些特殊情况
# - npm install 中的包名
# - @anthropic-ai/claude-code

if content != original_content:
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"✅ 修复: $filename")
EOF
    
    if [ $? -eq 0 ]; then
      FIXED_FILES=$((FIXED_FILES + 1))
    fi
  fi
done

echo ""
echo "✅ 第二轮修复完成！"
echo "📊 修复文件数: $FIXED_FILES"
echo ""
echo "运行检查脚本验证..."
bash check-commands.sh
