# HAP 独立页面开发流程

## 核心理念

**HAP 应用 = 后端服务 + 数据库**

独立页面不仅仅是静态展示,而是:
- **前端**: React/Vue 等现代框架搭建的完整应用
- **后端**: HAP 应用提供 API 服务和数据存储
- **集成**: 通过 HAP V3 接口实现前后端数据交互

## 开发流程

### 阶段 1: 需求分析与架构设计

#### 1.1 收集用户需求
```
用户提供:
- 业务场景描述
- 功能需求列表
- 数据结构说明
- 页面交互要求
```

#### 1.2 分析 HAP 应用现有结构

**步骤1: 通过 MCP 获取应用结构**
```javascript
// 使用 MCP 查询应用信息
1. 获取应用列表
2. 查看工作表结构
3. 分析字段定义
4. 了解现有数据
```

**步骤2: 评估数据承载能力**
```
检查项:
✅ 现有工作表是否满足需求?
✅ 字段类型是否匹配?
✅ 关联关系是否完整?
✅ 权限配置是否合理?
```

**步骤3: 设计数据模型**
```
如果现有结构不满足:
1. 列出需要新增的工作表
2. 定义每个工作表的字段
3. 设计表间关联关系
4. 规划权限和流程
```

#### 1.3 征得用户同意

**向用户展示架构方案:**

```markdown
## 数据架构方案

### 现有结构分析
- 工作表A: 满足需求,无需修改
- 工作表B: 缺少字段X,需要新增

### 需要的调整

#### 1. 新增工作表
- **工作表名称**: 订单明细
- **用途**: 存储订单商品信息
- **字段列表**:
  - 订单关联 (关联记录)
  - 商品名称 (文本)
  - 数量 (数值)
  - 单价 (金额)

#### 2. 修改现有工作表
- **工作表**: 产品
- **修改内容**: 新增 "库存预警值" 字段 (数值)

### 是否需要示例数据?
- ✅ 是: 我会创建 10-20 条测试数据
- ❌ 否: 使用空表,您自己录入
```

### 阶段 2: HAP 应用配置

#### 2.1 结构调整(需用户在 HAP 中操作)

**用户需要在明道云应用中:**
1. 创建新的工作表
2. 添加缺少的字段
3. 配置字段属性(类型、必填、默认值)
4. 设置关联关系
5. 配置权限和流程

**AI 提供配置清单:**
```yaml
工作表: 订单
字段配置:
  - 订单编号:
      类型: 自动编号
      格式: "ORD-{YYYY}{MM}{DD}-{####}"

  - 客户姓名:
      类型: 文本
      必填: 是

  - 联系电话:
      类型: 电话
      必填: 是
      验证: 手机号格式

  - 订单状态:
      类型: 单选
      选项:
        - 待确认
        - 已确认
        - 生产中
        - 已完成
        - 已取消
      默认值: 待确认

  - 订单金额:
      类型: 金额
      只读: 是
      公式: SUM(订单明细.小计)

  - 下单时间:
      类型: 日期时间
      默认值: 当前时间
```

#### 2.2 录入示例数据(如果需要)

**提供数据导入模板:**
```csv
订单编号,客户姓名,联系电话,订单状态,备注
ORD-20240101-0001,张三,13800138000,已确认,全屋定制
ORD-20240101-0002,李四,13900139000,生产中,客厅家具
```

### 阶段 3: 前端页面开发

#### 3.1 创建项目结构
```bash
project-name/
├── src/
│   ├── services/
│   │   ├── hapAPI.js           # HAP 接口封装
│   │   └── dataService.js      # 业务数据服务
│   ├── pages/                  # 页面组件
│   ├── components/             # 公共组件
│   └── utils/                  # 工具函数
```

#### 3.2 获取 HAP 字段 ID

**通过 MCP 或 API 查询:**
```javascript
// 方式1: 使用 MCP 查询
通过 MCP 工具查看工作表结构,获取字段 ID

// 方式2: 使用 API 查询
const worksheet = await hapAPI.getWorksheetDetail(worksheetId);
const fields = worksheet.controls.map(ctrl => ({
  id: ctrl.controlId,
  name: ctrl.controlName,
  type: ctrl.type
}));
console.table(fields);
```

#### 3.3 创建字段映射配置

