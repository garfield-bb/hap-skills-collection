# Schema 定义模板

本文档提供了 HAP API 文档中常用的数据模型定义模板。

## 基础对象模板

简单的数据对象定义:

```yaml
type: object
properties:
  id:
    type: string
    description: 唯一标识符
    example: "a#1234567890"

  name:
    type: string
    description: 名称
    example: "示例名称"

  createTime:
    type: string
    description: 创建时间
    example: "2025-01-05 10:30:00"

  status:
    type: integer
    description: 状态 (0:禁用, 1:启用)
    enum: [0, 1]
    example: 1

required:
  - id
  - name
```

## 请求 Schema 模板

### 基础请求 (含鉴权参数)

```yaml
type: object
properties:
  appKey:
    type: string
    description: 应用密钥
    example: "a9455c30bd12d0c4"

  sign:
    type: string
    description: 签名,用于验证请求合法性
    example: "ZmUyYWQ0YzljZjZmOGU5MzBmYzE5MDU3NjBlNDc3NTdkODIzNzk0NjA5ZmY5N2YzOGYxNTllZDc1MWRkYzljNA=="

  timestamp:
    type: string
    description: 请求时间戳 (毫秒)
    example: "1767595805516"

  projectId:
    type: string
    description: 项目ID
    example: "fe288386-3d26-4eab-b5d2-51eeab82a7f9"

  # 业务参数
  userName:
    type: string
    description: 用户名
    example: "张三"

  email:
    type: string
    format: email
    description: 邮箱地址
    example: "zhangsan@example.com"

  mobilePhone:
    type: string
    description: 手机号码
    example: "+8613800138000"

required:
  - appKey
  - sign
  - timestamp
  - projectId
  - userName
```

### 分页请求

```yaml
type: object
properties:
  appKey:
    type: string
    description: 应用密钥
    example: "a9455c30bd12d0c4"

  sign:
    type: string
    description: 签名
    example: "ZmUyYWQ0YzljZjZmOGU5MzBmYzE5MDU3NjBlNDc3NTdkODIzNzk0NjA5ZmY5N2YzOGYxNTllZDc1MWRkYzljNA=="

  timestamp:
    type: string
    description: 时间戳
    example: "1767595805516"

  projectId:
    type: string
    description: 项目ID
    example: "fe288386-3d26-4eab-b5d2-51eeab82a7f9"

  pageIndex:
    type: string
    description: 当前页码,从1开始
    example: "1"

  pageSize:
    type: string
    description: 每页数量,最大100
    example: "20"

  keyword:
    type: string
    description: 搜索关键词 (可选)
    example: "搜索内容"

required:
  - appKey
  - sign
  - timestamp
  - projectId
  - pageIndex
  - pageSize
```

## 响应 Schema 模板

### 标准成功响应

```yaml
type: object
properties:
  code:
    type: integer
    description: 状态码,1表示操作完成;非1表示操作异常
    example: 1

  message:
    type: string
    description: 状态描述
    example: "success"

  data:
    type: object
    description: 返回的业务数据
    properties:
      userId:
        type: string
        description: 用户ID
        example: "a#1234567890"

      userName:
        type: string
        description: 用户名
        example: "张三"

      createdAt:
        type: string
        description: 创建时间
        example: "2025-01-05 10:30:00"

required:
  - code
  - message
```

### 列表响应 (含分页)

```yaml
type: object
properties:
  code:
    type: integer
    description: 状态码,1表示操作完成;非1表示操作异常
    example: 1

  message:
    type: string
    description: 状态描述
    example: "success"

  data:
    type: object
    properties:
      count:
        type: integer
        description: 总记录数
        example: 355

      users:
        type: array
        description: 用户列表
        items:
          $ref: './userInfo.yaml'

    required:
      - count
      - users

required:
  - code
  - message
  - data
```

### 数组响应

```yaml
type: object
properties:
  code:
    type: integer
    description: 状态码,1表示成功
    example: 1

  message:
    type: string
    description: 状态描述
    example: ""

  data:
    type: array
    description: 返回的数据列表
    items:
      $ref: './itemSchema.yaml'

required:
  - code
  - message
  - data
```

## 复杂对象模板

### 嵌套对象

