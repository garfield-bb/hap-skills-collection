# HAP MCP 完整开发流程

## 🎯 核心能力

**HAP MCP 可以:**
1. ✅ 查询应用结构(工作表、字段)
2. ✅ 读取数据(查询记录)
3. ✅ 创建记录
4. ✅ 更新记录
5. ✅ 删除记录
6. ✅ 管理应用结构(如果 MCP 支持)

**这意味着:**
- 🔍 不需要手动查字段 ID - MCP 直接告诉你
- 📝 可以直接通过 MCP 创建示例数据
- ⚙️ 可能可以通过 MCP 调整应用结构
- ✅ 整个开发流程更加自动化

---

## 📋 完整开发流程(使用 MCP)

### 阶段 1: 需求分析

#### 1.1 收集用户需求
```
用户提供:
- 业务场景: "我需要一个订单管理系统"
- 功能需求: "创建订单、查看列表、修改状态"
- 数据要求: "关联客户和产品"
```

#### 1.2 通过 MCP 分析现有应用结构

**第1步: 查询应用信息**
```
通过 hap-mcp-定制家具官网 查询:
- 应用基本信息
- 所有工作表列表
- 每个工作表的字段定义
```

**AI 输出分析报告:**
```markdown
## 现有应用结构分析

### 已有工作表

#### 1. 客户工作表
- worksheetId: 67a1234...
- 字段列表:
  - name (文本) - 客户姓名
  - phone (电话) - 联系电话
  - address (文本) - 地址
  - create_time (日期时间)

#### 2. 产品工作表
- worksheetId: 67b2345...
- 字段列表:
  - name (文本) - 产品名称
  - price (金额) - 价格
  - stock (数值) - 库存
  - category (单选) - 分类

### 需求匹配度
✅ 客户数据: 已有工作表,满足需求
✅ 产品数据: 已有工作表,满足需求
❌ 订单数据: 缺少工作表,需要新建
❌ 订单明细: 缺少工作表,需要新建
```

### 阶段 2: 设计数据架构

#### 2.1 AI 提供架构方案

```markdown
## 订单管理系统 - 数据架构方案

### 需要新增的工作表

#### 📋 工作表1: 订单
**用途**: 存储订单主信息

**字段设计**:
| 字段名称 | 字段类型 | 说明 | 配置 |
|---------|---------|------|------|
| 订单编号 | 自动编号 | 唯一标识 | 格式: ORD-{YYYY}{MM}{DD}-{####} |
| 客户 | 关联记录 | 关联客户表 | 必填,单选 |
| 订单状态 | 单选 | 订单流程状态 | 选项: 待确认/已确认/生产中/已完成/已取消 |
| 订单金额 | 金额 | 订单总金额 | 公式: SUM(订单明细.小计) |
| 下单时间 | 日期时间 | 创建时间 | 默认当前时间 |
| 备注 | 文本 | 订单说明 | 可选 |

#### 📦 工作表2: 订单明细
**用途**: 存储订单中的产品明细

**字段设计**:
| 字段名称 | 字段类型 | 说明 | 配置 |
|---------|---------|------|------|
| 订单 | 关联记录 | 关联订单表 | 必填,多条 |
| 产品 | 关联记录 | 关联产品表 | 必填,单选 |
| 数量 | 数值 | 购买数量 | 必填,默认1,最小值1 |
| 单价 | 金额 | 产品单价 | 查找字段,来自产品.价格 |
| 小计 | 金额 | 行总价 | 公式: 数量 × 单价 |

### 需要修改的工作表

#### 🔧 产品工作表
**建议新增字段**:
- 库存预警值 (数值): 当库存低于此值时预警

### 关联关系图
```
客户 ←──────┐
             │
          订单主表
             │
             ↓
          订单明细 ──→ 产品
```

### 示例数据
我可以通过 MCP 创建以下示例数据:
- ✅ 10 个客户
- ✅ 20 个产品
- ✅ 15 个订单(含明细)

**是否需要创建示例数据?**
[是 - AI 通过 MCP 创建] [否 - 我自己录入]
```

