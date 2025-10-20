# 图书管理系统开发规范

> 本文档定义了图书管理系统的开发规范和最佳实践。所有代码生成都应遵循此规范。

## 项目信息

- **项目名称**: 在线图书管理系统
- **技术栈**: Spring Boot 2.7 + JDK 1.8 + Vue 3
- **开发模式**: 前后端分离
- **代码风格**: 遵循阿里巴巴 Java 开发规范 + Vue 3 官方风格指南

---

## 后端开发规范

### 1. 项目结构

```
backend/
└── src/main/java/com/bookms/
    ├── controller/      # 控制器层 - 处理 HTTP 请求
    ├── service/         # 服务层 - 业务逻辑
    ├── mapper/          # 数据访问层 - MyBatis Mapper
    ├── entity/          # 实体类 - 数据库表映射
    ├── dto/             # 数据传输对象 - 请求参数
    ├── vo/              # 视图对象 - 响应数据
    ├── config/          # 配置类
    ├── common/          # 公共类
    │   ├── Result.java  # 统一返回结果
    │   ├── Constants.java
    │   └── exception/   # 异常处理
    └── utils/           # 工具类
```

### 2. 命名规范

#### 2.1 包命名
- 全部小写
- 使用点号分隔
- 示例：`com.bookms.controller`

#### 2.2 类命名
- 使用 PascalCase（大驼峰）
- Controller 类：以 `Controller` 结尾，如 `BookController`
- Service 类：以 `Service` 结尾，实现类以 `Impl` 结尾
  - 接口：`BookService`
  - 实现：`BookServiceImpl`
- Entity 类：实体名称，如 `Book`、`User`
- DTO 类：以 `DTO` 结尾，如 `LoginDTO`
- VO 类：以 `VO` 结尾，如 `BookVO`

#### 2.3 方法命名
- 使用 camelCase（小驼峰）
- 查询：`getXxx`、`listXxx`、`findXxx`
- 新增：`addXxx`、`createXxx`、`saveXxx`
- 修改：`updateXxx`、`modifyXxx`
- 删除：`deleteXxx`、`removeXxx`
- 判断：`isXxx`、`hasXxx`

#### 2.4 变量命名
- 使用 camelCase
- 布尔类型：`isXxx`、`hasXxx`、`canXxx`
- 集合类型：复数形式，如 `books`、`userList`

### 3. 代码规范

#### 3.1 Controller 层规范

```java
/**
 * 图书管理控制器
 *
 * @author System
 * @since 2024-01-01
 */
@RestController
@RequestMapping("/api/books")
@Slf4j
@RequiredArgsConstructor
public class BookController {

    private final BookService bookService;

    /**
     * 分页查询图书列表
     *
     * @param page 页码
     * @param size 每页数量
     * @param keyword 搜索关键词
     * @param category 分类
     * @return 图书列表
     */
    @GetMapping
    public Result<Page<BookVO>> getBookList(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String category) {

        log.info("查询图书列表, page={}, size={}, keyword={}, category={}",
                page, size, keyword, category);

        Page<BookVO> bookPage = bookService.getBookList(page, size, keyword, category);
        return Result.success(bookPage);
    }

    /**
     * 获取图书详情
     *
     * @param id 图书ID
     * @return 图书详情
     */
    @GetMapping("/{id}")
    public Result<BookVO> getBookDetail(@PathVariable Long id) {
        log.info("查询图书详情, id={}", id);
        BookVO book = bookService.getBookDetail(id);
        return Result.success(book);
    }

    /**
     * 添加图书（需要管理员权限）
     *
     * @param bookDTO 图书信息
     * @return 添加结果
     */
    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public Result<BookVO> addBook(@Valid @RequestBody BookDTO bookDTO) {
        log.info("添加图书, bookDTO={}", bookDTO);
        BookVO book = bookService.addBook(bookDTO);
        return Result.success(book);
    }
}
```