**建立字段映射表:**
```javascript
// src/config/fieldMapping.js
export const FIELD_MAPPING = {
  // 订单工作表
  ORDER: {
    WORKSHEET_ID: '67a1234567890abcdef',
    FIELDS: {
      ORDER_NUMBER: '67a1234567890abc001',
      CUSTOMER_NAME: '67a1234567890abc002',
      PHONE: '67a1234567890abc003',
      STATUS: '67a1234567890abc004',
      AMOUNT: '67a1234567890abc005',
      CREATE_TIME: 'ctime',
      UPDATE_TIME: 'utime'
    }
  },

  // 产品工作表
  PRODUCT: {
    WORKSHEET_ID: '67b1234567890abcdef',
    FIELDS: {
      NAME: '67b1234567890abc001',
      CATEGORY: '67b1234567890abc002',
      PRICE: '67b1234567890abc003',
      STOCK: '67b1234567890abc004',
      IMAGES: '67b1234567890abc005'
    }
  }
};
```

#### 3.4 实现数据服务层

**封装业务逻辑:**
```javascript
// src/services/orderService.js
import hapAPI from './hapAPI';
import { FIELD_MAPPING } from '../config/fieldMapping';

const { ORDER } = FIELD_MAPPING;

export class OrderService {
  // 获取订单列表
  async getOrders(filters = {}) {
    const result = await hapAPI.getRows(ORDER.WORKSHEET_ID, {
      pageIndex: filters.page || 1,
      pageSize: filters.pageSize || 20,
      filters: this.buildFilters(filters)
    });

    return result.rows.map(row => this.parseOrder(row));
  }

  // 创建订单
  async createOrder(orderData) {
    const controls = [
      {
        controlId: ORDER.FIELDS.CUSTOMER_NAME,
        type: 2,
        value: orderData.customerName
      },
      {
        controlId: ORDER.FIELDS.PHONE,
        type: 3,
        value: orderData.phone
      },
      {
        controlId: ORDER.FIELDS.STATUS,
        type: 9,
        value: JSON.stringify([orderData.status || 'pending'])
      }
    ];

    return await hapAPI.createRow(ORDER.WORKSHEET_ID, controls);
  }

  // 解析订单数据
  parseOrder(row) {
    return {
      id: row.rowid,
      orderNumber: row[ORDER.FIELDS.ORDER_NUMBER],
      customerName: row[ORDER.FIELDS.CUSTOMER_NAME],
      phone: row[ORDER.FIELDS.PHONE],
      status: this.parseSelectField(row[ORDER.FIELDS.STATUS]),
      amount: parseFloat(row[ORDER.FIELDS.AMOUNT]) || 0,
      createTime: row[ORDER.FIELDS.CREATE_TIME],
      updateTime: row[ORDER.FIELDS.UPDATE_TIME]
    };
  }

  // 构建筛选条件
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

    if (filters.dateRange) {
      filterControls.push({
        controlId: ORDER.FIELDS.CREATE_TIME,
        dataType: 16,
        filterType: 15,
        values: [filters.dateRange.start]
      });
    }

    return filterControls.length > 0
      ? { filterControls, conjunction: 1 }
      : undefined;
  }

  parseSelectField(value) {
    try {
      const values = typeof value === 'string' ? JSON.parse(value) : value;
      return Array.isArray(values) ? values[0] : '';
    } catch {
      return '';
    }
  }
}

export const orderService = new OrderService();
```

### 阶段 4: 开发验证流程

#### 4.1 本地开发验证

**验证清单:**
```
✅ 能否成功连接 HAP 应用?
✅ 能否正确获取工作表结构?
✅ 能否读取数据并正确解析?
✅ 能否创建新记录?
✅ 能否更新记录?
✅ 字段类型解析是否正确?
✅ 关联字段数据是否完整?
```

#### 4.2 数据一致性检查

**对比验证:**
```javascript
// 1. 在页面创建一条记录
await orderService.createOrder({
  customerName: '测试用户',
  phone: '13800138000'
});

// 2. 登录明道云查看
// 验证数据是否正确写入

// 3. 在明道云修改数据
// 刷新页面,验证数据是否正确读取
```

### 阶段 5: 性能优化

#### 5.1 数据缓存策略
```javascript
// 使用 React Query 或 SWR
import { useQuery } from '@tanstack/react-query';

function useOrders(filters) {
  return useQuery({
    queryKey: ['orders', filters],
    queryFn: () => orderService.getOrders(filters),
    staleTime: 5 * 60 * 1000, // 5分钟缓存
    cacheTime: 10 * 60 * 1000
  });
}
```

#### 5.2 分页加载
```javascript
// 实现虚拟滚动或分页
const [page, setPage] = useState(1);
const { data, isLoading } = useOrders({ page, pageSize: 20 });
```

