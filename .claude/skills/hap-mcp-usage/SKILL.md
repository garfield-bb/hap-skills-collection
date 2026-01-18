---
name: hap-mcp-usage
description: 明道云 HAP MCP 自动化配置技能。当用户提到"配置 MCP"、"HAP MCP"、"MCP 配置"、"添加 MCP"、"MCP 连接"等需求时**立即触发**。支持 9 种 AI 工具的自动化配置，配置完成后自动验证连通性。
license: MIT
---

# HAP MCP 自动化配置技能

本技能帮助用户在 9 种 AI 工具中**自动化配置** HAP MCP 服务器，并验证连通性。

## 🎯 技能触发场景

当用户说以下任何内容时，**立即使用本技能**：
- "配置这个 MCP"
- "添加 MCP 服务器"
- "帮我配置 HAP MCP"
- "设置 MCP 连接"
- 提供了包含 `hap-mcp-` 的配置信息
- 提供了包含 `HAP-Appkey` 和 `HAP-Sign` 的 URL

## 关于 HAP MCP

HAP 提供两种不同类型的 MCP，**作用和使用场景完全不同**：

### 🔷 类型 1: HAP API 文档 MCP

**作用**: 让 AI 读懂 HAP 接口文档（只读，不执行操作）

**配置格式**（官方固定）:
```json
{
  "mcpServers": {
    "应用 API - API 文档": {
      "command": "npx",
      "args": ["-y", "apifox-mcp-server@latest", "--site-id=5442569"]
    }
  }
}
```

**适用场景**:
- 📖 查询 HAP API 文档
- 🛠️ 学习接口结构和参数
- 📝 生成 API 调用代码

### 🔶 类型 2: HAP 应用执行 MCP

**作用**: 让 AI 执行 HAP 应用接口（可操作真实数据）

**配置格式**（应用专属）:
```json
{
  "mcpServers": {
    "hap-mcp-应用名": {
      "url": "https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx"
    }
  }
}
```

**适用场景**:
- 🔍 查询应用真实数据
- ✏️ 创建/修改/删除记录
- 📊 数据统计和分析
- 🔄 执行工作流

---

## 🤖 AI 执行步骤（自动化配置）

当用户提供 MCP 配置时，AI 必须按以下步骤自动化完成配置：

### Step 1: 识别当前 AI 工具平台

首先确定用户当前使用的是哪个 AI 工具（从以下 9 个平台中识别）：

1. **Claude Code** - Anthropic 官方 CLI
2. **TRAE** - 标准化 `.trae/` 目录
3. **Cursor** - 最流行的 AI 编辑器
4. **GitHub Copilot** - GitHub 官方工具
5. **Google Antigravity** - Google 实验工具
6. **OpenCode** - 开源 AI 工具
7. **Windsurf** - Codeium 出品
8. **Gemini CLI** - Google Gemini 命令行
9. **Codex** - OpenAI 编程助手

**识别方法**:
- 如果用户明确提到工具名称，使用该工具
- 否则，询问用户："您当前使用的是哪个 AI 工具？（Claude Code / Cursor / TRAE / 其他）"

### Step 2: 解析 MCP 配置信息

从用户提供的配置中提取：
- **服务器名称**: 如 `hap-mcp-客户管理`
- **URL**: 包含 `HAP-Appkey` 和 `HAP-Sign` 的完整 URL
- **MCP 类型**: 根据配置格式判断是 API 文档 MCP 还是应用执行 MCP

### Step 3: 根据平台自动化配置

根据识别到的平台，执行对应的配置步骤：

#### 🔧 Claude Code

**配置方式**: 命令行
```bash
# 添加 HTTP MCP 服务器
claude mcp add <server-name> --url "<server-url>"

# 示例
claude mcp add hap-mcp-客户管理 --url "https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx"
```

**验证命令**:
```bash
claude mcp list
```

#### 🔧 Cursor

**配置文件**: `.cursor/mcp.json`（项目级，推荐）或 `~/.cursor/mcp.json`（全局）

**自动化步骤**:
1. 检查并创建 `.cursor` 目录（如果不存在）
2. 读取现有配置文件（如果存在）
3. 添加或更新 MCP 配置
4. 保存到 `.cursor/mcp.json`

