#!/bin/bash

# Commit 消息生成工具
# 遵循约定式提交规范 (Conventional Commits)

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# 检查是否有待提交的更改
check_changes() {
    if ! git diff --cached --quiet; then
        echo -e "${GREEN}✅ 发现待提交的更改${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️  没有待提交的更改，请先使用 git add 添加文件${NC}"
        return 1
    fi
}

# 显示待提交的文件
show_staged_files() {
    echo -e "${BLUE}📁 待提交的文件：${NC}"
    git diff --cached --name-status | while read status file; do
        case $status in
            A) echo -e "  ${GREEN}新增${NC}: $file" ;;
            M) echo -e "  ${YELLOW}修改${NC}: $file" ;;
            D) echo -e "  ${RED}删除${NC}: $file" ;;
            R*) echo -e "  ${PURPLE}重命名${NC}: $file" ;;
            *) echo -e "  ${BLUE}其他${NC}: $file" ;;
        esac
    done
    echo ""
}

# 提交类型选择
select_commit_type() {
    echo -e "${BLUE}📋 选择提交类型：${NC}"
    echo "1.  feat     - 新功能"
    echo "2.  fix      - Bug 修复"
    echo "3.  docs     - 文档更新"
    echo "4.  style    - 代码格式化"
    echo "5.  refactor - 代码重构"
    echo "6.  perf     - 性能优化"
    echo "7.  test     - 测试相关"
    echo "8.  build    - 构建系统"
    echo "9.  ci       - CI/CD 相关"
    echo "10. chore    - 其他维护"
    echo "11. revert   - 回滚提交"
    echo "12. deps     - 依赖更新"
    echo "13. config   - 配置修改"
    echo "14. init     - 初始化项目"
    echo ""
    
    read -p "请选择提交类型 (1-14): " type_choice
    
    case $type_choice in
        1) echo "feat" ;;
        2) echo "fix" ;;
        3) echo "docs" ;;
        4) echo "style" ;;
        5) echo "refactor" ;;
        6) echo "perf" ;;
        7) echo "test" ;;
        8) echo "build" ;;
        9) echo "ci" ;;
        10) echo "chore" ;;
        11) echo "revert" ;;
        12) echo "deps" ;;
        13) echo "config" ;;
        14) echo "init" ;;
        *) echo "feat" ;;
    esac
}

# 作用域选择
select_scope() {
    echo -e "${BLUE}🎯 选择作用域（可选）：${NC}"
    echo "1. frontend  - 前端相关"
    echo "2. backend   - 后端相关"
    echo "3. ui        - 用户界面"
    echo "4. api       - API 相关"
    echo "5. auth      - 认证相关"
    echo "6. config    - 配置相关"
    echo "7. deps      - 依赖相关"
    echo "8. build     - 构建相关"
    echo "9. test      - 测试相关"
    echo "10. docs     - 文档相关"
    echo "11. 自定义   - 输入自定义作用域"
    echo "12. 跳过     - 不指定作用域"
    echo ""
    
    read -p "请选择作用域 (1-12): " scope_choice
    
    case $scope_choice in
        1) echo "frontend" ;;
        2) echo "backend" ;;
        3) echo "ui" ;;
        4) echo "api" ;;
        5) echo "auth" ;;
        6) echo "config" ;;
        7) echo "deps" ;;
        8) echo "build" ;;
        9) echo "test" ;;
        10) echo "docs" ;;
        11) read -p "请输入自定义作用域: " custom_scope; echo "$custom_scope" ;;
        12) echo "" ;;
        *) echo "" ;;
    esac
}

