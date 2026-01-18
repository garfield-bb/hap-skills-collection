
# HAP As Database Skill

本技能指导如何使用明道云 HAP（高级应用平台）作为后台内容管理系统，搭建完整的前后端分离项目。

## 适用场景

- ✅ 企业官网（产品展示、新闻资讯、案例展示）
- ✅ 内容管理网站（博客、文档库、知识库）
- ✅ 数据展示平台（数据看板、报表展示）
- ✅ 表单收集系统（在线预约、问卷调查、询价订单）
- ✅ 营销落地页（活动页面、促销页面）

## 技术栈

- **后端**: HAP（零代码/低代码平台）
- **API**: HAP 应用公开 API V3
- **前端**: HTML5 + CSS3 + JavaScript (ES6+)
- **部署**: 静态网站托管（GitHub Pages、Vercel、Netlify 等）

---

## 🎯 核心概念

### HAP 在项目中的角色

HAP 不是前端框架，而是**数据管理后台** + **API 服务器**：

```
┌─────────────┐     API V3      ┌──────────────┐
│   前端网站   │ ←──────────────→ │   HAP 后台   │
│  (HTML/JS)  │   读取/写入数据    │ (数据管理)   │
└─────────────┘                  └──────────────┘
     ↓ 部署                           ↓ 存储
  Vercel/GitHub              产品/案例/新闻数据
```

### 职责划分

#### 前端项目
- ✅ 页面布局和样式
- ✅ 通过 HAP API V3 读取数据
- ✅ 动态渲染内容
- ✅ 处理用户交互
- ❌ 不存储业务数据
- ❌ 不使用 @mdfe/view SDK（那是插件用的）

#### HAP 后台
- ✅ 存储所有业务数据
- ✅ 提供数据管理界面
- ✅ 通过 API 暴露数据
- ❌ 不负责前端渲染

---

## 🚀 开发流程

### 第一步：HAP 后台配置

#### 1.1 创建应用结构

使用 MCP 创建应用和工作表：

```javascript
// 示例：创建产品展示应用
// 1. 创建应用
// 2. 创建工作表（产品、案例、新闻等）
// 3. 配置字段（标题、描述、图片、价格等）
```

**关键字段类型：**
- 标题字段（Text）
- 描述字段（Text/RichText）
- 图片字段（Attachment）
- 分类字段（SingleSelect/MultipleSelect）
- 价格字段（Number）
- 日期字段（Date/DateTime）

#### 1.2 配置 API 鉴权

获取应用的 API 凭证：
1. 在 HAP 应用中开启"公开 API"
2. 获取 `HAP-Appkey` 和 `HAP-Sign`
3. 配置到前端项目

#### 1.3 填充示例数据

⚠️ **重要：附件字段必须填充 URL！**

使用 MCP 创建示例数据时：
- ✅ 每条记录的图片字段都必须有完整的 URL
- ❌ 绝不允许附件字段为空数组 `[]`

**测试图片 URL（可直接使用）：**
```javascript
const SAMPLE_IMAGES = [
    'https://m1.mingdaoyun.cn/doc/20251205/095p6B8tbW3x9v1A5lc41O8QdYaua101bM8Wb7442Q2ZfKb21m8deM1U0r4UaC9h.png',
    'https://m1.mingdaoyun.cn/doc/20251205/1B4Ed46s1a3wfaeI2RaBdM1Ybb4MeB0je21WcH2d7mal8Q667i2w0A2EaW1t02cS.png',
    'https://m1.mingdaoyun.cn/doc/20251205/0u1r8Rcjb39Uc5fT1edP3w9q8q5y0lc45c657Q8zfG768S3XbF9N148X8Qfc1Rdq.png',
    // ... 更多图片
];
```

---

### 第二步：前端项目搭建

#### 2.1 项目结构

```
website/
├── index.html          # 首页
├── products.html       # 产品列表
├── product-detail.html # 产品详情
├── css/
│   └── style.css       # 样式
├── js/
│   ├── config.js       # API 配置
│   ├── api.js          # API 封装
│   └── main.js         # 业务逻辑
└── images/             # 静态资源
```

#### 2.2 API 配置（config.js）

```javascript
const API_CONFIG = {
    baseURL: 'https://api.mingdao.com/v3',
    appKey: 'your-app-key',
    sign: 'your-sign',
    worksheetId: 'your-worksheet-id'
};
```

