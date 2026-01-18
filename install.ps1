<#
.SYNOPSIS
    HAP Skills Collection - Windows 安装脚本

.DESCRIPTION
    支持的平台:
    - Claude Code (原生)
    - Cursor (原生兼容)
    - OpenCode (原生兼容)
    - GitHub Copilot (原生兼容)
    - Google Antigravity (原生兼容)
    - TRAE (原生)
    - Windsurf (需软链接)
    - Gemini CLI (需软链接)
    - OpenAI Codex (需软链接)

.PARAMETER All
    安装到所有支持的平台

.PARAMETER Global
    全局安装(用户级)

.PARAMETER Project
    项目级安装

.PARAMETER Claude
    只安装到 Claude Code

.PARAMETER Cursor
    只安装到 Cursor

.PARAMETER Antigravity
    只安装到 Google Antigravity

.PARAMETER TRAE
    只安装到 TRAE

.PARAMETER Windsurf
    只安装到 Windsurf

.PARAMETER Copilot
    只安装到 GitHub Copilot

.PARAMETER OpenCode
    只安装到 OpenCode

.PARAMETER Gemini
    只安装到 Gemini CLI

.PARAMETER Codex
    只安装到 OpenAI Codex

.EXAMPLE
    .\install.ps1 -All -Global
    全局安装到所有平台

.EXAMPLE
    .\install.ps1 -Claude
    只安装到 Claude Code

.EXAMPLE
    .\install.ps1 -TRAE -Global
    全局安装到 TRAE

.NOTES
    需要管理员权限创建软链接
    TRAE 使用标准化的 .trae/skills/ 目录结构
#>

[CmdletBinding()]
param(
    [switch]$All,
    [switch]$Global,
    [switch]$Project,
    [switch]$Claude,
    [switch]$Cursor,
    [switch]$Antigravity,
    [switch]$TRAE,
    [switch]$Windsurf,
    [switch]$Copilot,
    [switch]$OpenCode,
    [switch]$Gemini,
    [switch]$Codex,
    [switch]$Help
)

# 检查是否需要管理员权限
function Test-Administrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# 颜色输出
function Write-Info { param($Message) Write-Host "ℹ $Message" -ForegroundColor Blue }
function Write-Success { param($Message) Write-Host "✓ $Message" -ForegroundColor Green }
function Write-Warning { param($Message) Write-Host "⚠ $Message" -ForegroundColor Yellow }
function Write-Error { param($Message) Write-Host "✗ $Message" -ForegroundColor Red }
function Write-Header { param($Message) Write-Host "`n═══ $Message ═══`n" -ForegroundColor Blue }

# 显示使用说明
function Show-Usage {
    @"

HAP Skills Collection - Windows 安装脚本

使用方法:
  .\install.ps1 [参数]

参数:
  -All             安装到所有支持的平台
  -Global          全局安装(用户级)
  -Project         项目级安装
  -Claude          只安装到 Claude Code
  -Cursor          只安装到 Cursor
  -Antigravity     只安装到 Google Antigravity
  -TRAE            只安装到 TRAE
  -Windsurf        只安装到 Windsurf
  -Copilot         只安装到 GitHub Copilot
  -OpenCode        只安装到 OpenCode
  -Gemini          只安装到 Gemini CLI
  -Codex           只安装到 OpenAI Codex
  -Help            显示此帮助信息

平台支持说明:
  ✓ 原生支持: Claude Code, Cursor, Antigravity, Copilot, OpenCode, TRAE
  ⚡ 软链接: Windsurf, Gemini CLI, Codex (需要管理员权限)

示例:
  .\install.ps1 -All -Global        # 全局安装到所有平台
  .\install.ps1 -Claude              # 只安装到 Claude Code
  .\install.ps1 -TRAE -Global       # 全局安装到 TRAE

注意:
  - 创建软链接需要管理员权限
  - 建议使用 "以管理员身份运行 PowerShell"

"@
}

# 脚本目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillsSource = Join-Path $ScriptDir ".claude\skills"

# 检查技能源目录
function Test-Source {
    if (-not (Test-Path $SkillsSource)) {
        Write-Error "未找到技能源目录: $SkillsSource"
        exit 1
    }
    Write-Success "找到技能源目录: $SkillsSource"
}

# 复制技能文件
function Copy-Skills {
    param(
        [string]$TargetDir,
        [string]$PlatformName
    )

    # 创建目标目录
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

    # 复制技能文件
    Copy-Item -Path "$SkillsSource\*" -Destination $TargetDir -Recurse -Force

    Write-Success "$PlatformName : 技能已复制到 $TargetDir"
}