# 生成 commit 消息
generate_commit_message() {
    local commit_type=$1
    local scope=$2
    local description=$3
    local body=$4
    local breaking_change=$5
    local issues=$6
    
    # 构建主题行
    local subject="${commit_type}"
    if [ -n "$scope" ]; then
        subject="${subject}(${scope})"
    fi
    
    # 检查是否有破坏性变更
    if [ "$breaking_change" = "y" ]; then
        subject="${subject}!"
    fi
    
    subject="${subject}: ${description}"
    
    # 构建完整消息
    local commit_msg="$subject"
    
    if [ -n "$body" ]; then
        commit_msg="${commit_msg}\n\n${body}"
    fi
    
    if [ "$breaking_change" = "y" ]; then
        commit_msg="${commit_msg}\n\nBREAKING CHANGE: 这是一个破坏性变更"
    fi
    
    if [ -n "$issues" ]; then
        commit_msg="${commit_msg}\n\n关联问题: ${issues}"
    fi
    
    echo -e "$commit_msg"
}

# 依赖更新专用模板
deps_update_template() {
    echo -e "${BLUE}📦 依赖更新模板${NC}"
    echo "1. 安全更新"
    echo "2. 补丁更新"
    echo "3. 小版本更新"
    echo "4. 主版本更新"
    echo "5. 新增依赖"
    echo "6. 删除依赖"
    echo "7. 自定义"
    echo ""
    
    read -p "选择更新类型 (1-7): " update_type
    
    case $update_type in
        1) echo "deps: 修复安全漏洞" ;;
        2) echo "deps: 更新补丁版本依赖" ;;
        3) echo "deps: 更新小版本依赖" ;;
        4) echo "deps: 更新主版本依赖" ;;
        5) read -p "请输入新增的依赖名: " dep_name; echo "deps: 添加 ${dep_name}" ;;
        6) read -p "请输入删除的依赖名: " dep_name; echo "deps: 移除 ${dep_name}" ;;
        7) read -p "请输入自定义描述: " custom_desc; echo "deps: ${custom_desc}" ;;
        *) echo "deps: 更新依赖" ;;
    esac
}

# 主程序
main() {
    echo -e "${GREEN}🚀 Git Commit 消息生成工具${NC}"
    echo "=================================="
    echo ""
    
    # 检查是否有待提交的更改
    if ! check_changes; then
        exit 1
    fi
    
    # 显示待提交的文件
    show_staged_files
    
    # 选择提交类型
    commit_type=$(select_commit_type)
    
    # 如果是依赖更新，使用特殊模板
    if [ "$commit_type" = "deps" ]; then
        commit_message=$(deps_update_template)
        echo ""
        echo -e "${YELLOW}📝 生成的 commit 消息：${NC}"
        echo "$commit_message"
        echo ""
        read -p "确认提交吗？(y/N): " confirm
        if [[ $confirm == [yY] ]]; then
            git commit -m "$commit_message"
            echo -e "${GREEN}✅ 提交成功！${NC}"
        else
            echo -e "${YELLOW}❌ 已取消提交${NC}"
        fi
        return
    fi
    
    # 选择作用域
    scope=$(select_scope)
    
    # 输入描述
    echo ""
    read -p "请输入简短描述（必填）: " description
    
    if [ -z "$description" ]; then
        echo -e "${RED}❌ 描述不能为空${NC}"
        exit 1
    fi
    
    # 输入详细说明
    echo ""
    read -p "请输入详细说明（可选，按回车跳过）: " body
    
    # 询问是否有破坏性变更
    echo ""
    read -p "是否包含破坏性变更？(y/N): " breaking_change
    
    # 输入关联问题
    echo ""
    read -p "请输入关联的 Issue 编号（可选，格式: #123, #456）: " issues
    
    # 生成并显示 commit 消息
    echo ""
    echo -e "${YELLOW}📝 生成的 commit 消息：${NC}"
    commit_message=$(generate_commit_message "$commit_type" "$scope" "$description" "$body" "$breaking_change" "$issues")
    echo "=================================="
    echo -e "$commit_message"
    echo "=================================="
    echo ""
    
    # 确认提交
    read -p "确认提交吗？(y/N): " confirm
    if [[ $confirm == [yY] ]]; then
        git commit -m "$(echo -e "$commit_message")"
        echo -e "${GREEN}✅ 提交成功！${NC}"
    else
        echo -e "${YELLOW}❌ 已取消提交${NC}"
    fi
}

# 运行主程序
main
