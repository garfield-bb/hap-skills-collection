
# HAP V3 接口使用技能

此技能提供使用明道云 HAP V3 接口搭建页面、实时获取数据和操作数据的完整指南。

## 关于此技能

明道云 HAP (High-performance Application Platform) 是一个超级应用平台,通过这个基座可以搭建很多应用。通过 HAP V3 接口,您可以:

1. **在自定义视图插件中**调用 V3 接口操作数据
2. **在独立前端页面中**使用 V3 接口编排业务逻辑
3. **实时获取和操作**明道云应用中的数据

## 🤖 AI 执行步骤（思考 Todo List）

**当用户需要使用 HAP V3 接口时，AI 应按照以下步骤思考和执行：**

### 步骤 1: 识别使用场景
- [ ] 判断用户的使用场景：
  - 在自定义视图插件中使用 V3 接口？
  - 在独立前端页面中使用 V3 接口？
  - 需要查询 API 文档？

### 步骤 2: 获取鉴权信息
- [ ] 检查用户是否已配置 HAP MCP（`~/.cursor/mcp.json`）
- [ ] 如果没有配置，指导用户配置或从用户提供的配置中提取
- [ ] 从 MCP 配置中提取 Appkey 和 Sign
- [ ] 告知用户如何在代码中使用这些鉴权信息

### 步骤 3: 查询 API 文档（如需要）
- [ ] 如果用户需要了解如何调用某个接口：
  - [ ] 使用 Apifox MCP 查询相关 API 文档
  - [ ] 展示接口定义、参数、返回值
  - [ ] 提供代码示例

### 步骤 4: 实现 API 调用
- [ ] 根据场景选择合适的调用方式：
  - [ ] 视图插件中：使用 `mdye` 封装的 API 或直接调用
  - [ ] 独立页面中：使用 fetch/axios 调用，处理 CORS
- [ ] 配置正确的请求头（Appkey、Sign）
- [ ] 构建请求参数（payload、filter 等）
- [ ] 实现错误处理

### 步骤 5: 处理数据
- [ ] 解析返回的数据结构
- [ ] 处理筛选器（filter）的构建
- [ ] 处理附件字段（必须有 URL）
- [ ] 处理选项字段（使用 key 而非显示文本）

### 步骤 6: 测试和优化
- [ ] 使用 MCP 验证数据一致性
- [ ] 测试接口调用是否正常
- [ ] 优化性能（缓存、防抖等）

---

## HAP 作为后端服务

**重要理念**: HAP 应用 = 完整的后端服务

- **工作表** = 数据库表
- **字段** = 表字段
- **V3 接口** = RESTful API
- **HAP MCP** = 应用结构和数据管理工具

独立页面开发时,HAP 应用充当中后端服务,提供:
- ✅ 数据存储(工作表即数据库)
- ✅ 业务逻辑(字段公式、工作流)
- ✅ 权限管理(角色和权限配置)
- ✅ API 接口(V3 RESTful API)

## 使用 MCP 管理应用

**HAP MCP 可以:**
- 🔍 查询应用结构(工作表、字段定义)
- 📝 读取数据(查询记录)
- ➕ 创建记录
- ✏️ 更新记录
- 🗑️ 删除记录
- ⚙️ 管理应用结构(如果 MCP 支持)

**开发流程:**
1. 通过 MCP 分析现有应用结构
2. 设计数据模型并征得用户同意
3. 配置 HAP 应用(手动或通过 MCP)
4. 通过 MCP 创建示例数据
5. 通过 MCP 获取字段 ID 映射
6. 开发前端页面
7. 通过 MCP 验证数据一致性

**详细流程**: 参见 [MCP_WORKFLOW.md](./MCP_WORKFLOW.md) 和 [DEVELOPMENT_WORKFLOW.md](./DEVELOPMENT_WORKFLOW.md)

### 核心概念

- **应用 (App)**: 明道云中的一个完整应用,由多个工作表组成
- **工作表 (Worksheet)**: 类似数据表,存储具体的业务数据
- **视图 (View)**: 工作表的不同展示方式
- **Appkey & Sign**: 应用级别的鉴权密钥,用于 API 访问控制

## 鉴权配置

### 1. 获取鉴权密钥

每个明道云应用都有专属的 Appkey 和 Sign,用于 V3 接口鉴权。

