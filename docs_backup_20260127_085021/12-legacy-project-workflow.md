# 12 - 老项目迁移：平滑接入现有项目

## 老项目的常见挑战

```
没有规范文档  ─┐
              ├─→ 难以让 Claude 理解项目
代码风格混乱  ─┤
              │
大量遗留代码  ─┤
              ├─→ 上下文压缩困难
技术栈陈旧    ─┤
              │
缺乏测试覆盖  ─┴─→ 无法安全重构
```

## 迁移策略

### 第一阶段：项目理解（1-2 天）

#### 步骤 1：初始化 Claude Code

```bash
cd your-legacy-project
claude-code init
```

#### 步骤 2：让 Claude 理解项目

```bash
# Claude 自动分析项目结构
claude-code . "分析这个项目的结构、技术栈、核心功能"

# 输出应该包括：
# - 项目类型（Web/CLI/Library）
# - 技术栈
# - 主要模块
# - 代码规模
# - 潜在问题
```

#### 步骤 3：创建项目摘要

```markdown
# 项目摘要

## 基本信息
- 项目名称: XX 系统
- 创建时间: 2020-01
- 代码规模: 50K LOC
- 技术栈: Java 8 + Spring Boot 2.x + PostgreSQL

## 架构概述
[简化的架构描述]

## 核心模块
1. 用户模块 (src/main/java/com/example/user/)
2. 商品模块 (src/main/java/com/example/product/)
3. 订单模块 (src/main/java/com/example/order/)

## 主要问题
- [ ] 没有单元测试
- [ ] 代码风格不统一
- [ ] 文档不完整
- [ ] 存在 N+1 查询问题

## 改进优先级
1. 添加测试覆盖
2. 性能优化
3. 代码重构
4. 文档补充
```

### 第二阶段：规范建立（1-2 天）

#### 步骤 1：创建 CLAUDE.md

从现有项目推断规范：

```bash
claude-code . "根据现有代码推断项目的编码规范，并生成 CLAUDE.md"
```

**输出示例：**

```markdown
# XX 系统 Claude Code 规则

## 项目信息
- 项目: XX 系统后端
- 技术栈: Java 21 + Spring Boot 3.x
- 数据库: PostgreSQL

## 代码规范

### 目录结构
```
src/main/java/com/example/
├── config/          # 配置类
├── feature/
│   ├── user/        # 用户模块
│   ├── product/     # 商品模块
│   └── order/       # 订单模块
├── shared/
│   ├── exception/   # 异常定义
│   ├── dto/         # 数据传输对象
│   └── util/        # 工具类
└── domain/          # 领域对象
```

### 命名规范
- 类: PascalCase
- 方法: camelCase
- 常量: UPPER_SNAKE_CASE
- 包: 全小写点分隔

### 依赖注入
- 使用 Constructor Injection
- 禁止 Field Injection
- 使用 Lombok @RequiredArgsConstructor

### 异常处理
- 创建自定义异常类继承 RuntimeException
- 所有异常都要记录日志
- API 返回统一的错误响应格式

### 数据库规范
- 表名: snake_case
- 字段: snake_case
- 每个表必须有 created_at, updated_at
- 添加必要的索引

### 提交规范
格式: type(scope): message

示例:
- feat(user): 添加用户注册功能
- fix(order): 修复订单计算错误
- refactor(product): 优化商品查询性能
- test(user): 添加用户服务单元测试
```

#### 步骤 2：创建上下文索引

```bash
# 生成项目代码索引，便于快速查找
claude-code . "生成项目的代码索引，列出所有主要类和函数"
```

**输出：** `.claude/code-index.md`

```markdown
# 代码索引

## 用户模块
- UserController: src/main/java/com/example/feature/user/UserController.java (第 15 行)
- UserService: src/main/java/com/example/feature/user/UserService.java (第 30 行)
- UserRepository: src/main/java/com/example/feature/user/UserRepository.java

## 商品模块
- ProductController: src/main/java/com/example/feature/product/ProductController.java
- ProductService: src/main/java/com/example/feature/product/ProductService.java

## 共享层
- ErrorResponse: src/main/java/com/example/shared/dto/ErrorResponse.java
- BaseException: src/main/java/com/example/shared/exception/BaseException.java
```

