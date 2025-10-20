# 新项目案例：在线图书管理系统

## 项目概述

这是一个前后端分离的在线图书管理系统，展示如何使用 Claude Code 从零开始快速开发一个完整项目。

**技术栈：**
- **后端**: Spring Boot 2.7 + JDK 1.8 + MyBatis + MySQL
- **前端**: Vue 3 + Element Plus + Axios
- **测试**: JUnit 5 + Playwright (浏览器自动化测试)

**功能清单：**
- 图书管理（增删改查）
- 用户认证（登录/注册）
- 借阅管理
- 浏览器自动化测试

## 项目结构

```
book-management-system/
├── backend/                    # 后端 Spring Boot 项目
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/
│   │   │   │   └── com/
│   │   │   │       └── bookms/
│   │   │   │           ├── BookManagementApplication.java
│   │   │   │           ├── controller/
│   │   │   │           │   ├── BookController.java
│   │   │   │           │   ├── UserController.java
│   │   │   │           │   └── BorrowController.java
│   │   │   │           ├── service/
│   │   │   │           │   ├── BookService.java
│   │   │   │           │   ├── UserService.java
│   │   │   │           │   └── BorrowService.java
│   │   │   │           ├── mapper/
│   │   │   │           │   ├── BookMapper.java
│   │   │   │           │   ├── UserMapper.java
│   │   │   │           │   └── BorrowMapper.java
│   │   │   │           ├── entity/
│   │   │   │           │   ├── Book.java
│   │   │   │           │   ├── User.java
│   │   │   │           │   └── Borrow.java
│   │   │   │           ├── dto/
│   │   │   │           ├── vo/
│   │   │   │           ├── config/
│   │   │   │           └── common/
│   │   │   └── resources/
│   │   │       ├── application.yml
│   │   │       ├── mapper/
│   │   │       └── db/
│   │   │           └── schema.sql
│   │   └── test/
│   │       └── java/
│   │           └── com/
│   │               └── bookms/
│   │                   ├── BookControllerTest.java
│   │                   └── UserControllerTest.java
│   └── pom.xml
│
├── frontend/                   # 前端 Vue 项目
│   ├── src/
│   │   ├── main.js
│   │   ├── App.vue
│   │   ├── views/
│   │   │   ├── Login.vue
│   │   │   ├── Register.vue
│   │   │   ├── BookList.vue
│   │   │   ├── BookDetail.vue
│   │   │   └── BorrowHistory.vue
│   │   ├── components/
│   │   │   ├── BookCard.vue
│   │   │   └── Header.vue
│   │   ├── router/
│   │   │   └── index.js
│   │   ├── store/
│   │   │   └── index.js
│   │   ├── api/
│   │   │   ├── book.js
│   │   │   ├── user.js
│   │   │   └── borrow.js
│   │   └── utils/
│   │       ├── request.js
│   │       └── auth.js
│   ├── tests/
│   │   ├── e2e/
│   │   │   ├── login.spec.js
│   │   │   ├── book-management.spec.js
│   │   │   └── borrow.spec.js
│   │   └── unit/
│   ├── package.json
│   └── vite.config.js
│
├── .claude/
│   ├── config.json
│   ├── mcp-servers.json         # MCP 配置
│   └── commands/
│       ├── start-dev.md
│       └── run-tests.md
├── CLAUDE.md                     # 项目规范
└── README.md
```

## 快速开始指南

### 第一步：初始化项目

```bash
# 创建项目目录
mkdir book-management-system
cd book-management-system

# 初始化 Claude Code
claude code init
```

### 第二步：配置 MCP 服务器

创建 `.claude/mcp-servers.json`：

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "git": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-git", "--repository", "."]
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "mcp-server-playwright"]
    }
  }
}
```

或使用命令行快速添加：

```bash
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
claude mcp add playwright -- npx -y mcp-server-playwright
```

### 第三步：创建项目规范文件

创建 `CLAUDE.md`（见下文完整内容）

### 第四步：使用 Prompt 开始开发

复制下面的 **完整开发 Prompt**，在 Claude Code 中使用。

---

## 完整开发 Prompt

```markdown
# 项目需求：在线图书管理系统