**从 MCP 配置中获取:**

```json
{
  "hap-mcp-MEGA CRM": {
    "url": "https://api.mingdao.com/mcp?HAP-Appkey=881f73bb18ad7b7d&HAP-Sign=NTk4OGRhYzkzMzkxOGMxZWVlZDRlN2ZmMzhkN2JjZDM2ODAwOGVmMTI5NTQwODA3ZGI4NTBmOGMzOTlkNmE4ZA==",
    "type": "sse"
  }
}
```

提取出:
- **Appkey**: `881f73bb18ad7b7d`
- **Sign**: `NTk4OGRhYzkzMzkxOGMxZWVlZDRlN2ZmMzhkN2JjZDM2ODAwOGVmMTI5NTQwODA3ZGI4NTBmOGMzOTlkNmE4ZA==`

### 2. 配置请求头

所有 V3 接口请求都需要在 HTTP Header 中包含鉴权信息:

```javascript
const headers = {
  'Content-Type': 'application/json',
  'HAP-Appkey': '881f73bb18ad7b7d',
  'HAP-Sign': 'NTk4OGRhYzkzMzkxOGMxZWVlZDRlN2ZmMzhkN2JjZDM2ODAwOGVmMTI5NTQwODA3ZGI4NTBmOGMzOTlkNmE4ZA=='
};
```

### 3. 处理 CORS 跨域问题

在前端页面中调用 HAP V3 接口时,需要处理 CORS 跨域:

**方案1: 使用代理服务器**
```javascript
// 在 package.json 中配置代理
{
  "proxy": "https://api.mingdao.com"
}

// 调用时使用相对路径
const response = await fetch('/v3/app/worksheets/list', {
  method: 'POST',
  headers: headers,
  body: JSON.stringify(payload)
});
```

**方案2: 在服务端调用**
```javascript
// Node.js 后端示例
const axios = require('axios');

async function getWorksheets(appId) {
  const response = await axios.post(
    'https://api.mingdao.com/v3/app/worksheets/list',
    { appId },
    { headers }
  );
  return response.data;
}
```

## 获取 API 文档结构

使用 Apifox MCP Server 获取完整的 API 文档:

**MCP 配置:**
```json
{
  "HAP-应用API文档": {
    "command": "npx -y apifox-mcp-server@latest --site-id=5442569",
    "args": [],
    "env": {},
    "type": "stdio"
  }
}
```

**查询示例:**
通过 MCP 可以查询:
- 所有可用的 API 端点
- 每个接口的请求参数
- 响应数据结构
- 筛选器使用规范

## 常用 API 接口

### 1. 应用管理

#### 获取应用信息

```javascript
// GET /v3/app
const response = await fetch('https://api.mingdao.com/v3/app', {
  method: 'GET',
  headers: {
    'HAP-Appkey': appkey,
    'HAP-Sign': sign
  }
});

const appInfo = await response.json();
console.log('应用信息:', appInfo);
```

**响应数据:**
```json
{
  "appId": "693d2fed8474b99be3d3c12e",
  "appName": "MEGA CRM",
  "description": "客户关系管理系统",
  "iconUrl": "https://...",
  "iconColor": "#2196F3"
}
```

#### 获取工作表列表

```javascript
// POST /v3/app/worksheets/list
const response = await fetch('https://api.mingdao.com/v3/app/worksheets/list', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'HAP-Appkey': appkey,
    'HAP-Sign': sign
  },
  body: JSON.stringify({
    appId: '693d2fed8474b99be3d3c12e'
  })
});

const { worksheets } = await response.json();
```

**响应数据:**
```json
{
  "worksheets": [
    {
      "worksheetId": "69563e5df03728c888c04f05",
      "worksheetName": "客户",
      "entityName": "customer",
      "views": [
        {
          "viewId": "...",
          "viewName": "所有客户",
          "viewType": 0
        }
      ]
    }
  ]
}
```

### 2. 工作表结构

#### 获取工作表详情

```javascript
// GET /v3/app/worksheets/{worksheet_id}
const response = await fetch(
  `https://api.mingdao.com/v3/app/worksheets/${worksheetId}`,
  {
    method: 'GET',
    headers: {
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    }
  }
);