#### 2.3 API 封装（api.js）

```javascript
// 查询数据
async function getRecords(worksheetId, filter = {}) {
    const response = await fetch(`${API_CONFIG.baseURL}/app/worksheets/${worksheetId}/rows/list`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'HAP-Appkey': API_CONFIG.appKey,
            'HAP-Sign': API_CONFIG.sign
        },
        body: JSON.stringify({
            pageIndex: 1,
            pageSize: 50,
            filter: filter
        })
    });
    return response.json();
}

// 创建记录
async function createRecord(worksheetId, data) {
    const response = await fetch(`${API_CONFIG.baseURL}/app/worksheets/${worksheetId}/rows`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'HAP-Appkey': API_CONFIG.appKey,
            'HAP-Sign': API_CONFIG.sign
        },
        body: JSON.stringify({
            fields: data
        })
    });
    return response.json();
}
```

#### 2.4 筛选查询

⚠️ **重要：SingleSelect/MultipleSelect 必须使用 key（UUID）！**

这是最常见的错误！

```javascript
// ❌ 错误：使用显示文本
filter: {
    type: 'group',
    logic: 'AND',
    children: [{
        type: 'condition',
        field: 'category',
        operator: 'eq',
        value: ['现代简约']  // ❌ 错误！
    }]
}

// ✅ 正确：使用选项的 key（UUID）
filter: {
    type: 'group',
    logic: 'AND',
    children: [{
        type: 'condition',
        field: 'category',
        operator: 'eq',
        value: ['uuid-xxxx-xxxx']  // ✅ 正确！
    }]
}
```

**获取选项 key 的方法：**
1. 使用 MCP `get_worksheet_structure` 获取工作表结构
2. 从返回的字段定义中找到 options 数组
3. 每个选项有 `key`（UUID）和 `value`（显示文本）
4. 筛选时使用 `key`，渲染时使用 `value`

---

### 第三步：数据渲染

#### 3.1 读取并渲染数据

```javascript
async function loadProducts() {
    const data = await getRecords(WORKSHEET_ID);

    const container = document.getElementById('products');
    data.rows.forEach(row => {
        const html = `
            <div class="product-card">
                <img src="${row.image?.[0]?.url || 'default.jpg'}" alt="${row.title}">
                <h3>${row.title}</h3>
                <p>${row.description}</p>
                <span class="price">¥${row.price}</span>
            </div>
        `;
        container.innerHTML += html;
    });
}
```

#### 3.2 处理附件字段

```javascript
// 附件字段是数组
const images = row.image; // [{url: '...', name: '...'}, ...]

// 获取第一张图片
const firstImage = images?.[0]?.url || 'default.jpg';

// 获取所有图片
const imageUrls = images?.map(img => img.url) || [];
```

---

## 📋 开发检查清单

### HAP 配置
- [ ] 创建应用和工作表
- [ ] 配置字段类型
- [ ] 开启公开 API
- [ ] 获取 Appkey 和 Sign
- [ ] 填充示例数据（图片必须有 URL）

### 前端开发
- [ ] 创建项目结构
- [ ] 配置 API 凭证
- [ ] 封装 API 调用
- [ ] 实现数据渲染
- [ ] 处理筛选和搜索
- [ ] 测试所有功能

### 部署上线
- [ ] 选择部署平台（Vercel/GitHub Pages）
- [ ] 配置环境变量
- [ ] 测试线上环境
- [ ] 配置自定义域名

---

## ⚠️ 常见错误（AI 必须避免）

### 错误 1: 附件字段为空
```javascript
// ❌ 错误
fields: [{
    id: 'image',
    value: []  // 空数组导致无图片显示
}]

// ✅ 正确
fields: [{
    id: 'image',
    value: [{
        name: 'product.jpg',
        url: 'https://example.com/image.jpg'
    }]
}]
```

### 错误 2: 筛选时使用显示文本
```javascript
// ❌ 错误
value: ['客厅']  // 使用显示文本

// ✅ 正确
value: ['uuid-xxxx']  // 使用选项 key
```

### 错误 3: 混淆视图插件和独立网站
```javascript
// ❌ 错误：在独立网站中使用视图插件 SDK
import { useData } from '@mdfe/view';

// ✅ 正确：使用 API
fetch('https://api.mingdao.com/v3/...')
```

---

## 🎯 开发原则

1. **HAP 是数据库**
   - 仅用于数据存储和管理
   - 不负责前端渲染

