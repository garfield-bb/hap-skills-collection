#!/bin/bash

################################################################################
# HAP Skills Collection - Universal Installation Script
#
# 支持的平台:
# - Claude Code (原生)
# - Cursor (原生兼容)
# - OpenCode (原生兼容)
# - GitHub Copilot (原生兼容)
# - Google Antigravity (原生兼容)
# - TRAE (原生)
# - Windsurf (需软链接)
# - Gemini CLI (需软链接)
# - OpenAI Codex (需软链接)
#
# 使用方法:
#   ./install.sh                  # 交互式安装
#   ./install.sh --all            # 安装到所有支持的平台
#   ./install.sh --claude         # 只安装到 Claude Code
#   ./install.sh --global         # 全局安装(用户级)
#   ./install.sh --project        # 项目级安装
################################################################################

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 脚本目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SOURCE="$SCRIPT_DIR/.claude/skills"

# 打印带颜色的消息
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_header() { echo -e "\n${BLUE}═══${NC} $1 ${BLUE}═══${NC}\n"; }

# 显示使用说明
show_usage() {
    cat << EOF
HAP Skills Collection - 安装脚本

使用方法:
  ./install.sh [选项]

选项:
  --all             安装到所有支持的平台
  --global          全局安装(用户级)
  --project         项目级安装
  --claude          只安装到 Claude Code
  --cursor          只安装到 Cursor
  --antigravity     只安装到 Google Antigravity
  --trae            只安装到 TRAE
  --windsurf        只安装到 Windsurf
  --copilot         只安装到 GitHub Copilot
  --opencode        只安装到 OpenCode
  --gemini          只安装到 Gemini CLI
  --codex           只安装到 OpenAI Codex
  --help            显示此帮助信息

平台支持说明:
  ✓ 原生支持: Claude Code, Cursor, Antigravity, Copilot, OpenCode, TRAE
  ⚡ 软链接: Windsurf, Gemini CLI, Codex (需要从 Claude 创建链接)

示例:
  ./install.sh --global --all      # 全局安装到所有平台
  ./install.sh --claude             # 只安装到 Claude Code
  ./install.sh --global --trae     # 全局安装到 TRAE

EOF
}

# 检查技能源目录
check_source() {
    if [ ! -d "$SKILLS_SOURCE" ]; then
        print_error "未找到技能源目录: $SKILLS_SOURCE"
        exit 1
    fi
    print_success "找到技能源目录: $SKILLS_SOURCE"
}

# 复制技能文件
copy_skills() {
    local target_dir="$1"
    local platform_name="$2"

    # 创建目标目录
    mkdir -p "$target_dir"

    # 复制技能文件
    cp -rf "$SKILLS_SOURCE/"* "$target_dir/"

    print_success "$platform_name: 技能已复制到 $target_dir"
}

# 创建软链接
create_symlink() {
    local source_dir="$1"
    local target_dir="$2"
    local platform_name="$3"

    # 创建父目录
    mkdir -p "$(dirname "$target_dir")"

    # 如果目标已存在
    if [ -e "$target_dir" ]; then
        if [ -L "$target_dir" ]; then
            print_warning "$platform_name: 软链接已存在,跳过"
            return
        else
            print_warning "$platform_name: 目录已存在,备份为 ${target_dir}.backup"
            mv "$target_dir" "${target_dir}.backup"
        fi
    fi

    # 创建软链接
    ln -s "$source_dir" "$target_dir"
    print_success "$platform_name: 已创建软链接 $target_dir -> $source_dir"
}

# 安装到 Claude Code
install_claude() {
    local scope="$1"
    print_header "安装到 Claude Code"

    if [ "$scope" = "global" ]; then
        copy_skills "$HOME/.claude/skills" "Claude Code (全局)"
    else
        copy_skills ".claude/skills" "Claude Code (项目)"
    fi
}

