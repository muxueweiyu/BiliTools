#!/bin/bash

# BiliTools 更新日志管理脚本
# 用于管理项目依赖更新和生成更新日志

echo "📦 BiliTools 依赖更新日志管理器"
echo "=================================="

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 显示菜单
show_menu() {
    echo ""
    echo "请选择操作："
    echo "1. 检查可更新的包"
    echo "2. 生成更新前的快照"
    echo "3. 执行安全更新"
    echo "4. 执行补丁更新"
    echo "5. 执行小版本更新"
    echo "6. 查看更新日志"
    echo "7. 回滚到上一个版本"
    echo "8. 清理缓存"
    echo "9. 退出"
    echo ""
}

# 检查可更新的包
check_outdated() {
    echo -e "${BLUE}🔍 检查可更新的包...${NC}"
    pnpm outdated
    echo ""
    echo -e "${BLUE}🔒 检查安全漏洞...${NC}"
    pnpm audit
}

# 生成更新前快照
create_snapshot() {
    echo -e "${YELLOW}📸 生成更新前快照...${NC}"
    timestamp=$(date +"%Y%m%d_%H%M%S")
    
    # 备份 package.json 和 pnpm-lock.yaml
    cp package.json "package.json.backup_${timestamp}"
    cp pnpm-lock.yaml "pnpm-lock.yaml.backup_${timestamp}"
    
    # 生成当前依赖列表
    pnpm list --depth=0 > "dependencies_snapshot_${timestamp}.txt"
    
    echo -e "${GREEN}✅ 快照已保存:${NC}"
    echo "  - package.json.backup_${timestamp}"
    echo "  - pnpm-lock.yaml.backup_${timestamp}"
    echo "  - dependencies_snapshot_${timestamp}.txt"
}

# 执行安全更新
security_update() {
    echo -e "${RED}🔒 执行安全更新...${NC}"
    pnpm audit --fix
    echo -e "${GREEN}✅ 安全更新完成${NC}"
}

# 执行补丁更新
patch_update() {
    echo -e "${YELLOW}🔧 执行补丁更新...${NC}"
    pnpm update
    echo -e "${GREEN}✅ 补丁更新完成${NC}"
}

# 执行小版本更新
minor_update() {
    echo -e "${BLUE}🚀 执行小版本更新...${NC}"
    echo "⚠️  这可能包含破坏性变更，请确保已备份！"
    read -p "继续吗? (y/N): " confirm
    if [[ $confirm == [yY] ]]; then
        pnpm update --latest
        echo -e "${GREEN}✅ 小版本更新完成${NC}"
    else
        echo "已取消更新"
    fi
}

# 查看更新日志
view_changelog() {
    echo -e "${BLUE}📋 项目更新日志${NC}"
    if [ -f "CHANGELOG.md" ]; then
        head -50 CHANGELOG.md
    else
        echo "未找到 CHANGELOG.md 文件"
    fi
    
    echo ""
    echo -e "${BLUE}📋 最近的快照文件${NC}"
    ls -la *.backup_* dependencies_snapshot_* 2>/dev/null || echo "无备份文件"
}

# 回滚功能
rollback() {
    echo -e "${RED}🔄 回滚到上一个版本...${NC}"
    echo "可用的备份文件："
    ls -la *.backup_* 2>/dev/null || echo "无备份文件"
    
    read -p "输入要回滚的时间戳 (格式: YYYYMMDD_HHMMSS): " timestamp
    
    if [ -f "package.json.backup_${timestamp}" ] && [ -f "pnpm-lock.yaml.backup_${timestamp}" ]; then
        cp "package.json.backup_${timestamp}" package.json
        cp "pnpm-lock.yaml.backup_${timestamp}" pnpm-lock.yaml
        pnpm install
        echo -e "${GREEN}✅ 回滚完成${NC}"
    else
        echo -e "${RED}❌ 备份文件不存在${NC}"
    fi
}

# 清理缓存
clean_cache() {
    echo -e "${YELLOW}🧹 清理缓存...${NC}"
    pnpm store prune
    echo -e "${GREEN}✅ 缓存清理完成${NC}"
}

# 主循环
main() {
    while true; do
        show_menu
        read -p "选择操作 (1-9): " choice
        
        case $choice in
            1) check_outdated ;;
            2) create_snapshot ;;
            3) security_update ;;
            4) patch_update ;;
            5) minor_update ;;
            6) view_changelog ;;
            7) rollback ;;
            8) clean_cache ;;
            9) echo "👋 再见！"; exit 0 ;;
            *) echo -e "${RED}❌ 无效选择${NC}" ;;
        esac
        
        echo ""
        read -p "按回车键继续..."
    done
}

# 运行主程序
main