**规范要点：**
- ✅ 使用 `@RestController` 和 `@RequestMapping`
- ✅ 使用 Lombok 的 `@Slf4j` 和 `@RequiredArgsConstructor`
- ✅ 统一使用 `Result` 包装返回结果
- ✅ 添加详细的方法注释
- ✅ 参数验证使用 `@Valid`
- ✅ 记录关键操作日志
- ✅ 权限控制使用 `@PreAuthorize`

#### 3.2 Service 层规范

```java
/**
 * 图书服务接口
 */
public interface BookService {

    /**
     * 分页查询图书列表
     */
    Page<BookVO> getBookList(Integer page, Integer size, String keyword, String category);

    /**
     * 获取图书详情
     */
    BookVO getBookDetail(Long id);

    /**
     * 添加图书
     */
    BookVO addBook(BookDTO bookDTO);
}

/**
 * 图书服务实现类
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {

    private final BookMapper bookMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public BookVO addBook(BookDTO bookDTO) {
        // 1. 参数验证
        if (bookMapper.existsByIsbn(bookDTO.getIsbn())) {
            throw new BusinessException("ISBN 已存在");
        }

        // 2. 转换并保存
        Book book = BeanUtil.copyProperties(bookDTO, Book.class);
        book.setCreateTime(LocalDateTime.now());
        bookMapper.insert(book);

        // 3. 返回结果
        return BeanUtil.copyProperties(book, BookVO.class);
    }
}
```

**规范要点：**
- ✅ Service 层定义接口
- ✅ 业务逻辑都在 Service 层实现
- ✅ 使用 `@Transactional` 控制事务
- ✅ 参数验证和业务校验
- ✅ 异常使用自定义业务异常
- ✅ 使用工具类进行对象转换

#### 3.3 统一返回结果

```java
/**
 * 统一返回结果
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result<T> {
    private Integer code;
    private String message;
    private T data;

    public static <T> Result<T> success() {
        return new Result<>(200, "操作成功", null);
    }

    public static <T> Result<T> success(T data) {
        return new Result<>(200, "操作成功", data);
    }

    public static <T> Result<T> success(String message, T data) {
        return new Result<>(200, message, data);
    }

    public static <T> Result<T> error(String message) {
        return new Result<>(500, message, null);
    }

    public static <T> Result<T> error(Integer code, String message) {
        return new Result<>(code, message, null);
    }
}
```

#### 3.4 统一异常处理

```java
/**
 * 全局异常处理器
 */
@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    /**
     * 业务异常
     */
    @ExceptionHandler(BusinessException.class)
    public Result<?> handleBusinessException(BusinessException e) {
        log.error("业务异常：{}", e.getMessage());
        return Result.error(e.getCode(), e.getMessage());
    }

    /**
     * 参数验证异常
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<?> handleValidException(MethodArgumentNotValidException e) {
        String message = e.getBindingResult().getFieldError().getDefaultMessage();
        log.error("参数验证失败：{}", message);
        return Result.error(400, message);
    }

    /**
     * 系统异常
     */
    @ExceptionHandler(Exception.class)
    public Result<?> handleException(Exception e) {
        log.error("系统异常", e);
        return Result.error("系统错误，请联系管理员");
    }
}
```

### 4. 数据库规范

#### 4.1 表命名
- 使用小写字母
- 单词之间用下划线分隔
- 统一前缀：`tb_`
- 示例：`tb_user`、`tb_book`、`tb_borrow`

#### 4.2 字段命名
- 使用小写字母
- 单词之间用下划线分隔
- 示例：`user_name`、`create_time`

#### 4.3 必备字段
每个表都应包含：
- `id`：主键，BIGINT，自增
- `create_time`：创建时间，DATETIME
- `update_time`：更新时间，DATETIME

#### 4.4 索引规范
- 主键索引：`PRIMARY KEY`
- 唯一索引：`UNIQUE KEY uk_字段名`
- 普通索引：`KEY idx_字段名`
- 外键约束：`FOREIGN KEY`

### 5. 测试规范

#### 5.1 单元测试

