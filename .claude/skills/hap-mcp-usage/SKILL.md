---
name: hap-mcp-usage
description: 明道云 HAP MCP 使用指南技能。当用户提到"HAP MCP"、"MCP 配置"、"MCP 使用"、"API 文档 MCP"、"应用执行 MCP"等需求时使用。帮助用户理解和正确使用两种 HAP MCP，并在 Cursor 中自动化配置 MCP 服务器。
license: MIT
---

# HAP MCP Usage Skill

本技能帮助用户理解和正确使用明道云 HAP 的两种 MCP 服务。

## 关于 HAP MCP

HAP 提供两种不同类型的 MCP，**作用和使用场景完全不同**，需要明确区分。

---

## 🔷 类型 1: HAP API 文档 MCP (ApiFox MCP)

### 作用
让 AI 模型"读懂 HAP 的接口文档"。

### 特点
- 📖 **只读的接口文档服务**，不会执行任何操作
- 📚 帮助理解 HAP API V3 的结构、参数、示例
- 🎓 类似于"API 使用手册"

### 重要限制
⚠️ 该 MCP 仅支持读取 **V3 分组**下的 API 接口
- **原因**: V2 API 即将淘汰，官方已不再推荐使用

### 使用场景
- 📖 学习和理解 HAP API 的结构
- 🛠️ 开发前的 API 调研和方案设计
- 📝 生成 API 调用代码
- 🔍 查找合适的接口用于业务编排

### 典型案例
```
场景: 有个客户案例管理应用，想基于应用数据做个可视化页面

步骤:
1. 通过 ApiBox MCP 读取 HAP 接口文档
2. 了解有哪些 API 可用（获取数据、筛选、统计等）
3. 在 IDE 中生成调用代码
4. 实现对应用数据的实时展示

关键点: 只读文档，不会修改任何数据
```

### 特点总结
- ✅ 暴露接口定义、文档、示例
- ✅ 帮助理解 API 结构和用法
- ✅ 适合开发阶段的研发助手
- ❌ MCP 本身不能直接执行业务操作
- ❌ MCP 本身不能访问真实数据
- ℹ️ 用户可根据文档自行配置密钥并编排请求来操作数据

### 配置方式（官方固定配置）
```json
{
  "mcpServers": {
    "应用 API - API 文档": {
      "command": "npx",
      "args": [
        "-y",
        "apifox-mcp-server@latest",
        "--site-id=5442569"
      ]
    }
  }
}
```

### 何时使用
- 用户说"我想了解 HAP 有哪些 API"
- 用户说"帮我查查 HAP 接口文档"
- 用户说"怎么调用 HAP 的获取数据接口"
- 开发阶段需要 API 参考

---

## 🔶 类型 2: HAP 应用执行 MCP (HAP Application MCP)

### 作用
让 AI 模型"执行 HAP 应用接口"。

### 特点
- ⚡ **可执行的业务工具**，会真实操作数据
- 🔧 直接调用 HAP API 进行增删改查
- 🔐 带有应用鉴权信息，可以访问真实业务数据

### 使用场景
- 🔍 直接查询应用中的真实数据
- ✏️ 创建、修改、删除业务记录
- 📊 统计和分析应用数据
- 🔄 执行业务流程和工作流
- 🎯 系统集成和数据编排

### 典型案例
```
场景: 编排场景中，需要查询客户数据并更新订单状态

步骤:
1. 使用 HAP Application MCP 获取应用结构
2. 查询符合条件的客户记录
3. 分析数据并进行字段映射
4. 直接更新订单表中的状态字段

关键点: 真实数据操作，有权限控制
```

### 特点总结
- ✅ 可执行真实的业务操作
- ✅ 访问应用中的真实数据
- ✅ 带权限和安全控制
- ✅ 适合生产环境的智能管家
- ⚠️ 需要 Appkey 和 Sign 鉴权
- ⚠️ 操作会影响真实业务数据

### 配置方式（应用专属配置）