# 创建软链接
function New-SymbolicLinkSafe {
    param(
        [string]$SourceDir,
        [string]$TargetDir,
        [string]$PlatformName
    )

    # 检查管理员权限
    if (-not (Test-Administrator)) {
        Write-Warning "$PlatformName : 需要管理员权限创建软链接"
        Write-Warning "请以管理员身份运行 PowerShell 并重新执行此脚本"
        return
    }

    # 创建父目录
    $ParentDir = Split-Path -Parent $TargetDir
    New-Item -ItemType Directory -Force -Path $ParentDir | Out-Null

    # 如果目标已存在
    if (Test-Path $TargetDir) {
        $Item = Get-Item $TargetDir
        if ($Item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            Write-Warning "$PlatformName : 软链接已存在,跳过"
            return
        } else {
            Write-Warning "$PlatformName : 目录已存在,备份为 ${TargetDir}.backup"
            Move-Item $TargetDir "${TargetDir}.backup" -Force
        }
    }

    # 创建软链接
    New-Item -ItemType SymbolicLink -Path $TargetDir -Target $SourceDir -Force | Out-Null
    Write-Success "$PlatformName : 已创建软链接 $TargetDir -> $SourceDir"
}

# 安装到 Claude Code
function Install-Claude {
    param([string]$Scope)
    Write-Header "安装到 Claude Code"

    if ($Scope -eq "global") {
        Copy-Skills "$env:USERPROFILE\.claude\skills" "Claude Code (全局)"
    } else {
        Copy-Skills ".claude\skills" "Claude Code (项目)"
    }
}

# 安装到 Cursor
function Install-Cursor {
    param([string]$Scope)
    Write-Header "安装到 Cursor"

    if ($Scope -eq "global") {
        Copy-Skills "$env:USERPROFILE\.cursor\skills" "Cursor (全局)"
    } else {
        Copy-Skills ".cursor\skills" "Cursor (项目)"
    }
}

# 安装到 Google Antigravity
function Install-Antigravity {
    param([string]$Scope)
    Write-Header "安装到 Google Antigravity"

    if ($Scope -eq "global") {
        Copy-Skills "$env:USERPROFILE\.gemini\antigravity\skills" "Antigravity (全局)"
    } else {
        Copy-Skills ".agent\skills" "Antigravity (项目)"
    }
}

# 安装到 TRAE
function Install-TRAE {
    param([string]$Scope)
    Write-Header "安装到 TRAE"

    if ($Scope -eq "global") {
        Copy-Skills "$env:USERPROFILE\.trae\skills" "TRAE (全局)"
    } else {
        Copy-Skills ".trae\skills" "TRAE (项目)"
    }
}

# 安装到 GitHub Copilot
function Install-Copilot {
    param([string]$Scope)
    Write-Header "安装到 GitHub Copilot"

    if ($Scope -eq "global") {
        Copy-Skills "$env:USERPROFILE\.copilot\skills" "GitHub Copilot (全局)"
    } else {
        Copy-Skills ".github\skills" "GitHub Copilot (项目)"
    }
}

# 安装到 OpenCode
function Install-OpenCode {
    param([string]$Scope)
    Write-Header "安装到 OpenCode"

    if ($Scope -eq "global") {
        Copy-Skills "$env:USERPROFILE\.config\opencode\skill" "OpenCode (全局)"
    } else {
        Copy-Skills ".opencode\skill" "OpenCode (项目)"
    }
}

# 安装到 Windsurf (软链接)
function Install-Windsurf {
    param([string]$Scope)
    Write-Header "安装到 Windsurf (软链接)"

    if ($Scope -eq "global") {
        # 确保 Claude 全局目录存在
        New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills" | Out-Null
        New-SymbolicLinkSafe "$env:USERPROFILE\.claude\skills" "$env:USERPROFILE\.codeium\windsurf\skills" "Windsurf (全局)"
    } else {
        Copy-Skills ".windsurf\skills" "Windsurf (项目)"
    }
}

# 安装到 Gemini CLI (软链接)
function Install-Gemini {
    param([string]$Scope)
    Write-Header "安装到 Gemini CLI (软链接)"

    if ($Scope -eq "global") {
        New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills" | Out-Null
        New-SymbolicLinkSafe "$env:USERPROFILE\.claude\skills" "$env:USERPROFILE\.gemini\skills" "Gemini CLI (全局)"
    } else {
        Copy-Skills ".gemini\skills" "Gemini CLI (项目)"
    }
}