```java
@SpringBootTest
@AutoConfigureMockMvc
class BookControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void testGetBookList() throws Exception {
        mockMvc.perform(get("/api/books")
                        .param("page", "1")
                        .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data").exists());
    }
}
```

#### 5.2 测试覆盖率
- Controller 层：100%
- Service 层：> 90%
- 整体覆盖率：> 80%

---

## 前端开发规范

### 1. 项目结构

```
frontend/
├── src/
│   ├── main.js           # 入口文件
│   ├── App.vue           # 根组件
│   ├── views/            # 页面组件
│   ├── components/       # 公共组件
│   ├── router/           # 路由配置
│   ├── store/            # 状态管理
│   ├── api/              # API 接口
│   ├── utils/            # 工具函数
│   ├── styles/           # 全局样式
│   └── assets/           # 静态资源
└── tests/
    ├── unit/             # 单元测试
    └── e2e/              # E2E 测试
```

### 2. 命名规范

#### 2.1 文件命名
- 组件文件：PascalCase，如 `BookCard.vue`
- 工具文件：camelCase，如 `request.js`
- 样式文件：kebab-case，如 `common-styles.css`

#### 2.2 组件命名
- 单文件组件：PascalCase
- 组件名称应该是多个单词
- 基础组件：以 `Base` 开头，如 `BaseButton.vue`

#### 2.3 变量命名
- 使用 camelCase
- 布尔类型：`isXxx`、`hasXxx`
- 常量：UPPER_SNAKE_CASE

### 3. 代码规范

#### 3.1 组件规范

```vue
<template>
  <div class="book-card">
    <el-card :body-style="{ padding: '0px' }">
      <img :src="book.coverUrl" class="book-cover" />
      <div class="book-info">
        <h3 class="book-title">{{ book.title }}</h3>
        <p class="book-author">{{ book.author }}</p>
        <div class="book-footer">
          <span class="book-price">¥{{ book.price }}</span>
          <el-button type="primary" size="small" @click="handleView">
            查看详情
          </el-button>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { defineProps, defineEmits } from 'vue'

// Props 定义
const props = defineProps({
  book: {
    type: Object,
    required: true
  }
})

// Emits 定义
const emit = defineEmits(['view'])

// 方法
const handleView = () => {
  emit('view', props.book.id)
}
</script>

<style scoped>
.book-card {
  margin-bottom: 20px;
}

.book-cover {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

.book-info {
  padding: 14px;
}

.book-title {
  font-size: 16px;
  margin: 0 0 10px 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.book-author {
  color: #999;
  font-size: 14px;
  margin: 0 0 10px 0;
}

.book-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.book-price {
  color: #f56c6c;
  font-size: 18px;
  font-weight: bold;
}
</style>
```

**规范要点：**
- ✅ 使用 Composition API (`<script setup>`)
- ✅ Props 和 Emits 类型定义
- ✅ 清晰的组件结构
- ✅ Scoped 样式
- ✅ 语义化的类名

#### 3.2 API 调用规范

```javascript
// api/book.js
import request from '@/utils/request'

/**
 * 获取图书列表
 * @param {Object} params - 查询参数
 * @param {number} params.page - 页码
 * @param {number} params.size - 每页数量
 * @param {string} params.keyword - 搜索关键词
 * @param {string} params.category - 分类
 * @returns {Promise}
 */
export function getBookList(params) {
  return request({
    url: '/api/books',
    method: 'get',
    params
  })
}

/**
 * 获取图书详情
 * @param {number} id - 图书ID
 * @returns {Promise}
 */
export function getBookDetail(id) {
  return request({
    url: `/api/books/${id}`,
    method: 'get'
  })
}

/**
 * 添加图书
 * @param {Object} data - 图书信息
 * @returns {Promise}
 */
export function addBook(data) {
  return request({
    url: '/api/books',
    method: 'post',
    data
  })
}
```

**规范要点：**
- ✅ 统一的 request 封装
- ✅ 详细的 JSDoc 注释
- ✅ 导出命名函数
- ✅ 清晰的参数说明