#### 2.2 征得用户同意

**AI 询问:**
```
📊 数据架构方案已准备好!

需要您确认:
1. ✅ 是否同意新增 "订单" 和 "订单明细" 工作表?
2. ✅ 字段设计是否满足需求?需要调整吗?
3. ✅ 是否需要我创建示例数据?(通过 MCP 直接创建)

请回复:
- "同意,创建示例数据" - 我会立即配置
- "同意,不要示例数据" - 我会配置空表
- "需要调整..." - 告诉我需要改什么
```

### 阶段 3: 配置 HAP 应用

#### 3.1 通过 MCP 创建工作表结构

**如果 MCP 支持结构管理:**
```javascript
// AI 通过 MCP 自动创建工作表
MCP 操作:
1. 创建 "订单" 工作表
2. 添加所有字段(编号、客户、状态、金额...)
3. 创建 "订单明细" 工作表
4. 添加所有字段(订单、产品、数量、单价、小计)
5. 配置关联关系
6. 设置字段属性(必填、默认值、公式)
```

**如果 MCP 不支持结构管理:**
```
AI 提供详细配置清单:

请在明道云应用中按以下步骤操作:

第1步: 创建 "订单" 工作表
- 点击 "新建工作表"
- 名称: 订单
- 图标: 📋

第2步: 添加字段
1. 订单编号(自动编号)
   - 格式设置: ORD-{YYYY}{MM}{DD}-{####}

2. 客户(关联记录)
   - 关联表: 选择 "客户" 工作表
   - 关联方式: 单条
   - 必填: 是

... (详细步骤)

完成后请告诉我,我会继续下一步。
```

#### 3.2 通过 MCP 创建示例数据

**AI 通过 MCP 自动创建:**
```javascript
// 1. 创建客户示例数据
通过 MCP 创建 10 条客户记录:
- 张三, 13800138000, 北京市朝阳区...
- 李四, 13900139000, 上海市浦东新区...
...

// 2. 创建产品示例数据
通过 MCP 创建 20 条产品记录:
- 北欧实木沙发, 5999, 客厅家具...
- 现代简约床, 3999, 卧室家具...
...

// 3. 创建订单数据
通过 MCP 创建 15 条订单:
- ORD-20240101-0001, 客户:张三, 状态:已确认...
  明细: 北欧沙发 x1, 实木茶几 x1

- ORD-20240101-0002, 客户:李四, 状态:生产中...
  明细: 简约床 x1, 床头柜 x2
...
```

**AI 输出创建报告:**
```
✅ 示例数据创建完成!

已创建:
- 客户: 10 条
- 产品: 20 条
- 订单: 15 条
- 订单明细: 35 条

您现在可以:
1. 登录明道云查看数据
2. 开始开发前端页面
3. 使用真实数据测试
```

### 阶段 4: 获取字段映射

#### 4.1 通过 MCP 自动获取字段 ID

**AI 自动查询并生成配置:**
```javascript
// 通过 MCP 查询工作表结构
const orderSheet = await MCP.getWorksheetDetail('订单');
const orderDetailSheet = await MCP.getWorksheetDetail('订单明细');

// AI 自动生成字段映射配置
export const FIELD_MAPPING = {
  ORDER: {
    WORKSHEET_ID: '67a1234567890abcdef',
    FIELDS: {
      ORDER_NUMBER: '67a1234567890abc001',  // 从 MCP 查询得到
      CUSTOMER: '67a1234567890abc002',
      STATUS: '67a1234567890abc003',
      AMOUNT: '67a1234567890abc004',
      CREATE_TIME: '67a1234567890abc005',
      REMARK: '67a1234567890abc006'
    }
  },

  ORDER_DETAIL: {
    WORKSHEET_ID: '67b2345678901bcdefg',
    FIELDS: {
      ORDER: '67b2345678901bcd001',
      PRODUCT: '67b2345678901bcd002',
      QUANTITY: '67b2345678901bcd003',
      PRICE: '67b2345678901bcd004',
      SUBTOTAL: '67b2345678901bcd005'
    }
  }
};
```

