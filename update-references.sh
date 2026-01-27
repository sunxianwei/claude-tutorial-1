#!/bin/bash
# 批量更新文档引用脚本

cd /Users/sun/gitrepo/me/claude-tutorial-2

# 定义重命名映射
declare -A rename_map=(
    ["00-references.md"]="00-参考资料.md"
    ["00-basic-tutorial.md"]="00-基础篇导航.md"
    ["00-advanced-tutorial.md"]="00-进阶篇导航.md"
    ["01-quick-start.md"]="01-快速开始.md"
    ["02-installation.md"]="02-安装配置.md"
    ["03-mcp-setup.md"]="03-MCP配置指南.md"
    ["04-mcp-common.md"]="04-MCP常用集合.md"
    ["05-subagents.md"]="05-子代理使用.md"
    ["06-rules-file.md"]="06-规则文件系统.md"
    ["07-context-compression.md"]="07-上下文压缩.md"
    ["08-builtin-tools.md"]="08-内置工具列表.md"
    ["09-extend-ability.md"]="09-能力扩展.md"
    ["10-shortcuts.md"]="10-快捷键速查.md"
    ["11-new-project-workflow.md"]="11-新项目工作流.md"
    ["12-legacy-project-workflow.md"]="12-老项目迁移.md"
    ["13-best-practices.md"]="13-最佳实践.md"
    ["14-important-notice.md"]="14-重要说明.md"
    ["15-command-reference.md"]="15-命令参考.md"
    ["16-permissions.md"]="16-权限管理.md"
    ["17-custom-commands.md"]="17-自定义命令.md"
    ["18-ide-integration.md"]="18-IDE集成.md"
    ["19-session-management.md"]="19-会话管理.md"
    ["20-visualization-tools.md"]="20-可视化工具.md"
    ["21-legacy-project-guide.md"]="21-老项目开发指南.md"
    ["22-mcp-examples-verified.md"]="22-MCP配置实例.md"
    ["23-role-based-scenarios.md"]="23-按岗位场景.md"
    ["27-skills-guide.md"]="27-Skills指南.md"
    ["28-model-providers.md"]="28-模型切换.md"
)

# 需要更新的文件列表
files_to_update=(
    "README.md"
    "QUICK_START.md"
    "docs/README.md"
    "docs/00-参考资料.md"
    "docs/00-基础篇导航.md"
    "docs/00-进阶篇导航.md"
    "docs/01-快速开始.md"
    "docs/02-安装配置.md"
    "docs/03-MCP配置指南.md"
    "docs/04-MCP常用集合.md"
    "docs/05-子代理使用.md"
    "docs/06-规则文件系统.md"
    "docs/07-上下文压缩.md"
    "docs/08-内置工具列表.md"
    "docs/09-能力扩展.md"
    "docs/10-快捷键速查.md"
    "docs/11-新项目工作流.md"
    "docs/12-老项目迁移.md"
    "docs/13-最佳实践.md"
    "docs/14-重要说明.md"
    "docs/15-命令参考.md"
    "docs/16-权限管理.md"
    "docs/17-自定义命令.md"
    "docs/18-IDE集成.md"
    "docs/19-会话管理.md"
    "docs/20-可视化工具.md"
    "docs/21-老项目开发指南.md"
    "docs/22-MCP配置实例.md"
    "docs/23-按岗位场景.md"
    "docs/27-Skills指南.md"
    "docs/28-模型切换.md"
)

echo "开始更新文档引用..."

# 对每个文件进行替换
for file in "${files_to_update[@]}"; do
    if [ -f "$file" ]; then
        echo "处理: $file"
        # 对每个映射进行替换
        for old_name in "${!rename_map[@]}"; do
            new_name="${rename_map[$old_name]}"
            # 使用 sed 进行替换（macOS 兼容）
            sed -i '' "s|${old_name}|${new_name}|g" "$file" 2>/dev/null
        done
    fi
done

echo "✅ 更新完成！"