#### 3.3 页面组件规范

```vue
<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getBookList } from '@/api/book'
import BookCard from '@/components/BookCard.vue'

// 路由
const router = useRouter()

// 响应式数据
const loading = ref(false)
const books = ref([])
const total = ref(0)
const queryParams = ref({
  page: 1,
  size: 12,
  keyword: '',
  category: ''
})

// 方法
const loadBooks = async () => {
  loading.value = true
  try {
    const { data } = await getBookList(queryParams.value)
    books.value = data.records
    total.value = data.total
  } catch (error) {
    ElMessage.error('加载图书列表失败')
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  queryParams.value.page = 1
  loadBooks()
}

const handleView = (id) => {
  router.push(`/books/${id}`)
}

const handlePageChange = (page) => {
  queryParams.value.page = page
  loadBooks()
}

// 生命周期
onMounted(() => {
  loadBooks()
})
</script>
```

**规范要点：**
- ✅ 使用 Composition API
- ✅ 响应式数据使用 ref/reactive
- ✅ 异步操作使用 async/await
- ✅ 错误处理和用户提示
- ✅ Loading 状态管理

### 4. 测试规范

#### 4.1 E2E 测试规范

```javascript
import { test, expect } from '@playwright/test'

test.describe('图书列表页', () => {
  test.beforeEach(async ({ page }) => {
    // 每个测试前登录
    await page.goto('http://localhost:5173/login')
    await page.fill('input[name="username"]', 'testuser')
    await page.fill('input[name="password"]', 'Test123456')
    await page.click('button[type="submit"]')
    await page.waitForURL(/.*books/)
  })

  test('应该显示图书列表', async ({ page }) => {
    // 验证页面标题
    await expect(page.locator('h1')).toContainText('图书列表')

    // 验证至少有一本书
    const books = page.locator('.book-card')
    await expect(books).not.toHaveCount(0)

    // 验证图书卡片包含必要信息
    const firstBook = books.first()
    await expect(firstBook.locator('.book-title')).toBeVisible()
    await expect(firstBook.locator('.book-author')).toBeVisible()
    await expect(firstBook.locator('.book-price')).toBeVisible()
  })

  test('应该能够搜索图书', async ({ page }) => {
    // 输入搜索关键词
    await page.fill('input[placeholder*="搜索"]', 'Java')
    await page.keyboard.press('Enter')

    // 等待搜索结果
    await page.waitForSelector('.book-card')

    // 验证搜索结果包含关键词
    const titles = await page.locator('.book-title').allTextContents()
    expect(titles.some(title => title.includes('Java'))).toBeTruthy()
  })

  test('应该能够查看图书详情', async ({ page }) => {
    // 点击第一本书
    await page.click('.book-card:first-child')

    // 验证跳转到详情页
    await expect(page).toHaveURL(/.*books\/\d+/)

    // 验证详情页内容
    await expect(page.locator('.book-detail')).toBeVisible()
    await expect(page.locator('.book-title')).toBeVisible()
    await expect(page.locator('.book-description')).toBeVisible()
  })
})
```

**规范要点：**
- ✅ 使用 `test.describe` 组织测试
- ✅ 使用 `test.beforeEach` 设置前置条件
- ✅ 清晰的测试用例描述
- ✅ 使用 `expect` 进行断言
- ✅ 等待异步操作完成

---

## 通用规范

### 1. Git 提交规范

使用 Conventional Commits 规范：

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Type 类型：**
- `feat`: 新功能
- `fix`: 修复 bug
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 代码重构
- `test`: 测试相关
- `chore`: 构建/工具链

**示例：**
```
feat(book): 添加图书搜索功能

- 实现按标题、作者、ISBN 搜索
- 添加分类筛选
- 支持分页显示

Closes #123
```

### 2. 代码注释规范

#### 2.1 Java 注释

