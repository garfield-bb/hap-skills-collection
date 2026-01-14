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
```json
{
  "mcpServers": {
    "hap-mcp-API测试": {
      "url": "https://api.mingdao.com/mcp?HAP-Appkey=539f83a2********&HAP-Sign=YmYwZmMyM2M0ZDdjNDUxMGMzMTY2MTQ5Y2MxNDhmMTZlM2Q3NjE1OTNiYzdlOGJh********"
    }
  }
}
```

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

### 多 MCP 配置时的处理流程 ⭐重要

当存在多个 HAP 应用 MCP 配置时，**必须遵循以下流程**，避免操作到错误的应用：

```
用户请求
  ↓
1. 识别当前连接的 MCP 应用
  ↓
2. 分析用户需求，确定目标应用
  ↓
3. 对比当前连接 vs 目标应用
  ↓
4. 如果不匹配 → 与用户确认
  ↓
5. 确认后执行操作
```

#### Step 1: 识别当前连接的 MCP 应用

**必须首先执行：**
```python
# 调用 get_app_info 确认当前连接的应用
mcp_hap-mcp-_get_app_info()
# 返回：应用名称（name）、应用ID（appId）等信息
```

**关键信息：**
- 应用名称（name）- 用于对比和确认
- 应用ID（appId）- 用于验证
- 组织ID（organizationId）

#### Step 2: 分析用户需求，确定目标应用

**分析维度：**

1. **用户明确提到应用名称**
   - 例如："在自媒体运营应用中..."
   - → 直接使用指定的应用

2. **用户提到业务场景**
   - 例如："小红书运营"、"自媒体运营"
   - → 根据场景匹配对应的应用（需要检查 MCP 配置）

3. **用户提供 MCP 配置**
   - 例如：`{"hap-mcp-自媒体运营": {"url": "..."}}`
   - → **从配置中提取应用名称**：`hap-mcp-{应用名称}` → 去掉 `hap-mcp-` 前缀
   - → 使用配置中指定的应用

4. **上下文推断**
   - 根据对话历史、项目名称等推断
   - → **必须与用户确认**

#### Step 3: 对比并确认

**如果当前连接 ≠ 目标应用：**

```
❌ 错误做法：
- 直接操作（可能操作到错误的应用）
- 假设用户意图（容易出错）

✅ 正确做法：
- 明确告知用户当前连接的应用
- 询问是否切换到目标应用
- 或确认是否在当前应用中操作
```

**确认话术模板：**
```
当前连接的是「[应用名称]」应用，但根据您的需求，应该使用「[目标应用名称]」应用。

请确认：
1. 切换到「[目标应用名称]」应用进行操作？
2. 还是在当前「[应用名称]」应用中操作？

（如果用户提供了 MCP 配置，也可以说明：您提供的 MCP 配置指向「[应用名称]」应用）
```

#### Step 4: 执行操作

**确认后执行：**
- 如果用户确认切换 → 使用对应的 MCP 配置（注意：MCP 连接由系统管理，可能需要用户手动切换或重启 Cursor）
- 如果用户确认在当前应用 → 继续操作
- 如果用户提供新配置 → 先更新 MCP 配置，再操作

#### 实际案例

**案例 1: 用户提供 MCP 配置**
```
用户：{"hap-mcp-自媒体运营":{"url":"..."}}

处理流程：
1. ✅ 读取 MCP 配置，识别应用名称：自媒体运营
2. ✅ 调用 get_app_info() 确认当前连接的应用
3. ✅ 对比：当前连接 vs 自媒体运营
4. ✅ 如果不匹配，询问用户：
   您提供的 MCP 配置指向「自媒体运营」应用。
   当前连接的是「[当前应用]」应用。
   
   是否切换到「自媒体运营」应用进行操作？
5. ✅ 确认后执行操作
```

**案例 2: 用户提到业务场景**
```
用户：帮我创建小红书运营的数据表

处理流程：
1. ✅ 调用 get_app_info() 确认当前连接的应用
2. ✅ 分析需求：小红书运营 → 可能对应「自媒体运营」应用
3. ✅ 检查 MCP 配置，查找可能匹配的应用
4. ✅ 询问用户：
   根据您的需求「小红书运营」，我找到了以下可能的应用：
   - 自媒体运营（hap-mcp-自媒体运营）
   
   当前连接的是「[当前应用]」应用。
   
   请确认在哪个应用中创建数据表？
5. ✅ 确认后执行操作
```

