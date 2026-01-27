# 06 - 规则文件系统：CLAUDE.md 完全指南

## 什么是规则文件？

**CLAUDE.md** 是 Claude Code 中最重要的配置文件。它定义了你的项目的所有规范、约定和期望，让 AI 理解并遵循你的工程实践。

### 作用

```
┌─────────────────────────────────────────┐
│      你的工程规范和最佳实践               │
├─────────────────────────────────────────┤
│        CLAUDE.md 规则文件                 │
├─────────────────────────────────────────┤
│  Claude Code 在生成代码时都会遵循这些规则  │
├─────────────────────────────────────────┤
│     生成高质量、符合规范的代码             │
└─────────────────────────────────────────┘
```

## 规则文件分层架构

### 1. 全局规则（跨所有项目）

**位置：** `~/.claude/CLAUDE.md`

**作用：** 个人或团队的通用规范

**示例：**

```markdown
# 全局 Claude Code 规则

## 所有项目通用

### 代码风格
- 使用 UTF-8 编码
- Unix 换行符 (LF)
- 文件末尾保留空行
- 行长不超过 120 字符

### Git 规范
- 提交信息使用中文
- 符合 Conventional Commits
- 每个提交应该是可独立运行的

### 安全规范
- 不提交密钥和密码
- 使用环境变量管理敏感信息
- 定期审查依赖安全

### 文档规范
- 项目必须有 README
- API 必须有文档
- 复杂逻辑添加注释
```

### 2. 公司规则（跨项目共享）

**位置：** `.claude/company-rules.md`

**作用：** 整个公司或团队的统一规范

**示例：**

```markdown
# 公司级 Claude Code 规则

## 项目结构
公司要求所有项目采用统一的目录结构：
```
src/
├── features/          # 功能模块
├── shared/           # 共享代码
├── infrastructure/   # 基础设施
└── config/          # 配置文件
```
``

## 编码规范
- 类名使用大驼峰 (PascalCase)
- 函数名使用小驼峰 (camelCase)
- 常量全大写下划线分隔 (SNAKE_CASE)

## API 规范
- 所有 API 返回统一的响应格式
- 错误码范围：1000-1999（服务错误）、2000-2999（业务错误）
- 版本在 URL 中：/api/v1/...

## 数据库规范
- 表名使用小写加下划线
- 字段名使用小驼峰
- 每个表必须有 created_at 和 updated_at
```
```

### 3. 项目规则（单个项目）

**位置：** `项目根目录/CLAUDE.md`

**作用：** 项目特定的规范

**示例（Vue 项目）：**

```markdown
# 项目：电商管理后台

## 项目描述
基于 Vue 3 + Vite 的电商管理系统前端

## 技术栈
- Vue 3.4+ (Composition API)
- TypeScript 5.x
- Vite 5.x
- Element Plus
- Pinia (状态管理)

## 项目结构
```
src/
├── views/           # 页面组件
├── components/      # 可复用组件
├── stores/          # Pinia 状态
├── services/        # API 服务
├── utils/           # 工具函数
├── types/           # TypeScript 类型
├── assets/          # 静态资源
└── styles/          # 全局样式
```
``

## 代码规范

### 组件命名
- 文件名: PascalCase (UserList.vue, OrderDetail.vue)
- 组件名: 与文件名一致

### 类型定义
- 所有 props 必须定义类型
- API 响应必须定义 interface
- 避免使用 any

### 状态管理
- 使用 Pinia 管理全局状态
- Store 命名：xxxStore
- 避免在组件中进行复杂的状态操作

### 样式规范
- 使用 scoped style
- CSS 类名使用 kebab-case
- 使用 CSS 变量定义主题色

## API 规范
- 基础 URL: https://api.example.com/api/v1
- 所有请求使用 TypeScript 类型检查
- 错误处理必须统一

## 测试要求
- 关键组件必须有单元测试
- 测试覆盖率 >= 80%
- 使用 Vitest + Testing Library

## 提交规范
类型: scope(作用域): 描述

示例:
- feat(user): 添加用户个人中心页面
- fix(cart): 修复购物车数量计算错误
- docs(readme): 更新项目文档
- refactor(store): 优化状态管理结构
- test(utils): 添加工具函数测试

## 部署
- 开发环境: npm run dev
- 测试环境: npm run build:staging
- 生产环境: npm run build:prod
- 自动部署到 Vercel
```
```

### 4. 个人规则（仅对特定开发者）

**位置：** `.claude/personal-rules-[name].md`

**作用：** 某个开发者的个人偏好

**示例：**

```markdown
# 张三的个人 Claude Code 规则

## 我的偏好

### 代码风格
- 我喜欢使用函数式编程
- 避免使用 this
- 优先使用 const 而非 let

### 注释风格
- 添加 TODO 注释以标记待做项
- 复杂逻辑添加详细注释
- 函数前添加 JSDoc

### 调试方式
- 优先使用 console.log
- 使用 debugger 进行断点调试
- 调试完成后需要清理 console.log

### 性能偏好
- 关注代码性能
- 避免创建不必要的对象
- 使用 Object.freeze 冻结常量
```
```

## 规则文件完整示例

### Java Spring Boot 项目

```markdown
# 项目：用户服务

## 项目描述
Spring Boot 3.x 微服务，提供用户管理相关 API