```java
/**
 * 类注释：简要描述类的功能
 *
 * @author 作者
 * @since 版本号
 */
public class BookService {

    /**
     * 方法注释：描述方法功能
     *
     * @param id 图书ID
     * @return 图书详情
     * @throws BusinessException 业务异常
     */
    public BookVO getBookDetail(Long id) {
        // 实现逻辑
    }
}
```

#### 2.2 JavaScript 注释

```javascript
/**
 * 函数注释：描述函数功能
 * @param {number} id - 图书ID
 * @returns {Promise<Object>} 图书详情
 */
export function getBookDetail(id) {
  return request({
    url: `/api/books/${id}`,
    method: 'get'
  })
}
```

### 3. 日志规范

#### 3.1 日志级别
- `DEBUG`: 调试信息
- `INFO`: 一般信息
- `WARN`: 警告信息
- `ERROR`: 错误信息

#### 3.2 日志内容
```java
// ✅ 好的日志
log.info("用户登录, username={}", username);
log.error("查询图书失败, id={}, error={}", id, e.getMessage());

// ❌ 不好的日志
log.info("登录");
log.error(e.getMessage());
```

### 4. 性能优化

#### 4.1 后端优化
- 使用缓存（Redis）
- 数据库索引优化
- 分页查询
- 异步处理

#### 4.2 前端优化
- 组件懒加载
- 图片懒加载
- 防抖和节流
- 虚拟滚动

### 5. 安全规范

#### 5.1 后端安全
- 使用 BCrypt 加密密码
- JWT Token 认证
- 参数验证
- SQL 注入防护
- XSS 防护

#### 5.2 前端安全
- 不在前端存储敏感信息
- 使用 HTTPS
- Token 过期处理
- 输入验证

---

## 开发流程

### 1. 功能开发流程

```
1. 需求分析 → 2. 设计方案 → 3. 编写代码 → 4. 单元测试 → 5. 集成测试 → 6. 代码审查 → 7. 部署上线
```

### 2. 分支管理

- `main`: 主分支，生产环境代码
- `develop`: 开发分支
- `feature/xxx`: 功能分支
- `bugfix/xxx`: 修复分支
- `hotfix/xxx`: 紧急修复分支

### 3. 代码审查要点

- [ ] 代码符合规范
- [ ] 测试覆盖率达标
- [ ] 没有安全隐患
- [ ] 性能没有明显下降
- [ ] 文档和注释完整

---

## 常用工具和库

### 后端
- **Lombok**: 简化 Java 代码
- **Hutool**: Java 工具库
- **MyBatis-Plus**: MyBatis 增强工具
- **Spring Security**: 安全框架
- **JWT**: Token 认证

### 前端
- **Element Plus**: UI 组件库
- **Axios**: HTTP 客户端
- **Vue Router**: 路由管理
- **Pinia**: 状态管理
- **Day.js**: 日期处理
- **Lodash**: 工具库

### 测试
- **JUnit 5**: Java 单元测试
- **Mockito**: Mock 框架
- **Playwright**: E2E 测试

---

## 问题排查

### 后端问题

#### 问题 1: 跨域错误
**解决方案**: 配置 CORS

```java
@Configuration
public class CorsConfig {
    @Bean
    public CorsFilter corsFilter() {
        CorsConfiguration config = new CorsConfiguration();
        config.addAllowedOrigin("http://localhost:5173");
        config.addAllowedMethod("*");
        config.addAllowedHeader("*");
        config.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return new CorsFilter(source);
    }
}
```

#### 问题 2: SQL 执行失败
**排查步骤**:
1. 检查 MyBatis 配置
2. 查看 SQL 日志
3. 验证数据库连接
4. 检查表结构和字段

### 前端问题

#### 问题 1: 接口请求失败
**排查步骤**:
1. 检查网络请求（F12 → Network）
2. 查看请求 URL 和参数
3. 检查响应状态码
4. 验证 Token 是否有效

#### 问题 2: 组件不渲染
**排查步骤**:
1. 检查控制台错误
2. 验证数据是否正确
3. 检查条件渲染逻辑
4. 确认组件已正确导入

---

**遵循本规范，确保代码质量和项目的可维护性！**