const worksheet = await response.json();
```

**响应数据:**
```json
{
  "worksheetId": "69563e5df03728c888c04f05",
  "worksheetName": "客户",
  "controls": [
    {
      "controlId": "name",
      "controlName": "客户名称",
      "type": 2,
      "required": true
    },
    {
      "controlId": "industry",
      "controlName": "所属行业",
      "type": 9,
      "options": [
        { "key": "key1", "value": "互联网" },
        { "key": "key2", "value": "金融" }
      ]
    }
  ]
}
```

### 3. 数据查询

#### 获取记录列表

```javascript
// POST /v3/app/worksheets/{worksheet_id}/rows/list
const response = await fetch(
  `https://api.mingdao.com/v3/app/worksheets/${worksheetId}/rows/list`,
  {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    },
    body: JSON.stringify({
      pageIndex: 1,
      pageSize: 50,
      sortId: 'ctime',
      isAsc: false,
      filters: {
        // 筛选条件
      }
    })
  }
);

const { rows, total } = await response.json();
```

**完整示例:**
```javascript
async function getCustomers() {
  const response = await fetch(
    `https://api.mingdao.com/v3/app/worksheets/${worksheetId}/rows/list`,
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'HAP-Appkey': appkey,
        'HAP-Sign': sign
      },
      body: JSON.stringify({
        pageIndex: 1,
        pageSize: 100,
        sortId: 'ctime',
        isAsc: false,
        filters: {
          filterControls: [
            {
              controlId: 'status',
              dataType: 9,
              spliceType: 1,
              filterType: 2,
              values: ['active_key']
            }
          ]
        }
      })
    }
  );

  const result = await response.json();
  return result.rows;
}
```

#### 获取单条记录详情

```javascript
// GET /v3/app/worksheets/{worksheet_id}/rows/{row_id}
const response = await fetch(
  `https://api.mingdao.com/v3/app/worksheets/${worksheetId}/rows/${rowId}`,
  {
    method: 'GET',
    headers: {
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    }
  }
);

const row = await response.json();
```

### 4. 数据操作

#### 创建记录

```javascript
// POST /v3/app/worksheets/{worksheet_id}/rows
const response = await fetch(
  `https://api.mingdao.com/v3/app/worksheets/${worksheetId}/rows`,
  {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    },
    body: JSON.stringify({
      controls: [
        {
          controlId: 'name',
          type: 2,
          value: '新客户名称'
        },
        {
          controlId: 'industry',
          type: 9,
          value: JSON.stringify(['key1'])
        }
      ]
    })
  }
);

const newRow = await response.json();
```

#### 更新记录

```javascript
// PUT /v3/app/worksheets/{worksheet_id}/rows/{row_id}
const response = await fetch(
  `https://api.mingdao.com/v3/app/worksheets/${worksheetId}/rows/${rowId}`,
  {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    },
    body: JSON.stringify({
      controls: [
        {
          controlId: 'status',
          type: 9,
          value: JSON.stringify(['new_status_key'])
        }
      ]
    })
  }
);
```

#### 删除记录

```javascript
// DELETE /v3/app/worksheets/{worksheet_id}/rows/batch
const response = await fetch(
  `https://api.mingdao.com/v3/app/worksheets/${worksheetId}/rows/batch`,
  {
    method: 'DELETE',
    headers: {
      'Content-Type': 'application/json',
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    },
    body: JSON.stringify({
      rowIds: [rowId1, rowId2]
    })
  }
);
```

### 5. 关联记录

#### 获取关联记录

```javascript
// GET /v3/app/worksheets/{worksheet_id}/rows/{row_id}/relations/{field}
const response = await fetch(
  `https://api.mingdao.com/v3/app/worksheets/${worksheetId}/rows/${rowId}/relations/${fieldId}`,
  {
    method: 'GET',
    headers: {
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    }
  }
);

const relations = await response.json();
```

### 6. 选项集管理

#### 获取选项集列表

```javascript
// GET /v3/app/optionsets
const response = await fetch(
  'https://api.mingdao.com/v3/app/optionsets',
  {
    method: 'GET',
    headers: {
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    }
  }
);

const optionSets = await response.json();
```

#### 获取选项集详情

```javascript
// GET /v3/app/optionsets/{optionset_id}
const response = await fetch(
  `https://api.mingdao.com/v3/app/optionsets/${optionsetId}`,
  {
    method: 'GET',
    headers: {
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    }
  }
);