**案例 3: 用户未明确指定**
```
用户：帮我创建一些数据表

处理流程：
1. ✅ 调用 get_app_info() 确认当前连接的应用
2. ✅ 明确告知用户：
   当前连接的是「[应用名称]」应用。
   我将在此应用中创建数据表。
   
   如果需要在其他应用中操作，请告诉我应用名称。
3. ✅ 等待用户确认或提供更多信息
4. ✅ 确认后执行操作
```

#### 检查清单

在执行任何 HAP MCP 操作前，必须完成：

- [ ] **Step 1**: 调用 `get_app_info()` 确认当前连接的应用
- [ ] **Step 2**: 分析用户需求，确定目标应用
- [ ] **Step 3**: 对比当前连接 vs 目标应用
- [ ] **Step 4**: 如果不匹配，与用户确认
- [ ] **Step 5**: 确认后执行操作

#### 常见错误及避免方法

**❌ 错误 1: 直接操作，不确认**
```
用户：创建数据表
AI: 直接创建（可能创建到错误的应用）

✅ 正确做法：
用户：创建数据表
AI: 
1. 先确认当前应用
2. 询问用户是否在当前应用中创建
3. 确认后创建
```

**❌ 错误 2: 假设用户意图**
```
用户：创建小红书笔记表
AI: 假设用户要在"自媒体运营"应用中创建，直接操作

✅ 正确做法：
用户：创建小红书笔记表
AI: 
1. 确认当前连接的应用
2. 询问：在「[当前应用]」应用中创建，还是「自媒体运营」应用中创建？
3. 确认后创建
```

**❌ 错误 3: 忽略 MCP 配置中的应用名称**
```
用户提供：{"hap-mcp-自媒体运营": {...}}
AI: 直接使用，不检查应用名称

✅ 正确做法：
用户提供：{"hap-mcp-自媒体运营": {...}}
AI: 
1. 识别 MCP 配置中的应用名称：自媒体运营（去掉 hap-mcp- 前缀）
2. 确认当前连接的应用
3. 对比并询问用户确认
```

### 决策树