**AI 告知用户:**
```
✅ 字段映射已自动生成!

我已经通过 MCP 获取了所有字段 ID,
并生成了字段映射配置文件。

文件位置: src/config/fieldMapping.js
```

### 阶段 5: 开发前端页面

#### 5.1 创建数据服务层

**AI 自动生成完整的数据服务:**
```javascript
// src/services/orderService.js
import hapAPI from './hapAPI';
import { FIELD_MAPPING } from '../config/fieldMapping';

const { ORDER, ORDER_DETAIL } = FIELD_MAPPING;

export class OrderService {
  // 获取订单列表
  async getOrders(filters = {}) {
    const result = await hapAPI.getRows(ORDER.WORKSHEET_ID, {
      pageIndex: filters.page || 1,
      pageSize: filters.pageSize || 20,
      sortId: ORDER.FIELDS.CREATE_TIME,
      isAsc: false,
      filters: this.buildFilters(filters)
    });

    return result.rows.map(row => this.parseOrder(row));
  }

  // 获取订单详情(含明细)
  async getOrderDetail(orderId) {
    // 1. 获取订单主信息
    const order = await hapAPI.getRowDetail(ORDER.WORKSHEET_ID, orderId);

    // 2. 获取订单明细
    const details = await hapAPI.getRelationRows(
      ORDER_DETAIL.WORKSHEET_ID,
      orderId,
      ORDER_DETAIL.FIELDS.ORDER
    );

    return {
      ...this.parseOrder(order),
      details: details.map(d => this.parseOrderDetail(d))
    };
  }

  // 创建订单
  async createOrder(orderData) {
    // 1. 创建订单主记录
    const orderControls = [
      {
        controlId: ORDER.FIELDS.CUSTOMER,
        type: 29,
        value: JSON.stringify([{
          name: orderData.customer.name,
          sid: orderData.customer.sid
        }])
      },
      {
        controlId: ORDER.FIELDS.STATUS,
        type: 9,
        value: JSON.stringify(['pending'])
      },
      {
        controlId: ORDER.FIELDS.REMARK,
        type: 2,
        value: orderData.remark || ''
      }
    ];

    const orderResult = await hapAPI.createRow(
      ORDER.WORKSHEET_ID,
      orderControls
    );

    // 2. 创建订单明细
    if (orderData.products && orderData.products.length > 0) {
      await Promise.all(
        orderData.products.map(product =>
          this.createOrderDetail(orderResult.rowId, product)
        )
      );
    }

    return orderResult;
  }

  // 创建订单明细
  async createOrderDetail(orderId, product) {
    const controls = [
      {
        controlId: ORDER_DETAIL.FIELDS.ORDER,
        type: 29,
        value: JSON.stringify([{
          name: orderId,
          sid: orderId
        }])
      },
      {
        controlId: ORDER_DETAIL.FIELDS.PRODUCT,
        type: 29,
        value: JSON.stringify([{
          name: product.name,
          sid: product.sid
        }])
      },
      {
        controlId: ORDER_DETAIL.FIELDS.QUANTITY,
        type: 6,
        value: product.quantity
      }
    ];

    return await hapAPI.createRow(ORDER_DETAIL.WORKSHEET_ID, controls);
  }

  // 更新订单状态
  async updateOrderStatus(orderId, status) {
    return await hapAPI.updateRow(
      ORDER.WORKSHEET_ID,
      orderId,
      [{
        controlId: ORDER.FIELDS.STATUS,
        type: 9,
        value: JSON.stringify([status])
      }]
    );
  }

  // 解析订单数据
  parseOrder(row) {
    return {
      id: row.rowid,
      orderNumber: row[ORDER.FIELDS.ORDER_NUMBER],
      customer: this.parseRelation(row[ORDER.FIELDS.CUSTOMER]),
      status: this.parseSelect(row[ORDER.FIELDS.STATUS]),
      amount: parseFloat(row[ORDER.FIELDS.AMOUNT]) || 0,
      createTime: row[ORDER.FIELDS.CREATE_TIME],
      remark: row[ORDER.FIELDS.REMARK] || ''
    };
  }

  // 解析订单明细
  parseOrderDetail(row) {
    return {
      id: row.rowid,
      product: this.parseRelation(row[ORDER_DETAIL.FIELDS.PRODUCT]),
      quantity: parseInt(row[ORDER_DETAIL.FIELDS.QUANTITY]) || 0,
      price: parseFloat(row[ORDER_DETAIL.FIELDS.PRICE]) || 0,
      subtotal: parseFloat(row[ORDER_DETAIL.FIELDS.SUBTOTAL]) || 0
    };
  }

  // 工具方法
  parseSelect(value) {
    try {
      const values = typeof value === 'string' ? JSON.parse(value) : value;
      return Array.isArray(values) ? values[0] : '';
    } catch {
      return '';
    }
  }

  parseRelation(value) {
    try {
      const relations = typeof value === 'string' ? JSON.parse(value) : value;
      return Array.isArray(relations) && relations.length > 0
        ? relations[0]
        : null;
    } catch {
      return null;
    }
  }

  buildFilters(filters) {
    const filterControls = [];

    if (filters.status) {
      filterControls.push({
        controlId: ORDER.FIELDS.STATUS,
        dataType: 9,
        filterType: 2,
        values: [filters.status]
      });
    }

    if (filters.customerId) {
      filterControls.push({
        controlId: ORDER.FIELDS.CUSTOMER,
        dataType: 29,
        filterType: 2,
        values: [filters.customerId]
      });
    }

    if (filters.startDate) {
      filterControls.push({
        controlId: ORDER.FIELDS.CREATE_TIME,
        dataType: 16,
        filterType: 15,
        values: [filters.startDate]
      });
    }

    if (filters.endDate) {
      filterControls.push({
        controlId: ORDER.FIELDS.CREATE_TIME,
        dataType: 16,
        filterType: 17,
        values: [filters.endDate]
      });
    }

    return filterControls.length > 0
      ? { filterControls, conjunction: 1 }
      : undefined;
  }
}

export const orderService = new OrderService();
```