## 技术栈
- Java 21+
- Spring Boot 3.2+
- Spring Data JPA
- PostgreSQL 15+
- Lombok
- Swagger 3.0

## 项目结构
```
src/main/java/com/example/userservice/
├── config/           # 配置类
├── controller/       # API 控制器
├── service/          # 业务逻辑
├── repository/       # 数据访问
├── entity/           # 实体类
├── dto/              # 数据传输对象
├── exception/        # 异常处理
└── utils/            # 工具类
```
``

## 代码规范

### 类命名
- Controller: UserController
- Service: UserService
- Repository: UserRepository
- Entity: User
- DTO: UserDTO / UserVO
- 接口: IUserService 或 UserService (推荐)

### 方法命名
- 获取: get, find, query
- 新增: create, add, insert
- 修改: update, modify
- 删除: delete, remove
- 检验: check, validate

### 依赖注入
- 使用 Constructor Injection (推荐)
- 避免使用 Field Injection
- 使用 @RequiredArgsConstructor (Lombok)

### 异常处理
```java
// ✅ 推荐
try {
  // 业务逻辑
} catch (DataAccessException e) {
  throw new BusinessException("数据访问失败", e);
}

// ❌ 不推荐
try {
  // 业务逻辑
} catch (Exception e) {
  e.printStackTrace();
}
```

### 数据库规范
- 表名: user_info (小写下划线)
- 字段: user_name (小写下划线)
- 时间字段: created_at, updated_at
- 主键: id (自增)

### API 规范
- 基础路径: /api/v1/users
- 查询: GET /api/v1/users/{id}
- 列表: GET /api/v1/users?page=1&size=10
- 创建: POST /api/v1/users
- 更新: PUT /api/v1/users/{id}
- 删除: DELETE /api/v1/users/{id}

### 响应格式
```json
{
  "code": 0,
  "message": "success",
  "data": {},
  "timestamp": "2025-10-20T10:00:00Z"
}
```

### 错误处理
- 参数验证错误: 400
- 认证失败: 401
- 权限不足: 403
- 资源不存在: 404
- 服务器错误: 500

## Swagger 文档要求
- 所有 Controller 方法必须有 @Operation
- 所有 DTO 字段必须有 @Schema
- 包含请求响应示例

## 单元测试
- 测试覆盖率 >= 80%
- Service 层必须有单元测试
- 使用 JUnit 5 + Mockito
- 测试类名: 被测类名 + Test

## 提交规范
示例:
- feat(user): 添加用户注册 API
- fix(auth): 修复 JWT 过期时间
- refactor(repository): 优化查询性能
- test(service): 添加 UserService 单元测试
- docs(api): 更新 Swagger 文档

## 部署流程
1. 本地测试: mvn test
2. 打包: mvn clean package
3. Docker 构建: docker build -t userservice:1.0.0
4. 推送到仓库
5. 自动部署到 K8s

## 常用命令
- 启动: mvn spring-boot:run
- 打包: mvn clean package
- 测试: mvn test
- 代码检查: mvn checkstyle:check
```
```

## 规则文件的优先级

```
个人规则 (最高优先级)
    ↑
项目规则
    ↑
公司规则
    ↑
全局规则 (最低优先级)
```

当产生冲突时，优先级高的规则会覆盖低优先级的规则。

## 如何使用规则文件

### 步骤 1：创建规则文件

在项目根目录：

```bash
touch CLAUDE.md
```

### 步骤 2：编写规则

参考上面的示例，编写适合你项目的规则。

### 步骤 3：Claude Code 自动应用

当你运行 Claude Code 时，它会自动读取并应用规则：

```bash
claude-code .
```

### 步骤 4：验证规则生效

```bash
# 查看已加载的规则
claude-code --show-rules

# 调试模式
claude-code --debug . "test"
```

## 高级特性

### 条件规则

根据环境应用不同规则：

```markdown
## 仅在开发环境

[IF env=development]
- 允许 console.log
- 允许使用 debugger
- 测试覆盖率可降至 60%
[/IF]

## 仅在生产环境

[IF env=production]
- 禁止 console.log
- 禁止使用 debugger
- 测试覆盖率必须 >= 80%
[/IF]
```

### 规则模板

可以为常见框架创建可复用的规则模板：

```bash
# 创建模板
claude-code --create-template react-typescript

# 在新项目中使用
claude-code init --template react-typescript
```

## 最佳实践

### 1. 保持规则简洁

```markdown
# ✅ 好的规则
- 使用 Prettier 格式化代码
- 遵循 Google Java 风格指南
```

```markdown
# ❌ 不好的规则
- 使用 Prettier 格式化代码, 具体配置是...
  （太详细，应该在 .prettierrc 中配置）
```

### 2. 定期更新规则

定期审查和更新规则，确保与实际项目保持同步。

### 3. 规则版本控制

```bash
# 添加到 Git
git add CLAUDE.md
git commit -m "docs: 更新 Claude Code 规则"
```

### 4. 文档链接

在规则中添加文档链接：

```markdown
## 代码风格

详见: [风格指南](./docs/style-guide.md)
```

## 下一章

👉 **[第 7 章：上下文压缩](07-context-compression.md)** - 优化 Token 使用

---

**时间提示：** 本章阅读 20 分钟，编写规则 15 分钟 ⏱️
