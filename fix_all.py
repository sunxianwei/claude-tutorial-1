#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import re

base_dir = "/Users/sun/gitrepo/me/claude-tutorial-2"

# 收集所有 .md 文件
md_files = []
for root, dirs, files in os.walk(base_dir):
    # 跳过备份目录
    if 'backup' in root or '.git' in root or '.specstory' in root:
        continue
    for f in files:
        if f.endswith('.md'):
            md_files.append(os.path.join(root, f))

print(f"找到 {len(md_files)} 个 Markdown 文件")

# 修复规则
fixes = []

# 1. 更新"14-重要说明"引用
fixes.append(("14-重要说明.md", "00-重要说明-必读.md"))
fixes.append(("14-重要说明", "00-重要说明-必读"))

# 2. 删除 claude init 相关内容
claude_init_replacements = [
    # 完整的 claude init 命令行
    (r"```bash\s*\n.*?claude init.*?\n.*?```", 
     "⚠️ **注意：** Claude Code 没有 `init` 命令。请手动创建 `.claude/` 目录和 `CLAUDE.md` 文件。\n\n```bash\n# 正确的初始化方式\nmkdir -p .claude\ntouch CLAUDE.md\n```"),
    
    # 单独的 claude init 命令
    ("claude init", ""),
    
    # 带参数的 claude init
    (r"claude init --\w+[^\n]*", ""),
]

update_count = 0
error_count = 0

for file_path in md_files:
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # 应用所有修复规则
        for old_text, new_text in fixes:
            content = content.replace(old_text, new_text)
        
        # 删除 claude init 相关内容（更复杂的处理）
        # 删除包含 claude init 的整行
        lines = content.split('\n')
        new_lines = []
        skip_next = False
        
        for i, line in enumerate(lines):
            # 如果这一行包含 claude init
            if 'claude init' in line:
                # 检查是否在代码块中
                if '```' not in line and not line.strip().startswith('#'):
                    # 跳过这一行
                    continue
                # 如果在代码块中，替换为注释说明
                elif line.strip().startswith('claude init'):
                    new_lines.append('# ⚠️ 注意：Claude Code 没有 init 命令')
                    new_lines.append('# 正确的初始化方式：')
                    new_lines.append('mkdir -p .claude')
                    new_lines.append('touch CLAUDE.md')
                    continue
            
            new_lines.append(line)
        
        content = '\n'.join(new_lines)
        
        # 如果内容有变化，写回文件
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"✅ 更新: {os.path.relpath(file_path, base_dir)}")
            update_count += 1
        
    except Exception as e:
        print(f"❌ 错误: {os.path.relpath(file_path, base_dir)} - {e}")
        error_count += 1

print(f"\n✅ 完成！")
print(f"   更新文件: {update_count}")
print(f"   错误: {error_count}")
