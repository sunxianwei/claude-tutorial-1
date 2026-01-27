#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import re

# 重命名映射
rename_map = {
    "00-references.md": "00-参考资料.md",
    "00-basic-tutorial.md": "00-基础篇导航.md",
    "00-advanced-tutorial.md": "00-进阶篇导航.md",
    "01-quick-start.md": "01-快速开始.md",
    "02-installation.md": "02-安装配置.md",
    "03-mcp-setup.md": "03-MCP配置指南.md",
    "04-mcp-common.md": "04-MCP常用集合.md",
    "05-subagents.md": "05-子代理使用.md",
    "06-rules-file.md": "06-规则文件系统.md",
    "07-context-compression.md": "07-上下文压缩.md",
    "08-builtin-tools.md": "08-内置工具列表.md",
    "09-extend-ability.md": "09-能力扩展.md",
    "10-shortcuts.md": "10-快捷键速查.md",
    "11-new-project-workflow.md": "11-新项目工作流.md",
    "12-legacy-project-workflow.md": "12-老项目迁移.md",
    "13-best-practices.md": "13-最佳实践.md",
    "14-important-notice.md": "14-重要说明.md",
    "15-command-reference.md": "15-命令参考.md",
    "16-permissions.md": "16-权限管理.md",
    "17-custom-commands.md": "17-自定义命令.md",
    "18-ide-integration.md": "18-IDE集成.md",
    "19-session-management.md": "19-会话管理.md",
    "20-visualization-tools.md": "20-可视化工具.md",
    "21-legacy-project-guide.md": "21-老项目开发指南.md",
    "22-mcp-examples-verified.md": "22-MCP配置实例.md",
    "23-role-based-scenarios.md": "23-按岗位场景.md",
    "27-skills-guide.md": "27-Skills指南.md",
    "28-model-providers.md": "28-模型切换.md",
}

base_dir = "/Users/sun/gitrepo/me/claude-tutorial-2"

# 需要更新的文件
files_to_update = [
    "README.md",
    "QUICK_START.md",
]

# 添加 docs 目录下的所有 md 文件
docs_dir = os.path.join(base_dir, "docs")
if os.path.exists(docs_dir):
    for f in os.listdir(docs_dir):
        if f.endswith(".md"):
            files_to_update.append(os.path.join("docs", f))

print("开始更新文档引用...")
update_count = 0

for file_path in files_to_update:
    full_path = os.path.join(base_dir, file_path)
    if not os.path.exists(full_path):
        continue
    
    try:
        with open(full_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # 替换所有旧文件名
        for old_name, new_name in rename_map.items():
            content = content.replace(old_name, new_name)
        
        # 如果内容有变化，写回文件
        if content != original_content:
            with open(full_path, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"✅ 更新: {file_path}")
            update_count += 1
        else:
            print(f"⏭️  跳过: {file_path} (无需更新)")
            
    except Exception as e:
        print(f"❌ 错误: {file_path} - {e}")

print(f"\n✅ 完成！共更新 {update_count} 个文件")
