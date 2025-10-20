# 项目规范文件

> 本文件定义了本 Java Spring Boot 项目使用 Claude Code 时的规范和约定

## 代码风格

### Java 规范
- 使用 Java 21+ 特性
- 4 空格缩进
- 类名使用 PascalCase
- 方法和变量使用 camelCase
- 常量使用 UPPER_SNAKE_CASE
- 包名使用小写

### 代码注释
- 所有公共类和方法必须有 Javadoc 注释
- 复杂业务逻辑必须添加说明注释
- 注释使用中文

## 项目结构

```
src/main/java/com/example/ecommerce/
├── controller/     # REST 控制器层
├── service/        # 业务逻辑层
├── repository/     # 数据访问层
├── entity/         # 实体类
├── dto/            # 数据传输对象
├── config/         # 配置类
├── exception/      # 异常处理
└── util/           # 工具类
```

## 分层架构规范

### Controller 层
- 只负责接收请求和返回响应
- 不包含业务逻辑
- 使用 `@RestController` 注解
- 使用 `@RequestMapping` 定义路由
- 必须有 Swagger 注解

### Service 层
- 包含核心业务逻辑
- 使用 `@Service` 注解
- 使用 `@Transactional` 管理事务
- 方法必须有明确的职责

### Repository 层
- 继承 `JpaRepository`
- 只定义数据访问方法
- 复杂查询使用 `@Query` 注解

## 数据库规范

### 实体类
- 使用 JPA 注解
- 使用 Lombok 简化代码
- 必须包含 `createdAt` 和 `updatedAt` 字段
- 使用 `@CreationTimestamp` 和 `@UpdateTimestamp`

### 数据库迁移
- 使用 Flyway 或 Liquibase
- 迁移脚本命名: `V{version}__{description}.sql`
- 禁止直接修改已应用的迁移脚本

## API 设计规范

### RESTful 约定
- GET: 查询资源
- POST: 创建资源
- PUT: 更新资源（全量）
- PATCH: 更新资源（部分）
- DELETE: 删除资源

### URL 设计
```
GET    /api/users          # 获取用户列表
GET    /api/users/{id}     # 获取单个用户
POST   /api/users          # 创建用户
PUT    /api/users/{id}     # 更新用户
DELETE /api/users/{id}     # 删除用户
```

### 响应格式
```json
{
  "code": 200,
  "message": "success",
  "data": { ... }
}
```

### 错误响应
```json
{
  "code": 400,
  "message": "参数错误",
  "errors": [
    {
      "field": "email",
      "message": "邮箱格式不正确"
    }
  ]
}
```

## 测试规范

- 最低测试覆盖率: 80%
- Service 层必须有单元测试
- Controller 层必须有集成测试
- 使用 JUnit 5 + Mockito

### 测试命名
```java
// 格式: methodName_condition_expectedResult
@Test
void createUser_validInput_returnsCreatedUser() { }

@Test
void createUser_duplicateUsername_throwsException() { }
```

## 异常处理

### 自定义异常
```java
public class ResourceNotFoundException extends RuntimeException {
    public ResourceNotFoundException(String message) {
        super(message);
    }
}
```

### 全局异常处理
使用 `@ControllerAdvice` 统一处理异常

## Git 提交规范

使用 Conventional Commits:

```
<type>(<scope>): <subject>
```

### Type 类型
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `refactor`: 重构
- `test`: 测试相关
- `perf`: 性能优化

### 示例
```
feat(user): 实现用户注册功能

- 添加 UserController.register 方法
- 实现邮箱验证逻辑
- 添加密码加密
- 完整的单元测试

Closes #123
```

## 安全规范

- 所有密码必须加密存储
- 使用 JWT 进行认证
- API 必须有权限控制
- 敏感信息不能记录日志
- 输入数据必须验证

## 性能优化

- 查询使用分页
- 避免 N+1 查询问题
- 合理使用缓存
- 数据库索引优化
- 使用连接池

## Claude Code 使用约定

### 提示词模板

**创建 API:**
```
创建 [资源名] 的 CRUD API
要求:
- 包含 Controller、Service、Repository
- 完整的参数验证
- 异常处理
- Swagger 文档
- 单元测试
```

**数据库迁移:**
```
为 [表名] 创建数据库迁移脚本
字段: [字段列表]
要求: 包含索引、外键约束
```

**添加功能:**
```
为 [Service] 添加 [功能描述]
要求: 包含事务处理、异常处理、单元测试
```

## 依赖管理

- 使用 Maven 管理依赖
- 定期更新依赖版本
- 新增依赖需要团队评审
- 避免依赖冲突

## 日志规范

- 使用 SLF4J + Logback
- 日志级别: DEBUG < INFO < WARN < ERROR
- 生产环境使用 INFO 级别
- 异常必须记录完整堆栈

## 配置管理

- 使用 Spring Profiles (dev, test, prod)
- 敏感配置使用环境变量
- 配置文件使用 YAML 格式

---

**最后更新**: 2025-01-20
**维护者**: 后端开发团队
