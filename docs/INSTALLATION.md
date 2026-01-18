# HAP Skills Collection - 通用安装指南

本指南提供了 HAP Skills Collection 在所有支持平台上的详细安装说明。

## 📋 目录

- [平台兼容性](#平台兼容性)
- [快速安装](#快速安装)
- [各平台详细安装](#各平台详细安装)
- [验证安装](#验证安装)
- [常见问题](#常见问题)

---

## 🎯 平台兼容性

### 兼容性速查表

| 平台/工具 | 项目级目录 | 全局/用户级目录 | 兼容性 | 安装方式 |
|----------|-----------|---------------|-------|---------|
| **Claude Code** | `.claude/skills/` | `~/.claude/skills/` | ✓ 原生 (基准) | 脚本/手动 |
| **Cursor** | `.cursor/skills/` | `~/.cursor/skills/` | ✓ 原生兼容 | 脚本/手动 |
| **GitHub Copilot** | `.github/skills/` | `~/.copilot/skills/` | ✓ 原生兼容 | 脚本/手动 |
| **Google Antigravity** | `.agent/skills/` | `~/.gemini/antigravity/skills/` | ✓ 原生兼容 | 脚本/手动 |
| **OpenCode** | `.opencode/skill/` | `~/.config/opencode/skill/` | ✓ 原生兼容 | 脚本/手动 |
| **TRAE** | `.trae/skills/` | `~/.trae/skills/` | ✓ 原生 | 脚本/手动 |
| **Windsurf** | `.windsurf/skills/` | `~/.codeium/windsurf/skills/` | ⚡ 结构兼容 | 脚本+软链 |
| **Gemini CLI** | `.gemini/skills/` | `~/.gemini/skills/` | ⚡ 结构兼容 | 脚本+软链 |
| **OpenAI Codex** | `.codex/skills/` | `~/.codex/skills/` | ⚡ 结构兼容 | 脚本+软链 |

**术语说明:**
- **✓ 原生兼容**: 工具会自动扫描 Claude 的目录或使用相同的目录结构
- **⚡ 结构兼容**: 支持相同的 SKILL.md 格式，通过软链接可实现共享

---

## ⚡ 快速安装

### 一键安装脚本 (推荐)

我们提供了智能安装脚本，自动处理所有平台的安装和配置。

#### macOS / Linux

```bash
# 1. 克隆仓库
git clone https://github.com/garfield-bb/hap-skills-collection.git
cd hap-skills-collection

# 2. 运行安装脚本
chmod +x install.sh

# 交互式安装 (推荐)
./install.sh

# 或一键安装到所有平台
./install.sh --all --global

# 或只安装到特定平台
./install.sh --claude --global
./install.sh --trae --global
./install.sh --cursor --global
```

#### Windows

```powershell
# 1. 克隆仓库
git clone https://github.com/garfield-bb/hap-skills-collection.git
cd hap-skills-collection

# 2. 以管理员身份运行 PowerShell,然后执行

# 交互式安装 (推荐)
.\install.ps1

# 或一键安装到所有平台
.\install.ps1 -All -Global

# 或只安装到特定平台
.\install.ps1 -Claude -Global
.\install.ps1 -TRAE -Global
.\install.ps1 -Cursor -Global
```

**安装脚本功能:**
- ✅ 自动检测系统和平台
- ✅ 支持全局和项目级安装
- ✅ 自动创建软链接(需要的平台)
- ✅ 备份已有配置
- ✅ 验证安装结果

---

## 📦 各平台详细安装

### 1. Claude Code (原生支持)

Claude Code 是 Anthropic 官方工具,原生支持 skills 功能。

#### 自动安装 (推荐)

```bash
# macOS/Linux
./install.sh --claude --global

# Windows (管理员 PowerShell)
.\install.ps1 -Claude -Global
```

#### 手动安装

```bash
# 全局安装
mkdir -p ~/.claude/skills
cp -r .claude/skills/* ~/.claude/skills/

# 或项目安装
mkdir -p .claude/skills
cp -r [path-to-hap-skills]/.claude/skills/* .claude/skills/
```

#### 验证

```bash
# 启动 Claude Code
claude code

# 测试
> 帮我使用 HAP V3 API 查询数据
```

---

### 2. TRAE (原生支持)

TRAE 使用标准化的 `.trae/skills/` 目录结构,与 Claude 完全兼容。

#### 自动安装 (推荐)

```bash
# macOS/Linux
./install.sh --trae --global

# Windows (管理员 PowerShell)
.\install.ps1 -TRAE -Global
```

#### 手动安装

```bash
# 全局安装
mkdir -p ~/.trae/skills
cp -r .claude/skills/* ~/.trae/skills/

# 或项目安装
mkdir -p .trae/skills
cp -r [path-to-hap-skills]/.claude/skills/* .trae/skills/
```

#### 验证

在 TRAE 中测试:
```
你: 帮我使用 HAP V3 API 查询数据
```

---

### 3. Cursor (原生兼容)

Cursor 原生兼容 Claude 的 skills 目录结构。

#### 自动安装 (推荐)

```bash
# macOS/Linux
./install.sh --cursor --global

# Windows (管理员 PowerShell)
.\install.ps1 -Cursor -Global
```

#### 手动安装

```bash
# 全局安装
mkdir -p ~/.cursor/skills
cp -r .claude/skills/* ~/.cursor/skills/

# 或项目安装
mkdir -p .cursor/skills
cp -r [path-to-hap-skills]/.claude/skills/* .cursor/skills/
```

#### 验证

1. 打开 Cursor
2. 使用快捷键 `Cmd/Ctrl + L` 打开 AI 聊天
3. 测试: "帮我使用 HAP V3 API 查询数据"

---

### 4. Google Antigravity (原生兼容)

Google Antigravity 原生兼容 Claude 的 skills。

#### 自动安装 (推荐)

```bash
# macOS/Linux
./install.sh --antigravity --global

# Windows (管理员 PowerShell)
.\install.ps1 -Antigravity -Global
```

#### 手动安装

```bash
# 全局安装
mkdir -p ~/.gemini/antigravity/skills
cp -r .claude/skills/* ~/.gemini/antigravity/skills/

# 或项目安装
mkdir -p .agent/skills
cp -r [path-to-hap-skills]/.claude/skills/* .agent/skills/
```

---

### 5. GitHub Copilot (原生兼容)

GitHub Copilot 原生兼容 Claude 的 skills 格式。

#### 自动安装 (推荐)

```bash
# macOS/Linux
./install.sh --copilot --global

# Windows (管理员 PowerShell)
.\install.ps1 -Copilot -Global
```

#### 手动安装

```bash
# 全局安装
mkdir -p ~/.copilot/skills
cp -r .claude/skills/* ~/.copilot/skills/

# 或项目安装
mkdir -p .github/skills
cp -r [path-to-hap-skills]/.claude/skills/* .github/skills/
```

---

### 6. OpenCode (原生兼容)

#### 自动安装 (推荐)

```bash
# macOS/Linux
./install.sh --opencode --global

# Windows (管理员 PowerShell)
.\install.ps1 -OpenCode -Global
```

#### 手动安装

```bash
# 全局安装
mkdir -p ~/.config/opencode/skill
cp -r .claude/skills/* ~/.config/opencode/skill/

# 或项目安装
mkdir -p .opencode/skill
cp -r [path-to-hap-skills]/.claude/skills/* .opencode/skill/
```

---

### 7. Windsurf (需软链接)

Windsurf 支持 SKILL.md 格式,但只扫描自己的目录。通过软链接可以共享 Claude 的 skills。

#### 自动安装 (推荐)

```bash
# macOS/Linux
./install.sh --windsurf --global

# Windows (管理员 PowerShell)
.\install.ps1 -Windsurf -Global
```

#### 手动安装 - 软链接方式 (推荐)

```bash
# macOS/Linux
mkdir -p ~/.claude/skills
cp -r .claude/skills/* ~/.claude/skills/
ln -s ~/.claude/skills ~/.codeium/windsurf/skills

# Windows (管理员 PowerShell)
New-Item -ItemType Directory -Force -Path "$HOME\.claude\skills"
Copy-Item -Path ".claude\skills\*" -Destination "$HOME\.claude\skills" -Recurse
New-Item -ItemType SymbolicLink -Path "$HOME\.codeium\windsurf\skills" -Target "$HOME\.claude\skills"
```

**优势:** Windsurf 会自动同步 Claude 目录的更新

---

### 8. Gemini CLI (需软链接)

#### 自动安装 (推荐)

```bash
# macOS/Linux
./install.sh --gemini --global

# Windows (管理员 PowerShell)
.\install.ps1 -Gemini -Global
```

#### 手动安装 - 软链接方式

```bash
# macOS/Linux
mkdir -p ~/.claude/skills
cp -r .claude/skills/* ~/.claude/skills/
ln -s ~/.claude/skills ~/.gemini/skills

# Windows (管理员 PowerShell)
New-Item -ItemType SymbolicLink -Path "$HOME\.gemini\skills" -Target "$HOME\.claude\skills"
```

---

### 9. OpenAI Codex (需软链接)

#### 自动安装 (推荐)

```bash
# macOS/Linux
./install.sh --codex --global

# Windows (管理员 PowerShell)
.\install.ps1 -Codex -Global
```

#### 手动安装 - 软链接方式

```bash
# macOS/Linux
mkdir -p ~/.claude/skills
cp -r .claude/skills/* ~/.claude/skills/
ln -s ~/.claude/skills ~/.codex/skills

# Windows (管理员 PowerShell)
New-Item -ItemType SymbolicLink -Path "$HOME\.codex\skills" -Target "$HOME\.claude\skills"
```

---

## ✅ 验证安装

### 通用验证步骤

在任一已安装的平台中,测试以下问题:

```
1. 帮我使用 HAP V3 API 查询数据
2. 帮我开发一个明道云视图插件
3. 使用 HAP 搭建一个网站
4. 配置 HAP MCP Server
```

如果 AI 能够:
- ✅ 识别 HAP 相关术语
- ✅ 提供具体的 API 调用步骤
- ✅ 引用技能文档中的内容

则说明安装成功!

### 技术验证

检查技能文件是否存在:

```bash
# macOS/Linux
ls -la ~/.claude/skills/
ls -la ~/.trae/skills/
ls -la ~/.cursor/skills/

# Windows
dir $HOME\.claude\skills
dir $HOME\.trae\skills
dir $HOME\.cursor\skills
```

应该看到:
```
hap-v3-api/
hap-view-plugin/
hap-frontend-project/
hap-mcp-usage/
```

---

## ❓ 常见问题

### Q: 我应该选择全局安装还是项目安装?

**推荐全局安装**,原因:
- ✅ 所有项目都能使用
- ✅ 只需安装一次
- ✅ 易于维护和更新

**项目安装适用于:**
- 特定项目需要自定义技能
- 多人协作,需要版本控制
- 不同项目使用不同技能版本

### Q: Windows 上为什么需要管理员权限?

创建符号链接 (Symbolic Link) 需要管理员权限。这只影响:
- Windsurf
- Gemini CLI
- OpenAI Codex

其他平台不需要管理员权限。

### Q: 我已经手动配置了 .cursorrules,还需要安装吗?

`.cursorrules` 是旧的配置方式,仍然可用。但原生 skills 目录:
- ✅ 更标准化
- ✅ 更易维护
- ✅ 多工具共享

建议迁移到 skills 目录,然后简化 `.cursorrules`。

### Q: 如何更新技能?

```bash
# 进入技能仓库
cd hap-skills-collection

# 拉取最新版本
git pull

# 重新运行安装脚本
./install.sh --all --global
```

### Q: 软链接和复制有什么区别?

| 方式 | 优势 | 劣势 |
|-----|------|------|
| **软链接** | • 自动同步更新<br>• 节省磁盘空间 | • 需要管理员权限(Windows)<br>• 依赖源目录 |
| **复制** | • 独立副本<br>• 不需要特殊权限 | • 更新需要手动同步<br>• 占用更多空间 |

**建议:**
- 全局安装使用软链接
- 项目安装使用复制

### Q: TRAE 的特殊性是什么?

TRAE 使用标准化的 `.trae/skills/` 目录结构:
- ✅ 与 Claude 完全兼容
- ✅ 一个 Skill 就是一个位于 `.trae/skills/` 目录下的文件夹
- ✅ 支持所有 SKILL.md 格式特性

### Q: 多个平台会冲突吗?

不会。每个平台使用独立的目录:
- Claude: `~/.claude/skills/`
- TRAE: `~/.trae/skills/`
- Cursor: `~/.cursor/skills/`
- Windsurf: `~/.codeium/windsurf/skills/` (可以软链到 Claude)

### Q: 脚本安装失败怎么办?

1. **检查权限**
   ```bash
   # macOS/Linux
   chmod +x install.sh

   # Windows: 以管理员身份运行 PowerShell
   ```

2. **检查依赖**
   - Git (用于克隆仓库)
   - 对应平台已安装

3. **手动安装**
   参考本文档的"手动安装"部分

4. **提交 Issue**
   https://github.com/garfield-bb/hap-skills-collection/issues

---

## 🎯 安装建议

### "一次编写,到处运行" 最佳实践

**推荐策略:** 以 Claude 为中心

1. **始终维护 `~/.claude/skills`** (全局中心目录)
2. **原生兼容的平台** 自动识别或直接复制
3. **需要软链的平台** 链接到 Claude 目录

**操作步骤:**

```bash
# 1. 安装到 Claude (中心)
./install.sh --claude --global

# 2. 其他原生兼容平台
./install.sh --cursor --trae --antigravity --global

# 3. 需要软链的平台 (自动链接到 Claude)
./install.sh --windsurf --gemini --codex --global
```

**结果:** 更新 Claude 目录,所有平台自动同步 (软链) 或手动更新 (复制)

---

## 📚 相关文档

- [快速开始指南](../README.md#快速开始)
- [技能列表](../README.md#技能列表)
- [使用示例](../README.md#使用示例)
- [贡献指南](./contribution-guide.md)

---

## 💡 技术支持

- **问题反馈**: [GitHub Issues](https://github.com/garfield-bb/hap-skills-collection/issues)
- **功能建议**: [GitHub Discussions](https://github.com/garfield-bb/hap-skills-collection/discussions)

---

**享受跨平台 AI 开发的便利! 🚀**