### 第三阶段：逐步改进（1-4 周）

#### 改进优先级

| 优先级 | 任务 | 工作量 | 收益 |
|-------|------|-------|------|
| 🔴 高 | 添加单元测试 | 3-5 天 | 安全重构的基础 |
| 🔴 高 | 性能优化 | 2-3 天 | 立竿见影的收益 |
| 🟡 中 | 代码重构 | 5-7 天 | 提高可维护性 |
| 🟡 中 | 文档补充 | 2-3 天 | 降低学习成本 |
| 🟢 低 | 技术升级 | 5-10 天 | 长期收益 |

#### 步骤 1：添加测试

```bash
# 分析缺失的测试
claude-code . "分析项目中缺失测试的关键模块"

# 生成单元测试
claude-code --subagent=testing . "为 UserService 生成单元测试，覆盖率 >= 80%"

# 运行测试
mvn test

# 检查覆盖率
mvn clean test jacoco:report
```

#### 步骤 2：性能优化

```bash
# 识别性能问题
claude-code . "分析项目中的性能问题，特别是数据库查询"

# 列出所有 N+1 查询问题
claude-code search "for.*stream.*query" \
  && claude-code search "for.*select"

# 优化查询
claude-code --subagent=refactor . "优化 N+1 查询，使用 join 或 batch fetch"

# 运行性能测试
mvn clean test -Dtest=PerformanceTest
```

#### 步骤 3：代码重构

```bash
# 模块化分析
claude-code . "分析代码中的重复和不规范，建议重构方向"

# 逐个模块重构
claude-code --subagent=refactor . "重构用户模块：提取公共方法、简化逻辑"

# 验证功能
mvn test

# 提交
claude-code commit --auto
```

### 第四阶段：持续维护（长期）

#### 建立规范检查

```bash
# 每周检查代码质量
claude-code --subagent=review . "周代码质量检查"

# 定期更新文档
claude-code --subagent=documentation . "更新 API 文档和 README"

# 监控技术债
claude-code . "列出所有 TODO 注释，评估技术债务"
```

## 实战案例：Spring Boot 2.x 升级到 3.x

### 第一步：分析兼容性

```bash
claude-code . "分析升级 Spring Boot 3.x 需要的改动：
- Java 版本要求
- 依赖变化
- API 变化
- 配置变化
"
```

### 第二步：生成升级计划

```bash
claude-code . "生成详细的升级计划，包括：
- 需要修改的文件清单
- 修改前后的代码对比
- 需要运行的测试
- 预期的问题和解决方案
"
```

### 第三步：自动升级

```bash
# 升级依赖
claude-code . "更新 pom.xml，升级 Spring Boot 到 3.x"

# 修复 API 变化
claude-code --subagent=refactor . "修复 Spring Boot 3.x 的 API 变化，特别是：
- javax -> jakarta
- WebSecurityConfigurerAdapter 移除
- 其他破坏性变化
"

# 运行测试
mvn clean test

# 验证功能
npm run dev  # 或启动应用
```

### 第四步：验收

```bash
# 性能对比
claude-code . "对比升级前后的性能数据"

# 功能验收
claude-code . "验收清单：
- [ ] 所有单元测试通过
- [ ] 所有集成测试通过
- [ ] 性能达到预期
- [ ] 文档已更新
"
```

## 迁移检查清单

使用此清单确保迁移的平稳进行：

```markdown
## 项目理解阶段
- [ ] 分析了项目结构
- [ ] 理解了技术栈
- [ ] 创建了项目摘要
- [ ] 识别了主要问题

## 规范建立阶段
- [ ] 创建了 CLAUDE.md
- [ ] 生成了代码索引
- [ ] 建立了 .claudeignore
- [ ] 配置了 MCP 服务

## 改进实施阶段
- [ ] 添加了单元测试
- [ ] 优化了性能
- [ ] 清理了代码
- [ ] 补充了文档

## 验收阶段
- [ ] 所有测试通过
- [ ] 代码审查完成
- [ ] 文档验收
- [ ] 性能验收
```

---

**时间提示：** 本章内容，迁移时间取决于项目规模，通常 2-4 周 ⏱️