#### 5.3 批量操作
```javascript
// 批量更新订单状态
async function batchUpdateStatus(orderIds, status) {
  await Promise.all(
    orderIds.map(id =>
      orderService.updateOrder(id, { status })
    )
  );
}
```

## 完整案例流程

### 案例: 开发订单管理系统

#### 第1步: 用户需求
```
用户说:
"我需要一个订单管理系统,要能:
1. 创建订单,选择客户和产品
2. 查看订单列表,按状态筛选
3. 修改订单状态
4. 查看订单详情和历史记录"
```

#### 第2步: AI 分析现有结构
```javascript
// 通过 MCP 查询
const app = await hapMCP.getAppStructure();

// 分析结果:
已有工作表:
- 客户 (满足需求)
- 产品 (满足需求)

缺少工作表:
- 订单 (需要新建)
- 订单明细 (需要新建)
```

#### 第3步: AI 提供架构方案
```markdown
## 订单管理系统 - 数据架构方案

### 现有结构
✅ 客户工作表 - 已有,无需修改
✅ 产品工作表 - 已有,建议新增 "库存" 字段

### 需要新增

#### 工作表1: 订单主表
字段:
- 订单编号 (自动编号): ORD-{YYYY}{MM}{DD}-{####}
- 客户 (关联记录): 关联到客户表
- 订单状态 (单选): 待确认/已确认/生产中/已完成/已取消
- 订单金额 (金额): 公式字段,汇总订单明细
- 下单时间 (日期时间): 默认当前时间
- 备注 (文本)

#### 工作表2: 订单明细表
字段:
- 订单 (关联记录): 关联到订单表
- 产品 (关联记录): 关联到产品表
- 数量 (数值): 必填,默认1
- 单价 (金额): 从产品表查找
- 小计 (金额): 公式 = 数量 × 单价

### 示例数据
是否需要我提供 20 条示例订单数据?
[是] [否,我自己录入]
```

#### 第4步: 用户确认并配置

用户在明道云中:
1. 创建订单主表
2. 创建订单明细表
3. 配置字段和关联关系

#### 第5步: AI 开发前端

```javascript
// 1. 获取字段 ID 映射
const orderSheet = await hapAPI.getWorksheetDetail(worksheetId);

// 2. 创建配置文件
export const FIELD_MAPPING = {
  ORDER: {
    WORKSHEET_ID: worksheetId,
    FIELDS: { ... }
  }
};

// 3. 实现数据服务
export class OrderService { ... }

// 4. 开发页面组件
<OrderList />
<OrderForm />
<OrderDetail />
```

#### 第6步: 验证测试

```
1. 创建订单 → 检查明道云数据
2. 修改状态 → 验证更新成功
3. 删除订单 → 验证关联明细处理
4. 筛选查询 → 验证筛选器正确
```

## 最佳实践

### 1. 字段映射管理
```javascript
// ✅ 推荐: 集中管理
// src/config/fieldMapping.js
export const FIELD_MAPPING = { ... };

// ❌ 不推荐: 散落在代码中
const name = row['67a1234567890abc002'];
```

### 2. 数据解析封装
```javascript
// ✅ 推荐: 统一解析方法
parseSelectField(value) { ... }
parseAttachments(value) { ... }
parseRelations(value) { ... }

// ❌ 不推荐: 重复解析逻辑
```

### 3. 错误处理
```javascript
// ✅ 推荐: 完善的错误处理
try {
  await orderService.createOrder(data);
  toast.success('订单创建成功');
} catch (error) {
  console.error('创建订单失败:', error);
  toast.error('创建失败: ' + error.message);
}
```

### 4. 数据验证
```javascript
// ✅ 推荐: 前端和后端双重验证
// 前端验证
if (!formData.customerName) {
  return setError('请输入客户姓名');
}

// HAP 应用中也设置字段为必填
```

## 总结

**HAP 作为后端的优势:**
1. ✅ 无需开发后端 API
2. ✅ 自动提供数据库
3. ✅ 内置权限管理
4. ✅ 支持复杂业务逻辑
5. ✅ 提供数据报表和分析

**开发流程要点:**
1. 🔍 先分析现有结构
2. 📋 设计完整数据模型
3. 🤝 征得用户同意
4. ⚙️ 配置 HAP 应用
5. 💻 开发前端页面
6. ✅ 验证数据一致性

**记住:**
- HAP 应用 = 你的后端服务
- 工作表 = 数据库表
- 字段 = 表字段
- V3 接口 = RESTful API
