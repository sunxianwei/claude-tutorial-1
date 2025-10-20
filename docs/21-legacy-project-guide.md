# 老项目使用 Claude Code 详细指南

## 目录

1. [为什么老项目需要特殊处理](#为什么老项目需要特殊处理)
2. [准备工作](#准备工作)
3. [项目分析阶段](#项目分析阶段)
4. [创建项目规范文件](#创建项目规范文件)
5. [渐进式接入策略](#渐进式接入策略)
6. [常见场景和 Prompt](#常见场景和-prompt)
7. [最佳实践](#最佳实践)
8. [常见问题](#常见问题)

---

## 为什么老项目需要特殊处理

老项目与新项目的主要区别：

| 特点 | 新项目 | 老项目 |
|-----|--------|--------|
| **代码规范** | 统一 | 可能不一致 |
| **技术栈** | 最新 | 可能过时 |
| **文档** | 完整 | 缺失或过时 |
| **依赖** | 清晰 | 复杂耦合 |
| **测试** | 完善 | 缺失或不足 |
| **业务逻辑** | 清晰 | 复杂且隐晦 |

**挑战：**
- 🔴 Claude 需要更多上下文才能理解项目
- 🔴 现有代码风格可能与 Claude 生成的不一致
- 🔴 修改可能破坏现有功能
- 🔴 依赖版本冲突
- 🔴 缺乏完整的测试覆盖

**解决方案：**
- ✅ 充分的项目分析
- ✅ 详细的规范文档
- ✅ 渐进式接入
- ✅ 完善的测试保障

---

## 准备工作

### 第一步：环境检查

```bash
# 1. 检查项目是否是 Git 仓库
git status

# 2. 创建新分支（强烈推荐）
git checkout -b feature/claude-code-integration

# 3. 确保代码已提交
git add .
git commit -m "feat: 准备接入 Claude Code"

# 4. 备份数据库（如果有）
mysqldump -u root -p database_name > backup_$(date +%Y%m%d).sql
```

### 第二步：安装 Claude Code

```bash
# 全局安装
npm install -g @anthropic-ai/claude-code

# 验证安装
claude --version
```

### 第三步：初始化配置

```bash
# 进入项目目录
cd your-legacy-project

# 初始化 Claude Code
claude code init
```

这会创建：
```
your-project/
├── .claude/
│   ├── config.json
│   └── mcp-servers.json
└── CLAUDE.md
```

### 第四步：配置 MCP 服务器

```bash
# 添加文件系统访问
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .

# 添加 Git 集成
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .

# 如果是 Web 项目，添加 Playwright
claude mcp add playwright -- npx -y mcp-server-playwright

# 如果有数据库，添加数据库 MCP
# PostgreSQL
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres

# MySQL (需要自行实现或使用第三方)
```

---

## 项目分析阶段

### 阶段 1：让 Claude 了解项目

这是最关键的步骤！Claude 需要充分理解你的项目才能提供准确的帮助。

#### Prompt 模板 1：初步了解项目

```markdown
我有一个老项目需要你帮助维护和开发新功能。

首先，请帮我分析这个项目的基本情况：

## 分析任务

### 1. 项目结构分析
请分析项目的目录结构，识别：
- 项目类型（Spring Boot、Vue、React 等）
- 主要目录的作用
- 配置文件位置
- 关键文件（入口文件、路由文件、配置文件）

### 2. 技术栈识别
请识别：
- 编程语言和版本
- 主要框架和库
- 构建工具
- 数据库类型
- 第三方依赖

### 3. 代码风格分析
请分析现有代码的风格：
- 命名规范
- 目录组织方式
- 注释风格
- 代码格式化规则

### 4. 业务逻辑概览
通过文件名、目录结构和关键代码，推测：
- 主要业务模块
- 核心功能
- 数据模型

### 5. 问题识别
识别潜在问题：
- 缺失的文档
- 代码质量问题
- 技术债务
- 安全隐患

## 输出格式

请生成一份详细的项目分析报告，包括：

1. **项目概况**
   - 项目类型
   - 技术栈清单
   - 项目规模（文件数、代码行数）

2. **架构分析**
   - 目录结构说明
   - 模块划分
   - 层次关系

3. **代码规范总结**
   - 命名规范示例
   - 文件组织方式
   - 需要遵循的特定规则

4. **建议的改进方向**
   - 优先级高的问题
   - 可以改进的地方

现在开始分析吧！
```

**使用方式：**

```bash
$ claude code .

> [粘贴上面的 Prompt]
```

**预期输出：**

Claude 会扫描项目文件，生成类似这样的报告：

```markdown
# 项目分析报告

## 1. 项目概况

### 基本信息
- **项目类型**: Spring Boot 后端项目
- **主要语言**: Java 8
- **项目规模**:
  - 约 150 个 Java 文件
  - 约 15,000 行代码
  - 12 个主要模块

### 技术栈
- **框架**: Spring Boot 2.3.0
- **数据库**: MySQL 5.7 + MyBatis
- **构建工具**: Maven 3.6
- **其他依赖**:
  - Lombok
  - FastJSON
  - Apache Commons

## 2. 架构分析

### 目录结构
```
src/main/java/com/company/project/
├── controller/    # 控制器层 (25 个类)
├── service/       # 服务层 (30 个类)
├── dao/           # 数据访问层 (28 个类)
├── entity/        # 实体类 (35 个类)
├── config/        # 配置类 (8 个类)
├── util/          # 工具类 (15 个类)
└── common/        # 公共类 (9 个类)
```

### 模块划分
识别到以下业务模块：
1. **用户模块** (user/)
2. **商品模块** (product/)
3. **订单模块** (order/)
4. **支付模块** (payment/)
5. **物流模块** (logistics/)

### 层次关系
```
Controller → Service → DAO → Database
     ↓          ↓
   DTO        Entity
```

## 3. 代码规范总结

### 命名规范
- **类名**: PascalCase (如 `UserController`)
- **方法名**: camelCase (如 `getUserById`)
- **常量**: UPPER_SNAKE_CASE (如 `MAX_RETRY_COUNT`)
- **变量**: camelCase (如 `userName`)

### 文件组织
- Controller 类以 `Controller` 结尾
- Service 接口不带后缀，实现类以 `Impl` 结尾
- DAO 类以 `Dao` 结尾（注意：不是标准的 `Mapper`）

### 特殊规范
- 使用 FastJSON 进行 JSON 处理（而非 Jackson）
- 使用自定义的 `Result` 类包装返回结果
- 统一异常处理使用 `BusinessException`
- 日期格式统一使用 `yyyy-MM-dd HH:mm:ss`

### 代码风格特点
- 大量使用 Lombok 注解
- 服务层方法较长，平均 50+ 行
- 注释较少，约 30% 的方法没有注释
- 部分代码存在重复逻辑

## 4. 识别到的问题

### 高优先级
1. **缺少单元测试** - 测试覆盖率 < 10%
2. **日志不规范** - 大量 `System.out.println`
3. **SQL 注入风险** - 部分 DAO 使用字符串拼接
4. **异常处理不完善** - 大量空 catch 块

### 中优先级
1. **代码重复** - 多处相似逻辑
2. **方法过长** - 需要拆分
3. **命名不统一** - 部分使用拼音
4. **缺少接口文档** - 无 Swagger

### 低优先级
1. **日志级别混乱**
2. **配置硬编码**
3. **依赖版本过旧**

## 5. 建议改进方向

### 立即执行
1. 为核心业务添加单元测试
2. 修复 SQL 注入风险
3. 改进日志记录

### 短期执行
1. 添加 Swagger 文档
2. 统一异常处理
3. 代码重构（提取重复逻辑）

### 长期执行
1. 升级依赖版本
2. 引入代码质量工具
3. 建立代码审查流程

## 6. 后续工作建议

基于以上分析，建议：

1. **创建详细的 CLAUDE.md 规范文件**
   - 记录现有代码规范
   - 明确禁止和允许的做法
   - 提供代码示例

2. **制定渐进式改进计划**
   - 不要一次性大改
   - 按模块逐步优化
   - 保持向后兼容

3. **建立测试保障**
   - 先为核心功能补充测试
   - 再进行重构

---
以上是项目分析报告。你有什么问题或需要我深入分析某个部分吗？
```

### 阶段 2：深入了解特定模块

如果项目很大，可以针对特定模块进行深入分析：

#### Prompt 模板 2：模块深入分析

```markdown
我想深入了解项目中的 [模块名称] 模块。

请帮我详细分析这个模块：

## 分析内容

### 1. 业务逻辑
- 这个模块的核心功能是什么？
- 主要的业务流程有哪些？
- 涉及哪些数据表？

### 2. 代码质量
- 代码复杂度如何？
- 是否有明显的坏味道？
- 测试覆盖率如何？

### 3. 依赖关系
- 这个模块依赖哪些其他模块？
- 哪些模块依赖这个模块？
- 是否存在循环依赖？

### 4. 改进建议
- 可以如何优化？
- 有哪些风险点？
- 重构的优先级？

请详细分析并给出建议。
```

### 阶段 3：识别技术债务

#### Prompt 模板 3：技术债务清单

```markdown
请帮我生成一份技术债务清单。

## 检查项目

### 1. 代码质量问题
- 查找超长方法（> 100 行）
- 查找超大类（> 500 行）
- 查找复杂条件判断（嵌套 > 3 层）
- 查找重复代码

### 2. 安全问题
- SQL 注入风险
- XSS 风险
- 密码明文存储
- 敏感信息泄露

### 3. 性能问题
- N+1 查询
- 缺少索引
- 未使用缓存
- 同步阻塞操作

### 4. 可维护性问题
- 缺少注释
- 缺少测试
- 硬编码
- 魔法数字

## 输出格式

请生成一个 Markdown 表格，包括：

| 问题类型 | 位置 | 严重程度 | 影响 | 建议修复方案 |
|---------|------|---------|------|------------|
| ... | ... | 高/中/低 | ... | ... |

并按严重程度排序。
```

---

## 创建项目规范文件

基于项目分析结果，创建详细的 `CLAUDE.md` 规范文件。

### 模板：老项目 CLAUDE.md

```markdown
# [项目名称] 开发规范

> 本文档基于现有代码分析生成，定义了本项目的开发规范和 Claude Code 使用指南。

## 项目概况

### 基本信息
- **项目名称**: [填写]
- **项目类型**: [Spring Boot / Vue / React 等]
- **技术栈**: [详细列表]
- **开发团队**: [团队信息]
- **维护状态**: 持续维护

### 重要说明

⚠️ **这是一个老项目，有以下特点：**

1. **代码规范不统一**: 历史原因导致部分代码风格不一致
2. **测试覆盖率低**: 约 [X]% 的测试覆盖率
3. **文档不完整**: 部分模块缺少文档
4. **技术栈较老**: 部分依赖版本较旧
5. **业务逻辑复杂**: 长期积累的业务规则

**Claude Code 使用原则：**
- ✅ 新功能开发: 遵循新的规范
- ✅ Bug 修复: 最小化修改，保持原有风格
- ✅ 重构: 需要充分测试，渐进式进行
- ❌ 避免: 大规模重写现有代码

---

## 现有代码规范

### 1. 命名规范

#### 类命名
```java
// ✅ 现有规范
UserController       // Controller 类
UserService          // Service 接口
UserServiceImpl      // Service 实现
UserDao              // DAO 类（注意：不是 Mapper！）
User                 // 实体类

// ❌ 不要使用
UserMapper           // 本项目使用 Dao 后缀
```

#### 方法命名
```java
// ✅ 现有规范
getUserById()        // 查询单个
getUserList()        // 查询列表
addUser()            // 新增
updateUser()         // 更新
deleteUser()         // 删除

// ❌ 不要使用
findUserById()       // 本项目不使用 find 前缀
saveUser()           // 本项目用 add/update
```

#### 数据库表命名
```sql
-- ✅ 现有规范
t_user               -- 表名前缀 t_
user_name            -- 字段名小写下划线

-- ❌ 不要使用
tb_user              -- 本项目用 t_ 而非 tb_
userName             -- 不使用驼峰
```

### 2. 项目结构

```
src/main/java/com/company/project/
├── controller/      # ✅ 控制器层（保持此命名）
├── service/         # ✅ 服务层
│   └── impl/        # ✅ 服务实现（注意在 impl 子包中）
├── dao/             # ✅ DAO 层（不是 mapper！）
├── entity/          # ✅ 实体类（不是 model 或 domain！）
├── dto/             # DTO 传输对象
├── vo/              # VO 视图对象
├── config/          # 配置类
├── util/            # 工具类
├── common/          # 公共类
│   ├── Result.java  # 统一返回结果
│   └── exception/   # 异常类
└── constant/        # 常量类
```

### 3. 依赖使用规范

#### JSON 处理
```java
// ✅ 使用 FastJSON（项目现有依赖）
import com.alibaba.fastjson.JSON;
JSON.toJSONString(object);

// ❌ 不要引入新的 JSON 库
import com.fasterxml.jackson.databind.ObjectMapper;  // 不要用
```

#### 日期处理
```java
// ✅ 使用项目现有方式
import java.text.SimpleDateFormat;
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

// 或使用工具类
DateUtil.format(date, "yyyy-MM-dd HH:mm:ss");

// ❌ 不要引入新的日期库
import java.time.LocalDateTime;  // 项目尚未使用 Java 8 时间 API
```

#### 集合操作
```java
// ✅ 使用 Apache Commons
import org.apache.commons.collections.CollectionUtils;

// ❌ 不要引入 Guava
import com.google.common.collect.Lists;  // 项目没有 Guava 依赖
```

### 4. Controller 层规范

```java
/**
 * 用户控制器
 *
 * ⚠️ 注意事项：
 * - 本项目不使用 @RestController，而是 @Controller + @ResponseBody
 * - 返回值使用 Result 包装
 * - 不使用 RESTful 风格（历史原因）
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired  // ✅ 使用 @Autowired（不是构造器注入）
    private UserService userService;

    /**
     * 获取用户列表
     *
     * ⚠️ URL 风格：
     * - 使用 /getUserList 而非 /users (GET)
     * - 历史原因，保持一致性
     */
    @RequestMapping("/getUserList")
    @ResponseBody
    public Result getUserList(@RequestParam(required = false) String keyword) {
        try {
            List<User> users = userService.getUserList(keyword);
            return Result.success(users);
        } catch (Exception e) {
            log.error("查询用户列表失败", e);
            return Result.error("查询失败");
        }
    }
}
```

### 5. Service 层规范

```java
/**
 * 用户服务接口
 */
public interface UserService {
    List<User> getUserList(String keyword);
    User getUserById(Long id);
    int addUser(User user);
    int updateUser(User user);
    int deleteUser(Long id);
}

/**
 * 用户服务实现类
 *
 * ⚠️ 注意：
 * - 在 service.impl 包中
 * - 类名以 Impl 结尾
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;  // ✅ 注入 Dao 而非 Mapper

    @Override
    public List<User> getUserList(String keyword) {
        // ✅ 使用项目现有的方式处理空字符串
        if (StringUtil.isEmpty(keyword)) {  // 自定义工具类
            keyword = null;
        }
        return userDao.selectList(keyword);
    }
}
```

### 6. DAO 层规范

```java
/**
 * 用户DAO接口
 *
 * ⚠️ 注意：
 * - 本项目使用 Dao 后缀，不是 Mapper
 * - 不使用 MyBatis-Plus
 * - 使用原生 MyBatis
 */
@Repository
public interface UserDao {
    List<User> selectList(@Param("keyword") String keyword);
    User selectById(@Param("id") Long id);
    int insert(User user);
    int update(User user);
    int deleteById(@Param("id") Long id);
}
```

**对应的 XML：**

```xml
<!-- UserDao.xml -->
<!-- ⚠️ 放在 resources/mapper/ 目录下 -->
<mapper namespace="com.company.project.dao.UserDao">

    <!-- ✅ resultMap 定义（项目风格） -->
    <resultMap id="BaseResultMap" type="com.company.project.entity.User">
        <id column="id" property="id"/>
        <result column="user_name" property="userName"/>
        <result column="real_name" property="realName"/>
        <!-- ... -->
    </resultMap>

    <!-- ✅ SQL 片段 -->
    <sql id="Base_Column_List">
        id, user_name, real_name, email, phone, create_time, update_time
    </sql>

    <!-- 查询列表 -->
    <select id="selectList" resultMap="BaseResultMap">
        SELECT <include refid="Base_Column_List"/>
        FROM t_user
        WHERE del_flag = 0
        <if test="keyword != null and keyword != ''">
            AND (user_name LIKE CONCAT('%', #{keyword}, '%')
            OR real_name LIKE CONCAT('%', #{keyword}, '%'))
        </if>
        ORDER BY create_time DESC
    </select>
</mapper>
```

### 7. 统一返回结果

```java
/**
 * 统一返回结果
 *
 * ⚠️ 这是项目现有的 Result 类，保持不变！
 */
@Data
public class Result implements Serializable {
    private boolean success;      // ✅ 注意：使用 boolean，不是 Integer code
    private String message;
    private Object data;

    // ✅ 使用现有的静态方法
    public static Result success() {
        Result result = new Result();
        result.setSuccess(true);
        result.setMessage("操作成功");
        return result;
    }

    public static Result success(Object data) {
        Result result = success();
        result.setData(data);
        return result;
    }

    public static Result error(String message) {
        Result result = new Result();
        result.setSuccess(false);
        result.setMessage(message);
        return result;
    }
}
```

### 8. 异常处理

```java
/**
 * 业务异常
 *
 * ⚠️ 项目现有的异常类
 */
public class BusinessException extends RuntimeException {
    public BusinessException(String message) {
        super(message);
    }
}

/**
 * 全局异常处理器
 *
 * ⚠️ 保持现有的异常处理逻辑
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(BusinessException.class)
    @ResponseBody
    public Result handleBusinessException(BusinessException e) {
        return Result.error(e.getMessage());
    }

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Result handleException(Exception e) {
        log.error("系统异常", e);
        return Result.error("系统异常，请联系管理员");
    }
}
```

---

## Claude Code 使用规范

### 1. 新功能开发

**准则：** 新功能可以遵循更好的实践，但要保持与现有代码的一致性。

**Prompt 模板：**

```markdown
请为本项目开发 [功能描述]。

⚠️ 重要：这是一个老项目，请遵循以下规范：

## 必须遵守的规则

1. **命名规范**
   - DAO 类以 `Dao` 结尾（不是 Mapper）
   - Service 实现类以 `Impl` 结尾，放在 service.impl 包中
   - 方法使用 add/update/delete 前缀（不是 save/modify/remove）

2. **依赖使用**
   - JSON 处理使用 FastJSON
   - 不使用 MyBatis-Plus
   - 不使用 Java 8 时间 API

3. **返回结果**
   - 使用项目现有的 Result 类
   - Result.success() / Result.error()

4. **URL 风格**
   - 不使用 RESTful 风格
   - 使用 /getUserList 这样的风格

## 功能需求

[详细描述功能需求]

## 实现要求

1. 创建 Controller、Service、DAO 层代码
2. 编写 MyBatis XML 映射文件
3. 添加必要的注释
4. 编写单元测试（使用 JUnit 4）

请开始开发。
```

### 2. Bug 修复

**准则：** 最小化修改，不改变原有代码风格。

**Prompt 模板：**

```markdown
请修复以下 Bug：

## Bug 描述
[详细描述]

## 复现步骤
1. ...
2. ...
3. ...

## 期望行为
[描述期望的正确行为]

## 修复要求

⚠️ 这是 Bug 修复，请注意：

1. **最小化修改**
   - 只修改必要的代码
   - 不要重构无关代码
   - 保持原有代码风格

2. **保持兼容性**
   - 不改变方法签名
   - 不改变返回格式
   - 不影响其他功能

3. **充分测试**
   - 修复后进行测试
   - 确保不引入新问题

请开始修复。
```

### 3. 代码重构

**准则：** 谨慎重构，需要充分的测试保障。

**Prompt 模板：**

```markdown
我想重构 [模块/类/方法]。

## 重构目标
[描述重构的目的]

## 重构范围
[明确重构的边界]

## 重构要求

⚠️ 这是代码重构，请严格遵循：

### 阶段 1：分析现状
1. 分析现有代码的问题
2. 识别依赖关系
3. 评估重构风险

### 阶段 2：编写测试
1. 为现有代码补充单元测试
2. 确保测试覆盖所有分支
3. 验证测试全部通过

### 阶段 3：执行重构
1. 小步重构，频繁提交
2. 每次重构后运行测试
3. 保持功能不变

### 阶段 4：验证结果
1. 运行所有测试
2. 手动测试关键流程
3. 代码审查

请开始重构。
```

### 4. 添加单元测试

**Prompt 模板：**

```markdown
请为 [类名/方法名] 添加单元测试。

## 测试要求

⚠️ 注意项目使用 JUnit 4（不是 JUnit 5）！

1. **测试框架**
   - 使用 JUnit 4
   - 使用 @RunWith(SpringRunner.class)
   - 使用 @SpringBootTest

2. **测试覆盖**
   - 正常场景
   - 异常场景
   - 边界条件

3. **Mock 使用**
   - 使用 Mockito mock 依赖
   - 不连接真实数据库

## 测试代码示例

参考现有的测试代码风格：

```java
@RunWith(SpringRunner.class)
@SpringBootTest
public class UserServiceTest {

    @Autowired
    private UserService userService;

    @MockBean  // ✅ 使用 @MockBean mock DAO
    private UserDao userDao;

    @Test
    public void testGetUserById() {
        // Given
        Long userId = 1L;
        User mockUser = new User();
        mockUser.setId(userId);
        mockUser.setUserName("test");

        Mockito.when(userDao.selectById(userId))
               .thenReturn(mockUser);

        // When
        User user = userService.getUserById(userId);

        // Then
        Assert.assertNotNull(user);
        Assert.assertEquals("test", user.getUserName());
    }
}
```

请开始编写测试。
```

---

## 渐进式接入策略

### 策略 1：按模块接入

**适用场景：** 项目模块划分清晰

**步骤：**

1. **选择一个独立模块**
   - 优先选择新模块或改动较少的模块
   - 避开核心业务模块

2. **为该模块创建详细规范**
   ```markdown
   # User 模块开发规范

   本模块使用 Claude Code 辅助开发，遵循以下规范...
   ```

3. **逐步迁移**
   - 新功能：完全使用 Claude Code
   - Bug 修复：使用 Claude Code 辅助
   - 重构：渐进式重构

4. **积累经验**
   - 记录问题和解决方案
   - 优化规范文档
   - 分享给团队

5. **推广到其他模块**

### 策略 2：按任务类型接入

**适用场景：** 模块耦合较紧

**步骤：**

1. **从简单任务开始**
   - 文档生成
   - 单元测试补充
   - 代码注释

2. **逐步增加难度**
   - 工具类开发
   - 简单的 CRUD 功能
   - 业务逻辑实现

3. **最后处理复杂任务**
   - 核心业务重构
   - 性能优化
   - 架构调整

### 策略 3：双轨制运行

**适用场景：** 团队成员技能差异大

**步骤：**

1. **核心开发者先行**
   - 熟悉 Claude Code
   - 建立规范
   - 积累案例

2. **编写使用指南**
   - 常见场景 Prompt
   - 问题解决方案
   - 最佳实践

3. **逐步推广**
   - 内部培训
   - 结对编程
   - 代码审查

---

## 常见场景和 Prompt

### 场景 1：理解复杂的业务逻辑

```markdown
请帮我理解 [类名/方法名] 的业务逻辑。

## 分析要求

1. **业务流程**
   - 主要流程是什么？
   - 有哪些分支？
   - 异常情况如何处理？

2. **数据流**
   - 输入是什么？
   - 输出是什么？
   - 中间经过哪些处理？

3. **依赖关系**
   - 调用了哪些其他方法？
   - 依赖哪些外部服务？

4. **潜在问题**
   - 有没有明显的 bug？
   - 有没有性能问题？
   - 有没有安全风险？

请详细分析并生成文档。
```

### 场景 2：生成 API 文档

```markdown
请为本项目的所有 API 接口生成 Swagger 文档。

## 要求

1. **添加 Swagger 依赖**
   - 使用 Swagger 2.x（与项目 Spring Boot 版本兼容）

2. **创建 Swagger 配置类**
   - 包名：com.company.project.config
   - 类名：SwaggerConfig

3. **为 Controller 添加注解**
   - @Api：类级别注解
   - @ApiOperation：方法级别注解
   - @ApiParam：参数注解

4. **示例：**
   ```java
   @Api(tags = "用户管理")
   @Controller
   @RequestMapping("/user")
   public class UserController {

       @ApiOperation("获取用户列表")
       @RequestMapping("/getUserList")
       @ResponseBody
       public Result getUserList(
               @ApiParam("搜索关键词") @RequestParam(required = false) String keyword) {
           // ...
       }
   }
   ```

请开始添加 Swagger 文档。
```

### 场景 3：优化慢查询

```markdown
请帮我优化以下慢查询。

## 查询SQL
```sql
[粘贴慢查询 SQL]
```

## 执行计划
```
[粘贴 EXPLAIN 结果]
```

## 表结构
```sql
[粘贴相关表的 CREATE TABLE 语句]
```

## 优化要求

1. **分析问题**
   - 为什么慢？
   - 缺少什么索引？
   - 有没有不必要的操作？

2. **提供优化方案**
   - SQL 改写
   - 索引建议
   - 其他优化（缓存、分页等）

3. **预估效果**
   - 优化后的预期性能

请开始分析。
```

### 场景 4：添加日志

```markdown
请为 [类名] 添加完善的日志。

## 日志要求

⚠️ 项目使用 Slf4j + Lombok

1. **日志级别**
   - DEBUG：方法入参、出参
   - INFO：关键业务操作
   - WARN：异常情况但程序可继续
   - ERROR：错误和异常

2. **日志格式**
   ```java
   // ✅ 好的日志
   log.info("查询用户, userId={}", userId);
   log.error("更新用户失败, userId={}, error={}", userId, e.getMessage(), e);

   // ❌ 不好的日志
   log.info("查询用户");  // 缺少关键信息
   System.out.println("..."); // 不要用
   ```

3. **添加位置**
   - 方法入口
   - 关键分支
   - 异常处理
   - 方法出口（可选）

请添加日志。
```

### 场景 5：数据库迁移脚本

```markdown
我需要修改数据库表结构。

## 变更需求
[描述需要的变更]

## 生成内容

请生成以下内容：

1. **变更 SQL（V1__add_xxx.sql）**
   ```sql
   -- 包含完整的 ALTER TABLE 语句
   -- 考虑兼容性和性能
   ```

2. **回滚 SQL**
   ```sql
   -- 如果需要回滚，执行的 SQL
   ```

3. **数据迁移脚本（如需要）**
   ```sql
   -- 迁移现有数据的脚本
   ```

4. **实体类更新**
   - 更新对应的 Entity 类
   - 更新 MyBatis XML

5. **验证 SQL**
   ```sql
   -- 验证变更是否成功的 SQL
   ```

## 注意事项

⚠️ 这是生产数据库，请：
- 提供分步执行的 SQL
- 考虑大表的影响
- 添加必要的索引
- 考虑锁等待问题

请生成迁移脚本。
```

---

## 最佳实践

### 1. 保持小步前进

✅ **推荐：**
```
1. 修改一个文件
2. 运行测试
3. 提交代码
4. 继续下一个
```

❌ **避免：**
```
1. 一次性修改 20 个文件
2. 发现问题难以回滚
```

### 2. 充分利用 Git

```bash
# 每次使用 Claude Code 前
git checkout -b feature/xxx

# 频繁提交
git add .
git commit -m "feat: 添加用户查询功能"

# 出现问题可以回滚
git reset --hard HEAD~1
```

### 3. 建立测试保障

```markdown
对于任何修改，遵循：

1. 先写测试（如果没有）
2. 测试通过
3. 进行修改
4. 测试仍然通过
5. 提交代码
```

### 4. 渐进式重构

```markdown
不要：
❌ 一次性重写整个模块

而是：
✅ 第一次：提取重复代码
✅ 第二次：优化命名
✅ 第三次：简化逻辑
✅ 第四次：添加文档
```

### 5. 保持文档同步

```markdown
每次重要修改后，更新：

1. CLAUDE.md - 如果规范有变化
2. README.md - 如果功能有增加
3. API 文档 - 如果接口有变化
4. 数据库文档 - 如果表结构有变化
```

---

## 常见问题

### Q1: Claude 生成的代码风格与项目不一致

**原因：** CLAUDE.md 规范不够详细

**解决：**
```markdown
在 CLAUDE.md 中增加更多示例：

## Controller 代码示例

✅ 正确的写法：
```java
[粘贴项目现有的代码]
```

❌ 不要这样写：
```java
[粘贴不希望的写法]
```
```

### Q2: Claude 修改了不应该修改的文件

**原因：** 没有明确指定修改范围

**解决：**
```markdown
请只修改 UserController.java 文件。

⚠️ 不要修改其他文件！
```

### Q3: 生成的代码破坏了现有功能

**原因：** 缺少测试保障

**解决：**
```bash
# 1. 回滚代码
git reset --hard HEAD~1

# 2. 先补充测试
claude code . "请为 UserService 补充完整的单元测试"

# 3. 再进行修改
claude code . "现在请修改用户查询逻辑..."
```

### Q4: 不知道如何描述需求

**解决：** 使用结构化的 Prompt

```markdown
## 需求描述
[用一句话概括]

## 背景
[为什么需要这个功能]

## 详细需求
1. [功能点 1]
2. [功能点 2]
3. [功能点 3]

## 验收标准
- [ ] 标准 1
- [ ] 标准 2
- [ ] 标准 3

## 约束条件
- 不能修改 XXX
- 必须兼容 XXX
- 性能要求 XXX
```

### Q5: Claude 对项目理解不准确

**解决：** 提供更多上下文

```markdown
请帮我实现用户查询功能。

## 项目上下文

参考现有的 ProductController.java，它的实现方式是正确的。

请用同样的方式实现 UserController。

## 特别注意

1. 本项目不使用 RESTful 风格
2. URL 格式是 /getUserList
3. 返回值使用 Result 包装
```

---

## 总结

老项目使用 Claude Code 的关键：

1. **✅ 充分分析** - 深入理解现有代码
2. **✅ 详细规范** - 创建完善的 CLAUDE.md
3. **✅ 小步前进** - 渐进式接入，不要激进
4. **✅ 测试保障** - 先测试后修改
5. **✅ 持续优化** - 不断改进规范和流程

**记住：** Claude Code 是助手，不是替代品。对于老项目，你的领域知识比 AI 更重要！

---

**准备好了吗？开始在你的老项目上使用 Claude Code 吧！** 🚀