const optionSet = await response.json();
```

### 7. 角色和成员管理

#### 获取角色列表

```javascript
// GET /v3/app/roles
const response = await fetch(
  'https://api.mingdao.com/v3/app/roles',
  {
    method: 'GET',
    headers: {
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    }
  }
);

const roles = await response.json();
```

#### 获取角色成员

```javascript
// GET /v3/app/roles/{role_id}/members
const response = await fetch(
  `https://api.mingdao.com/v3/app/roles/${roleId}/members`,
  {
    method: 'GET',
    headers: {
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    }
  }
);

const members = await response.json();
```

### 8. 用户和部门查询

#### 查询用户

```javascript
// POST /v3/users/lookup
const response = await fetch(
  'https://api.mingdao.com/v3/users/lookup',
  {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    },
    body: JSON.stringify({
      keywords: '张三',
      pageIndex: 1,
      pageSize: 20
    })
  }
);

const users = await response.json();
```

#### 查询部门

```javascript
// POST /v3/departments/lookup
const response = await fetch(
  'https://api.mingdao.com/v3/departments/lookup',
  {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'HAP-Appkey': appkey,
      'HAP-Sign': sign
    },
    body: JSON.stringify({
      keywords: '销售部',
      pageIndex: 1,
      pageSize: 20
    })
  }
);

const departments = await response.json();
```

## 筛选器使用规范

### 筛选条件结构

```javascript
const filters = {
  filterControls: [
    {
      controlId: 'status',        // 字段 ID
      dataType: 9,                // 字段类型
      spliceType: 1,              // 连接方式: 1=且, 2=或
      filterType: 2,              // 筛选类型
      values: ['key1', 'key2']    // 筛选值
    }
  ],
  conjunction: 1  // 多个筛选条件之间的关系: 1=且, 2=或
};
```

### 常用筛选类型 (filterType)

| filterType | 含义 | 适用字段类型 | values 示例 |
|-----------|------|------------|-----------|
| 1 | 为空 | 所有 | [] |
| 2 | 等于 | 所有 | ['value'] |
| 3 | 不等于 | 所有 | ['value'] |
| 4 | 包含 | 文本 | ['keyword'] |
| 5 | 不包含 | 文本 | ['keyword'] |
| 6 | 开头是 | 文本 | ['prefix'] |
| 7 | 结尾是 | 文本 | ['suffix'] |
| 14 | 大于 | 数值/日期 | ['100'] |
| 15 | 大于等于 | 数值/日期 | ['100'] |
| 16 | 小于 | 数值/日期 | ['100'] |
| 17 | 小于等于 | 数值/日期 | ['100'] |
| 24 | 是(任意一个) | 选项/成员 | ['key1','key2'] |
| 25 | 不是(任意一个) | 选项/成员 | ['key1','key2'] |

### 筛选示例

#### 示例1: 筛选单选字段

```javascript
// 筛选状态为"进行中"的记录
const filters = {
  filterControls: [
    {
      controlId: 'status',
      dataType: 9,          // 单选
      spliceType: 1,
      filterType: 2,        // 等于
      values: ['status_key_inprogress']
    }
  ]
};
```

#### 示例2: 筛选日期范围

```javascript
// 筛选本月创建的记录
const startOfMonth = '2024-01-01';
const endOfMonth = '2024-01-31';

const filters = {
  filterControls: [
    {
      controlId: 'ctime',
      dataType: 16,         // 日期时间
      spliceType: 1,
      filterType: 15,       // 大于等于
      values: [startOfMonth]
    },
    {
      controlId: 'ctime',
      dataType: 16,
      spliceType: 1,
      filterType: 17,       // 小于等于
      values: [endOfMonth]
    }
  ],
  conjunction: 1  // 且
};
```

#### 示例3: 筛选成员字段

```javascript
// 筛选负责人是"张三"或"李四"的记录
const filters = {
  filterControls: [
    {
      controlId: 'owner',
      dataType: 26,         // 成员
      spliceType: 1,
      filterType: 24,       // 是(任意一个)
      values: [
        'accountId_zhangsan',
        'accountId_lisi'
      ]
    }
  ]
};
```

#### 示例4: 组合筛选

```javascript
// 筛选状态为"进行中"且负责人是"张三"的记录
const filters = {
  filterControls: [
    {
      controlId: 'status',
      dataType: 9,
      spliceType: 1,
      filterType: 2,
      values: ['status_key_inprogress']
    },
    {
      controlId: 'owner',
      dataType: 26,
      spliceType: 1,
      filterType: 24,
      values: ['accountId_zhangsan']
    }
  ],
  conjunction: 1  // 且
};
```

## 在视图插件中使用 V3 接口

### 方案1: 使用 mdye 封装的 api

在明道云视图插件中,推荐使用 `mdye` 提供的封装好的 API:

```javascript
import { api, config } from 'mdye';

