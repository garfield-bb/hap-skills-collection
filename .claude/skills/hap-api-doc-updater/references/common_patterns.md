# 常见模式参考

本文档记录了 HAP API 文档中的常见模式和最佳实践。

## 文件组织模式

### 按模块组织

```
paths/
├── user/              # 用户相关接口
│   ├── getUser.yaml
│   ├── createUser.yaml
│   └── updateUser.yaml
├── department/        # 部门相关接口
│   ├── getDepartment.yaml
│   └── createDepartment.yaml
└── app/              # 应用相关接口
    ├── getApp.yaml
    └── createApp.yaml

schemas/
├── base/             # 基础公共模型
│   ├── request/
│   │   ├── baseQueryAppkey.yaml
│   │   ├── baseQuerySign.yaml
│   │   └── baseQueryTimestamp.yaml
│   └── response/
│       └── baseResponse.yaml
├── user/             # 用户相关模型
│   ├── userInfo.yaml
│   ├── createUserRequest.yaml
│   └── createUserResponse.yaml
└── department/       # 部门相关模型
    ├── departmentInfo.yaml
    └── ...
```

## 命名约定

### 接口操作命名

遵循 RESTful 风格:

- **获取单个**: `get{Resource}` - 如 `getUser.yaml`
- **获取列表**: `get{Resource}s` 或 `get{Resource}List` - 如 `getUsers.yaml`
- **创建**: `create{Resource}` - 如 `createUser.yaml`
- **更新**: `update{Resource}` - 如 `updateUser.yaml`
- **删除**: `delete{Resource}` 或 `remove{Resource}` - 如 `deleteUser.yaml`
- **批量操作**: `batch{Action}{Resource}s` - 如 `batchCreateUsers.yaml`
- **同步**: `sync{Resource}s` - 如 `syncUsers.yaml`
- **upsert**: `upsert{Resource}` - 如 `upsertUser.yaml` (创建或更新)

### Schema 命名

- **请求模型**: `{operation}Request.yaml` - 如 `createUserRequest.yaml`
- **响应模型**: `{operation}Response.yaml` - 如 `createUserResponse.yaml`
- **实体模型**: `{entity}.yaml` 或 `{entity}Info.yaml` - 如 `user.yaml`, `userInfo.yaml`
- **列表项模型**: `{entity}Item.yaml` - 如 `userItem.yaml`

## 接口路径模式

### 组织授权 API 路径

版本号 + 模块 + 操作:
```
/v2/user/getUser
/v2/user/createUser
/v2/department/getDepartment
/v2/OrgRole/GetOrgRoles  (注意大小写保持原有风格)
```

### 应用 API 路径 (RESTful 风格)

```
/v3/app
/v3/app/worksheets
/v3/app/worksheets/{worksheet_id}
/v3/app/worksheets/{worksheet_id}/rows
/v3/app/worksheets/{worksheet_id}/rows/{row_id}
```

## openapi.yaml 路由配置模式

### 简单路由

```yaml
paths:
  /v2/user/getUser:
    servers:
      - url: 'host_generalintegrateapi'
    $ref: './paths/user/getUser.yaml'
```

### 多方法路由

```yaml
paths:
  /v3/app/roles/{role_id}:
    get:
      $ref: './paths/role/get.yaml#/get'
    delete:
      $ref: './paths/role/delete.yaml#/delete'
```

### 特定服务器路由

```yaml
paths:
  /v2/open/structure/GetSubordinateIds:
    # 不指定 servers,使用默认 server
    $ref: './paths/structure/getSubordinateIds.yaml'

  /v2/user/upsertUsers:
    servers:
      - url: 'host_generalintegrateapi'
    $ref: './paths/user/upsertUsers.yaml'
```

## 鉴权参数模式

### 方式1: 在 path 文件中直接定义

```yaml
post:
  parameters:
    - name: appKey
      in: query
      required: true
      description: 应用密钥
      schema:
        type: string
    - name: sign
      in: query
      required: true
      description: 签名
      schema:
        type: string
```

### 方式2: 引用基础 schema (推荐)

```yaml
post:
  parameters:
    - $ref: ../../schemas/base/request/baseQueryAppkey.yaml
    - $ref: ../../schemas/base/request/baseQuerySign.yaml
    - $ref: ../../schemas/base/request/baseQueryTimestamp.yaml
    - $ref: ../../schemas/base/request/baseQueryProjectId.yaml
```

### 方式3: 在 requestBody 中包含

```yaml
post:
  requestBody:
    required: true
    content:
      application/json:
        schema:
          type: object
          properties:
            appKey:
              type: string
            sign:
              type: string
            # ... 其他业务参数
```

## 响应结构模式

### 标准响应格式

所有接口都应遵循统一的响应格式:

```yaml
type: object
properties:
  code:
    type: integer
    description: 状态码,1表示成功
  message:
    type: string
    description: 状态描述
  data:
    # 具体的业务数据
```