**Cursor 自动化配置：**
- 配置文件位置：`~/.cursor/mcp.json`
- 配置格式示例：
```json
{
  "mcpServers": {
    "hap-mcp-API测试": {
      "url": "https://api.mingdao.com/mcp?HAP-Appkey=539f83a2********&HAP-Sign=YmYwZmMyM2M0ZDdjNDUxMGMzMTY2MTQ5Y2MxNDhmMTZlM2Q3NjE1OTNiYzdlOGJh********"
    }
  }
}
```
- ✅ 配置完成后会自动生效，无需重启 Cursor
- ✅ **配置后必须验证**：调用 MCP 工具测试配置是否正常工作

### 配置特征识别
- ✅ 服务器名称通常是 `hap-mcp-xxx`（应用名称）
- ✅ 使用 `url` 字段而非 `command`
- ✅ URL 中包含 `HAP-Appkey` 和 `HAP-Sign` 参数
- ✅ 指向 `api.mingdao.com/mcp` 端点

### 何时使用
- 用户说"查询 XXX 应用的数据"
- 用户说"帮我创建一条 XXX 记录"
- 用户说"统计 XXX 的数量"
- 用户说"更新 XXX 的状态"
- 需要真实操作业务数据时

---

## 🎯 两种 MCP 的对比

| 维度 | API 文档 MCP (ApiBox) | 应用执行 MCP (Application) |
|-----|---------------------|-------------------------|
| **作用** | 提供接口文档查询 | 直接执行业务操作 |
| **类型** | 只读文档服务 | 可执行工具 |
| **数据** | 接口定义、参数、示例 | 真实业务数据 |
| **权限** | 无需鉴权（公开文档） | 需要 Appkey + Sign |
| **适用阶段** | 开发/设计/学习阶段 | 生产/执行阶段 |
| **配置方式** | 官方固定（npx） | 应用专属（url） |
| **安全性** | 低风险（仅查询文档） | 高风险（操作真实数据） |
| **角色定位** | API 参考手册 + 研发助手 | 业务执行器 + 智能管家 |
| **能否操作数据** | MCP本身不能，但可查文档后自行编排 | MCP 可直接操作数据 |

---

## 🤖 AI 助手使用指南

### 决策树

```
用户请求
  ├─ 询问"有哪些 API"/"如何调用"
  │   └─ 使用 API 文档 MCP (ApiBox)
  │
  ├─ 需要"查询真实数据"/"操作记录"
  │   └─ 使用应用执行 MCP (Application)
  │
  ├─ 开发阶段的代码生成
  │   └─ 使用 API 文档 MCP (ApiBox)
  │
  └─ 生产环境的数据处理
      └─ 使用应用执行 MCP (Application)
```

### 常见场景示例

#### 场景 1: "HAP 有哪些获取数据的 API?"
- **使用**: API 文档 MCP
- **原因**: 查询接口定义

#### 场景 2: "查询客户管理应用中的所有客户"
- **使用**: 应用执行 MCP
- **原因**: 访问真实数据

#### 场景 3: "帮我写个调用 HAP API 的代码"
- **使用**: API 文档 MCP
- **原因**: 生成开发代码

#### 场景 4: "把这条订单的状态改为已完成"
- **使用**: 应用执行 MCP
- **原因**: 执行业务操作

---

## ⚙️ 配置建议

### 开发者场景（推荐两个都配置）

```json
{
  "mcpServers": {
    "应用 API - API 文档": {
      "command": "npx",
      "args": ["-y", "apifox-mcp-server@latest", "--site-id=5442569"]
    },
    "hap-mcp-客户管理": {
      "url": "https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx"
    }
  }
}
```

### 纯使用者场景（只需应用执行 MCP）

```json
{
  "mcpServers": {
    "hap-mcp-客户管理": {
      "url": "https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx"
    }
  }
}
```

---

## 🛠️ Cursor 自动化配置指南

当用户在 Cursor 中需要配置或更新 HAP MCP 时，AI 助手应该**自动化完成配置**，而不是只告诉用户如何手动配置。

### Cursor MCP 配置文件位置

Cursor 的 MCP 配置支持两种方式，**项目级配置优先于全局配置**：

