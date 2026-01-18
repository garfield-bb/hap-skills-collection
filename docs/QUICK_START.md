# HAP Skills Collection - 快速启动指南

## 🎯 5 分钟快速开始

### 步骤 1: 克隆仓库 (30秒)

```bash
git clone https://github.com/garfield-bb/hap-skills-collection.git
cd hap-skills-collection
```

### 步骤 2: 选择你的平台并安装 (1分钟)

#### macOS / Linux

```bash
# 交互式安装 - 选择你使用的平台
./install.sh

# 或一键安装到所有平台
./install.sh --all --global

# 或只安装到特定平台
./install.sh --claude --trae --cursor --global
```

#### Windows

```powershell
# 以管理员身份运行 PowerShell

# 交互式安装
.\install.ps1

# 或一键安装
.\install.ps1 -All -Global
```

### 步骤 3: 验证安装 (1分钟)

打开你的 AI 工具 (Claude Code / Cursor / TRAE 等)，测试：

```
你: 帮我使用 HAP V3 API 查询数据
AI: [自动使用 HAP V3 API 技能]

你: 帮我开发一个明道云视图插件
AI: [自动使用视图插件开发技能]
```

如果 AI 能够识别 HAP 术语并提供专业指导，安装成功！🎉

---

## 🤔 我应该选择哪个平台？

### 推荐平台速查

| 你的需求 | 推荐平台 | 理由 |
|---------|---------|------|
| **官方最标准** | Claude Code | Anthropic 官方，原生支持 |
| **最流行** | Cursor | 最多人使用，功能强大 |
| **标准化结构** | TRAE | 完全遵循标准化目录设计 |
| **免费开源** | OpenCode | 社区驱动，完全免费 |
| **GitHub 集成** | Copilot | 与 GitHub 深度集成 |
| **多功能** | Windsurf | Codeium 出品，功能全面 |

### 我可以安装到多个平台吗？

**可以！** 一键安装到所有 9 个平台：

```bash
# macOS/Linux
./install.sh --all --global

# Windows
.\install.ps1 -All -Global
```

---

## 📱 支持的 9 种平台

### ✓ 原生支持（推荐）

这些平台会自动识别 Claude 格式的 skills：

1. **Claude Code** - Anthropic 官方 CLI
2. **TRAE** - 标准化 skills 目录结构
3. **Cursor** - 最流行的 AI 编辑器
4. **GitHub Copilot** - GitHub 官方 AI 助手
5. **Google Antigravity** - Google 实验性 AI 工具
6. **OpenCode** - 开源 AI 编程工具

### ⚡ 软链接支持

这些平台通过软链接自动同步 Claude 目录：

7. **Windsurf** - Codeium 出品的 AI 编辑器
8. **Gemini CLI** - Google Gemini 命令行工具
9. **OpenAI Codex** - OpenAI 的编程助手

**优势：** 软链接平台会自动同步 Claude 目录的更新！

---

## 🎓 使用示例

### 示例 1: 查询数据

```
你: 帮我查询"订单管理"工作表中今天的订单

AI 会自动:
1. 获取应用信息
2. 找到"订单管理"工作表
3. 构建时间筛选器
4. 调用 HAP V3 API
5. 返回查询结果
```

### 示例 2: 开发看板

```
你: 帮我开发一个销售数据看板

AI 会自动:
1. 检查开发环境
2. 选择合适的模板 (React/Vue/JS)
3. 初始化项目
4. 设计看板布局
5. 集成数据查询
6. 启动开发服务器
```

### 示例 3: 配置 MCP

```
你: 帮我配置这个 MCP Server
{"hap-mcp-xxx": {"url": "https://..."}}

AI 会自动:
1. 读取配置文件
2. 添加 MCP 配置
3. 验证配置
4. 提示重启工具
```

---

## ❓ 常见问题

### Q: 安装失败怎么办？

**检查清单:**
- ✅ 是否已安装 Git
- ✅ macOS/Linux: 脚本是否有执行权限 (`chmod +x install.sh`)
- ✅ Windows: 是否以管理员身份运行 PowerShell
- ✅ 对应的 AI 工具是否已安装

**解决方案:**
1. 查看 [详细安装指南](./INSTALLATION.md)
2. 尝试手动安装
3. 提交 [GitHub Issue](https://github.com/garfield-bb/hap-skills-collection/issues)

### Q: 我需要安装到所有平台吗？

**不需要！** 只安装你使用的平台即可。

推荐策略:
1. 主要使用的平台 (如 Claude Code)
2. 备用平台 (如 Cursor)
3. 其他平台可选

### Q: 如何更新技能？

```bash
# 进入仓库目录
cd hap-skills-collection

# 拉取最新版本
git pull

# 重新安装
./install.sh --all --global
```

### Q: 全局安装和项目安装有什么区别？

| 类型 | 位置 | 适用场景 |
|-----|------|---------|
| **全局安装** | `~/.claude/skills` | 所有项目都能使用 |
| **项目安装** | `.claude/skills` | 仅当前项目使用 |

**推荐:** 全局安装，一次安装到处使用！

### Q: TRAE 是什么？有什么特别的？

TRAE 是一个 AI 编程工具，特点是：
- ✅ 使用标准化的 `.trae/skills/` 目录结构
- ✅ 与 Claude Code 完全兼容
- ✅ 一个 Skill 就是一个文件夹
- ✅ 完全支持 SKILL.md 格式

---

## 🚀 下一步

安装完成后:

1. **浏览技能文档**
   - [HAP V3 API 使用技能](../.claude/skills/hap-v3-api/SKILL.md)
   - [HAP 视图插件开发技能](../.claude/skills/hap-view-plugin/SKILL.md)

2. **查看完整文档**
   - [详细安装指南](./INSTALLATION.md)
   - [项目 README](../README.md)

3. **开始开发**
   ```
   你: 帮我使用 HAP V3 API 查询数据
   你: 帮我开发一个视图插件
   你: 使用 HAP 搭建一个网站
   ```

4. **加入社区**
   - [提问题](https://github.com/garfield-bb/hap-skills-collection/issues)
   - [提建议](https://github.com/garfield-bb/hap-skills-collection/discussions)

---

## 📞 获取帮助

- **安装问题**: 查看 [详细安装指南](./INSTALLATION.md)
- **使用问题**: 查看 [项目 README](../README.md)
- **Bug 反馈**: [GitHub Issues](https://github.com/garfield-bb/hap-skills-collection/issues)
- **功能建议**: [GitHub Discussions](https://github.com/garfield-bb/hap-skills-collection/discussions)

---

**开始你的 HAP 开发之旅吧！** 🎉
