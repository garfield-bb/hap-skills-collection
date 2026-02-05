# Path 定义模板

本文档提供了 HAP API 文档中常用的接口定义模板。

## GET 请求模板 (使用 Query Parameters)

适用于查询、获取数据的接口。

```yaml
get:
  tags:
    - user  # 或其他模块名
  summary: 获取用户列表  # 简短描述
  operationId: getUserList  # 操作ID,与文件名一致
  description: 根据条件查询用户列表,支持分页。  # 详细描述
  parameters:
    # 基础鉴权参数 (可选,根据需要引用)
    - $ref: ../../schemas/base/request/baseQueryAppkey.yaml
    - $ref: ../../schemas/base/request/baseQuerySign.yaml
    - $ref: ../../schemas/base/request/baseQueryTimestamp.yaml
    - $ref: ../../schemas/base/request/baseQueryProjectId.yaml

    # 业务参数
    - name: pageIndex
      in: query
      required: true
      description: 页码,从1开始
      schema:
        type: integer
        format: int32
        default: 1
      example: 1

    - name: pageSize
      in: query
      required: true
      description: 每页数量,最大100
      schema:
        type: integer
        format: int32
        default: 10
      example: 20

    - name: keyword
      in: query
      required: false
      description: 搜索关键词
      schema:
        type: string
      example: "张三"

  responses:
    "200":
      description: 成功响应
      content:
        application/json:
          schema:
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
                    description: 总数
                    example: 100
                  users:
                    type: array
                    items:
                      $ref: "../../schemas/user/userInfo.yaml"

    "400":
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
                example: "Invalid parameters"
```

## POST 请求模板 (使用 Request Body)

适用于创建、更新、复杂查询等接口。

```yaml
post:
  tags:
    - user
  summary: 创建用户
  operationId: createUser
  description: 创建一个新用户,返回创建的用户信息。
  requestBody:
    required: true
    content:
      application/json:
        schema:
          $ref: '../../schemas/user/createUserRequest.yaml'
        example:
          appKey: "a9455c30bd12d0c4"
          sign: "ZmUyYWQ0YzljZjZmOGU5MzBmYzE5MDU3NjBlNDc3NTdkODIzNzk0NjA5ZmY5N2YzOGYxNTllZDc1MWRkYzljNA=="
          timestamp: "1767595805516"
          projectId: "fe288386-3d26-4eab-b5d2-51eeab82a7f9"
          userName: "张三"
          email: "zhangsan@example.com"
          mobilePhone: "+8613800138000"

  responses:
    '200':
      description: 成功响应
      content:
        application/json:
          schema:
            $ref: '../../schemas/user/createUserResponse.yaml'
          example:
            code: 1
            message: "success"
            data:
              userId: "a#1234567890"
              userName: "张三"
              createdAt: "2025-01-05 10:30:00"

    '400':
      description: 请求参数错误
```

## PUT/PATCH 请求模板 (更新资源)

```yaml
patch:
  tags:
    - user
  summary: 更新用户信息
  operationId: updateUser
  description: 更新指定用户的信息,只需提供需要更新的字段。
  parameters:
    - name: userId
      in: path
      required: true
      description: 用户ID
      schema:
        type: string
      example: "a#1234567890"

  requestBody:
    required: true
    content:
      application/json:
        schema:
          $ref: '../../schemas/user/updateUserRequest.yaml'

  responses:
    '200':
      description: 更新成功
      content:
        application/json:
          schema:
            $ref: '../../schemas/user/updateUserResponse.yaml'
```

## DELETE 请求模板

```yaml
delete:
  tags:
    - user
  summary: 删除用户
  operationId: deleteUser
  description: 根据用户ID删除指定用户。
  parameters:
    - name: userId
      in: path
      required: true
      description: 用户ID
      schema:
        type: string
      example: "a#1234567890"

  responses:
    '200':
      description: 删除成功
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
                example: "删除成功"
```

## 多方法接口 (同一路径支持多个 HTTP 方法)

当同一路径支持多个 HTTP 方法时,在 openapi.yaml 中这样引用:

```yaml
paths:
  /v3/app/worksheets/{worksheet_id}:
    get:
      $ref: './paths/worksheet/getStructure.yaml#/get'
    post:
      $ref: './paths/worksheet/update.yaml#/post'
    delete:
      $ref: './paths/worksheet/delete.yaml#/delete'
```

对应的 path 文件:

**getStructure.yaml:**
```yaml
get:
  tags:
    - worksheet
  summary: 获取工作表结构
  # ...
```

## 路径参数模板

使用 `{parameter}` 定义路径参数:

```yaml
get:
  parameters:
    - name: worksheet_id
      in: path
      required: true
      description: 工作表ID
      schema:
        type: string
        format: uuid
      example: "550e8400-e29b-41d4-a716-446655440000"

    - name: row_id
      in: path
      required: true
      description: 行记录ID
      schema:
        type: string
      example: "60d5f8f8e1b2c3001c8e4b2a"
```

## 文件上传接口模板

```yaml
post:
  tags:
    - file
  summary: 上传文件
  operationId: uploadFile
  requestBody:
    required: true
    content:
      multipart/form-data:
        schema:
          type: object
          properties:
            file:
              type: string
              format: binary
              description: 要上传的文件
            fileName:
              type: string
              description: 文件名
          required:
            - file

  responses:
    '200':
      description: 上传成功
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
                  fileId:
                    type: string
                  url:
                    type: string
```

## 注意事项

1. **operationId 必须唯一** - 在整个 API 文档中不能重复
2. **tags 对应导航分组** - 确保 tag 在 openapi.yaml 的 tags 部分已定义
3. **description 提供足够信息** - 帮助用户理解接口用途和使用方法
4. **example 提供真实数据** - 使用真实且有意义的示例值
5. **required 准确标记** - 明确哪些参数是必填的
6. **引用路径正确** - 从 paths 引用 schemas 使用相对路径 `../../schemas/`