**配置格式**:
```json
{
  "mcpServers": {
    "hap-mcp-应用名": {
      "url": "https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx"
    }
  }
}
```

**注意**: 不需要 `"type": "http"` 字段（旧格式）

#### 🔧 TRAE

**配置文件**: `.trae/mcp.json`（项目级）或 `~/.trae/mcp.json`（全局）

**自动化步骤**:
1. 检查并创建 `.trae` 目录
2. 读取或创建 `mcp.json`
3. 添加 MCP 配置（格式同 Cursor）
4. 保存文件

#### 🔧 GitHub Copilot

**配置文件**: `~/.copilot/mcp.json`

**自动化步骤**:
1. 检查并创建 `~/.copilot` 目录
2. 读取或创建 `mcp.json`
3. 添加 MCP 配置
4. 保存文件

**配置格式**: 同 Cursor

#### 🔧 Google Antigravity

**配置文件**: `~/.gemini/antigravity/config.json`

**自动化步骤**:
1. 检查并创建目录
2. 读取或创建配置文件
3. 在 `mcpServers` 部分添加配置
4. 保存文件

**配置格式**: 同 Cursor

#### 🔧 OpenCode

**配置文件**: `~/.config/opencode/mcp.json`

**自动化步骤**:
1. 检查并创建目录
2. 读取或创建配置文件
3. 添加 MCP 配置
4. 保存文件

**配置格式**: 同 Cursor

#### 🔧 Windsurf

**配置文件**: `~/.codeium/windsurf/mcp.json`

**自动化步骤**:
1. 检查并创建目录
2. 读取或创建配置文件
3. 添加 MCP 配置
4. 保存文件

**配置格式**: 同 Cursor

#### 🔧 Gemini CLI

**配置文件**: `~/.gemini/config.json`

**配置方式**: 命令行或配置文件

**命令行方式**:
```bash
gemini mcp add <server-name> --url "<server-url>"
```

**配置文件方式**: 同 Cursor，在 `mcpServers` 中添加

**参考文档**: https://github.com/google-gemini/gemini-cli/blob/main/docs/tools/mcp-server.md

#### 🔧 OpenAI Codex

**配置文件**: `~/.codex/config.toml`

**配置格式** (TOML):
```toml
[mcp_servers."hap-mcp-应用名"]
url = "https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx"
```

**自动化步骤**:
1. 读取现有 `config.toml`
2. 添加 MCP 服务器配置（TOML 格式）
3. 保存文件

### Step 4: 验证 MCP 连通性

**重要**: 配置完成后，**必须自动验证** MCP 是否可以正常连接。

**验证方法**:
1. 调用 MCP 工具：`get_app_info`（获取应用信息）
2. 检查返回结果：
   - ✅ 成功：返回应用信息（应用名称、工作表列表等）
   - ❌ 失败：返回错误信息（鉴权失败、网络错误等）

**验证示例**:
```javascript
// 调用 MCP 工具验证连通性
const result = await mcpClient.call('get_app_info');

if (result.success) {
  console.log('✅ MCP 连接成功！');
  console.log('应用名称：', result.appName);
  console.log('工作表数量：', result.worksheets.length);
} else {
  console.error('❌ MCP 连接失败：', result.error);
}
```

### Step 5: 向用户报告结果

配置完成后，向用户报告：

**成功时**:
```
✅ MCP 配置成功！

📋 配置信息：
- 平台：Cursor
- 服务器名称：hap-mcp-客户管理
- 配置文件：.cursor/mcp.json

✅ 连通性验证通过：
- 应用名称：客户管理系统
- 工作表数量：5 个

💡 下一步：
- 重启 Cursor 使配置生效
- 现在可以使用 MCP 工具操作数据了
```

**失败时**:
```
❌ MCP 配置已保存，但连通性验证失败

📋 配置信息：
- 平台：Cursor
- 配置文件：.cursor/mcp.json

❌ 连接错误：
- 错误信息：鉴权失败，请检查 Appkey 和 Sign

🔧 解决方案：
1. 检查 Appkey 和 Sign 是否正确
2. 确认应用是否已启用 MCP 功能
3. 重启 Cursor 后重试
```

