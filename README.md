# HAP Skills Collection

<div align="center">

![HAP Skills](https://img.shields.io/badge/HAP-Skills-blue)
![Platforms](https://img.shields.io/badge/platforms-9-green)
![License](https://img.shields.io/badge/license-MIT-orange)
![Version](https://img.shields.io/badge/version-2.0.0-purple)

**明道云 HAP 开发技能集合** - 让 AI 编程工具理解并使用明道云 HAP 平台

支持 **9 种主流 AI 工具** 的一键安装

[快速开始](#-快速开始) • [技能列表](#-技能列表) • [平台支持](#-支持的平台) • [安装指南](#-安装指南)

[English](./README.en.md) | [中文](./README.md)

</div>

---

## 📖 项目简介

**HAP Skills Collection** 是一套专为明道云 HAP 平台开发的 AI 技能包集合，让主流 AI 编程工具能够**自动理解并使用**明道云的 API、开发规范和最佳实践。

### ✨ 核心特性

- 🎯 **零学习成本** - AI 自动理解明道云 API，无需手动查文档
- 🛠️ **最佳实践内置** - 基于实战经验的开发规范和技巧
- 🔄 **完整工作流** - 从项目初始化到发布上线的全流程支持
- 📚 **持续更新** - 跟随明道云平台更新，保持最新
- 🔌 **9 平台支持** - 支持所有主流 AI 编程工具，一键安装

### 🎯 包含技能

本项目包含 **3 个核心技能**，涵盖 HAP 平台开发的各个场景：

| 技能 | 适用场景 |
|------|----------|
| 🔧 **HAP MCP 使用技能** | 自动化配置 MCP；搭建自动化流程；搭建应用 / 操作数据 |
| 📊 **HAP V3 API 使用技能** | 需要通过 API 进行数据查询与数据操作 |
| 🎨 **HAP 视图插件开发技能** | 自动化搭建并发布视图插件（扩展页面、对外分享） |

---

## 📱 支持的平台

本项目支持 **9 种主流 AI 编程工具**，涵盖所有常用平台：

| 平台 | 兼容性 | 安装方式 | 目录位置 | 推荐度 |
|------|--------|----------|----------|--------|
| **Claude Code** | ✓ 原生 | 脚本/手动 | `~/.claude/skills/` | ⭐⭐⭐⭐⭐ |
| **TRAE** | ✓ 原生兼容 | 脚本/手动 | `~/.trae/skills/` | ⭐⭐⭐⭐⭐ |
| **Cursor** | ✓ 原生兼容 | 脚本/手动 | `~/.cursor/skills/` | ⭐⭐⭐⭐⭐ |
| **GitHub Copilot** | ✓ 原生兼容 | 脚本/手动 | `~/.copilot/skills/` | ⭐⭐⭐⭐ |
| **Google Antigravity** | ✓ 原生兼容 | 脚本/手动 | `~/.gemini/antigravity/skills/` | ⭐⭐⭐⭐ |
| **OpenCode** | ✓ 原生兼容 | 脚本/手动 | `~/.config/opencode/skill/` | ⭐⭐⭐⭐ |
| **Windsurf** | ⚡ 软链接 | 脚本自动 | `~/.codeium/windsurf/skills/` | ⭐⭐⭐⭐ |
| **Gemini CLI** | ⚡ 软链接 | 脚本自动 | `~/.gemini/skills/` | ⭐⭐⭐ |
| **OpenAI Codex** | ⚡ 软链接 | 脚本自动 | `~/.codex/skills/` | ⭐⭐⭐ |

**符号说明:**
- **✓ 原生** - 工具自动扫描或使用相同的目录结构，无需额外配置
- **⚡ 软链接** - 通过链接到 Claude 目录实现自动同步，更新一处全部同步

---

## 🚀 快速开始

### 💡 推荐策略："一次安装，到处运行"

**默认规则：全局安装到 Claude Code**

1. **为什么选择 Claude？**
   - ✅ Anthropic 官方工具，最标准的实现
   - ✅ 原生支持 skills，兼容性最好
   - ✅ 其他平台可以直接兼容或软链接

2. **"一次安装，到处运行"的优势：**
   - 🎯 **一次安装** - 只需在 `~/.claude/skills/` 安装一次
   - 🔄 **自动同步** - 原生兼容平台自动识别，软链接平台自动同步
   - 💾 **节省空间** - 避免多次复制，统一维护
   - ⚡ **更新简单** - 更新 Claude 目录，所有平台立即生效

3. **实施步骤：**

```bash
# 1. 克隆仓库
git clone https://github.com/garfield-bb/hap-skills-collection.git
cd hap-skills-collection

# 2. 一键全局安装（默认推荐）
./install.sh --all --global  # macOS/Linux
.\install.ps1 -All -Global   # Windows（管理员权限）

# 结果：
# ✅ Claude Code:     ~/.claude/skills/          (主目录)
# ✅ TRAE:            ~/.trae/skills/            (独立副本)
# ✅ Cursor:          ~/.cursor/skills/          (独立副本)
# ✅ Copilot:         ~/.copilot/skills/         (独立副本)
# ✅ Antigravity:     ~/.gemini/antigravity/skills/ (独立副本)
# ✅ OpenCode:        ~/.config/opencode/skill/  (独立副本)
# ⚡ Windsurf:        ~/.codeium/windsurf/skills/ → ~/.claude/skills/ (软链接)
# ⚡ Gemini CLI:      ~/.gemini/skills/          → ~/.claude/skills/ (软链接)
# ⚡ Codex:           ~/.codex/skills/           → ~/.claude/skills/ (软链接)
```

### ✅ 验证安装

在任一已安装的平台中测试：

```
你: 帮我使用 HAP V3 API 查询数据
AI: [自动使用 HAP V3 API 技能，提供完整的查询步骤]

你: 帮我开发一个明道云视图插件
AI: [自动使用视图插件开发技能，引导完整开发流程]
```

📚 **需要更多帮助？** 查看 [详细安装指南](./docs/INSTALLATION.md) 或 [快速启动指南](./docs/QUICK_START.md)

---

## 📚 技能列表

本项目包含 **3 个核心技能**，涵盖明道云 HAP 平台开发的各个方面。

### 1. HAP V3 API 使用技能 ⭐⭐⭐⭐⭐

**一句话介绍：** 使用明道云 V3 接口进行数据查询、操作和业务编排的完整工作流指南。

**适用场景：**
- 在自定义视图插件中调用 HAP API 获取和操作数据
- 在独立前端页面中使用 V3 接口编排业务逻辑
- 进行数据迁移、批量操作和数据同步
- 基于 HAP 开发完整的应用系统

**核心能力：**
- 📖 **完整工作流** - 从零开始的 API 调用全流程（获取应用信息 → 工作表结构 → 数据操作）
- 🔍 **Filter 筛选器** - 完整的筛选器语法、运算符使用和复杂条件构建
- 🔗 **关联字段查询** - 深度查询关联记录、子表数据的最佳实践
- ⚠️ **常见陷阱** - 选项字段 key 值、关联字段处理等常见问题的解决方案
- ⚡ **性能优化** - 分页查询、批量操作、并发控制的最佳实践
- 🔑 **鉴权配置** - 从 MCP 配置自动提取或手动配置 Appkey/Sign

**AI 会自动帮你：**
1. 从 MCP 配置中提取鉴权密钥（如果已配置）
2. 获取应用和工作表的完整结构信息
3. 识别字段类型并构建正确的查询参数
4. 处理选项字段的 key 值映射
5. 构建符合规范的 Filter 筛选器
6. 执行 API 调用并格式化返回结果

**使用示例：**
```
你: 帮我查询"客户管理"工作表中，本月新增的、状态为"成交"的客户列表

AI 会自动完成：
1. 获取应用信息和工作表结构
2. 找到"状态"字段的选项 key 值
3. 构建时间范围和状态的组合筛选器
4. 调用查询接口并返回结果
```

📁 [查看完整文档](./.claude/skills/hap-v3-api/SKILL.md)

---

### 2. HAP 视图插件开发技能 ⭐⭐⭐⭐⭐

**一句话介绍：** 创建和开发明道云自定义视图插件的完整开发流程和最佳实践。

**适用场景：**
- 开发数据看板、BI 驾驶舱展示业务数据
- 创建订单看板、任务看板等自定义视图
- 开发日历视图、甘特图、时间轴视图
- 构建地图视图、自定义图表等特殊业务视图

**核心能力：**
- 🚀 **7 步开发流程** - 环境检查 → 模板选择 → 项目初始化 → 开发 → 调试 → 构建 → 发布
- 📦 **4 种模板** - JavaScript、React、React+Tailwind、Vue 模板自动选择
- 🔧 **字段处理** - 正确处理选项、关联、成员、附件等各种字段类型
- 🔌 **双 API 集成** - mdye API（获取当前视图数据）+ V3 API（深度查询）
- 📊 **BI 看板设计** - 数据卡片、图表、表格等组件的最佳实践
- 🎨 **响应式布局** - 自适应不同屏幕尺寸的布局方案

**AI 会自动帮你：**
1. 检查 mdye-cli 是否已安装
2. 根据需求选择合适的模板（需要 UI 组件库 → React-Tailwind）
3. 初始化项目并配置开发环境
4. 获取工作表字段结构并生成类型定义
5. 编写数据查询逻辑（mdye API + V3 API）
6. 设计看板布局和组件结构
7. 配置开发服务器和构建流程
8. 生成发布包并提供发布步骤

**使用示例：**
```
你: 帮我开发一个销售数据看板，显示今日销售额、订单数量、客户分布和销售趋势图

AI 会自动完成：
1. 选择 React-Tailwind 模板（适合看板开发）
2. 初始化项目并配置 Tailwind CSS
3. 获取"订单"工作表的字段结构
4. 编写数据查询逻辑（今日订单、统计汇总）
5. 设计 4 个数据卡片 + 1 个图表组件
6. 实现响应式布局
7. 启动开发服务器供实时预览
```

📁 [查看完整文档](./.claude/skills/hap-view-plugin/SKILL.md)

---

### 3. HAP MCP 使用指南 ⭐⭐⭐⭐

**一句话介绍：** 配置和管理 HAP MCP Server，让 AI 工具直接操作明道云应用数据。

**核心能力：**
- 🔧 **MCP Server 配置** - 在 Cursor、Claude 等工具中配置 MCP 服务器
- 🤖 **自动化配置** - 自动读取 Cursor 配置文件并添加 MCP 配置
- 🔑 **密钥管理** - 从 MCP URL 提取 Appkey 和 Sign，供其他技能使用
- 📖 **两种 MCP 类型** - API 文档 MCP vs 应用执行 MCP 的区别和使用场景
- ✅ **配置验证** - 验证 MCP 配置是否正确并可用

**AI 会自动帮你：**
1. 识别 MCP 配置格式（JSON 对象）
2. 读取 Cursor 的 settings.json 或 mcp.json 文件
3. 解析 MCP URL 中的鉴权参数
4. 添加或更新 MCP 服务器配置
5. 验证配置语法和格式
6. 提示重启工具使配置生效

**两种 MCP 类型说明：**

| 类型 | 用途 | URL 格式 | 工具使用 |
|-----|------|---------|---------|
| **API 文档 MCP** | 提供 HAP API 文档供 AI 参考 | `https://apifox.mingdao.com/mcp/...` | 无需鉴权密钥 |
| **应用执行 MCP** | 直接操作应用数据（查询、新增、修改） | `https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx` | 包含鉴权密钥 |

**使用示例：**
```
你: 帮我配置这个 MCP
{"hap-mcp-客户管理":{"url":"https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx"}}

AI 会自动完成：
1. 识别这是应用执行 MCP
2. 读取 ~/.cursor/mcp.json 文件
3. 添加 "hap-mcp-客户管理" 配置
4. 保存文件并验证
5. 提示重启 Cursor
```

📁 [查看完整文档](./.claude/skills/hap-mcp-usage/SKILL.md)

### 📚 详细文档

需要更多帮助？查看详细指南：

- **[快速启动指南](./docs/QUICK_START.md)** - 5 分钟快速开始
- **[通用安装指南](./docs/INSTALLATION.md)** - 支持所有平台的详细说明
- **[平台兼容性说明](./docs/INSTALLATION.md#平台兼容性)** - 了解各平台的支持情况
- **[常见问题](./docs/INSTALLATION.md#常见问题)** - 安装疑难解答

---

## 💡 使用示例

### 示例 1: 使用 V3 API 查询数据

**场景:** 查询"客户管理"工作表中本月新增的、状态为"成交"的客户

```
你: 帮我查询"客户管理"工作表中，本月新增的、状态为"成交"的客户列表

AI 会自动完成：
1. 获取应用信息和工作表结构
2. 找到"状态"字段的选项 key 值
3. 构建时间范围筛选器（本月）
4. 构建状态筛选器（成交）
5. 组合多个筛选条件（AND 逻辑）
6. 调用查询接口并返回结果
```

### 示例 2: 开发视图插件

**场景:** 开发一个销售数据看板，显示关键业务指标

```
你: 帮我开发一个销售数据看板，显示今日销售额、订单数量、客户分布和销售趋势

AI 会自动完成：
1. 检查 mdye-cli 环境
2. 选择 React-Tailwind 模板（适合看板）
3. 初始化项目并配置 Tailwind
4. 获取"订单"工作表字段结构
5. 编写数据查询逻辑（今日订单统计）
6. 设计 4 个数据卡片组件
7. 添加销售趋势图表
8. 实现响应式布局
9. 启动开发服务器
```

### 示例 3: 配置 MCP Server

**场景:** 配置应用执行 MCP，让 AI 直接操作数据

```
你: 帮我配置这个 MCP
{"hap-mcp-客户管理":{"url":"https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx"}}

AI 会自动完成：
1. 读取 Cursor 配置文件
2. 解析 MCP URL 和鉴权参数
3. 添加 MCP 服务器配置
4. 验证配置语法
5. 提示重启 Cursor 使配置生效
```

---

## 🎯 技能选择指南

根据你的开发需求选择合适的技能：

| 开发需求 | 推荐技能 | 核心优势 |
|---------|---------|---------|
| 📊 **数据查询和操作** | HAP V3 API 使用技能 | 完整工作流、Filter 语法、关联查询 |
| 🎨 **自定义视图开发** | HAP 视图插件开发技能 | 7 步流程、4 种模板、BI 看板指南 |
| 🔧 **MCP 配置管理** | HAP MCP 使用指南 | 自动化配置、密钥提取和管理 |

**快速决策流程：**

```
需要查询/操作数据？           → HAP V3 API 使用技能
需要开发看板/视图？           → HAP 视图插件开发技能
需要配置 MCP Server？       → HAP MCP 使用指南
```

---

## 📁 项目结构

```
hap-skills-collection/
├── README.md                          # 项目主文档
├── README.en.md                       # 英文文档
├── LICENSE                            # MIT 许可证
├── install.sh                         # macOS/Linux 安装脚本
├── install.ps1                        # Windows 安装脚本
├── uninstall.sh                       # 卸载脚本
├── docs/                              # 文档目录
│   ├── QUICK_START.md                 # 快速启动指南
│   ├── INSTALLATION.md                # 详细安装指南
│   └── ...                            # 其他文档
├── .claude/skills/                    # 技能目录
│   ├── hap-v3-api/                    # HAP V3 API 使用技能
│   │   ├── SKILL.md                   # 技能文档
│   │   └── references/                # 参考文档
│   ├── hap-view-plugin/               # 视图插件开发技能
│   │   ├── SKILL.md
│   │   └── references/
│   ├── hap-mcp-usage/                 # MCP 使用指南
│   │   └── SKILL.md
│   └── hap-skills-updater/            # Skills 更新工具（内部使用）
│       └── SKILL.md
└── mcp-mingdao-proxy/                 # MCP 代理工具
    └── README.md
```

---

## 📋 更新日志

### v2.0.0 (2026-01-18)

**🎉 重大更新 - 通用安装系统**

- ✨ **新增支持 5 个平台** - 总计支持 9 种 AI 工具
  - 新增：TRAE（标准化目录）
  - 新增：GitHub Copilot（原生兼容）
  - 新增：Google Antigravity（原生兼容）
  - 新增：OpenCode（原生兼容）
  - 新增：Gemini CLI（软链接）
  - 新增：OpenAI Codex（软链接）

- 🚀 **通用安装脚本**
  - 新增：macOS/Linux 一键安装脚本（`install.sh`）
  - 新增：Windows PowerShell 安装脚本（`install.ps1`）
  - 新增：卸载脚本（`uninstall.sh`）
  - 支持：交互式安装模式
  - 支持：全局/项目级安装
  - 支持：自动软链接创建
  - 支持：配置备份和验证

- 📚 **完善文档体系**
  - 新增：[快速启动指南](./docs/QUICK_START.md) - 5 分钟快速上手
  - 新增：[通用安装指南](./docs/INSTALLATION.md) - 所有平台详细说明
  - 新增：[英文 README](./README.en.md)
  - 优化：主 README 结构和内容

- 🔧 **TRAE 原生支持**
  - 完全遵循 TRAE 标准化 `.trae/skills/` 目录设计
  - 与 Claude Code 100% 兼容

- 💡 **最佳实践**
  - 提供"一次安装，到处运行"的策略
  - 软链接平台自动同步更新
  - 详细的平台兼容性说明

### v1.0.0 (2026-01-14)

- ✅ 初始发布
- ✅ 3 个核心技能
  - HAP V3 API 使用技能
  - HAP 视图插件开发技能
  - HAP MCP 使用指南
- ✅ 支持 4 个平台
  - Claude Code（原生）
  - Cursor（原生兼容）
  - Windsurf（软链接）
  - Codeium（手动配置）
- ✅ 完整的使用文档
- ✅ Cursor MCP 自动化配置功能

---

## 🔗 相关链接

### 明道云平台
- **明道云官网**: https://www.mingdao.com
- **HAP API 文档**: https://apifox.mingdao.com
- **明道云帮助中心**: https://help.mingdao.com

### 支持的 AI 工具
- **Claude Code**: https://claude.ai/code
- **Cursor**: https://cursor.sh
- **GitHub Copilot**: https://github.com/features/copilot
- **Windsurf**: https://codeium.com/windsurf
- **Codeium**: https://codeium.com

### 本项目
- **GitHub 仓库**: https://github.com/garfield-bb/hap-skills-collection
- **问题反馈**: https://github.com/garfield-bb/hap-skills-collection/issues
- **功能建议**: https://github.com/garfield-bb/hap-skills-collection/discussions

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