```
用户请求
  ├─ 询问"有哪些 API"/"如何调用"
  │   └─ 使用 API 文档 MCP (ApiBox)
  │
  ├─ 需要"查询真实数据"/"操作记录"
  │   ├─ Step 1: 调用 get_app_info() 确认当前应用
  │   ├─ Step 2: 分析需求，确定目标应用
  │   ├─ Step 3: 对比当前连接 vs 目标应用
  │   ├─ Step 4: 如果不匹配 → 与用户确认
  │   └─ Step 5: 确认后使用应用执行 MCP (Application)
  │
  ├─ 开发阶段的代码生成
  │   └─ 使用 API 文档 MCP (ApiBox)
  │
  └─ 生产环境的数据处理
      ├─ Step 1: 调用 get_app_info() 确认当前应用
      ├─ Step 2: 分析需求，确定目标应用
      ├─ Step 3: 对比当前连接 vs 目标应用
      ├─ Step 4: 如果不匹配 → 与用户确认
      └─ Step 5: 确认后使用应用执行 MCP (Application)
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

Cursor 的 MCP 配置存储在以下位置：
- **macOS**: `~/.cursor/mcp.json`
- **Windows**: `%USERPROFILE%\.cursor\mcp.json`
- **Linux**: `~/.cursor/mcp.json`

⚠️ **重要**: Cursor 的 MCP 配置存储在 `~/.cursor/mcp.json`，而不是 `settings.json` 文件中。

### 自动化配置步骤

当用户提供 MCP 配置信息时（例如：`{"hap-mcp-应用名":{"url":"https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx"}}`），AI 应该：

1. **查找配置文件**
   - 首先尝试读取 `~/.cursor/mcp.json`
   - 如果不存在，检查其他可能的配置文件位置
   - 使用 `run_terminal_cmd` 查找配置文件：`find ~/.cursor -name "mcp*.json"`

2. **读取现有配置**
   - 使用 `read_file` 工具读取配置文件
   - 检查是否已存在 `mcpServers` 配置结构
   - 如果文件不存在，创建新的配置结构

3. **解析用户提供的配置**
   - 提取服务器名称（如 `hap-mcp-自媒体运营`）
   - 提取 URL（包含 Appkey 和 Sign）
   - 解析 JSON 格式的配置对象

4. **更新或添加配置**
   - 如果配置文件中已有 `mcpServers`，则在其中添加或更新服务器配置
   - 如果配置文件中没有 `mcpServers`，则创建新的配置结构
   - **注意**: 应用执行 MCP 只需要 `url` 字段，不需要 `type` 字段

5. **保存配置文件**
   - 如果文件受保护无法直接编辑，使用 Python 脚本通过 JSON 操作更新：
   ```python
   import json
   import os
   
   file_path = os.path.expanduser('~/.cursor/mcp.json')
   with open(file_path, 'r', encoding='utf-8') as f:
       data = json.load(f)
   
   # 添加新的 MCP 服务器配置
   data['mcpServers']['hap-mcp-应用名'] = {
       'url': 'https://api.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx'
   }
   
   # 写回文件
   with open(file_path, 'w', encoding='utf-8') as f:
       json.dump(data, f, ensure_ascii=False, indent=2)
   ```
   - 使用 `run_terminal_cmd` 执行 Python 脚本更新配置
   - 保持 JSON 格式正确，注意逗号和缩进

### 配置格式示例

#### 新增应用执行 MCP

如果用户提供：
```json
{"hap-mcp-自媒体运营":{"url":"https://api.mingdao.com/mcp?HAP-Appkey=601530a05105750f&HAP-Sign=MDc2ZTRmNTMxYjFmOTZlNzM5ODc4NGJlNmNiMzM0NTY0YWExODgxY2RjYTIxMGQzM2FlMGRiZDRlOTEyY2Y2ZA=="}}
```

AI 应该更新 `~/.cursor/mcp.json` 文件，在 `mcpServers` 中添加：
```json
{
  "mcpServers": {
    "应用 API - API 文档": {
      "command": "npx -y apifox-mcp-server@latest --site-id=5442569",
      "args": [],
      "env": {}
    },
    "hap-mcp-清华大学官网": {
      "url": "https://api2.mingdao.com/mcp?HAP-Appkey=xxx&HAP-Sign=xxx"
    },
    "hap-mcp-自媒体运营": {
      "url": "https://api.mingdao.com/mcp?HAP-Appkey=601530a05105750f&HAP-Sign=MDc2ZTRmNTMxYjFmOTZlNzM5ODc4NGJlNmNiMzM0NTY0YWExODgxY2RjYTIxMGQzM2FlMGRiZDRlOTEyY2Y2ZA=="
    },
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

**注意**: 
- 应用执行 MCP 只需要 `url` 字段，**不需要** `type` 字段
- 保留其他已存在的 MCP 配置，不要删除

#### 更新现有 MCP 配置

如果配置已存在，AI 应该：
- 使用 Python 脚本更新对应的 URL（因为文件可能受保护）
- 保持其他配置不变
- 确保 JSON 格式正确

### 实际操作示例

**场景**: 用户说"把这个 MCP 配置都这里"并提供了配置信息

**AI 操作流程**:
1. 使用 `run_terminal_cmd` 查找配置文件：`find ~/.cursor -name "mcp*.json"`
2. 读取 `~/.cursor/mcp.json` 查看现有配置
3. 解析用户提供的 MCP 配置（提取服务器名和 URL）
4. 使用 Python 脚本更新配置文件（因为文件可能受保护）：
   ```bash
   python3 -c "
   import json
   import os
   
   file_path = os.path.expanduser('~/.cursor/mcp.json')
   with open(file_path, 'r', encoding='utf-8') as f:
       data = json.load(f)
   
   data['mcpServers']['hap-mcp-自媒体运营'] = {
       'url': 'https://api.mingdao.com/mcp?HAP-Appkey=601530a05105750f&HAP-Sign=MDc2ZTRmNTMxYjFmOTZlNzM5ODc4NGJlNmNiMzM0NTY0YWExODgxY2RjYTIxMGQzM2FlMGRiZDRlOTEyY2Y2ZA=='
   }
   
   with open(file_path, 'w', encoding='utf-8') as f:
       json.dump(data, f, ensure_ascii=False, indent=2)
   
   print('配置已添加成功')
   "
   ```
5. 验证配置是否正确添加
6. 告知用户配置已完成，需要重启 Cursor 才能生效

### 注意事项

- ✅ **自动化执行**: 不要只告诉用户如何配置，应该直接帮用户配置好
- ✅ **配置文件位置**: 使用 `~/.cursor/mcp.json`，不是 `settings.json`
- ✅ **格式检查**: 确保 JSON 格式正确，注意逗号、引号、括号匹配
- ✅ **保留现有配置**: 更新时不要删除其他已存在的 MCP 配置
- ✅ **文件保护**: 如果文件受保护无法直接编辑，使用 Python 脚本通过 JSON 操作更新
- ✅ **配置格式**: 应用执行 MCP 只需要 `url` 字段，不需要 `type` 字段
- ⚠️ **权限问题**: 如果文件无法写入，提示用户检查文件权限
- ⚠️ **备份建议**: 更新前可以提醒用户配置文件包含敏感信息

### 配置后的提示

配置完成后，AI 应该告知用户：
- ✅ 配置已保存到 `~/.cursor/mcp.json` 文件
- ✅ 配置位置和文件名
- ✅ 需要重启 Cursor 或重新加载 MCP 服务器才能生效
- ⚠️ 提醒保护鉴权信息，不要分享配置

---

## 🔐 安全提示

### API 文档 MCP
- ✅ 安全，可以公开配置
- ✅ 不包含敏感信息
- ✅ 可以提交到代码仓库

### 应用执行 MCP
- ⚠️ 包含鉴权信息，需要保密
- ⚠️ 不要分享配置或提交到公开仓库
- ⚠️ 建议使用 `.claude/settings.local.json` 存储
- ⚠️ 确保添加到 `.gitignore`

---

## 📚 使用原则

当用户询问 HAP MCP 相关问题时：

1. **首先确认**: 用户想用哪种 MCP？
   - 学习 API → API 文档 MCP
   - 操作数据 → 应用执行 MCP

2. **多 MCP 配置时的处理** ⭐重要：
   - **必须首先调用** `get_app_info()` 确认当前连接的应用
   - **分析用户需求**，确定目标应用（从用户描述、MCP 配置、业务场景等推断）
   - **对比当前连接 vs 目标应用**
   - **如果不匹配，必须与用户确认**，不要假设用户意图
   - **确认后执行操作**

3. **配置 MCP**: 
   - **如果用户提供配置信息** → **自动化配置**，直接更新 Cursor 全局设置文件
   - **如果用户询问如何配置** → 提供配置说明，并询问是否需要帮助自动化配置
   - **如果用户说"配置 MCP"** → 主动读取并更新配置文件
   - 检查配置文件格式和必需参数
   - **从 MCP 配置中提取应用名称**：`hap-mcp-{应用名称}` → 去掉 `hap-mcp-` 前缀

4. **指导使用**: 根据场景选择正确的 MCP
   - 开发阶段 → API 文档 MCP
   - 生产环境 → 应用执行 MCP

5. **安全提醒**: 涉及应用执行 MCP 时
   - 提醒保护鉴权信息
   - 警告数据操作的影响
   - 配置文件包含敏感信息，不要分享

### 核心原则总结

**多 MCP 配置时的黄金法则：**
1. ✅ **先确认，后操作** - 永远先确认当前连接的应用
2. ✅ **多问一句** - 不确定时，与用户确认
3. ✅ **明确告知** - 清楚说明当前状态和目标状态
4. ✅ **避免假设** - 不要假设用户意图

**关键检查点：**
- 当前连接的应用是什么？（调用 `get_app_info()`）
- 用户需求对应的应用是什么？（分析用户描述、MCP 配置）
- 两者是否一致？
- 如果不一致，是否已与用户确认？

---

## 📖 相关资源

- HAP 官方文档: https://help.mingdao.com
- HAP API 文档: https://api.mingdao.com/docs
- MCP 协议规范: https://modelcontextprotocol.io

---

**当用户提到 MCP 时，请使用此 skill 确保正确理解和使用两种不同的 MCP 类型。**
