---
name: hap-v3-api
description: 使用明道云 HAP V3 接口搭建页面和操作数据的专业技能。**立即触发条件**：用户提到"HAP V3"、"HAP API"、"接口调用"、"数据接口"、"Appkey"、"Sign"、"接口鉴权"、"Filter 筛选"、"查询数据"、"创建记录"。提供完整的 API 使用指南：鉴权配置、接口调用、筛选器使用、数据操作等。如果用户已配置 HAP MCP，AI 应该自动从 MCP 配置中提取鉴权密钥。
license: MIT
---

# HAP V3 API 使用技能

此技能提供使用明道云 HAP V3 接口搭建页面、实时获取数据和操作数据的完整指南。

## Overview

明道云 HAP (High-performance Application Platform) 是一个超级应用平台,通过这个基座可以搭建很多应用。通过 HAP V3 接口,您可以:

1. **在自定义视图插件中**调用 V3 接口操作数据
2. **在独立前端页面中**使用 V3 接口编排业务逻辑
3. **实时获取和操作**明道云应用中的数据

**核心能力:**
- ✅ 完整的 API 使用工作流（从零搭建应用到数据操作）
- ✅ 详细的字段类型处理规范
- ✅ Filter 筛选器完整语法
- ✅ 关联字段深度查询指南
- ✅ 常见陷阱和解决方案
- ✅ 性能优化最佳实践

**详细文档:** 参考 `references/hap-api-usage-guide.md` 获取完整的 API 使用规范

---

## 快速开始

### 1. 获取 API 凭证

**方法一: 从 MCP 配置中提取（推荐）**

如果用户已经配置了 HAP 应用执行 MCP，AI 助手应该**自动从 MCP 配置中提取鉴权密钥**，而不是让用户手动输入。

#### 自动化提取步骤

1. **读取 Cursor 全局设置文件**
   - **macOS**: `~/Library/Application Support/Cursor/User/settings.json`
   - **Windows**: `%APPDATA%\Cursor\User\settings.json`
   - **Linux**: `~/.config/Cursor/User/settings.json`

2. **查找 MCP 配置**
   - 在 `mcpServers` 对象中查找以 `hap-mcp-` 开头的服务器配置
   - 识别应用执行 MCP（包含 `url` 字段且 URL 指向 `api.mingdao.com/mcp`）

3. **从 URL 中解析参数**
   - MCP 配置格式示例：
   ```json
   {
     "mcpServers": {
       "hap-mcp-应用名": {
         "url": "https://api.mingdao.com/mcp?HAP-Appkey=6802bfa5da37d75f&HAP-Sign=MWZmZWU1YmMyMzE4ZTAxYjY3NTViYjM5NzhlNTdhOTIwZWFhYTc2Y2I2YzljNWMzNDFmMjk4NTM2N2M0YTg2OA==",
         "type": "http"
       }
     }
   }
   ```

4. **提取鉴权密钥**
   - 从 URL 的查询参数中提取 `HAP-Appkey` 的值
   - 从 URL 的查询参数中提取 `HAP-Sign` 的值
   - 注意：URL 参数可能经过 URL 编码，需要正确解码

#### 代码示例（AI 助手操作）

```javascript
// 1. 读取配置文件
const settingsPath = process.platform === 'darwin' 
  ? `${process.env.HOME}/Library/Application Support/Cursor/User/settings.json`
  : process.platform === 'win32'
  ? `${process.env.APPDATA}/Cursor/User/settings.json`
  : `${process.env.HOME}/.config/Cursor/User/settings.json`;

const settings = JSON.parse(fs.readFileSync(settingsPath, 'utf8'));

// 2. 查找 HAP MCP 配置
const mcpServers = settings.mcpServers || {};
const hapMcpConfig = Object.entries(mcpServers).find(
  ([name, config]) => name.startsWith('hap-mcp-') && config.url
);

if (hapMcpConfig) {
  const [, config] = hapMcpConfig;
  const url = new URL(config.url);
  
  // 3. 提取 Appkey 和 Sign
  const appkey = url.searchParams.get('HAP-Appkey');
  const sign = url.searchParams.get('HAP-Sign');
  
  // 4. 使用提取的密钥
  console.log('Appkey:', appkey);
  console.log('Sign:', sign);
}
```

