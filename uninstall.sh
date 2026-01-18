#!/bin/bash

################################################################################
# HAP Skills Collection - Uninstallation Script
# 卸载脚本
################################################################################

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_header() { echo -e "\n${BLUE}═══${NC} $1 ${BLUE}═══${NC}\n"; }

# 显示使用说明
show_usage() {
    cat << EOF
HAP Skills Collection - 卸载脚本

使用方法:
  ./uninstall.sh [选项]

选项:
  --all             从所有平台卸载
  --global          卸载全局安装
  --project         卸载项目级安装
  --claude          只从 Claude Code 卸载
  --cursor          只从 Cursor 卸载
  --trae            只从 TRAE 卸载
  --help            显示此帮助信息

示例:
  ./uninstall.sh --all --global    # 从所有平台卸载全局安装

EOF
}

# 删除目录
remove_dir() {
    local dir="$1"
    local platform="$2"

    if [ -d "$dir" ]; then
        print_warning "删除 $platform: $dir"
        rm -rf "$dir"
        print_success "$platform: 已卸载"
    else
        print_info "$platform: 未安装,跳过"
    fi
}

# 删除软链接
remove_symlink() {
    local link="$1"
    local platform="$2"

    if [ -L "$link" ]; then
        print_warning "删除软链接 $platform: $link"
        rm "$link"
        print_success "$platform: 软链接已删除"
    elif [ -d "$link" ]; then
        print_warning "$platform: 是目录而非软链接,是否删除? (y/N)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            rm -rf "$link"
            print_success "$platform: 已删除"
        fi
    else
        print_info "$platform: 未安装,跳过"
    fi
}

# 卸载 Claude Code
uninstall_claude() {
    local scope="$1"
    print_header "卸载 Claude Code"

    if [ "$scope" = "global" ]; then
        remove_dir "$HOME/.claude/skills/hap-v3-api" "Claude Code (全局)"
        remove_dir "$HOME/.claude/skills/hap-view-plugin" "Claude Code (全局)"
        remove_dir "$HOME/.claude/skills/hap-frontend-project" "Claude Code (全局)"
        remove_dir "$HOME/.claude/skills/hap-mcp-usage" "Claude Code (全局)"
        remove_dir "$HOME/.claude/skills/hap-skills-updater" "Claude Code (全局)"
    else
        remove_dir ".claude/skills" "Claude Code (项目)"
    fi
}

# 卸载 Cursor
uninstall_cursor() {
    local scope="$1"
    print_header "卸载 Cursor"

    if [ "$scope" = "global" ]; then
        remove_dir "$HOME/.cursor/skills/hap-v3-api" "Cursor (全局)"
        remove_dir "$HOME/.cursor/skills/hap-view-plugin" "Cursor (全局)"
        remove_dir "$HOME/.cursor/skills/hap-frontend-project" "Cursor (全局)"
        remove_dir "$HOME/.cursor/skills/hap-mcp-usage" "Cursor (全局)"
        remove_dir "$HOME/.cursor/skills/hap-skills-updater" "Cursor (全局)"
    else
        remove_dir ".cursor/skills" "Cursor (项目)"
    fi
}

# 卸载 TRAE
uninstall_trae() {
    local scope="$1"
    print_header "卸载 TRAE"

    if [ "$scope" = "global" ]; then
        remove_dir "$HOME/.trae/skills/hap-v3-api" "TRAE (全局)"
        remove_dir "$HOME/.trae/skills/hap-view-plugin" "TRAE (全局)"
        remove_dir "$HOME/.trae/skills/hap-frontend-project" "TRAE (全局)"
        remove_dir "$HOME/.trae/skills/hap-mcp-usage" "TRAE (全局)"
        remove_dir "$HOME/.trae/skills/hap-skills-updater" "TRAE (全局)"
    else
        remove_dir ".trae/skills" "TRAE (项目)"
    fi
}

# 卸载 Windsurf
uninstall_windsurf() {
    local scope="$1"
    print_header "卸载 Windsurf"

    if [ "$scope" = "global" ]; then
        remove_symlink "$HOME/.codeium/windsurf/skills" "Windsurf (全局)"
    else
        remove_dir ".windsurf/skills" "Windsurf (项目)"
    fi
}

# 卸载所有
uninstall_all() {
    local scope="$1"
    print_header "卸载所有平台"

    uninstall_claude "$scope"
    uninstall_cursor "$scope"
    uninstall_trae "$scope"
    uninstall_windsurf "$scope"

    # 其他平台类似...
}

# 主函数
main() {
    local scope="global"
    local uninstall_mode=""
    local specific_platform=""

    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --help)
                show_usage
                exit 0
                ;;
            --all)
                uninstall_mode="all"
                shift
                ;;
            --global)
                scope="global"
                shift
                ;;
            --project)
                scope="project"
                shift
                ;;
            --claude)
                specific_platform="claude"
                shift
                ;;
            --cursor)
                specific_platform="cursor"
                shift
                ;;
            --trae)
                specific_platform="trae"
                shift
                ;;
            --windsurf)
                specific_platform="windsurf"
                shift
                ;;
            *)
                print_error "未知参数: $1"
                show_usage
                exit 1
                ;;
        esac
    done

    # 显示警告
    print_header "HAP Skills Collection - 卸载"
    print_warning "警告: 此操作将删除 HAP Skills 文件"
    print_warning "是否继续? (y/N)"
    read -r response

    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        print_info "已取消卸载"
        exit 0
    fi

    # 执行卸载
    if [ -n "$specific_platform" ]; then
        case $specific_platform in
            claude) uninstall_claude "$scope" ;;
            cursor) uninstall_cursor "$scope" ;;
            trae) uninstall_trae "$scope" ;;
            windsurf) uninstall_windsurf "$scope" ;;
        esac
    elif [ "$uninstall_mode" = "all" ]; then
        uninstall_all "$scope"
    else
        print_error "请指定 --all 或特定平台"
        show_usage
        exit 1
    fi

    print_header "卸载完成"
    print_success "HAP Skills 已成功卸载"
}

main "$@"