#### 5.2 开发页面组件

**AI 生成完整的订单列表页面:**
```javascript
// src/pages/OrderListPage.jsx
import React, { useState, useEffect } from 'react';
import { orderService } from '../services/orderService';

export default function OrderListPage() {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filters, setFilters] = useState({
    status: '',
    page: 1
  });

  useEffect(() => {
    loadOrders();
  }, [filters]);

  async function loadOrders() {
    setLoading(true);
    try {
      const data = await orderService.getOrders(filters);
      setOrders(data);
    } catch (error) {
      console.error('加载订单失败:', error);
    } finally {
      setLoading(false);
    }
  }

  async function handleStatusChange(orderId, newStatus) {
    try {
      await orderService.updateOrderStatus(orderId, newStatus);
      loadOrders(); // 刷新列表
    } catch (error) {
      console.error('更新状态失败:', error);
    }
  }

  return (
    <div className="order-list-page">
      {/* 筛选栏 */}
      <div className="filters">
        <select
          value={filters.status}
          onChange={(e) => setFilters({...filters, status: e.target.value})}
        >
          <option value="">全部状态</option>
          <option value="pending">待确认</option>
          <option value="confirmed">已确认</option>
          <option value="processing">生产中</option>
          <option value="completed">已完成</option>
          <option value="cancelled">已取消</option>
        </select>
      </div>

      {/* 订单列表 */}
      {loading ? (
        <div>加载中...</div>
      ) : (
        <div className="order-list">
          {orders.map(order => (
            <div key={order.id} className="order-card">
              <div className="order-header">
                <span className="order-number">{order.orderNumber}</span>
                <span className={`status status-${order.status}`}>
                  {order.status}
                </span>
              </div>
              <div className="order-body">
                <p>客户: {order.customer?.name}</p>
                <p>金额: ¥{order.amount.toLocaleString()}</p>
                <p>下单时间: {order.createTime}</p>
              </div>
              <div className="order-actions">
                <button onClick={() => handleStatusChange(order.id, 'confirmed')}>
                  确认
                </button>
                <button onClick={() => window.location.href = `/orders/${order.id}`}>
                  查看详情
                </button>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
```