# 安装到 OpenAI Codex (软链接)
function Install-Codex {
    param([string]$Scope)
    Write-Header "安装到 OpenAI Codex (软链接)"

    if ($Scope -eq "global") {
        New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills" | Out-Null
        New-SymbolicLinkSafe "$env:USERPROFILE\.claude\skills" "$env:USERPROFILE\.codex\skills" "OpenAI Codex (全局)"
    } else {
        Copy-Skills ".codex\skills" "OpenAI Codex (项目)"
    }
}

# 交互式安装
function Start-InteractiveInstall {
    param([string]$Scope)

    Write-Header "HAP Skills Collection 安装向导"

    Write-Host "请选择要安装的平台 (可多选,用逗号分隔):"
    Write-Host ""
    Write-Host "  原生支持 (推荐):"
    Write-Host "    1) Claude Code"
    Write-Host "    2) Cursor"
    Write-Host "    3) Google Antigravity"
    Write-Host "    4) TRAE"
    Write-Host "    5) GitHub Copilot"
    Write-Host "    6) OpenCode"
    Write-Host ""
    Write-Host "  需要软链接 (需管理员权限):"
    Write-Host "    7) Windsurf"
    Write-Host "    8) Gemini CLI"
    Write-Host "    9) OpenAI Codex"
    Write-Host ""
    Write-Host "    0) 全部安装"
    Write-Host ""

    $Input = Read-Host "请输入序号"
    $Choices = $Input -split '[,\s]' | Where-Object { $_ }

    # 处理选择
    if ($Choices -contains "0") {
        Install-All $Scope
        return
    }

    foreach ($Choice in $Choices) {
        switch ($Choice) {
            "1" { Install-Claude $Scope }
            "2" { Install-Cursor $Scope }
            "3" { Install-Antigravity $Scope }
            "4" { Install-TRAE $Scope }
            "5" { Install-Copilot $Scope }
            "6" { Install-OpenCode $Scope }
            "7" { Install-Windsurf $Scope }
            "8" { Install-Gemini $Scope }
            "9" { Install-Codex $Scope }
            default { Write-Warning "未知选项: $Choice" }
        }
    }
}

# 安装到所有平台
function Install-All {
    param([string]$Scope)

    Write-Header "安装到所有平台"

    Install-Claude $Scope
    Install-Cursor $Scope
    Install-Antigravity $Scope
    Install-TRAE $Scope
    Install-Copilot $Scope
    Install-OpenCode $Scope
    Install-Windsurf $Scope
    Install-Gemini $Scope
    Install-Codex $Scope
}

# 显示安装后说明
function Show-PostInstall {
    Write-Header "安装完成"

    @"
✓ HAP Skills 安装成功!

下一步:

1. 原生支持的平台 (无需额外操作):
   - Claude Code
   - Cursor
   - Google Antigravity
   - TRAE
   - GitHub Copilot
   - OpenCode

2. 需要软链接的平台 (已自动配置):
   - Windsurf
   - Gemini CLI
   - OpenAI Codex

3. 验证安装:
   # 在任一支持的工具中测试
   "帮我使用 HAP V3 API 查询数据"
   "帮我开发一个明道云视图插件"

4. 查看文档:
   - README: $ScriptDir\README.md
   - 详细指南: $ScriptDir\docs\

提示:
- TRAE 使用标准化的 .trae/skills/ 目录结构
- 软链接平台会自动同步 Claude 目录的更新
- 项目级安装不影响全局配置
- 某些软链接操作需要管理员权限

开始使用 HAP Skills 吧! 🚀

"@
}

# 主函数
function Main {
    # 显示欢迎信息
    Clear-Host
    @"
╔════════════════════════════════════════════╗
║   HAP Skills Collection                    ║
║   Windows Installation Script              ║
╚════════════════════════════════════════════╝
"@

    # 显示帮助
    if ($Help) {
        Show-Usage
        exit 0
    }

    # 检查源目录
    Test-Source

    # 确定安装范围
    $Scope = if ($Global) { "global" } else { "project" }

    # 执行安装
    if ($Claude) {
        Install-Claude $Scope
    } elseif ($Cursor) {
        Install-Cursor $Scope
    } elseif ($Antigravity) {
        Install-Antigravity $Scope
    } elseif ($TRAE) {
        Install-TRAE $Scope
    } elseif ($Windsurf) {
        Install-Windsurf $Scope
    } elseif ($Copilot) {
        Install-Copilot $Scope
    } elseif ($OpenCode) {
        Install-OpenCode $Scope
    } elseif ($Gemini) {
        Install-Gemini $Scope
    } elseif ($Codex) {
        Install-Codex $Scope
    } elseif ($All) {
        Install-All $Scope
    } else {
        Start-InteractiveInstall $Scope
    }

    # 显示安装后说明
    Show-PostInstall
}

# 运行主函数
Main