// 已经包含了鉴权,无需手动配置
const { appId, worksheetId } = config;

// 直接调用
const result = await api.getFilterRows({
  worksheetId,
  viewId: config.viewId,
  pageSize: 50
});
```

### 方案2: 直接调用 V3 接口

如果需要调用 mdye 未封装的接口:

```javascript
async function callV3API(endpoint, method = 'GET', body = null) {
  const headers = {
    'Content-Type': 'application/json',
    'HAP-Appkey': YOUR_APPKEY,
    'HAP-Sign': YOUR_SIGN
  };

  const options = {
    method,
    headers
  };

  if (body) {
    options.body = JSON.stringify(body);
  }

  const response = await fetch(
    `https://api.mingdao.com${endpoint}`,
    options
  );

  return await response.json();
}

// 使用示例
const optionSets = await callV3API('/v3/app/optionsets', 'GET');
```

## 在独立页面中使用 V3 接口

### 完整的 React 示例

```javascript
import React, { useState, useEffect } from 'react';

// 配置
const API_CONFIG = {
  baseURL: 'https://api.mingdao.com',
  appkey: '881f73bb18ad7b7d',
  sign: 'NTk4OGRhYzkzMzkxOGMxZWVlZDRlN2ZmMzhkN2JjZDM2ODAwOGVmMTI5NTQwODA3ZGI4NTBmOGMzOTlkNmE4ZA=='
};

// 封装请求函数
async function hapRequest(endpoint, options = {}) {
  const headers = {
    'Content-Type': 'application/json',
    'HAP-Appkey': API_CONFIG.appkey,
    'HAP-Sign': API_CONFIG.sign,
    ...options.headers
  };

  const response = await fetch(`${API_CONFIG.baseURL}${endpoint}`, {
    ...options,
    headers
  });

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }

  return await response.json();
}