# 安装到 Cursor
install_cursor() {
    local scope="$1"
    print_header "安装到 Cursor"

    if [ "$scope" = "global" ]; then
        copy_skills "$HOME/.cursor/skills" "Cursor (全局)"
    else
        copy_skills ".cursor/skills" "Cursor (项目)"
    fi
}

# 安装到 Google Antigravity
install_antigravity() {
    local scope="$1"
    print_header "安装到 Google Antigravity"

    if [ "$scope" = "global" ]; then
        copy_skills "$HOME/.gemini/antigravity/skills" "Antigravity (全局)"
    else
        copy_skills ".agent/skills" "Antigravity (项目)"
    fi
}

# 安装到 TRAE
install_trae() {
    local scope="$1"
    print_header "安装到 TRAE"

    if [ "$scope" = "global" ]; then
        copy_skills "$HOME/.trae/skills" "TRAE (全局)"
    else
        copy_skills ".trae/skills" "TRAE (项目)"
    fi
}

# 安装到 GitHub Copilot
install_copilot() {
    local scope="$1"
    print_header "安装到 GitHub Copilot"

    if [ "$scope" = "global" ]; then
        copy_skills "$HOME/.copilot/skills" "GitHub Copilot (全局)"
    else
        copy_skills ".github/skills" "GitHub Copilot (项目)"
    fi
}

# 安装到 OpenCode
install_opencode() {
    local scope="$1"
    print_header "安装到 OpenCode"

    if [ "$scope" = "global" ]; then
        copy_skills "$HOME/.config/opencode/skill" "OpenCode (全局)"
    else
        copy_skills ".opencode/skill" "OpenCode (项目)"
    fi
}

# 安装到 Windsurf (软链接)
install_windsurf() {
    local scope="$1"
    print_header "安装到 Windsurf (软链接)"

    if [ "$scope" = "global" ]; then
        # 确保 Claude 全局目录存在
        mkdir -p "$HOME/.claude/skills"
        create_symlink "$HOME/.claude/skills" "$HOME/.codeium/windsurf/skills" "Windsurf (全局)"
    else
        # 项目级使用独立目录
        copy_skills ".windsurf/skills" "Windsurf (项目)"
    fi
}

# 安装到 Gemini CLI (软链接)
install_gemini() {
    local scope="$1"
    print_header "安装到 Gemini CLI (软链接)"

    if [ "$scope" = "global" ]; then
        mkdir -p "$HOME/.claude/skills"
        create_symlink "$HOME/.claude/skills" "$HOME/.gemini/skills" "Gemini CLI (全局)"
    else
        copy_skills ".gemini/skills" "Gemini CLI (项目)"
    fi
}

# 安装到 OpenAI Codex (软链接)
install_codex() {
    local scope="$1"
    print_header "安装到 OpenAI Codex (软链接)"

    if [ "$scope" = "global" ]; then
        mkdir -p "$HOME/.claude/skills"
        create_symlink "$HOME/.claude/skills" "$HOME/.codex/skills" "OpenAI Codex (全局)"
    else
        copy_skills ".codex/skills" "OpenAI Codex (项目)"
    fi
}

# 交互式选择
interactive_install() {
    local scope="$1"

    print_header "HAP Skills Collection 安装向导"

    echo "请选择要安装的平台 (可多选,用空格分隔):"
    echo ""
    echo "  原生支持 (推荐):"
    echo "    1) Claude Code"
    echo "    2) Cursor"
    echo "    3) Google Antigravity"
    echo "    4) TRAE"
    echo "    5) GitHub Copilot"
    echo "    6) OpenCode"
    echo ""
    echo "  需要软链接:"
    echo "    7) Windsurf"
    echo "    8) Gemini CLI"
    echo "    9) OpenAI Codex"
    echo ""
    echo "    0) 全部安装"
    echo ""
    read -p "请输入序号: " choices

    # 处理选择
    if [[ "$choices" =~ 0 ]]; then
        install_all "$scope"
        return
    fi

    for choice in $choices; do
        case $choice in
            1) install_claude "$scope" ;;
            2) install_cursor "$scope" ;;
            3) install_antigravity "$scope" ;;
            4) install_trae "$scope" ;;
            5) install_copilot "$scope" ;;
            6) install_opencode "$scope" ;;
            7) install_windsurf "$scope" ;;
            8) install_gemini "$scope" ;;
            9) install_codex "$scope" ;;
            *) print_warning "未知选项: $choice" ;;
        esac
    done
}