**项目级配置**（推荐用于项目专属 MCP）：
- 在项目根目录创建：`.cursor/mcp.json`
- 仅对当前项目有效
- 适合团队协作或项目特定的 MCP 配置

**全局配置**（适用于所有项目）：
- **macOS**: `~/.cursor/mcp.json`
- **Windows**: `%USERPROFILE%\.cursor\mcp.json`
- **Linux**: `~/.cursor/mcp.json`
- 对所有项目都有效
- 适合个人常用 MCP 配置

**优先级**：如果项目级和全局配置都存在同名 MCP，项目级配置会覆盖全局配置。

**⚠️ 重要说明**：旧版 Cursor 使用 `settings.json` 配置 MCP，现在已改为使用 `.cursor/mcp.json`。

### 自动化配置步骤

当用户提供 MCP 配置信息时（例如：`{"hap-mcp-应用名":{"url":"https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx"}}`），AI 应该：

1. **确定配置位置**
   - **优先使用项目级配置**：在项目根目录创建或更新 `.cursor/mcp.json`
   - 如果用户明确要求全局配置，则使用全局 `~/.cursor/mcp.json`
   - 如果没有 `.cursor` 目录，先创建它

2. **读取现有配置文件（如果存在）**
   - 使用 `read_file` 工具读取现有配置文件
   - 检查是否已存在 `mcpServers` 配置

3. **解析用户提供的配置**
   - 提取服务器名称（如 `hap-mcp-清华大学官网`）
   - 提取 URL（包含 Appkey 和 Sign）

4. **更新或添加配置**
   - 如果配置文件中已有 `mcpServers`，则更新或添加新的服务器配置
   - 如果配置文件中没有 `mcpServers`，则创建新的配置结构
   - **注意**：`.cursor/mcp.json` 中 `url` 类型的 MCP **不需要**添加 `"type": "http"` 字段（这是旧 `settings.json` 格式）

5. **保存配置文件**
   - 使用 `write` 工具创建或更新 `.cursor/mcp.json` 文件
   - 保持 JSON 格式正确，注意逗号和缩进

6. **验证配置状态**（重要！）
   - 配置完成后，必须验证配置是否正常工作
   - 通过调用 MCP 工具测试，如：
     - 调用 `get_time` 获取当前时间
     - 调用 `get_app_info` 获取应用信息
   - 如果验证成功，说明配置已自动生效，无需重启 Cursor

### 配置格式示例

#### 新增应用执行 MCP

如果用户提供：
```json
{"hap-mcp-清华大学官网":{"url":"https://api.mingdao.com/mcp?HAP-Appkey=6802bfa5da37d75f&HAP-Sign=MWZmZWU1YmMyMzE4ZTAxYjY3NTViYjM5NzhlNTdhOTIwZWFhYTc2Y2I2YzljNWMzNDFmMjk4NTM2N2M0YTg2OA=="}}
```

AI 应该在项目根目录创建或更新 `.cursor/mcp.json` 文件：
```json
{
  "mcpServers": {
    "hap-mcp-清华大学官网": {
      "url": "https://api.mingdao.com/mcp?HAP-Appkey=6802bfa5da37d75f&HAP-Sign=MWZmZWU1YmMyMzE4ZTAxYjY3NTViYjM5NzhlNTdhOTIwZWFhYTc2Y2I2YzljNWMzNDFmMjk4NTM2N2M0YTg2OA=="
    }
  }
}
```

**重要说明**：
- `.cursor/mcp.json` 格式中，`url` 类型的 MCP **不需要** `"type": "http"` 字段
- `"type": "http"` 只在旧的 `settings.json` 配置方式中需要

#### 更新现有 MCP 配置

如果配置已存在，AI 应该：
- 使用 `search_replace` 工具更新对应的 URL
- 保持其他配置不变
- 确保 JSON 格式正确

### 实际操作示例

**场景**: 用户说"帮我配置这个 MCP"并提供了配置信息