### 阶段 6: 验证测试

#### 6.1 通过 MCP 验证数据

**AI 执行验证流程:**
```javascript
// 1. 在前端创建一条订单
const newOrder = await orderService.createOrder({
  customer: { name: '测试客户', sid: '...' },
  products: [
    { name: '测试产品', sid: '...', quantity: 2 }
  ],
  remark: '测试订单'
});

// 2. 通过 MCP 查询验证
const verification = await MCP.getRowDetail(
  ORDER.WORKSHEET_ID,
  newOrder.rowId
);

// 3. AI 输出验证报告
✅ 订单创建成功
✅ 数据写入正确
✅ 订单编号: ORD-20240105-0001
✅ 订单明细: 1 条
```

#### 6.2 数据一致性检查

**验证清单:**
```
✅ 前端显示的数据与 HAP 应用一致
✅ 创建的记录能够正确读取
✅ 更新操作正确同步
✅ 关联字段数据完整
✅ 筛选器工作正常
✅ 分页加载正确
```

---

## 🚀 完整案例: 5分钟搭建订单系统

### 用户说:
```
"我需要一个订单管理系统,
能创建订单、查看列表、修改状态"
```

### AI 操作流程:

#### 第1步: MCP 分析(10秒)
```
通过 MCP 查询应用结构
→ 发现有客户和产品表
→ 缺少订单和订单明细表
```

#### 第2步: 提供方案(20秒)
```
AI: "需要新增订单和订单明细表,
     字段设计如下...(展示架构方案)
     是否需要创建示例数据?"

用户: "同意,创建示例数据"
```

#### 第3步: MCP 配置应用(如果支持)(1分钟)
```
通过 MCP 自动:
→ 创建订单工作表
→ 创建订单明细工作表
→ 配置字段和关联
→ 创建15条示例订单
```

#### 第4步: 生成代码(2分钟)
```
AI 自动生成:
→ 字段映射配置
→ 数据服务层
→ 订单列表页面
→ 订单创建页面
→ 订单详情页面
```

#### 第5步: 启动验证(1分钟)
```
npm run dev
→ 访问 http://localhost:3000/orders
→ 查看15条示例订单
→ 创建新订单测试
→ 通过 MCP 验证数据一致性
```

**总耗时: 约 5 分钟!**

---

## ✨ MCP 的强大之处

### 传统方式 vs MCP 方式

#### ❌ 传统方式
```
1. 手动登录明道云查看结构 (5分钟)
2. 手动记录字段 ID (10分钟)
3. 手动创建测试数据 (15分钟)
4. 手动验证数据 (5分钟)
总计: 35分钟
```

#### ✅ MCP 方式
```
1. MCP 查询应用结构 (10秒)
2. MCP 自动获取字段 ID (5秒)
3. MCP 创建示例数据 (1分钟)
4. MCP 验证数据 (10秒)
总计: 2分钟
```

**效率提升: 17倍!**

---

## 📝 总结

**使用 HAP MCP 的开发流程:**

1. 🔍 **分析需求** → MCP 查询现有结构
2. 📋 **设计架构** → AI 提供完整方案
3. 🤝 **征得同意** → 用户确认方案
4. ⚙️ **配置应用** → MCP 自动创建(或用户手动)
5. 📝 **创建数据** → MCP 生成示例数据
6. 🎯 **获取映射** → MCP 自动获取字段 ID
7. 💻 **生成代码** → AI 自动生成完整代码
8. ✅ **验证测试** → MCP 验证数据一致性

**核心优势:**
- ⚡ **自动化**: MCP 自动完成大部分工作
- 🎯 **准确性**: 直接从 HAP 获取,无需手动记录
- 🚀 **高效率**: 从需求到上线,5分钟完成
- 🔄 **实时验证**: 随时通过 MCP 检查数据

**记住:**
- HAP 应用 = 完整的后端服务
- HAP MCP = 自动化开发助手
- V3 接口 = 前端数据通道
- 三者结合 = 极速开发体验!