```yaml
type: object
properties:
  userId:
    type: string
    description: 用户ID
    example: "a#1234567890"

  userName:
    type: string
    description: 用户名
    example: "张三"

  profile:
    type: object
    description: 用户详细信息
    properties:
      avatar:
        type: string
        description: 头像URL
        example: "https://example.com/avatar.png"

      bio:
        type: string
        description: 个人简介
        example: "这是我的简介"

      location:
        type: object
        description: 位置信息
        properties:
          country:
            type: string
            example: "中国"
          city:
            type: string
            example: "北京"

  departments:
    type: array
    description: 所属部门列表
    items:
      $ref: './department.yaml'

required:
  - userId
  - userName
```

### 使用 allOf 组合

当多个接口共享相同的基础字段时:

```yaml
allOf:
  - $ref: './baseRequest.yaml'
  - type: object
    properties:
      userName:
        type: string
        description: 用户名
        example: "张三"

      email:
        type: string
        format: email
        description: 邮箱
        example: "zhangsan@example.com"

    required:
      - userName
      - email
```

## 数据类型示例

### 字符串类型

```yaml
# 普通字符串
userName:
  type: string
  description: 用户名
  example: "张三"

# 邮箱
email:
  type: string
  format: email
  description: 邮箱地址
  example: "user@example.com"

# URL
url:
  type: string
  format: uri
  description: 链接地址
  example: "https://example.com"

# 日期时间
createTime:
  type: string
  format: date-time
  description: 创建时间
  example: "2025-01-05T10:30:00Z"

# 日期
birthDate:
  type: string
  format: date
  description: 生日
  example: "1990-01-01"

# UUID
id:
  type: string
  format: uuid
  description: 唯一标识符
  example: "550e8400-e29b-41d4-a716-446655440000"

# 枚举
status:
  type: string
  enum: ["active", "inactive", "pending"]
  description: 状态
  example: "active"
```

### 数字类型

```yaml
# 整数
count:
  type: integer
  format: int32
  description: 数量
  minimum: 0
  maximum: 100
  example: 10

# 长整数
timestamp:
  type: integer
  format: int64
  description: 时间戳
  example: 1704441000000

# 浮点数
price:
  type: number
  format: float
  description: 价格
  minimum: 0
  example: 99.99

# 双精度浮点数
latitude:
  type: number
  format: double
  description: 纬度
  example: 39.904989
```

### 布尔类型

```yaml
isActive:
  type: boolean
  description: 是否激活
  example: true
```

### 数组类型

```yaml
# 字符串数组
tags:
  type: array
  description: 标签列表
  items:
    type: string
  example: ["标签1", "标签2"]

# 对象数组
users:
  type: array
  description: 用户列表
  items:
    $ref: './userInfo.yaml'

# 数字数组
scores:
  type: array
  description: 分数列表
  items:
    type: integer
  example: [85, 90, 95]
```

### 对象类型

```yaml
metadata:
  type: object
  description: 元数据
  additionalProperties: true
  example:
    key1: "value1"
    key2: "value2"
```

## 常用字段约束

```yaml
userName:
  type: string
  minLength: 2
  maxLength: 50
  pattern: "^[a-zA-Z0-9_]+$"
  description: 用户名,2-50个字符,只能包含字母、数字和下划线

age:
  type: integer
  minimum: 0
  maximum: 150
  description: 年龄

email:
  type: string
  format: email
  description: 邮箱地址

items:
  type: array
  minItems: 1
  maxItems: 100
  uniqueItems: true
  description: 项目列表,最少1个,最多100个,不能重复
```

## 引用其他 Schema

### 相对路径引用

```yaml
# 从同目录引用
user:
  $ref: './userInfo.yaml'

# 从父目录引用
baseRequest:
  $ref: '../base/baseRequest.yaml'

# 从根schemas目录引用 (从 paths 文件中)
schema:
  $ref: '../../schemas/user/userInfo.yaml'
```

## 注意事项

1. **必填字段** - 所有必填字段必须在 `required` 数组中列出
2. **示例值** - 每个字段都应提供有意义的 `example`
3. **描述清晰** - `description` 应该简洁明了,说明字段用途
4. **数据格式** - 使用适当的 `format` (email, uri, date-time, uuid 等)
5. **引用路径** - 确保 `$ref` 路径正确,使用相对路径
6. **中英文一致** - 中英文版本的字段结构必须完全一致,仅描述不同
7. **避免重复** - 将公共字段提取为独立的 schema 文件供引用