// 组件示例
function CustomerList() {
  const [customers, setCustomers] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    loadCustomers();
  }, []);

  async function loadCustomers() {
    setLoading(true);
    try {
      const result = await hapRequest(
        '/v3/app/worksheets/69563e5df03728c888c04f05/rows/list',
        {
          method: 'POST',
          body: JSON.stringify({
            pageIndex: 1,
            pageSize: 100,
            sortId: 'ctime',
            isAsc: false
          })
        }
      );

      setCustomers(result.rows || []);
    } catch (error) {
      console.error('加载客户失败:', error);
    } finally {
      setLoading(false);
    }
  }

  async function createCustomer(data) {
    try {
      const result = await hapRequest(
        '/v3/app/worksheets/69563e5df03728c888c04f05/rows',
        {
          method: 'POST',
          body: JSON.stringify({
            controls: [
              {
                controlId: 'name',
                type: 2,
                value: data.name
              },
              {
                controlId: 'industry',
                type: 9,
                value: JSON.stringify([data.industryKey])
              }
            ]
          })
        }
      );

      // 刷新列表
      loadCustomers();
      return result;
    } catch (error) {
      console.error('创建客户失败:', error);
      throw error;
    }
  }

  return (
    <div>
      <h1>客户列表</h1>
      {loading ? (
        <p>加载中...</p>
      ) : (
        <ul>
          {customers.map(customer => (
            <li key={customer.rowid}>
              {customer.name}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

export default CustomerList;
```

## 最佳实践

### 1. 鉴权信息管理

```javascript
// ✅ 推荐: 使用环境变量
const API_CONFIG = {
  appkey: process.env.REACT_APP_HAP_APPKEY,
  sign: process.env.REACT_APP_HAP_SIGN
};

// ❌ 不推荐: 硬编码在代码中
const appkey = '881f73bb18ad7b7d';
```

### 2. 错误处理

```javascript
async function safeHapRequest(endpoint, options) {
  try {
    const result = await hapRequest(endpoint, options);
    return { success: true, data: result };
  } catch (error) {
    console.error('API 调用失败:', error);
    return { success: false, error: error.message };
  }
}
```

### 3. 请求封装

```javascript
class HapAPI {
  constructor(appkey, sign) {
    this.appkey = appkey;
    this.sign = sign;
    this.baseURL = 'https://api.mingdao.com';
  }

  async request(endpoint, options = {}) {
    const headers = {
      'Content-Type': 'application/json',
      'HAP-Appkey': this.appkey,
      'HAP-Sign': this.sign,
      ...options.headers
    };

    const response = await fetch(`${this.baseURL}${endpoint}`, {
      ...options,
      headers
    });

    return await response.json();
  }

  // 工作表操作
  async getWorksheetRows(worksheetId, params) {
    return this.request(
      `/v3/app/worksheets/${worksheetId}/rows/list`,
      {
        method: 'POST',
        body: JSON.stringify(params)
      }
    );
  }

  async createRow(worksheetId, controls) {
    return this.request(
      `/v3/app/worksheets/${worksheetId}/rows`,
      {
        method: 'POST',
        body: JSON.stringify({ controls })
      }
    );
  }

  async updateRow(worksheetId, rowId, controls) {
    return this.request(
      `/v3/app/worksheets/${worksheetId}/rows/${rowId}`,
      {
        method: 'PUT',
        body: JSON.stringify({ controls })
      }
    );
  }

  async deleteRows(worksheetId, rowIds) {
    return this.request(
      `/v3/app/worksheets/${worksheetId}/rows/batch`,
      {
        method: 'DELETE',
        body: JSON.stringify({ rowIds })
      }
    );
  }
}

// 使用示例
const api = new HapAPI(appkey, sign);
const rows = await api.getWorksheetRows(worksheetId, {
  pageIndex: 1,
  pageSize: 50
});
```

### 4. 性能优化

```javascript
// 使用防抖减少请求频率
import { debounce } from 'lodash';

const debouncedSearch = debounce(async (keyword) => {
  const result = await hapRequest('/v3/app/worksheets/.../rows/list', {
    method: 'POST',
    body: JSON.stringify({
      filters: {
        filterControls: [{
          controlId: 'name',
          dataType: 2,
          filterType: 4,
          values: [keyword]
        }]
      }
    })
  });
  setResults(result.rows);
}, 300);

// 使用缓存避免重复请求
const cache = new Map();

async function cachedRequest(key, requestFn) {
  if (cache.has(key)) {
    return cache.get(key);
  }

  const result = await requestFn();
  cache.set(key, result);
  return result;
}
```

## 常见问题

### 问题1: CORS 跨域错误

**错误信息:**
```
Access to fetch at 'https://api.mingdao.com/v3/...' from origin 'http://localhost:3000'
has been blocked by CORS policy
```

**解决方案:**
1. 使用代理服务器
2. 在服务端调用接口
3. 使用明道云视图插件(自动处理 CORS)

### 问题2: 鉴权失败

**错误信息:**
```json
{
  "error_code": 401,
  "error_msg": "Unauthorized"
}
```

**解决方案:**
- 检查 Appkey 和 Sign 是否正确
- 确认请求头格式正确
- 验证应用是否有权访问目标资源

### 问题3: 筛选条件不生效

**常见原因:**
- filterType 使用错误
- dataType 与字段实际类型不匹配
- values 格式不正确

**解决方案:**
- 通过 MCP 查询 API 文档
- 查看字段定义确认 dataType
- 参考本文档的筛选示例

## 总结

使用 HAP V3 接口的关键点:

1. **鉴权配置**: 正确设置 Appkey 和 Sign
2. **接口调用**: 遵循标准的 RESTful 规范
3. **筛选器**: 理解 filterType 和 dataType 的对应关系
4. **错误处理**: 做好异常捕获和用户提示
5. **性能优化**: 使用缓存、防抖等技术
6. **CORS 处理**: 根据场景选择合适的跨域方案

## 参考资源

- 明道云 HAP 开发者文档
- Apifox MCP Server (查询 API 文档)
- HAP 视图插件开发技能
- 明道云开发者社区

---

**注意:** 本技能提供的是 HAP V3 接口使用指南,实际使用时请根据具体业务需求调整接口参数和处理逻辑。