# 安装到所有平台
install_all() {
    local scope="$1"

    print_header "安装到所有平台"

    install_claude "$scope"
    install_cursor "$scope"
    install_antigravity "$scope"
    install_trae "$scope"
    install_copilot "$scope"
    install_opencode "$scope"
    install_windsurf "$scope"
    install_gemini "$scope"
    install_codex "$scope"
}

# 显示安装后的说明
show_post_install() {
    print_header "安装完成"

    cat << EOF
${GREEN}✓${NC} HAP Skills 安装成功!

${BLUE}下一步:${NC}

${YELLOW}1. 原生支持的平台${NC} (无需额外操作):
   - Claude Code
   - Cursor
   - Google Antigravity
   - TRAE
   - GitHub Copilot
   - OpenCode

${YELLOW}2. 需要软链接的平台${NC} (已自动配置):
   - Windsurf
   - Gemini CLI
   - OpenAI Codex

${YELLOW}3. 验证安装${NC}:
   # 在任一支持的工具中测试
   "帮我使用 HAP V3 API 查询数据"
   "帮我开发一个明道云视图插件"

${YELLOW}4. 查看文档${NC}:
   - README: $SCRIPT_DIR/README.md
   - 详细指南: $SCRIPT_DIR/docs/

${BLUE}提示:${NC}
- TRAE 使用标准化的 .trae/skills/ 目录结构
- 软链接平台会自动同步 Claude 目录的更新
- 项目级安装不影响全局配置

${GREEN}开始使用 HAP Skills 吧! 🚀${NC}

EOF
}

# 主函数
main() {
    # 默认参数
    local scope="global"
    local install_mode=""
    local specific_platform=""

    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --help)
                show_usage
                exit 0
                ;;
            --all)
                install_mode="all"
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
            --antigravity)
                specific_platform="antigravity"
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
            --copilot)
                specific_platform="copilot"
                shift
                ;;
            --opencode)
                specific_platform="opencode"
                shift
                ;;
            --gemini)
                specific_platform="gemini"
                shift
                ;;
            --codex)
                specific_platform="codex"
                shift
                ;;
            *)
                print_error "未知参数: $1"
                show_usage
                exit 1
                ;;
        esac
    done

    # 显示欢迎信息
    clear
    cat << "EOF"
╔════════════════════════════════════════════╗
║   HAP Skills Collection                    ║
║   Universal Installation Script            ║
╚════════════════════════════════════════════╝
EOF

    # 检查源目录
    check_source

    # 执行安装
    if [ -n "$specific_platform" ]; then
        # 安装到特定平台
        case $specific_platform in
            claude) install_claude "$scope" ;;
            cursor) install_cursor "$scope" ;;
            antigravity) install_antigravity "$scope" ;;
            trae) install_trae "$scope" ;;
            windsurf) install_windsurf "$scope" ;;
            copilot) install_copilot "$scope" ;;
            opencode) install_opencode "$scope" ;;
            gemini) install_gemini "$scope" ;;
            codex) install_codex "$scope" ;;
        esac
    elif [ "$install_mode" = "all" ]; then
        # 安装到所有平台
        install_all "$scope"
    else
        # 交互式安装
        interactive_install "$scope"
    fi

    # 显示安装后说明
    show_post_install
}

# 运行主函数
main "$@"