2. **前端是展示层**
   - 通过 API 获取数据
   - 负责所有页面渲染

3. **API 是桥梁**
   - 前端与 HAP 唯一的通信方式
   - 使用 HAP API V3 规范

4. **MCP 是开发工具**
   - 用于快速搭建 HAP 应用结构
   - 用于填充示例数据
   - 前端项目不使用 MCP

---

## 📦 示例项目参考

典型的企业官网项目结构：

```
定制家具官网/
├── HAP 应用（后台）
│   ├── 产品表（产品展示）
│   ├── 案例表（案例展示）
│   ├── 新闻表（新闻资讯）
│   └── 询价表（用户询价）
│
├── 前端项目
│   ├── 首页（轮播图 + 产品推荐）
│   ├── 产品列表（分类筛选）
│   ├── 产品详情（图文详情）
│   ├── 案例展示（瀑布流）
│   ├── 新闻资讯（列表 + 详情）
│   └── 在线询价（表单提交）
│
└── 部署
    └── Vercel（自动部署）
```

---

## 🔗 相关资源

- HAP 官方文档: https://help.mingdao.com
- HAP API V3 文档: https://api.mingdao.com/docs
- Vercel 部署: https://vercel.com
- GitHub Pages: https://pages.github.com

---

## 🤖 AI 执行步骤（思考 Todo List）

**当用户需要搭建独立网站并使用 HAP 作为后台时，AI 应按照以下步骤思考和执行：**

### 步骤 1: 理解项目需求
- [ ] 明确用户要搭建什么类型的网站？（企业官网、产品展示、内容管理等）
- [ ] 确定前端技术栈选择（HTML/CSS/JS、React、Vue 等）
- [ ] 确定部署平台（Vercel、GitHub Pages、Netlify 等）

### 步骤 2: 设计数据模型
- [ ] 使用 MCP 获取现有 HAP 应用结构（如果已有）
- [ ] 设计需要的数据表（产品、新闻、案例等）
- [ ] 设计字段类型和结构
- [ ] **向用户确认数据模型设计**，获得同意后再继续

### 步骤 3: 配置 HAP 应用
- [ ] 检查是否已配置 HAP MCP（`~/.cursor/mcp.json`）
- [ ] 如果没有配置，指导用户配置或使用 MCP 创建应用结构
- [ ] 使用 MCP 创建数据表和字段
- [ ] 使用 MCP 创建示例数据

### 步骤 4: 开发前端项目
- [ ] 创建前端项目结构（如果不存在）
- [ ] 创建 API 调用封装文件（`js/api.js`）
- [ ] 配置 API 密钥和请求头
- [ ] 实现数据获取逻辑
- [ ] 实现页面渲染逻辑
- [ ] 处理附件字段（必须有 URL）
- [ ] 处理选项字段（使用 key 而非显示文本）

### 步骤 5: 集成和测试
- [ ] 使用 MCP 验证数据一致性
- [ ] 测试数据读取功能
- [ ] 测试数据筛选和排序
- [ ] 测试附件显示
- [ ] 修复问题并优化

### 步骤 6: 部署准备
- [ ] 配置部署配置文件（`vercel.json` 等）
- [ ] 确保 API 密钥安全（环境变量或配置文件）
- [ ] 测试生产环境部署
- [ ] 指导用户部署到生产环境

**关键原则：**
- ✅ HAP 是数据库，不是前端框架
- ✅ 前端通过 API V3 读取数据
- ✅ 不使用 @mdfe/view SDK（那是插件用的）
- ✅ 附件字段必须有 URL
- ✅ 筛选时使用选项 key 而非显示文本

---

## 📝 使用此 Skill

当用户说：
- "我想搭建一个企业官网"
- "用 HAP 作为后台管理系统"
- "做一个产品展示网站"
- "HAP + 前端项目怎么做"

立即使用此 skill，指导用户：
1. 使用 MCP 搭建 HAP 应用结构
2. 创建前端项目并集成 API
3. 实现数据读取和渲染
4. 部署到生产环境

**关键点：**
- 明确 HAP 是数据库，不是前端框架
- 附件字段必须有 URL
- 筛选时使用选项 key 而非显示文本
- 使用 API V3，不使用视图插件 SDK

---

**当用户需要搭建独立网站并使用 HAP 作为后台时，使用此 skill 提供完整的开发指导。**