**AI 操作流程**:
1. 检查项目根目录是否存在 `.cursor` 目录，不存在则创建
2. 读取或创建 `.cursor/mcp.json` 文件（优先使用项目级配置）
3. 检查现有配置结构（如果文件已存在）
4. 解析用户提供的 MCP 配置
5. 更新或添加 `mcpServers` 配置项
6. 保存文件到 `.cursor/mcp.json`
7. **验证配置状态**：调用 MCP 工具（如 `get_time` 或 `get_app_info`）测试配置是否正常工作
8. 告知用户配置已完成，配置已自动生效无需重启 Cursor

### 注意事项

- ✅ **自动化执行**: 不要只告诉用户如何配置，应该直接帮用户配置好
- ✅ **配置位置**: 优先使用项目级 `.cursor/mcp.json`，而非全局 `settings.json`（旧方式）
- ✅ **格式检查**: 确保 JSON 格式正确，注意逗号、引号、括号匹配
- ✅ **保留现有配置**: 更新时不要删除其他已存在的 MCP 配置
- ✅ **格式区别**: `.cursor/mcp.json` 中 `url` 类型 MCP **不需要** `"type": "http"` 字段
- ✅ **配置验证**: 配置完成后必须验证配置状态，通过调用 MCP 工具测试
- ✅ **自动生效**: 配置完成后会自动生效，无需重启 Cursor
- ⚠️ **目录创建**: 如果 `.cursor` 目录不存在，需要先创建它
- ⚠️ **权限问题**: 如果文件无法写入，提示用户检查文件权限
- ⚠️ **备份建议**: 更新前可以提醒用户配置文件包含敏感信息

### 配置后的提示

配置完成后，AI 应该告知用户：
- ✅ 配置已保存到 `.cursor/mcp.json`（项目级配置）
- ✅ 配置位置：项目根目录下的 `.cursor/mcp.json`
- ✅ 可能需要重启 Cursor 才能生效
- ⚠️ 提醒保护鉴权信息，不要分享配置
- 📝 提示：项目级配置会覆盖全局配置，仅对当前项目有效

---

## 🔐 安全提示

### API 文档 MCP
- ✅ 安全，可以公开配置
- ✅ 不包含敏感信息
- ✅ 可以提交到代码仓库

### 应用执行 MCP
- ⚠️ 包含鉴权信息，需要保密
- ⚠️ 不要分享配置或提交到公开仓库
- ⚠️ **配置文件位置**: 项目级 `.cursor/mcp.json` 或全局 `~/.cursor/mcp.json`
- ⚠️ 如果 `.cursor/mcp.json` 包含敏感信息，确保添加到 `.gitignore`

---

## 📚 使用原则

当用户询问 HAP MCP 相关问题时：

1. **首先确认**: 用户想用哪种 MCP？
   - 学习 API → API 文档 MCP
   - 操作数据 → 应用执行 MCP

2. **配置 MCP**: 
   - **如果用户提供配置信息** → **自动化配置**，在项目根目录创建或更新 `.cursor/mcp.json`
   - **如果用户询问如何配置** → 提供配置说明，并询问是否需要帮助自动化配置
   - **如果用户说"配置 MCP"** → 优先使用项目级 `.cursor/mcp.json`，而非全局 `settings.json`
   - 检查配置文件格式和必需参数（注意 `.cursor/mcp.json` 不需要 `type` 字段）
   - **配置完成后必须验证配置状态**：通过调用 MCP 工具（如 `get_time` 或 `get_app_info`）验证配置是否正常工作

3. **指导使用**: 根据场景选择正确的 MCP
   - 开发阶段 → API 文档 MCP
   - 生产环境 → 应用执行 MCP

4. **安全提醒**: 涉及应用执行 MCP 时
   - 提醒保护鉴权信息
   - 警告数据操作的影响
   - 配置文件包含敏感信息，不要分享

---

## 📖 相关资源

- HAP 官方文档: https://help.mingdao.com
- HAP API 文档: https://api.mingdao.com/docs
- MCP 协议规范: https://modelcontextprotocol.io

---

**当用户提到 MCP 时，请使用此 skill 确保正确理解和使用两种不同的 MCP 类型。**