#### 实际操作流程

当用户需要调用 HAP API 时，AI 应该：

1. **检查是否已配置 MCP**
   - 读取 Cursor 全局设置文件
   - 查找 `hap-mcp-*` 配置

2. **提取鉴权信息**
   - 如果找到 MCP 配置，自动从 URL 中提取 Appkey 和 Sign
   - 如果找到多个 MCP 配置，询问用户使用哪个应用

3. **使用提取的密钥**
   - 在 API 请求头中使用提取的 `HAP-Appkey` 和 `HAP-Sign`
   - 如果提取失败，提示用户手动提供或检查 MCP 配置

#### 注意事项

- ✅ **优先使用 MCP 配置**: 如果用户已配置 MCP，优先从配置中提取
- ✅ **URL 解码**: 注意 URL 参数可能经过编码，需要正确解码
- ✅ **多个应用**: 如果配置了多个 HAP MCP，询问用户使用哪个应用
- ⚠️ **配置不存在**: 如果未找到 MCP 配置，提示用户先配置 MCP 或手动提供密钥
- ⚠️ **权限问题**: 如果无法读取配置文件，提示用户检查文件权限

**方法二: 手动获取**

如果用户未配置 MCP 或需要手动提供：

1. 登录明道云 → 应用 → 设置 → API 密钥
2. 复制 Appkey 和 Sign
3. 或提供 MCP 配置信息，让 AI 自动提取

### 2. 配置请求头

所有 HAP V3 API 请求都需要以下请求头:

```javascript
const headers = {
  'Content-Type': 'application/json',
  'HAP-Appkey': 'your-app-key',
  'HAP-Sign': 'your-sign-key'
};
```

**⚠️ 注意:** 请求头使用 `HAP-Appkey` 和 `HAP-Sign`（不是 `AppKey` 和 `Sign`）

### 3. 获取 API 文档

**使用 Apifox MCP Server（推荐）:**

```json
{
  "应用 API - API 文档": {
    "command": "npx",
    "args": [
      "-y",
      "apifox-mcp-server@latest",
      "--site-id=5442569"
    ]
  }
}
```