### 返回单个对象

```yaml
responses:
  '200':
    description: 成功响应
    content:
      application/json:
        schema:
          type: object
          properties:
            code:
              type: integer
            message:
              type: string
            data:
              $ref: '../../schemas/user/userInfo.yaml'
```

### 返回列表 (带分页信息)

```yaml
responses:
  '200':
    description: 成功响应
    content:
      application/json:
        schema:
          type: object
          properties:
            code:
              type: integer
            message:
              type: string
            data:
              type: object
              properties:
                count:
                  type: integer
                  description: 总数
                items:
                  type: array
                  items:
                    $ref: '../../schemas/user/userInfo.yaml'
```

### 返回纯数组

```yaml
responses:
  '200':
    description: 成功响应
    content:
      application/json:
        schema:
          type: object
          properties:
            code:
              type: integer
            message:
              type: string
            data:
              type: array
              items:
                $ref: '../../schemas/user/userInfo.yaml'
```

### 无返回数据

```yaml
responses:
  '200':
    description: 操作成功
    content:
      application/json:
        schema:
          type: object
          properties:
            code:
              type: integer
              example: 1
            message:
              type: string
              example: "操作成功"
```

## 分页模式

### 请求分页参数

```yaml
# GET 请求
parameters:
  - name: pageIndex
    in: query
    required: true
    description: 页码,从1开始
    schema:
      type: integer
      format: int32
      default: 1

  - name: pageSize
    in: query
    required: true
    description: 每页数量
    schema:
      type: integer
      format: int32
      default: 10

# POST 请求 (在 requestBody 的 schema 中)
properties:
  pageIndex:
    type: string
    description: 当前页码
  pageSize:
    type: string
    description: 每页数量
```

### 响应分页数据

```yaml
data:
  type: object
  properties:
    count:
      type: integer
      description: 总记录数
    items:
      type: array
      items:
        $ref: './itemSchema.yaml'
```

## 中英文同步模式

### 保持结构一致

中文版 (`zh-Hans`):
```yaml
properties:
  userName:
    type: string
    description: 用户名
    example: "张三"
```

英文版 (`en`):
```yaml
properties:
  userName:
    type: string
    description: User name
    example: "John Doe"
```

### 仅翻译以下字段

- `summary` - 接口摘要
- `description` - 描述信息
- `example` - 示例值 (如果是文字)

### 保持完全一致的字段

- `type` - 数据类型
- `format` - 格式
- `required` - 必填字段
- `enum` - 枚举值
- `minimum`, `maximum` - 数值范围
- `minLength`, `maxLength` - 字符串长度
- 属性名称 (如 `userName`, `userId` 等)

## 错误处理模式

### 标准错误响应

```yaml
responses:
  '400':
    description: 请求参数错误
    content:
      application/json:
        schema:
          type: object
          properties:
            code:
              type: integer
              example: 400
            message:
              type: string
              example: "参数校验失败"

  '401':
    description: 未授权
    content:
      application/json:
        schema:
          type: object
          properties:
            code:
              type: integer
              example: 401
            message:
              type: string
              example: "签名验证失败"

  '404':
    description: 资源不存在
    content:
      application/json:
        schema:
          type: object
          properties:
            code:
              type: integer
              example: 404
            message:
              type: string
              example: "用户不存在"
```

## Schema 复用模式

### 提取公共字段

将多个接口共用的字段提取为独立的 schema:

**baseRequest.yaml:**
```yaml
type: object
properties:
  appKey:
    type: string
    description: 应用密钥
  sign:
    type: string
    description: 签名
  timestamp:
    type: string
    description: 时间戳
  projectId:
    type: string
    description: 项目ID
required:
  - appKey
  - sign
  - timestamp
  - projectId
```

**createUserRequest.yaml:**
```yaml
allOf:
  - $ref: '../base/baseRequest.yaml'
  - type: object
    properties:
      userName:
        type: string
      email:
        type: string
    required:
      - userName
```

## 版本管理模式

### 路径中包含版本号

```
/v2/user/getUser       # v2 版本
/v3/app/worksheets     # v3 版本
```

### 向后兼容

- 新增字段不影响旧版本
- 不要删除或修改已有字段的含义
- 如果需要重大变更,创建新版本接口

## 文档更新检查清单

每次更新文档后,检查以下项目:

1. [ ] 中文和英文版本都已更新
2. [ ] openapi.yaml 中添加/更新了路由
3. [ ] path 文件创建/更新正确
4. [ ] 必要的 schema 文件已创建
5. [ ] 所有 $ref 引用路径正确
6. [ ] 中英文字段结构完全一致
7. [ ] 所有必填字段在 required 中声明
8. [ ] description 清晰准确
9. [ ] example 有意义且真实
10. [ ] operationId 全局唯一
11. [ ] tags 正确分类
12. [ ] 响应格式遵循标准