---

## 📋 配置文件位置速查表

| 平台 | 项目级配置 | 全局配置 | 格式 |
|------|-----------|---------|------|
| **Claude Code** | - | 命令行配置 | 命令 |
| **Cursor** | `.cursor/mcp.json` | `~/.cursor/mcp.json` | JSON |
| **TRAE** | `.trae/mcp.json` | `~/.trae/mcp.json` | JSON |
| **GitHub Copilot** | - | `~/.copilot/mcp.json` | JSON |
| **Antigravity** | - | `~/.gemini/antigravity/config.json` | JSON |
| **OpenCode** | - | `~/.config/opencode/mcp.json` | JSON |
| **Windsurf** | - | `~/.codeium/windsurf/mcp.json` | JSON |
| **Gemini CLI** | - | `~/.gemini/config.json` | JSON |
| **Codex** | - | `~/.codex/config.toml` | TOML |

**推荐策略**:
- 支持项目级配置的平台（Cursor, TRAE）：优先使用项目级
- 其他平台：使用全局配置

---

## ⚠️ 重要注意事项

### 配置时必须做到

- ✅ **自动化执行**: 直接帮用户配置，不要只告诉步骤
- ✅ **平台识别**: 准确识别用户使用的工具
- ✅ **格式检查**: 确保 JSON/TOML 格式正确
- ✅ **验证连通**: 配置后立即验证 MCP 是否可用
- ✅ **保留配置**: 更新时不删除其他已存在的 MCP
- ✅ **错误处理**: 如果配置或验证失败，提供清晰的错误信息

### 配置时不要做

- ❌ 不要只告诉用户如何配置，要直接执行
- ❌ 不要跳过连通性验证步骤
- ❌ 不要使用错误的配置格式（如 Cursor 添加 `type: http`）
- ❌ 不要覆盖用户的其他 MCP 配置
- ❌ 不要忘记提示用户重启工具

### 配置优先级

1. **项目级配置** - 如果平台支持（Cursor, TRAE）
2. **全局配置** - 其他平台或用户明确要求

### 安全提示

- 🔐 提醒用户保护 `HAP-Appkey` 和 `HAP-Sign`
- 🔐 不要将配置文件提交到 Git（建议添加到 `.gitignore`）
- 🔐 定期检查和更新鉴权信息

---

## 📚 配置示例

### 示例 1: Cursor 项目级配置

**用户提供**:
```json
{"hap-mcp-客户管理":{"url":"https://api.mingdao.com/mcp?HAP-Appkey=abc123&HAP-Sign=xyz789"}}
```

**AI 执行**:
1. 创建 `.cursor` 目录（如果不存在）
2. 读取或创建 `.cursor/mcp.json`
3. 添加配置:
```json
{
  "mcpServers": {
    "hap-mcp-客户管理": {
      "url": "https://api.mingdao.com/mcp?HAP-Appkey=abc123&HAP-Sign=xyz789"
    }
  }
}
```
4. 调用 `get_app_info` 验证连通性
5. 报告结果给用户

### 示例 2: Claude Code 命令行配置

**用户提供**: 同上

**AI 执行**:
```bash
claude mcp add hap-mcp-客户管理 --url "https://api.mingdao.com/mcp?HAP-Appkey=abc123&HAP-Sign=xyz789"
```

验证:
```bash
claude mcp list
```

### 示例 3: Codex TOML 配置

**用户提供**: 同上

**AI 执行**:
编辑 `~/.codex/config.toml`:
```toml
[mcp_servers."hap-mcp-客户管理"]
url = "https://api.mingdao.com/mcp?HAP-Appkey=abc123&HAP-Sign=xyz789"
```

---

## 🎯 总结

本技能的核心价值：
1. **自动化** - 用户只需提供配置，AI 自动完成所有步骤
2. **全平台支持** - 支持 9 种主流 AI 工具
3. **验证保障** - 配置后立即验证连通性，确保可用
4. **错误处理** - 清晰的错误信息和解决方案

**记住**: 用户说"配置 MCP"时，不要问"需要我帮您配置吗？"，而是立即执行配置流程！