**在线文档资源:**
- [API 整体介绍](https://apifox.mingdao.com/7271706m0.md)
- [字段类型对照表](https://apifox.mingdao.com/7271709m0.md)
- [筛选器使用指南](https://apifox.mingdao.com/7271713m0.md)
- [错误码说明](https://apifox.mingdao.com/7271715m0.md)

---

## 核心工作流程

### 阶段一: 准备工作

**Step 1: 获取 API 凭证**
- **优先方式**: 从 Cursor MCP 配置中自动提取 Appkey 和 Sign（如果用户已配置）
- **备选方式**: 从 HAP 后台手动获取或让用户提供

**Step 2: 配置 API 请求头**
- 使用提取或提供的 Appkey 和 Sign 设置请求头
- 设置 `HAP-Appkey` 和 `HAP-Sign` 请求头

### 阶段二: 创建应用结构

**Step 3: 获取应用信息（可选）**
```javascript
GET /v3/app/info
```

**Step 4: 创建工作表**
```javascript
POST /v3/app/worksheets
{
  "name": "客户信息表",
  "alias": "customers",
  "fields": [
    {
      "name": "客户名称",
      "alias": "customer_name",
      "type": "Text",
      "isTitle": true,
      "required": true
    }
  ]
}
```

**详细规范:** 参考 `references/hap-api-usage-guide.md` 第 1 节

### 阶段三: 填充数据

**Step 5: 准备选项字段映射**
- 对于单选/多选字段,需要先获取选项的 key（UUID）
- 查询工作表结构获取 options 列表

**Step 6: 创建记录**
```javascript
POST /v3/app/worksheets/{worksheet_id}/rows
{
  "fields": [
    {
      "id": "customer_name",
      "value": "明道云科技有限公司"
    },
    {
      "id": "customer_type",
      "value": ["74c7b607-864d-4cc4-b401-28acba2636e9"]  // ⚠️ 使用选项key
    }
  ],
  "triggerWorkflow": true
}
```

**关键点:**
- ⚠️ 选项字段必须用 key,不能用显示文本
- ⚠️ 选项字段即使单选也要用数组格式
- ✅ 数值字段写入时传数字,读取时返回字符串

**详细规范:** 参考 `references/hap-api-usage-guide.md` 第 3 节

### 阶段四: 查询和分析数据

**Step 7: 查询记录列表**
```javascript
POST /v3/app/worksheets/{worksheet_id}/rows/list
{
  "filter": {
    "type": "group",
    "logic": "AND",
    "children": [
      {
        "type": "condition",
        "field": "customer_type",
        "operator": "eq",
        "value": ["74c7b607-864d-4cc4-b401-28acba2636e9"]  // 使用key
      }
    ]
  },
  "sorts": [{
    "field": "annual_budget",
    "isAsc": false
  }],
  "pageIndex": 1,
  "pageSize": 20
}
```

**详细规范:** 参考 `references/hap-api-usage-guide.md` 第 4 节

---

## Filter 筛选器规范 ⭐重点

### Filter 对象结构

**基础结构:**
```typescript
Filter = {
  type: 'group' | 'condition';
  
  // type='group' 时的字段
  logic?: 'AND' | 'OR';
  children?: Filter[];  // 子条件,最多两层嵌套
  
  // type='condition' 时的字段
  field?: string;       // 字段ID或别名
  operator?: string;    // 操作符
  value?: any[];        // 值数组
}
```

**规则:**
1. 顶层必须是 `group` 类型
2. 最多两层嵌套: group → group → condition
3. 同一 group 的 children 必须类型一致
4. group 必须指定 `logic` (AND/OR)
5. condition 必须指定 `field`, `operator`

### 操作符完整列表

| 操作符 | 说明 | 需要value | value格式 | 适用字段 |
|-------|------|----------|----------|---------|
| `eq` | 等于 | ✅ | `["值"]` | 所有类型 |
| `ne` | 不等于 | ✅ | `["值"]` | 所有类型 |
| `contains` | 包含 | ✅ | `["值"]` | Text, MultipleSelect |
| `notcontains` | 不包含 | ✅ | `["值"]` | Text, MultipleSelect |
| `startswith` | 开头是 | ✅ | `["值"]` | Text |
| `endswith` | 结尾是 | ✅ | `["值"]` | Text |
| `gt` | 大于 | ✅ | `["值"]` | Number, Date |
| `gte` | 大于等于 | ✅ | `["值"]` | Number, Date |
| `lt` | 小于 | ✅ | `["值"]` | Number, Date |
| `lte` | 小于等于 | ✅ | `["值"]` | Number, Date |
| `between` | 介于之间 | ✅ | `["最小值", "最大值"]` | Number, Date |
| `isempty` | 为空 | ❌ | 不需要 | 所有类型 |
| `isnotempty` | 不为空 | ❌ | 不需要 | 所有类型 |
| `belongsto` | 属于 | ✅ | `["ID1", "ID2"]` | Relation, Department |
| `in` | 在...中 | ✅ | `["值1", "值2"]` | 所有类型 |
| `concurrent` | 同时包含 | ✅ | `["值1", "值2"]` | MultipleSelect |

### 筛选示例

**示例1: 单选字段筛选（⚠️ 必须使用 key）**
```javascript
{
  "type": "group",
  "logic": "AND",
  "children": [{
    "type": "condition",
    "field": "customer_type",
    "operator": "eq",
    "value": ["74c7b607-864d-4cc4-b401-28acba2636e9"]  // ✅ 使用key
  }]
}

// ❌ 错误: value: ["成交客户"]  // 不能用显示文本!
```

**示例2: 数值范围筛选（⚠️ value 必须是字符串数组）**
```javascript
{
  "type": "condition",
  "field": "annual_budget",
  "operator": "between",
  "value": ["500000", "2000000"]  // ✅ 字符串数组
}

// ❌ 错误: value: [500000, 2000000]  // 不能用数字!
```

**示例3: 关联字段筛选（⚠️ 必须用 belongsto）**
```javascript
{
  "type": "condition",
  "field": "related_customer",
  "operator": "belongsto",  // ✅ 关联字段用 belongsto
  "value": ["customer-row-id"]
}

// ❌ 错误: operator: "eq"  // 关联字段不支持 eq!
```

**详细规范:** 参考 `references/hap-api-usage-guide.md` 第 4 节

---

## 字段类型处理规范

### 关键字段类型处理

#### 1. 选项字段（SingleSelect/MultipleSelect）⭐⭐⭐

**写入:** 必须传选项 key 的数组
```javascript
{
  "id": "customer_type",
  "value": ["74c7b607-864d-4cc4-b401-28acba2636e9"]  // 选项key
}
```

**读取:** 返回包含 key 和 value 的对象数组
```javascript
{
  "customer_type": [
    {
      "key": "74c7b607-864d-4cc4-b401-28acba2636e9",
      "value": "成交客户"
    }
  ]
}
```

**⚠️ 关键点:**
- 即使是单选,也要用数组 `["key"]`
- 不能传显示文本 `["成交客户"]`,必须用 key
- 筛选时必须使用 key,不能使用显示文本

#### 2. 附件字段（Attachment）⭐

**写入:** 支持 URL 和 base64
```javascript
{
  "id": "attachments",
  "type": "0",  // 0=覆盖, 1=追加
  "value": [{
    "name": "产品宣传册.pdf",
    "url": "https://example.com/brochure.pdf"
  }]
}
```

**读取:** 返回附件对象数组
```javascript
{
  "attachments": [{
    "file_id": "...",
    "file_name": "...",
    "downloadUrl": "https://...",  // ⚠️ 使用 downloadUrl
    "file_size": 2048576
  }]
}
```

**⚠️ 重要提示:**
- 附件上传是异步处理,通常需要 5-10 秒
- API 返回成功不代表附件已上传完成
- 使用 `downloadUrl` 而非 `url`

#### 3. 关联字段（Relation）⭐⭐⭐

**写入:** 传记录 ID 数组
```javascript
{
  "id": "related_customer",
  "value": ["945e6503-3823-4e91-9d84-a53f8bdd6fc5"]  // 记录rowid
}
```

**读取:** 返回对象数组（只包含 sid 和 name）
```javascript
{
  "related_customer": [{
    "sid": "945e6503-3823-4e91-9d84-a53f8bdd6fc5",
    "name": "明道云科技有限公司"
  }]
}
```

**获取完整关联数据:**
```javascript
// 方法1: 使用专用 API
GET /v3/app/worksheets/{worksheet_id}/rows/{row_id}/relations/{field_id}

// 方法2: 使用 sid 查询目标表
POST /v3/app/worksheets/{target_worksheet_id}/rows/list
{
  "filter": {
    "type": "group",
    "logic": "AND",
    "children": [{
      "type": "condition",
      "field": "rowid",  // ⚠️ 使用系统字段 rowid
      "operator": "in",
      "value": ["sid1", "sid2"]  // 传入关联记录的 sid
    }]
  }
}
```

**详细规范:** 参考 `references/hap-api-usage-guide.md` 第 6 节

#### 4. 成员字段（Collaborator）

**写入:** 传用户 ID 数组
```javascript
{
  "id": "owner",
  "value": ["user-account-id-123"]  // 用户ID,不是用户名
}
```

**获取用户ID:**
```javascript
POST /v3/users/lookup
{
  "name": "张三"  // 精确匹配姓名
}
```

#### 5. 数值字段（Number）

**写入:** 传数字类型
```javascript
{
  "id": "annual_budget",
  "value": 1000000.50
}
```

**读取:** 返回字符串
```javascript
{
  "annual_budget": "1000000.50"
}
```

**⚠️ 注意:** 写入数字,读取字符串

**详细规范:** 参考 `references/hap-api-usage-guide.md` 第 2、3 节

---

## triggerWorkflow 参数详解 ⭐重要

`triggerWorkflow` 参数控制是否在数据操作时触发工作表相关的工作流。

**适用范围:**
- ✅ 创建记录
- ✅ 批量创建
- ✅ 更新记录
- ✅ 批量更新
- ✅ 删除记录
- ✅ 批量删除

**参数说明:**

| 参数值 | 说明 | 默认值 | 使用场景 |
|-------|------|--------|---------|
| `true` | 触发工作流 | ✅ 是 | 正常业务操作,需要执行自动化流程 |
| `false` | 不触发工作流 | ❌ 否 | 数据迁移、批量初始化、测试数据 |

**✅ 应该设置为 `true` 的场景:**
- 正常业务操作（用户提交表单、更新状态等）
- 需要自动化处理的操作

**❌ 应该设置为 `false` 的场景:**
- 数据迁移和导入
- 批量数据初始化
- 定时同步任务
- 测试和调试

**性能影响:**
- `triggerWorkflow: false` - API 响应快,通常 < 500ms
- `triggerWorkflow: true` - 需要等待工作流执行,可能需要 1-5 秒

**详细说明:** 参考 `references/hap-api-usage-guide.md` 第 3.2 节

---

## 常见陷阱与解决方案 ⭐⭐⭐

### 陷阱1: 选项字段筛选使用显示文本

**问题:** 筛选单选/多选字段时返回空结果

**错误示例:**
```javascript
{
  "field": "customer_type",
  "operator": "eq",
  "value": ["成交客户"]  // ❌ 使用了显示文本
}
```

**正确做法:**
```javascript
{
  "field": "customer_type",
  "operator": "eq",
  "value": ["74c7b607-864d-4cc4-b401-28acba2636e9"]  // ✅ 使用选项key
}
```

**解决方案:**
1. 初始化时查询工作表结构,缓存选项映射
2. 或先查询一条记录,从返回数据获取 key
3. 建立 value → key 的映射表

### 陷阱2: 数值字段筛选使用数字类型

**问题:** 数值筛选无结果或报错

**错误示例:**
```javascript
{
  "field": "annual_budget",
  "operator": "gt",
  "value": [1000000]  // ❌ 数字类型
}
```

**正确做法:**
```javascript
{
  "field": "annual_budget",
  "operator": "gt",
  "value": ["1000000"]  // ✅ 字符串数组
}
```

**记忆口诀:** 筛选条件的 value 永远是字符串数组

### 陷阱3: 关联字段使用错误的操作符

**问题:** 使用错误的操作符筛选关联字段

**错误示例:**
```javascript
{
  "field": "related_customer",
  "operator": "eq",  // ❌ 关联字段不支持 eq
  "value": ["customer-id"]
}
```

**正确做法:**
```javascript
{
  "field": "related_customer",
  "operator": "belongsto",  // ✅ 使用 belongsto
  "value": ["customer-id"]
}
```

### 陷阱4: 关联字段 N+1 查询问题

**问题:** 在列表页逐个查询关联数据

**错误示例:**
```javascript
// ❌ 性能灾难:100个产品 = 1 + 100 = 101次请求
const products = await getProductList();  // 1次请求

for (const product of products) {
  const categoryId = product.category[0].sid;
  const category = await getCategoryById(categoryId);  // 100次请求!
}
```

**正确做法:** 批量查询
```javascript
// ✅ 性能优化:100个产品 = 1 + 1 = 2次请求
const products = await getProductList();  // 1次请求

// 收集所有分类ID
const categoryIds = new Set();
products.forEach(p => {
  if (p.category && p.category.length > 0) {
    categoryIds.add(p.category[0].sid);
  }
});

// 批量查询所有分类
const categories = await getRows('category-worksheet-id', {
  filter: {
    type: 'condition',
    field: 'rowid',
    operator: 'in',
    value: Array.from(categoryIds)
  }
});  // 1次请求

// 建立映射
const categoryMap = {};
categories.rows.forEach(cat => {
  categoryMap[cat.rowid] = cat;
});
```

**详细说明:** 参考 `references/hap-api-usage-guide.md` 第 7 节

---

## 性能优化建议

### 1. 查询优化

- **合理使用分页**: pageSize 不要超过 1000
- **指定返回字段**: 使用 fields 参数,只返回需要的字段
- **使用字段ID**: 比别名查询性能更好
- **避免过度嵌套**: Filter 嵌套控制在 2 层以内
- **善用视图**: 复杂筛选可先创建视图,再查询视图

### 2. 批量操作优化

- **批量创建**: 一次最多 100 条
- **批量更新**: 一次最多 100 条
- **包含关联字段**: 减少到每批 30-50 条
- **包含附件**: 建议单独处理,不要批量
- **批次间延迟**: 每批间隔 1-2 秒

### 3. 关联字段优化

- **减少嵌套查询**: 使用 get_record_relations API 一次获取
- **批量查询**: 避免 N+1 查询问题
- **缓存关联数据**: 频繁访问的关联数据可缓存
- **控制 showFields**: 只显示必要字段,减少数据量

**详细说明:** 参考 `references/hap-api-usage-guide.md` 第 8 节

---

## 🤖 AI 助手使用指南

当用户需要调用 HAP V3 API 时，AI 助手应该遵循以下原则：

### 1. 自动提取鉴权密钥

**优先级顺序：**

1. **优先从 MCP 配置提取**（推荐）
   - 读取 Cursor 全局设置文件
   - 查找 `hap-mcp-*` 配置
   - 从 URL 中提取 `HAP-Appkey` 和 `HAP-Sign`
   - 如果找到多个配置，询问用户使用哪个应用

2. **用户手动提供**
   - 如果未找到 MCP 配置，提示用户提供 Appkey 和 Sign
   - 或引导用户先配置 MCP

3. **引导配置 MCP**
   - 如果用户有 MCP 配置信息，帮助用户配置到 Cursor
   - 然后从配置中提取密钥

### 2. 配置请求头

提取到密钥后，自动配置请求头：

```javascript
const headers = {
  'Content-Type': 'application/json',
  'HAP-Appkey': extractedAppkey,  // 从 MCP 配置提取
  'HAP-Sign': extractedSign        // 从 MCP 配置提取
};
```

### 3. 处理多个应用

如果用户配置了多个 HAP MCP：

- **明确指定应用名**: 如果用户提到具体应用名，使用对应的配置
- **询问用户**: 如果未指定，列出所有配置的应用，让用户选择
- **默认使用**: 如果只有一个配置，直接使用

### 4. 错误处理

- **配置不存在**: 提示用户先配置 MCP 或手动提供密钥
- **URL 解析失败**: 检查 URL 格式是否正确
- **参数缺失**: 检查 Appkey 和 Sign 是否都存在
- **权限问题**: 如果无法读取配置文件，提示用户检查文件权限

### 5. 实际操作示例

**场景**: 用户说"帮我调用 HAP API 查询数据"

**AI 操作流程**:
1. 读取 Cursor 全局设置文件 `~/Library/Application Support/Cursor/User/settings.json`
2. 查找 `mcpServers` 中的 `hap-mcp-*` 配置
3. 如果找到配置，从 URL 中提取 Appkey 和 Sign
4. 如果找到多个配置，询问用户使用哪个应用
5. 使用提取的密钥配置 API 请求头
6. 执行 API 调用

**场景**: 用户提供了 MCP 配置信息

**AI 操作流程**:
1. 先帮助用户将 MCP 配置添加到 Cursor 全局设置文件
2. 然后从配置中提取 Appkey 和 Sign
3. 使用提取的密钥进行后续 API 调用

---

## 最佳实践

### 1. 初始化阶段

**必做事项:**
1. 查询所有工作表结构
2. 缓存所有选项字段的 key-value 映射
3. 缓存工作表 ID 和字段 ID
4. 建立用户姓名→ID 映射

**示例代码:**
```javascript
// 1. 获取工作表结构
const structure = await getWorksheetStructure(worksheetId);

// 2. 提取选项字段映射
const optionMaps = {};
structure.fields.forEach(field => {
  if (field.type === 'SingleSelect' || field.type === 'MultipleSelect') {
    optionMaps[field.id] = {};
    field.options.forEach(opt => {
      optionMaps[field.id][opt.value] = opt.key;  // value → key
    });
  }
});

// 3. 使用时查找key
const customerTypeKey = optionMaps['customer_type']['成交客户'];
```

### 2. 查询阶段

**建议:**
1. 优先使用字段 ID 而不是别名
2. 选项字段必须用 key,提前转换
3. 数值字段 value 用字符串
4. 关联字段用 belongsto 操作符
5. 合理设置 pageSize（建议 100-500）

### 3. 写入阶段

**检查清单:**
- [ ] 选项字段 value 是数组格式
- [ ] 选项字段传的是 key 不是 value
- [ ] 数值字段传数字类型
- [ ] 关联字段传的是 rowid
- [ ] 成员字段传的是 accountId
- [ ] 附件字段设置了 type 参数

### 4. 错误处理

**常见错误码:**
- `error_code: 1` - 成功
- `error_code: -1` - 失败,查看 error_msg
- `error_code: 4` - 权限不足
- `error_code: 10` - 参数错误

**建议:** 所有 API 调用都要检查 error_code 和 success

**详细说明:** 参考 `references/hap-api-usage-guide.md` 第 9 节

---

## 常用 API 端点速查

| 场景 | API 端点 | 关键参数 |
|-----|---------|---------|
| 创建工作表 | `POST /v3/app/worksheets` | fields |
| 添加字段 | `POST /v3/app/worksheets/{id}` | addFields |
| 创建记录 | `POST /v3/app/worksheets/{id}/rows` | fields |
| 批量创建 | `POST /v3/app/worksheets/{id}/rows/batch` | rows |
| 查询记录 | `POST /v3/app/worksheets/{id}/rows/list` | filter, sorts |
| 更新记录 | `POST /v3/app/worksheets/{id}/rows/{row_id}` | fields |
| 批量更新 | `PUT /v3/app/worksheets/{id}/rows/batch` | rowIds, fields |
| 删除记录 | `DELETE /v3/app/worksheets/{id}/rows/{row_id}` | permanent |
| 批量删除 | `DELETE /v3/app/worksheets/{id}/rows/batch` | rowIds, permanent |
| 透视分析 | `POST /v3/app/worksheets/{id}/rows/pivot` | rows, values |
| 查找用户 | `POST /v3/users/lookup` | name |
| 查找部门 | `POST /v3/departments/lookup` | name |
| 获取地区 | `POST /v3/regions` | search, id |

---

## 参考资源

### 核心文档

- **`references/hap-api-usage-guide.md`** - HAP V3 API 使用规范完整指南
  - 快速开始 - API 使用流程
  - 创建工作表规范
  - 字段类型参数详解
  - 创建/更新记录规范（triggerWorkflow 详解）
  - 查询筛选规范（Filter 对象结构、操作符列表）
  - 数据透视分析规范
  - 关联字段完整指南
  - 常见陷阱与解决方案
  - 性能优化建议
  - 最佳实践总结

### 在线文档

- [API 整体介绍](https://apifox.mingdao.com/7271706m0.md)
- [字段类型对照表](https://apifox.mingdao.com/7271709m0.md)
- [筛选器使用指南](https://apifox.mingdao.com/7271713m0.md)
- [错误码说明](https://apifox.mingdao.com/7271715m0.md)

### 相关技能

- **HAP 前后端项目搭建指南** - 使用 HAP 作为数据库搭建独立网站
- **HAP MCP 使用指南** - 了解如何使用 HAP MCP 进行应用管理
- **HAP 视图插件开发指南** - 开发 HAP 自定义视图插件

---

## 关键概念速查

**字段类型 (type):**
- 基础: `Text`, `Number`, `Date`, `Time`
- 选择: `SingleSelect`, `MultipleSelect`
- 关系: `Relation`, `Collaborator`, `Department`
- 其他: `Attachment`, `Rating`

**筛选操作符 (operator):**
- 比较: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`
- 文本: `contains`, `startswith`, `endswith`
- 范围: `between`, `in`
- 关联: `belongsto`
- 空值: `isempty`, `isnotempty`

**subType 参数:**
- Collaborator: `0`=单选, `1`=多选
- Relation: `1`=单条, `2`=多条
- Time: `1`=时:分, `6`=时:分:秒
- Date: `3`=年月日, `6`=年月日时分秒

---

## 错误排查清单

**筛选无结果:**
- [ ] 选项字段是否用了 key 而不是 value?
- [ ] 数值字段 value 是否用了字符串?
- [ ] 关联字段是否用了 belongsto?
- [ ] Filter 嵌套是否超过 2 层?
- [ ] 字段 ID 是否正确?

**创建/更新失败:**
- [ ] 必填字段是否都提供了?
- [ ] 关联字段的 dataSource 是否存在?
- [ ] 选项字段的 key 是否有效?
- [ ] 成员字段的 accountId 是否有效?
- [ ] 数值字段是否超出范围?

**数据异常:**
- [ ] 附件是否等待了 5-10 秒?
- [ ] 日期精度 subType 是否正确?
- [ ] 关联记录是否已删除?

---

**技能版本**: v2.0  
**最后更新**: 2026-01-11  
**基于**: HAP API V3  
**详细规范**: 参考 `references/hap-api-usage-guide.md`