我要开发一个前后端分离的在线图书管理系统。请严格按照以下要求完成。

## 技术栈要求

### 后端
- JDK 1.8
- Spring Boot 2.7.x
- MyBatis 3.x
- MySQL 8.0
- Maven

### 前端
- Vue 3
- Element Plus
- Axios
- Vue Router
- Pinia（状态管理）
- Vite

### 测试
- 后端：JUnit 5 + MockMvc
- 前端：Vitest + Playwright（E2E 测试）

## 项目结构

创建两个独立的项目：
1. `backend/` - Spring Boot 后端
2. `frontend/` - Vue 3 前端

## 数据库设计

### 1. 用户表 (tb_user)
```sql
CREATE TABLE tb_user (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  phone VARCHAR(20),
  role VARCHAR(20) DEFAULT 'USER',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### 2. 图书表 (tb_book)
```sql
CREATE TABLE tb_book (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(200) NOT NULL,
  author VARCHAR(100),
  isbn VARCHAR(50) UNIQUE,
  publisher VARCHAR(100),
  publish_date DATE,
  category VARCHAR(50),
  price DECIMAL(10,2),
  stock INT DEFAULT 0,
  description TEXT,
  cover_url VARCHAR(500),
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### 3. 借阅记录表 (tb_borrow)
```sql
CREATE TABLE tb_borrow (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  book_id BIGINT NOT NULL,
  borrow_date DATETIME NOT NULL,
  return_date DATETIME,
  due_date DATETIME NOT NULL,
  status VARCHAR(20) DEFAULT 'BORROWED',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES tb_user(id),
  FOREIGN KEY (book_id) REFERENCES tb_book(id)
);
```

## 后端功能需求

### 1. 用户模块 (UserController)

#### 1.1 用户注册
- 接口：`POST /api/users/register`
- 请求体：
  ```json
  {
    "username": "string",
    "password": "string",
    "email": "string",
    "phone": "string"
  }
  ```
- 验证：用户名不能重复，密码使用 BCrypt 加密

#### 1.2 用户登录
- 接口：`POST /api/users/login`
- 请求体：
  ```json
  {
    "username": "string",
    "password": "string"
  }
  ```
- 返回：JWT Token

#### 1.3 获取用户信息
- 接口：`GET /api/users/profile`
- 需要认证：Bearer Token

### 2. 图书模块 (BookController)

#### 2.1 图书列表（分页）
- 接口：`GET /api/books?page=1&size=10&keyword=&category=`
- 支持搜索和分类筛选

#### 2.2 图书详情
- 接口：`GET /api/books/{id}`

#### 2.3 添加图书（需要管理员权限）
- 接口：`POST /api/books`
- 请求体：
  ```json
  {
    "title": "string",
    "author": "string",
    "isbn": "string",
    "publisher": "string",
    "publishDate": "2024-01-01",
    "category": "string",
    "price": 29.99,
    "stock": 10,
    "description": "string",
    "coverUrl": "string"
  }
  ```

#### 2.4 更新图书（需要管理员权限）
- 接口：`PUT /api/books/{id}`

#### 2.5 删除图书（需要管理员权限）
- 接口：`DELETE /api/books/{id}`

### 3. 借阅模块 (BorrowController)

#### 3.1 借阅图书
- 接口：`POST /api/borrows`
- 请求体：
  ```json
  {
    "bookId": 1
  }
  ```
- 业务逻辑：
  - 检查库存
  - 减少库存
  - 创建借阅记录
  - 设置归还日期（30 天后）

#### 3.2 归还图书
- 接口：`PUT /api/borrows/{id}/return`

#### 3.3 我的借阅历史
- 接口：`GET /api/borrows/my?status=`
- 状态：BORROWED（借阅中）、RETURNED（已归还）、OVERDUE（已逾期）

## 前端功能需求

### 1. 路由设计

```javascript
const routes = [
  { path: '/', redirect: '/login' },
  { path: '/login', component: Login },
  { path: '/register', component: Register },
  {
    path: '/home',
    component: Layout,
    meta: { requiresAuth: true },
    children: [
      { path: '/books', component: BookList },
      { path: '/books/:id', component: BookDetail },
      { path: '/borrow-history', component: BorrowHistory },
      { path: '/admin/books', component: BookManagement, meta: { role: 'ADMIN' } }
    ]
  }
]
```

### 2. 页面组件

#### 2.1 登录页面 (Login.vue)
- 用户名/密码输入
- 表单验证
- 登录成功后跳转到图书列表
- 提示注册链接

#### 2.2 注册页面 (Register.vue)
- 用户名、密码、确认密码、邮箱、手机号
- 表单验证
- 注册成功后跳转到登录页

#### 2.3 图书列表页 (BookList.vue)
- 搜索框（标题、作者、ISBN）
- 分类筛选
- 图书卡片展示（封面、标题、作者、价格）
- 分页
- 点击卡片查看详情

#### 2.4 图书详情页 (BookDetail.vue)
- 完整图书信息
- 借阅按钮（检查库存）
- 借阅成功提示

#### 2.5 借阅历史页 (BorrowHistory.vue)
- 借阅记录表格
- 状态筛选
- 归还按钮

### 3. 组件要求

- 使用 Element Plus UI 组件
- 响应式设计
- 统一的错误提示
- Loading 状态处理

## 测试需求

### 1. 后端单元测试

为每个 Controller 创建测试类：

#### BookControllerTest.java
```java
@SpringBootTest
@AutoConfigureMockMvc
class BookControllerTest {

    @Test
    void testGetBookList() throws Exception {
        // 测试图书列表接口
    }

    @Test
    void testGetBookDetail() throws Exception {
        // 测试图书详情接口
    }

    @Test
    void testCreateBook() throws Exception {
        // 测试创建图书接口（需要管理员权限）
    }
}
```

测试覆盖率要求：> 80%

### 2. 前端 E2E 测试（使用 Playwright）

#### 测试场景 1：用户注册和登录流程 (tests/e2e/auth.spec.js)

```javascript
import { test, expect } from '@playwright/test';

test.describe('用户认证流程', () => {
  test('用户注册', async ({ page }) => {
    await page.goto('http://localhost:5173/register');

    // 填写注册表单
    await page.fill('input[name="username"]', 'testuser');
    await page.fill('input[name="password"]', 'Test123456');
    await page.fill('input[name="confirmPassword"]', 'Test123456');
    await page.fill('input[name="email"]', 'test@example.com');

    // 点击注册按钮
    await page.click('button[type="submit"]');

    // 验证跳转到登录页
    await expect(page).toHaveURL(/.*login/);

    // 验证成功提示
    await expect(page.locator('.el-message--success')).toBeVisible();
  });

  test('用户登录', async ({ page }) => {
    await page.goto('http://localhost:5173/login');

    // 填写登录表单
    await page.fill('input[name="username"]', 'testuser');
    await page.fill('input[name="password"]', 'Test123456');

    // 点击登录按钮
    await page.click('button[type="submit"]');

    // 验证跳转到首页
    await expect(page).toHaveURL(/.*books/);

    // 验证用户信息显示
    await expect(page.locator('.user-info')).toContainText('testuser');
  });
});
```

#### 测试场景 2：图书管理流程 (tests/e2e/book-management.spec.js)

```javascript
test.describe('图书管理流程', () => {
  test.beforeEach(async ({ page }) => {
    // 每个测试前登录
    await page.goto('http://localhost:5173/login');
    await page.fill('input[name="username"]', 'admin');
    await page.fill('input[name="password"]', 'Admin123456');
    await page.click('button[type="submit"]');
    await page.waitForURL(/.*books/);
  });

  test('搜索图书', async ({ page }) => {
    // 输入搜索关键词
    await page.fill('input[placeholder*="搜索"]', 'Java');
    await page.keyboard.press('Enter');

    // 等待搜索结果
    await page.waitForSelector('.book-card');

    // 验证搜索结果
    const books = page.locator('.book-card .book-title');
    await expect(books.first()).toContainText('Java');
  });

  test('查看图书详情', async ({ page }) => {
    // 点击第一本书
    await page.click('.book-card:first-child');

    // 验证详情页显示
    await expect(page.locator('.book-detail')).toBeVisible();
    await expect(page.locator('.book-title')).toBeVisible();
    await expect(page.locator('.book-author')).toBeVisible();
  });

  test('添加图书到管理员', async ({ page }) => {
    // 导航到管理页面
    await page.goto('http://localhost:5173/admin/books');

    // 点击添加按钮
    await page.click('button:has-text("添加图书")');

    // 填写表单
    await page.fill('input[name="title"]', '测试图书');
    await page.fill('input[name="author"]', '测试作者');
    await page.fill('input[name="isbn"]', '978-1234567890');
    await page.fill('input[name="price"]', '59.99');
    await page.fill('input[name="stock"]', '10');

    // 提交表单
    await page.click('button:has-text("确定")');

    // 验证成功提示
    await expect(page.locator('.el-message--success')).toBeVisible();

    // 验证列表中出现新书
    await expect(page.locator('.book-table')).toContainText('测试图书');
  });
});
```

#### 测试场景 3：借阅流程 (tests/e2e/borrow.spec.js)

```javascript
test.describe('图书借阅流程', () => {
  test('借阅图书', async ({ page }) => {
    // 登录
    await page.goto('http://localhost:5173/login');
    await page.fill('input[name="username"]', 'testuser');
    await page.fill('input[name="password"]', 'Test123456');
    await page.click('button[type="submit"]');

    // 进入图书列表
    await page.waitForURL(/.*books/);

    // 点击第一本书
    await page.click('.book-card:first-child');

    // 点击借阅按钮
    await page.click('button:has-text("借阅")');

    // 确认借阅
    await page.click('.el-message-box button:has-text("确定")');

    // 验证成功提示
    await expect(page.locator('.el-message--success')).toContainText('借阅成功');
  });

  test('查看借阅历史', async ({ page }) => {
    // 导航到借阅历史
    await page.goto('http://localhost:5173/borrow-history');

    // 验证表格显示
    await expect(page.locator('.borrow-table')).toBeVisible();

    // 验证至少有一条记录
    const rows = page.locator('.borrow-table tbody tr');
    await expect(rows).not.toHaveCount(0);
  });

  test('归还图书', async ({ page }) => {
    // 进入借阅历史
    await page.goto('http://localhost:5173/borrow-history');

    // 点击第一条记录的归还按钮
    await page.click('.borrow-table tbody tr:first-child button:has-text("归还")');

    // 确认归还
    await page.click('.el-message-box button:has-text("确定")');

    // 验证成功提示
    await expect(page.locator('.el-message--success')).toContainText('归还成功');

    // 验证状态变更
    await expect(page.locator('.borrow-table tbody tr:first-child')).toContainText('已归还');
  });
});
```

## 开发步骤

请按照以下顺序逐步完成：

### 阶段 1：项目初始化（10 分钟）
1. 创建 `backend/` 目录，初始化 Spring Boot 项目
2. 创建 `frontend/` 目录，初始化 Vue 3 项目
3. 配置数据库连接
4. 创建数据库表（执行 SQL）

### 阶段 2：后端开发（30 分钟）
1. 创建实体类（Entity）
2. 创建 Mapper 接口和 XML
3. 创建 Service 层
4. 创建 Controller 层
5. 配置 JWT 认证
6. 配置跨域（CORS）
7. 统一返回结果格式
8. 统一异常处理

### 阶段 3：后端测试（15 分钟）
1. 创建单元测试
2. 运行测试确保覆盖率 > 80%
3. 使用 Postman 或 curl 测试 API

### 阶段 4：前端开发（40 分钟）
1. 配置路由
2. 配置状态管理
3. 创建 API 服务
4. 创建页面组件
5. 实现用户认证
6. 实现图书管理
7. 实现借阅功能

### 阶段 5：E2E 测试（20 分钟）
1. 配置 Playwright
2. 编写认证流程测试
3. 编写图书管理流程测试
4. 编写借阅流程测试
5. 运行所有测试确保通过

### 阶段 6：文档和部署（10 分钟）
1. 生成 API 文档（Swagger）
2. 创建 README
3. 创建 Docker 配置（可选）

## 代码规范

### 后端规范
- 使用 Lombok 简化代码
- 所有类添加注释
- 统一使用 RESTful 风格
- 返回格式：
  ```json
  {
    "code": 200,
    "message": "success",
    "data": {}
  }
  ```

### 前端规范
- 使用 Composition API
- 组件使用 PascalCase 命名
- API 调用统一使用 async/await
- 错误统一使用 Element Plus Message 提示

## 配置文件

### application.yml
```yaml
server:
  port: 8080

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/book_management?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai
    username: root
    password: root
    driver-class-name: com.mysql.cj.jdbc.Driver

mybatis:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: com.bookms.entity
  configuration:
    map-underscore-to-camel-case: true

jwt:
  secret: your-secret-key-here
  expiration: 86400000
```

### vite.config.js
```javascript
export default defineConfig({
  server: {
    port: 5173,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true
      }
    }
  }
})
```

## 验收标准

- [ ] 后端所有 API 接口正常工作
- [ ] 后端单元测试覆盖率 > 80%
- [ ] 前端所有页面正常显示和交互
- [ ] 所有 Playwright E2E 测试通过
- [ ] 登录、注册流程完整
- [ ] 图书的增删改查功能完整
- [ ] 借阅和归还功能正常
- [ ] 数据验证和错误处理完善
- [ ] API 文档完整

## 开始开发

现在请开始开发这个项目。我会实时查看你的进度和代码生成情况。

遇到任何问题请及时告诉我，我会提供反馈。

开始吧！ 🚀
```

---

## 使用说明

### 1. 准备工作

```bash
# 创建项目目录
mkdir book-management-system
cd book-management-system

# 初始化 Claude Code
claude code init

# 配置 MCP
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
claude mcp add playwright -- npx -y mcp-server-playwright
```

### 2. 创建 CLAUDE.md

将项目规范写入 `CLAUDE.md`（见下一个文件）

### 3. 启动 Claude Code

```bash
claude code .
```

### 4. 粘贴 Prompt

将上面的**完整开发 Prompt** 粘贴到 Claude Code 中，然后按 Enter。

### 5. 实时监控

Claude Code 会开始：
1. 创建项目结构
2. 生成后端代码
3. 生成前端代码
4. 创建测试文件
5. 运行测试

### 6. 中间检查点

在每个阶段完成后，你可以：
- 查看生成的文件
- 运行测试验证
- 要求修改或优化
- 继续下一阶段

### 7. 测试验证

```bash
# 后端测试
cd backend
mvn test

# 前端测试
cd frontend
npm test

# E2E 测试
npm run test:e2e
```

### 8. 运行项目

```bash
# 启动后端
cd backend
mvn spring-boot:run

# 启动前端
cd frontend
npm run dev

# 访问
# 前端：http://localhost:5173
# 后端 API：http://localhost:8080
# Swagger 文档：http://localhost:8080/swagger-ui.html
```

## 预期时间

- **项目生成**: 10-15 分钟
- **测试运行**: 5 分钟
- **手动验证**: 10 分钟
- **总计**: 约 30 分钟

## 常见问题

### Q1: 如果生成的代码有问题怎么办？

**A**: 直接在 Claude Code 中继续对话：
```
"后端的用户登录接口返回格式不对，请修改为统一的返回格式"
```

### Q2: 如何添加新功能？

**A**: 继续在同一个会话中：
```
"请添加图书评论功能，包括：
1. 后端 API
2. 前端页面
3. E2E 测试"
```

### Q3: 测试失败怎么办？

**A**: 让 Claude Code 自动修复：
```
"Playwright 测试中的登录测试失败了，错误信息是：[粘贴错误]
请修复这个问题"
```

### Q4: 如何查看 Playwright 测试运行？

**A**: Playwright 通过 MCP 集成，Claude Code 会自动：
1. 启动浏览器
2. 执行测试步骤
3. 截图保存
4. 报告结果

你可以要求：
```
"使用 Playwright 运行登录测试，并截图展示"
```

## 下一步

完成这个项目后，你可以：

1. **添加更多功能**：
   - 图书推荐
   - 评论系统
   - 管理员面板

2. **优化性能**：
   - 添加 Redis 缓存
   - 数据库优化
   - 前端懒加载

3. **部署上线**：
   - Docker 容器化
   - CI/CD 配置
   - 云服务器部署

---

**准备好了吗？复制上面的 Prompt，开始你的第一个 Claude Code 项目吧！** 🚀
