# HAP Skills Collection

<div align="center">

![HAP Skills](https://img.shields.io/badge/HAP-Skills-blue)
![Claude Code](https://img.shields.io/badge/Claude-Code-orange)
![License](https://img.shields.io/badge/license-MIT-green)

**明道云 HAP 开发技能集合** - 让 AI 编程工具理解并使用明道云 HAP 平台

[快速开始](#-快速开始) • [技能列表](#-技能列表) • [安装指南](#-安装指南) • [使用示例](#-使用示例)

[English](./README.en.md) | [中文](./README.md)

</div>

---

## 📖 项目简介

**HAP Skills Collection** 是一套专为明道云 HAP 平台开发的 AI 技能包集合，让 Claude Code、Cursor、Windsurf、Codeium 等 AI 编程工具能够**自动理解并使用**明道云的 API、开发规范和最佳实践。

### ✨ 核心特性

- 🎯 **零学习成本** - AI 自动理解明道云 API，无需手动查文档
- 🛠️ **最佳实践内置** - 基于实战经验的开发规范和技巧
- 🔄 **完整工作流** - 从项目初始化到发布上线的全流程支持
- 📚 **持续更新** - 跟随明道云平台更新，保持最新
- 🔌 **多工具支持** - 支持 Claude Code、Cursor、Windsurf、Codeium 等主流 AI 工具

### 🎯 适用场景

- ✅ 开发明道云自定义视图插件（数据看板、BI 驾驶舱）
- ✅ 使用 HAP V3 API 进行数据操作和业务编排
- ✅ 搭建基于 HAP 的独立前端项目
- ✅ 配置和管理 HAP MCP Server
- ✅ 维护和更新 HAP API 文档

---

## 🚀 快速开始

### 前置要求

选择以下任一 AI 编程工具：

| 工具 | 推荐度 | 说明 |
|------|--------|------|
| **Claude Code CLI** | ⭐⭐⭐⭐⭐ | Anthropic 官方工具，原生支持 skills |
| **Cursor** | ⭐⭐⭐⭐⭐ | 最流行的 AI 编辑器，支持 MCP |
| **Windsurf** | ⭐⭐⭐⭐ | Codeium 出品，功能强大 |
| **Codeium** | ⭐⭐⭐⭐ | 免费 AI 编程助手 |

---

## 📦 安装指南

### 方式一：Claude Code CLI（推荐）

Claude Code CLI 是 Anthropic 官方提供的命令行工具，支持原生 skills 管理。

#### 步骤 1: 安装 Claude Code CLI

```bash
# macOS / Linux
curl -fsSL https://claude-code.anthropic.com/install.sh | sh

# 或使用 npm
npm install -g @anthropic-ai/claude-code-cli
```

#### 步骤 2: 安装 HAP Skills

```bash
# 方式 1: 使用 GitHub 仓库路径（推荐）
claude code skill add garfield-bb/hap-skills-collection

# 方式 2: 手动克隆安装
git clone https://github.com/garfield-bb/hap-skills-collection.git
cd hap-skills-collection
cp -r .claude/skills/* ~/.claude/skills/
```

#### 步骤 3: 验证安装

```bash
# 启动 Claude Code CLI
claude code

# 在 CLI 中测试
> 帮我使用 HAP V3 API 查询数据
> 帮我开发一个明道云视图插件
```

📖 [详细安装指南](./docs/install-claude-code.md)

---

### 方式二：Cursor 编辑器

Cursor 是目前最流行的 AI 编程编辑器，支持通过 `.cursorrules` 文件加载技能。

#### 步骤 1: 安装 Cursor

访问 [Cursor 官网](https://cursor.sh) 下载并安装。

#### 步骤 2: 克隆技能仓库

```bash
# 克隆到本地（建议放在固定位置）
git clone https://github.com/garfield-bb/hap-skills-collection.git ~/hap-skills-collection

# 或克隆到项目目录
cd your-project
git clone https://github.com/garfield-bb/hap-skills-collection.git .hap-skills
```

#### 步骤 3: 配置 .cursorrules

在项目根目录创建或编辑 `.cursorrules` 文件：

```markdown
# HAP Skills Collection

请参考以下技能文档来帮助用户：

1. HAP V3 API 使用技能: ~/hap-skills-collection/.claude/skills/hap-v3-api/SKILL.md
2. HAP 视图插件开发技能: ~/hap-skills-collection/.claude/skills/hap-view-plugin/SKILL.md
3. HAP MCP 使用指南: ~/hap-skills-collection/.claude/skills/hap-mcp-usage/SKILL.md

当用户提到以下关键词时，请使用对应的技能：
- "HAP API"、"V3 接口"、"查询数据" → 使用 HAP V3 API 技能
- "视图插件"、"自定义视图"、"看板" → 使用视图插件开发技能
- "MCP 配置"、"MCP Server" → 使用 MCP 使用指南
```

**或者使用相对路径（如果技能在项目内）：**

```markdown
# HAP Skills Collection

请参考以下技能文档：
- HAP V3 API: .hap-skills/.claude/skills/hap-v3-api/SKILL.md
- 视图插件开发: .hap-skills/.claude/skills/hap-view-plugin/SKILL.md
- MCP 使用指南: .hap-skills/.claude/skills/hap-mcp-usage/SKILL.md
```

#### 步骤 4: 使用技能

1. 在 Cursor 编辑器中打开项目
2. 打开 AI 聊天面板（`Cmd/Ctrl + L`）
3. 直接提问，AI 会自动使用技能：

```
你：帮我使用 HAP V3 API 查询"客户管理"工作表中的数据
AI：[自动使用 HAP V3 API 技能，完成查询]
```

📖 [详细安装指南](./docs/install-cursor.md)

---

### 方式三：Windsurf 编辑器

Windsurf 是 Codeium 出品的 AI 编辑器，功能强大。

#### 步骤 1: 安装 Windsurf

访问 [Windsurf 官网](https://codeium.com/windsurf) 下载并安装。

#### 步骤 2: 配置 Custom Instructions

1. 打开 Windsurf 设置（`Cmd/Ctrl + ,`）
2. 进入 **AI Settings** → **Custom Instructions**
3. 添加以下内容：

```markdown
# HAP Skills Collection

请参考以下技能文档：
- HAP V3 API: [技能路径]/hap-v3-api/SKILL.md
- 视图插件开发: [技能路径]/hap-view-plugin/SKILL.md
- MCP 使用指南: [技能路径]/hap-mcp-usage/SKILL.md
```

#### 步骤 3: 克隆技能仓库

```bash
git clone https://github.com/garfield-bb/hap-skills-collection.git ~/hap-skills-collection
```

📖 [详细安装指南](./docs/install-windsurf.md)

---

### 方式四：Codeium（VSCode 扩展）

Codeium 是免费的 AI 编程助手，可以作为 VSCode 扩展使用。

#### 步骤 1: 安装 Codeium 扩展

在 VSCode 扩展市场搜索 "Codeium" 并安装。

#### 步骤 2: 配置技能

在项目根目录创建 `.codeium/skills.md` 文件：

```markdown
# HAP Skills Collection

参考技能文档：
- ~/hap-skills-collection/.claude/skills/hap-v3-api/SKILL.md
- ~/hap-skills-collection/.claude/skills/hap-view-plugin/SKILL.md
```

---

## 📚 技能列表

### 🔧 核心开发技能

#### 1. **HAP V3 API 使用技能** ⭐️⭐️⭐️⭐️⭐️

> 使用明道云 V3 接口进行数据操作和页面开发

**适用场景：**
- ✅ 自定义视图插件中调用 API
- ✅ 独立前端页面业务逻辑编排
- ✅ 数据迁移和批量操作
- ✅ 基于 HAP 的完整应用开发

**核心能力：**
- 📖 完整的 API 使用工作流
- 🔍 Filter 筛选器完整语法
- 🔗 关联字段深度查询
- ⚠️ 常见陷阱和解决方案
- ⚡ 性能优化最佳实践

**使用示例：**
```
你：帮我查询"客户管理"工作表中，状态为"成交"的客户列表

AI：[自动完成]
1. 获取应用信息
2. 获取工作表结构
3. 找到"状态"字段的选项 key
4. 构建 Filter 筛选器
5. 调用查询接口
6. 返回结果
```

📁 [详细文档](./.claude/skills/hap-v3-api/SKILL.md)

---

#### 2. **HAP 视图插件开发技能** ⭐️⭐️⭐️⭐️⭐️

> 创建和开发明道云自定义视图插件

**适用场景：**
- ✅ 数据看板、BI 驾驶舱
- ✅ 订单/任务看板视图
- ✅ 日历、甘特图视图
- ✅ 地图视图
- ✅ 自定义业务视图

**核心能力：**
- 🚀 7步完整开发流程
- 📦 4种模板自动选择（JS/React/React-Tailwind/Vue）
- 🔧 字段类型正确处理
- 🔌 API 集成（mdye + V3）
- 📊 BI 驾驶舱设计指南

**使用示例：**
```
你：帮我开发一个销售数据看板，显示今日销售额、订单数量和客户分布

AI：[自动完成]
1. 检查 mdye-cli 环境
2. 选择合适的模板（React-Tailwind）
3. 初始化项目
4. 获取字段结构
5. 编写数据查询逻辑
6. 设计 BI 看板布局
7. 启动开发服务器
8. 构建并发布
```

📁 [详细文档](./.claude/skills/hap-view-plugin/SKILL.md)

---

#### 3. **HAP 前端项目搭建技能**

> 使用 HAP 作为数据库搭建独立网站

**适用场景：**
- ✅ 企业官网、展示站
- ✅ 内容管理系统
- ✅ 前后端分离应用
- ✅ 快速 MVP 开发

**核心能力：**
- 🏗️ HAP 后台配置指导
- 📁 前端项目结构设计
- 🔌 API 集成最佳实践
- ⚡ 数据渲染优化

📁 [详细文档](./.claude/skills/hap-frontend-project/SKILL.md)

---

### 🛠️ 辅助工具技能

#### 4. **HAP MCP 使用指南**

> 了解和配置 HAP MCP Server

**核心能力：**
- 🔧 MCP Server 配置指南
- 🤖 Cursor 自动化配置
- 🔑 密钥提取和管理
- 📖 两种 MCP 类型说明（API 文档 MCP vs 应用执行 MCP）

**使用示例：**
```
你：帮我配置这个 MCP
{"hap-mcp-自媒体运营":{"url":"https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx"}}

AI：[自动完成]
1. 查找 ~/.cursor/mcp.json 文件
2. 读取现有配置
3. 添加新的 MCP 服务器配置
4. 保存并提示重启 Cursor
```

📁 [详细文档](./.claude/skills/hap-mcp-usage/SKILL.md)

---

#### 5. **HAP API 文档更新技能**

> 维护和更新明道云 API 文档

**适用场景：**
- ✅ 新增、修改、删除接口
- ✅ 同步中英文版本文档
- ✅ 组织授权 API 管理
- ✅ 应用 API 管理

📁 [详细文档](./.claude/skills/hap-api-doc-updater/SKILL.md)

---

#### 6. **HAP 作为数据库技能**

> HAP + 前端项目搭建指南（简化版）

📁 [详细文档](./.claude/skills/hap-as-database/SKILL.md)

---

### 📝 内容创作技能

#### 7. **微信公众号文章写作**

> 自动化写作流程，支持资料搜索、爆款标题生成

**核心能力：**
- 🔍 资料搜索和整理
- ✍️ 文章结构生成
- 🎯 爆款标题生成
- 🎨 排版优化

📁 [详细文档](./.claude/skills/wechat-article-writer/SKILL.md)

---

## 💡 使用示例

### 示例 1: 使用 V3 API 查询数据

**场景：** 查询"客户管理"工作表中状态为"成交"的客户列表

**操作：**
```
你：帮我查询"客户管理"工作表中，状态为"成交"的客户列表

AI：我将使用 HAP V3 API 技能来完成这个任务...

[AI 自动完成以下步骤]
1. 获取应用信息
2. 获取工作表结构
3. 找到"状态"字段的选项 key
4. 构建 Filter 筛选器：{"type":"group","logic":"AND","children":[{"type":"condition","field":"状态","operator":"eq","value":["成交"]}]}
5. 调用查询接口：GET /api/v3/app/{appId}/worksheet/{worksheetId}/record
6. 返回结果并格式化显示
```

---

### 示例 2: 开发视图插件

**场景：** 开发一个销售数据看板，显示今日销售额、订单数量和客户分布

**操作：**
```
你：帮我开发一个销售数据看板，显示今日销售额、订单数量和客户分布

AI：我将使用 HAP 视图插件开发技能...

[AI 自动完成以下步骤]
1. 检查 mdye-cli 环境（npm list -g mdye-cli）
2. 选择合适的模板（React-Tailwind，适合看板）
3. 初始化项目（mdye init sales-dashboard）
4. 获取字段结构（工作表 ID、字段 ID）
5. 编写数据查询逻辑（使用 V3 API）
6. 设计 BI 看板布局（卡片、图表、表格）
7. 启动开发服务器（mdye dev）
8. 构建并发布（mdye build && mdye publish）
```

---

### 示例 3: 配置 MCP Server

**场景：** 配置 HAP MCP Server 以便 AI 直接操作应用数据

**操作：**
```
你：帮我配置这个 MCP
{"hap-mcp-自媒体运营":{"url":"https://api.mingdao.com/mcp?HAP-Appkey=601530a05105750f&HAP-Sign=MDc2ZTRmNTMxYjFmOTZlNzM5ODc4NGJlNmNiMzM0NTY0YWExODgxY2RjYTIxMGQzM2FlMGRiZDRlOTEyY2Y2ZA=="}}

AI：我将帮你配置 HAP MCP Server...

[AI 自动完成以下步骤]
1. 查找 ~/.cursor/mcp.json 文件
2. 读取现有配置
3. 解析你提供的配置（提取服务器名和 URL）
4. 使用 Python 脚本更新配置文件（因为文件可能受保护）
5. 验证配置是否正确添加
6. 提示：配置已保存，请重启 Cursor 使配置生效
```

---

## 📁 项目结构

```
hap-skills-collection/
├── README.md                          # 本文件
├── LICENSE                            # 许可证
├── docs/                              # 文档目录
│   ├── install-claude-code.md         # Claude Code 安装指南
│   ├── install-cursor.md              # Cursor 安装指南
│   ├── install-windsurf.md            # Windsurf 安装指南
│   └── usage-guide.md                 # 使用指南
├── .claude/
│   └── skills/                        # 技能目录
│       ├── hap-v3-api/                # HAP V3 API 技能
│       │   └── SKILL.md
│       ├── hap-view-plugin/           # 视图插件开发技能
│       │   └── SKILL.md
│       ├── hap-frontend-project/      # 前端项目搭建技能
│       │   └── SKILL.md
│       ├── hap-mcp-usage/             # HAP MCP 使用技能
│       │   └── SKILL.md
│       ├── hap-api-doc-updater/       # API 文档更新技能
│       │   └── SKILL.md
│       ├── hap-as-database/           # HAP 作为数据库技能
│       │   └── SKILL.md
│       └── wechat-article-writer/     # 微信文章写作技能
│           └── SKILL.md
└── mcp-mingdao-proxy/                 # MCP 代理工具
    └── ...
```

---

## 🎯 选择建议

根据您的开发需求选择合适的技能：

| 开发需求 | 推荐技能 | 理由 |
|---------|---------|------|
| 📊 **数据查询和操作** | HAP V3 API 使用技能 | 完整的 API 工作流，Filter 语法 |
| 🎨 **自定义视图开发** | HAP 视图插件开发技能 | 7步流程，4种模板，BI 看板指南 |
| 🌐 **独立网站搭建** | HAP 前端项目搭建技能 | HAP 作为数据库，前后端分离 |
| 🔧 **MCP 配置管理** | HAP MCP 使用指南 | 自动化配置，密钥管理 |
| 📝 **API 文档维护** | HAP API 文档更新技能 | 中英文同步，接口管理 |
| ✍️ **内容创作** | 微信公众号文章写作 | 资料搜索，爆款标题 |

**快速决策：**

- **查询/操作数据** → HAP V3 API 使用技能
- **开发看板/视图** → HAP 视图插件开发技能
- **搭建网站** → HAP 前端项目搭建技能
- **配置 MCP** → HAP MCP 使用指南

---

## 🤝 贡献指南

我们欢迎所有形式的贡献！无论是新技能、文档改进、Bug 修复还是使用反馈。

### 如何贡献

1. **Fork 本仓库**
   ```bash
   git clone https://github.com/garfield-bb/hap-skills-collection.git
   ```

2. **创建特性分支**
   ```bash
   git checkout -b feature/AmazingFeature
   ```

3. **提交更改**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```

4. **推送到分支**
   ```bash
   git push origin feature/AmazingFeature
   ```

5. **创建 Pull Request**

📖 [详细贡献指南](./docs/contribution-guide.md)

---

## 📋 更新日志

### v1.0.0 (2026-01-14)

- ✅ 初始发布
- ✅ 7 个核心技能
- ✅ 支持 Claude Code、Cursor、Windsurf、Codeium
- ✅ 完整的安装和使用文档
- ✅ Cursor MCP 自动化配置功能

---

## 🔗 相关链接

- **明道云官网**: https://www.mingdao.com
- **HAP API 文档**: https://apifox.mingdao.com
- **Claude Code CLI**: https://docs.anthropic.com/claude/docs/claude-code
- **Cursor 编辑器**: https://cursor.sh
- **Windsurf 编辑器**: https://codeium.com/windsurf
- **Codeium**: https://codeium.com

---

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](./LICENSE) 文件了解详情。

---

## 💬 反馈与支持

- **问题反馈**: [GitHub Issues](https://github.com/garfield-bb/hap-skills-collection/issues)
- **功能建议**: [GitHub Discussions](https://github.com/garfield-bb/hap-skills-collection/discussions)
- **技术交流**: 欢迎加入明道云开发者社区

---

<div align="center">

**如果这个项目对你有帮助，请给我们一个 ⭐️ Star！**

Made with ❤️ by HAP Community

</div>
