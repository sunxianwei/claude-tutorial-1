# 23 - 按岗位使用场景：IT 公司全流程

> 本章节详细说明不同岗位如何使用 Claude Code 提升工作效率

## 目录

1. [产品经理](#1-产品经理)
2. [UI/UX 设计师](#2-uiux-设计师)
3. [前端开发工程师](#3-前端开发工程师)
4. [后端开发工程师](#4-后端开发工程师)
5. [全栈开发工程师](#5-全栈开发工程师)
6. [测试工程师](#6-测试工程师)
7. [DevOps 工程师](#7-devops-工程师)
8. [数据库管理员](#8-数据库管理员)
9. [技术文档工程师](#9-技术文档工程师)
10. [项目经理](#10-项目经理)
11. [架构师](#11-架构师)
12. [安全工程师](#12-安全工程师)

---

## 1. 产品经理

### 核心工作场景

#### 场景 1：需求文档生成

**使用 MCP**: `filesystem`, `git`

```bash
# 配置
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
```

**Prompt 示例**:

```markdown
我需要为"用户权限管理"功能创建产品需求文档（PRD）。

## 背景
我们需要实现细粒度的用户权限控制。

## 要求
请生成包含以下内容的 PRD：

### 1. 功能概述
- 目标用户
- 核心价值
- 业务目标

### 2. 功能需求
- 角色管理
- 权限分配
- 权限检查

### 3. 用户故事
- 作为管理员，我希望...
- 作为普通用户，我希望...

### 4. 验收标准
- 明确的验收条件

### 5. 非功能需求
- 性能要求
- 安全要求

### 6. UI/UX 要点
- 关键页面布局
- 交互流程

### 7. 技术约束
- 兼容性要求
- 依赖系统

请生成完整的 PRD 文档，保存为 docs/prd/user-permission-management.md
```

#### 场景 2：竞品分析文档

**Prompt 示例**:

```markdown
帮我分析三个竞品的用户权限功能，并生成竞品分析报告。

## 竞品列表
1. 产品 A
2. 产品 B
3. 产品 C

## 分析维度
- 功能对比
- 优缺点分析
- 用户体验
- 技术实现（推测）
- 定价策略

请生成 Markdown 对比表格。
```

#### 场景 3：用户故事拆解

**Prompt 示例**:

```markdown
将以下需求拆解为用户故事和验收标准：

需求：实现订单管理功能

请按照以下格式拆解：

## Epic: 订单管理

### Story 1: 查看订单列表
**As a** 用户
**I want to** 查看我的所有订单
**So that** 我可以了解订单状态

**验收标准：**
- [ ] 可以看到订单列表
- [ ] 可以按状态筛选
- [ ] 显示订单关键信息

### Story 2: ...
[继续拆解]
```

#### 场景 4：API 文档审查

**使用 MCP**: `github` (查看代码)

```bash
claude mcp add github -- npx -y @modelcontextprotocol/server-github
export GITHUB_TOKEN="your_token"
```

**Prompt 示例**:

```markdown
审查后端 API 文档，检查是否符合产品需求。

## 审查要点
1. API 接口是否完整
2. 参数定义是否清晰
3. 返回格式是否统一
4. 错误处理是否完善
5. 是否有遗漏的功能

请列出问题清单和改进建议。
```

### 推荐工作流

```
需求收集 → 文档生成 → 用户故事 → 验收标准 → API 审查 → 迭代优化
```

---

## 2. UI/UX 设计师

### 核心工作场景

#### 场景 1：设计系统文档

**使用 MCP**: `filesystem`

**Prompt 示例**:

```markdown
帮我创建设计系统文档。

## 内容包括

### 1. 颜色规范
- 主色调
- 辅助色
- 状态色
- 中性色

### 2. 字体规范
- 字体家族
- 字号体系
- 行高规范
- 字重使用

### 3. 间距规范
- 基准间距
- 间距倍数
- 使用场景

### 4. 组件规范
- 按钮
- 表单
- 卡片
- 导航

请生成 Markdown 文档，包含代码示例。
```

#### 场景 2：页面布局代码生成

**Prompt 示例**:

```markdown
根据我的线框图描述，生成 HTML/CSS 布局代码。

## 页面描述
- 顶部导航栏（固定）
- 左侧边栏（200px）
- 主内容区（自适应）
- 底部版权信息

## 要求
- 响应式设计
- 使用 Flexbox
- 符合设计系统规范
- 提供移动端适配方案

请生成完整的 HTML 和 CSS 代码。
```

#### 场景 3：设计审查清单

**Prompt 示例**:

```markdown
生成 UI 设计审查清单。

包含：
- 视觉一致性
- 交互反馈
- 可访问性
- 响应式设计
- 性能考虑
- 品牌一致性

每项包含具体检查点。
```

### 推荐工作流

```
设计系统 → 原型代码 → 组件库文档 → 设计审查
```

---

## 3. 前端开发工程师

### 核心工作场景

#### 场景 1：组件开发

**使用 MCP**: `filesystem`, `git`, `context7`

```bash
# 配置
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
claude mcp add context7 -- npx -y @upstash/context7-mcp
```

**Prompt 示例**:

```markdown
创建一个 Vue 3 数据表格组件。

## 功能需求
- 支持排序
- 支持筛选
- 支持分页
- 支持自定义列
- 支持行选择

## 技术要求
- Vue 3 Composition API
- TypeScript
- 响应式设计
- 单元测试（Vitest）

## 文件结构
src/components/DataTable/
├── DataTable.vue
├── types.ts
├── hooks/
│   ├── useSort.ts
│   ├── useFilter.ts
│   └── usePagination.ts
└── __tests__/
    └── DataTable.spec.ts

请生成完整代码。
```

#### 场景 2：API 集成

**Prompt 示例**:

```markdown
创建用户管理模块的 API 服务。

## API 接口
- GET /api/users - 获取用户列表
- GET /api/users/:id - 获取用户详情
- POST /api/users - 创建用户
- PUT /api/users/:id - 更新用户
- DELETE /api/users/:id - 删除用户

## 技术要求
- 使用 Axios
- 统一错误处理
- 请求/响应拦截器
- TypeScript 类型定义
- 单元测试

生成 api/user.ts 和测试文件。
```

#### 场景 3：状态管理

**Prompt 示例**:

```markdown
使用 Pinia 创建用户状态管理。

## 状态
- userInfo
- isLoggedIn
- permissions

## Actions
- login()
- logout()
- fetchUserInfo()
- updatePermissions()

## Getters
- isAdmin
- hasPermission(permission)

请生成完整的 store 代码。
```

#### 场景 4：E2E 测试

**使用 MCP**: `playwright`

```bash
claude mcp add playwright -- npx -y @automatalabs/mcp-server-playwright
```

**Prompt 示例**:

```markdown
使用 Playwright 为用户登录流程创建 E2E 测试。

## 测试场景
1. 成功登录
2. 用户名错误
3. 密码错误
4. 记住我功能
5. 登出功能

## 要求
- 使用 Page Object 模式
- 包含等待和断言
- 错误截图
- 生成测试报告

生成完整的测试代码。
```

#### 场景 5：性能优化

**使用 MCP**: `context7` (查询最佳实践)

**Prompt 示例**:

```markdown
分析并优化前端性能。

## 检查项目
- 组件懒加载
- 图片优化
- 代码分割
- 缓存策略
- 包大小分析

使用 Context7 查询 Vue 3 性能优化最佳实践，然后：
1. 分析当前项目
2. 找出性能瓶颈
3. 提供优化方案
4. 实施关键优化
```

### 推荐 MCP 配置

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
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@automatalabs/mcp-server-playwright"]
    }
  }
}
```

### 推荐工作流

```
需求分析 → 组件设计 → 代码实现 → 单元测试 → E2E 测试 → 性能优化 → 代码审查
```

---

## 4. 后端开发工程师

### 核心工作场景

#### 场景 1：API 开发

**使用 MCP**: `filesystem`, `git`, `postgres`

```bash
# 配置
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres

# 设置数据库连接
export POSTGRES_CONNECTION_STRING="postgresql://localhost/mydb"
```

**Prompt 示例**:

```markdown
创建用户管理 REST API（Spring Boot）。

## 技术栈
- Spring Boot 2.7
- MyBatis
- MySQL
- JWT 认证

## API 接口
- POST /api/auth/login - 用户登录
- POST /api/auth/register - 用户注册
- GET /api/users - 获取用户列表（分页）
- GET /api/users/{id} - 获取用户详情
- PUT /api/users/{id} - 更新用户
- DELETE /api/users/{id} - 删除用户

## 要求
- RESTful 设计
- 统一返回格式
- 参数验证
- 异常处理
- Swagger 文档
- 单元测试（JUnit 5）

## 文件结构
src/main/java/com/example/
├── controller/
│   └── UserController.java
├── service/
│   ├── UserService.java
│   └── impl/
│       └── UserServiceImpl.java
├── mapper/
│   └── UserMapper.java
├── entity/
│   └── User.java
├── dto/
│   ├── LoginDTO.java
│   └── UserDTO.java
└── vo/
    └── UserVO.java

请生成完整代码。
```

#### 场景 2：数据库设计

**使用 MCP**: `postgres`

**Prompt 示例**:

```markdown
设计电商系统的数据库。

## 主要表
- 用户表
- 商品表
- 订单表
- 订单详情表
- 购物车表

## 要求
1. 生成建表 SQL
2. 添加索引
3. 添加外键约束
4. 添加注释
5. 生成 ER 图的 Mermaid 代码

请生成完整的数据库设计文档和 SQL。
```

#### 场景 3：性能优化

**使用 MCP**: `postgres`

**Prompt 示例**:

```markdown
优化以下慢查询：

```sql
SELECT o.*, u.name, p.title
FROM orders o
LEFT JOIN users u ON o.user_id = u.id
LEFT JOIN products p ON o.product_id = p.id
WHERE o.status = 'pending'
ORDER BY o.create_time DESC
LIMIT 100;
```

## 表信息
- orders: 100万条记录
- users: 10万条记录
- products: 5万条记录

## 当前问题
- 执行时间：3.5秒
- 没有使用索引

请提供：
1. 问题分析
2. 索引建议
3. SQL 优化方案
4. 预期性能提升
```

#### 场景 4：微服务开发

**Prompt 示例**:

```markdown
创建订单服务（Spring Cloud 微服务）。

## 服务功能
- 创建订单
- 查询订单
- 更新订单状态
- 取消订单

## 技术要求
- Spring Cloud
- Eureka 服务注册
- Feign 服务调用
- Hystrix 熔断
- Config 配置中心

## 依赖服务
- 用户服务
- 商品服务
- 支付服务

请生成完整的微服务项目结构和代码。
```

#### 场景 5：单元测试

**Prompt 示例**:

```markdown
为 UserService 生成完整的单元测试。

## 测试范围
- 用户注册（正常、用户名重复）
- 用户登录（正常、密码错误、用户不存在）
- 获取用户信息
- 更新用户信息

## 技术要求
- JUnit 5
- Mockito
- @SpringBootTest
- 测试覆盖率 > 80%

生成完整的测试类。
```

### 推荐 MCP 配置

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
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "${DATABASE_URL}"
      }
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

### 推荐工作流

```
API 设计 → 数据库设计 → 代码实现 → 单元测试 → 集成测试 → 性能优化 → API 文档
```

---

## 5. 全栈开发工程师

### 核心工作场景

#### 场景 1：全栈功能开发

**使用 MCP**: `filesystem`, `git`, `postgres`, `context7`, `playwright`

**完整配置**:

```bash
# 基础配置
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .

# 数据库
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres

# 文档查询
claude mcp add context7 -- npx -y @upstash/context7-mcp

# E2E 测试
claude mcp add playwright -- npx -y @automatalabs/mcp-server-playwright

# 代码托管
claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

**Prompt 示例**:

```markdown
完整实现"文章发布"功能（前后端 + 测试）。

## 需求
用户可以发布文章，包括标题、内容、封面图、分类、标签。

## 技术栈
- 后端：Spring Boot + MyBatis + MySQL
- 前端：Vue 3 + Element Plus
- 测试：JUnit 5 + Playwright

## 实现要求

### 后端
1. 数据库表设计
2. REST API 实现
3. 图片上传（OSS）
4. 单元测试

### 前端
1. 文章编辑器（富文本）
2. 图片上传组件
3. 表单验证
4. 状态管理

### 测试
1. 后端单元测试
2. 前端组件测试
3. E2E 测试（完整发布流程）

请分步骤实现：
1. 数据库设计
2. 后端 API
3. 前端页面
4. 集成测试
```

#### 场景 2：项目脚手架

**Prompt 示例**:

```markdown
创建全栈项目脚手架。

## 项目结构
```
fullstack-app/
├── backend/          # Spring Boot
│   ├── src/
│   ├── pom.xml
│   └── README.md
├── frontend/         # Vue 3
│   ├── src/
│   ├── package.json
│   └── README.md
├── docker-compose.yml
├── .gitignore
└── README.md
```

## 功能包含
- 用户认证
- 权限管理
- 日志系统
- 异常处理
- 文件上传
- 邮件发送

请生成完整的项目模板。
```

### 推荐工作流

```
需求分析 → 数据库设计 → 后端 API → 前端页面 → 联调测试 → E2E 测试 → 部署上线
```

---

## 6. 测试工程师

### 核心工作场景

#### 场景 1：测试用例生成

**使用 MCP**: `filesystem`, `git`

**Prompt 示例**:

```markdown
为用户登录功能生成测试用例。

## 功能描述
用户通过用户名和密码登录系统。

## 测试维度
- 功能测试
- 边界值测试
- 异常测试
- 安全测试
- 性能测试

## 输出格式
| 用例ID | 用例名称 | 前置条件 | 测试步骤 | 预期结果 | 优先级 |
|--------|---------|---------|---------|---------|-------|
| TC001 | ... | ... | ... | ... | P0 |

请生成完整的测试用例矩阵。
```

#### 场景 2：自动化测试脚本

**使用 MCP**: `playwright`

```bash
claude mcp add playwright -- npx -y @automatalabs/mcp-server-playwright
```

**Prompt 示例**:

```markdown
使用 Playwright 创建自动化测试套件。

## 测试场景
1. 用户注册流程
2. 用户登录流程
3. 密码找回流程
4. 个人信息修改
5. 账号注销

## 要求
- Page Object 模式
- 数据驱动测试
- 失败重试机制
- 截图和视频记录
- 生成 HTML 报告

生成完整的测试代码和配置。
```

#### 场景 3：API 测试

**Prompt 示例**:

```markdown
为用户管理 API 创建 Postman/Rest Assured 测试。

## API 列表
- POST /api/users/register
- POST /api/users/login
- GET /api/users/{id}
- PUT /api/users/{id}
- DELETE /api/users/{id}

## 测试内容
- 正常场景
- 异常场景
- 参数验证
- 权限验证
- 性能测试

生成完整的 API 测试代码（Rest Assured / Java）。
```

#### 场景 4：性能测试脚本

**Prompt 示例**:

```markdown
使用 JMeter 创建性能测试脚本。

## 测试接口
- POST /api/orders/create

## 性能指标
- 并发用户：1000
- 持续时间：30分钟
- 响应时间：< 500ms (95%)
- 错误率：< 0.1%

请生成：
1. JMeter 测试计划（JMX）
2. 测试数据准备脚本
3. 结果分析报告模板
```

#### 场景 5：测试报告生成

**Prompt 示例**:

```markdown
生成测试报告。

## 测试信息
- 项目：电商管理系统 v2.0
- 测试周期：2025-01-01 至 2025-01-15
- 测试类型：功能测试、性能测试
- 测试用例总数：150
- 通过：145
- 失败：5
- 阻塞：0

## 报告内容
1. 测试概述
2. 测试执行情况
3. 缺陷统计
4. 风险评估
5. 建议和总结

请生成完整的测试报告（Markdown格式）。
```

### 推荐 MCP 配置

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
      "args": ["-y", "@automatalabs/mcp-server-playwright"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

### 推荐工作流

```
需求分析 → 用例设计 → 自动化脚本 → 执行测试 → 缺陷跟踪 → 测试报告
```

---

## 7. DevOps 工程师

### 核心工作场景

#### 场景 1：CI/CD 流水线

**使用 MCP**: `git`, `github`/`gitlab`

```bash
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

**Prompt 示例**:

```markdown
创建完整的 CI/CD 流水线（GitHub Actions）。

## 流程
1. 代码推送触发
2. 代码检查（Lint）
3. 单元测试
4. 构建镜像
5. 推送到镜像仓库
6. 部署到测试环境
7. 自动化测试
8. 部署到生产环境（需审批）

## 技术栈
- GitHub Actions
- Docker
- Kubernetes
- Helm

生成完整的 .github/workflows/ci-cd.yml 文件。
```

#### 场景 2：Docker 配置

**Prompt 示例**:

```markdown
为前后端项目创建 Docker 配置。

## 服务
- 后端：Spring Boot
- 前端：Vue 3 (Nginx)
- 数据库：MySQL
- 缓存：Redis

## 要求
1. Dockerfile（前端、后端）
2. docker-compose.yml
3. 多阶段构建
4. 健康检查
5. 日志配置
6. 网络配置

生成完整的 Docker 配置文件。
```

#### 场景 3：Kubernetes 部署

**Prompt 示例**:

```markdown
创建 Kubernetes 部署配置。

## 服务
- 后端服务（3个副本）
- 前端服务（2个副本）
- MySQL（StatefulSet）
- Redis（StatefulSet）

## 资源对象
- Deployment
- Service
- ConfigMap
- Secret
- Ingress
- PersistentVolumeClaim

生成完整的 k8s yaml 文件。
```

#### 场景 4：监控告警

**Prompt 示例**:

```markdown
配置 Prometheus + Grafana 监控。

## 监控指标
- 应用性能（JVM、响应时间）
- 系统资源（CPU、内存、磁盘）
- 业务指标（订单量、用户数）

## 告警规则
- CPU > 80%
- 内存 > 90%
- 错误率 > 1%
- 响应时间 > 1s

生成：
1. Prometheus 配置
2. 告警规则
3. Grafana Dashboard JSON
```

#### 场景 5：自动化运维脚本

**Prompt 示例**:

```markdown
创建运维自动化脚本。

## 功能
1. 服务健康检查
2. 自动重启异常服务
3. 日志清理
4. 数据库备份
5. 磁盘空间监控

## 要求
- Bash 脚本
- 定时任务（Cron）
- 邮件通知
- 日志记录

生成完整的运维脚本套件。
```

### 推荐 MCP 配置

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
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

### 推荐工作流

```
环境搭建 → CI/CD 配置 → 容器化 → 部署上线 → 监控告警 → 持续优化
```

---

## 8. 数据库管理员

### 核心工作场景

#### 场景 1：数据库设计优化

**使用 MCP**: `postgres`

```bash
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres
export POSTGRES_CONNECTION_STRING="postgresql://localhost/mydb"
```

**Prompt 示例**:

```markdown
优化数据库设计。

## 当前问题
- 查询慢
- 数据冗余
- 缺少索引

## 优化要求
1. 分析表结构
2. 识别性能瓶颈
3. 提出优化方案
4. 生成优化 SQL

## 表信息
[提供 SHOW CREATE TABLE 输出]

请提供详细的优化方案。
```

#### 场景 2：数据库迁移

**Prompt 示例**:

```markdown
创建数据库版本迁移脚本（Flyway）。

## 变更内容
1. 添加 user_profile 表
2. 修改 users 表（添加字段）
3. 创建索引
4. 数据迁移

## 要求
- Flyway 格式
- 可回滚
- 包含验证 SQL

生成完整的迁移脚本。
```

#### 场景 3：数据备份恢复

**Prompt 示例**:

```markdown
创建数据库备份和恢复脚本。

## 要求
1. 全量备份脚本
2. 增量备份脚本
3. 自动化定时任务
4. 备份验证
5. 恢复脚本
6. 邮件通知

## 环境
- PostgreSQL 14
- Linux
- 保留 7 天备份

生成完整的备份方案和脚本。
```

### 推荐 MCP 配置

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "${DATABASE_URL}"
      }
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "git": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-git", "--repository", "."]
    }
  }
}
```

---

## 9. 技术文档工程师

### 核心工作场景

#### 场景 1：API 文档生成

**使用 MCP**: `filesystem`, `git`, `github`

**Prompt 示例**:

```markdown
为后端 API 生成完整文档。

## 文档内容
1. API 概述
2. 认证说明
3. 接口列表
4. 请求示例
5. 响应示例
6. 错误码说明
7. 更新日志

## 格式要求
- Markdown
- OpenAPI/Swagger 规范
- 代码示例（多语言）

请分析代码并生成完整的 API 文档。
```

#### 场景 2：用户手册

**Prompt 示例**:

```markdown
创建产品用户手册。

## 目标用户
普通用户（非技术人员）

## 内容结构
1. 快速开始
2. 功能介绍
3. 操作指南
4. 常见问题
5. 故障排查
6. 联系支持

## 要求
- 图文并茂
- 步骤清晰
- 通俗易懂

生成完整的用户手册框架和内容。
```

#### 场景 3：架构文档

**Prompt 示例**:

```markdown
生成系统架构文档。

## 内容包括
1. 系统概述
2. 架构设计
   - 系统架构图
   - 技术栈
   - 模块划分
3. 数据流图
4. 部署架构
5. 安全设计
6. 性能优化

## 图表要求
使用 Mermaid 语法生成：
- 架构图
- 时序图
- ER 图

生成完整的架构文档。
```

### 推荐工作流

```
需求理解 → 文档框架 → 内容编写 → 图表制作 → 审核发布 → 持续更新
```

---

## 10. 项目经理

### 核心工作场景

#### 场景 1：项目计划

**使用 MCP**: `filesystem`, `git`, `github`

**Prompt 示例**:

```markdown
创建项目计划。

## 项目信息
- 项目名称：电商小程序 v2.0
- 开始时间：2025-02-01
- 预计完成：2025-04-30
- 团队规模：10人

## 需求清单
1. 用户系统升级
2. 支付系统改造
3. 订单系统优化
4. 数据分析功能

## 输出要求
1. WBS（工作分解结构）
2. 甘特图（Mermaid）
3. 里程碑
4. 风险评估
5. 资源分配

生成完整的项目计划文档。
```

#### 场景 2：任务分配

**使用 MCP**: `github` (创建 Issues)

**Prompt 示例**:

```markdown
根据项目计划创建 GitHub Issues。

## 功能列表
[粘贴功能清单]

## Issue 要求
- 清晰的标题
- 详细的描述
- 验收标准
- 优先级标签
- 负责人
- 预估工时

生成所有 Issues 的内容，我将创建到 GitHub。
```

#### 场景 3：进度报告

**Prompt 示例**:

```markdown
生成项目周报。

## 本周完成
- 用户注册功能（100%）
- 商品列表（80%）

## 下周计划
- 完成商品列表
- 开始购物车功能

## 风险和问题
- 第三方支付接口对接延迟

## 数据统计
- 完成任务：15
- 进行中：8
- 未开始：12

生成完整的项目周报。
```

### 推荐工作流

```
项目立项 → 需求分析 → 计划制定 → 任务分配 → 进度跟踪 → 风险管理 → 项目总结
```

---

## 11. 架构师

### 核心工作场景

#### 场景 1：系统设计

**使用 MCP**: `context7` (查询最佳实践)

**Prompt 示例**:

```markdown
设计电商系统架构。

## 业务需求
- 支持 1000万 DAU
- 高并发秒杀
- 实时库存
- 分布式事务

## 技术约束
- 云原生架构
- 微服务
- 容器化部署

## 设计内容
1. 整体架构设计
2. 服务拆分
3. 数据架构
4. 缓存策略
5. 消息队列
6. 高可用方案
7. 监控体系

请使用 Context7 查询最佳实践，然后生成完整的架构设计文档，包含 Mermaid 架构图。
```

#### 场景 2：技术选型

**使用 MCP**: `context7`

**Prompt 示例**:

```markdown
进行技术选型分析。

## 场景
需要选择 API 网关

## 候选方案
1. Kong
2. Nginx + Lua
3. Spring Cloud Gateway
4. Traefik

## 评估维度
- 性能
- 功能
- 可扩展性
- 运维复杂度
- 社区支持
- 成本

请使用 Context7 查询各方案的详细信息，然后生成对比分析报告和选型建议。
```

#### 场景 3：代码审查

**Prompt 示例**:

```markdown
从架构角度审查代码。

## 审查维度
1. 架构一致性
2. 设计模式应用
3. 代码耦合度
4. 可扩展性
5. 性能考虑
6. 安全漏洞

## 代码路径
src/services/order/

请深入分析并提供改进建议。
```

### 推荐工作流

```
需求分析 → 架构设计 → 技术选型 → 原型验证 → 文档输出 → 技术评审 → 持续优化
```

---

## 12. 安全工程师

### 核心工作场景

#### 场景 1：安全审查

**使用 MCP**: `filesystem`, `git`

**Prompt 示例**:

```markdown
进行安全代码审查。

## 审查范围
src/controllers/
src/services/auth/

## 检查项目
1. SQL 注入
2. XSS 漏洞
3. CSRF 防护
4. 敏感信息泄露
5. 权限验证
6. 加密算法
7. 会话管理

请扫描代码并生成安全审查报告。
```

#### 场景 2：安全策略

**Prompt 示例**:

```markdown
制定应用安全策略。

## 内容包括
1. 认证策略
   - 密码复杂度
   - 多因素认证
   - Session 管理

2. 授权策略
   - RBAC 实现
   - API 权限控制

3. 数据安全
   - 敏感数据加密
   - 传输加密（HTTPS）
   - 数据脱敏

4. 日志审计
   - 操作日志
   - 安全事件日志

5. 应急响应
   - 事件分类
   - 响应流程

生成完整的安全策略文档。
```

#### 场景 3：渗透测试计划

**Prompt 示例**:

```markdown
创建渗透测试计划。

## 测试范围
- Web 应用
- API 接口
- 移动应用

## 测试内容
1. 信息收集
2. 漏洞扫描
3. 权限测试
4. 注入测试
5. 业务逻辑漏洞

## 工具
- OWASP ZAP
- Burp Suite
- Sqlmap

生成详细的测试计划和检查清单。
```

---

## 总结：按角色推荐的 MCP 配置

### 最小配置（所有角色）

```bash
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
```

### 开发角色

```bash
# 基础配置
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .

# 文档查询
claude mcp add context7 -- npx -y @upstash/context7-mcp

# 代码托管
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# 数据库（后端）
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres

# E2E 测试（前端/测试）
claude mcp add playwright -- npx -y @automatalabs/mcp-server-playwright
```

### 管理角色（PM/TPM）

```bash
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

---

## IT 公司全流程覆盖

```
产品规划（PM）
    ↓
需求设计（PM + Designer）
    ↓
技术评审（Architect）
    ↓
任务分解（PM + Tech Lead）
    ↓
开发实现（Developer）
    ↓
代码审查（Tech Lead/Architect）
    ↓
测试验证（QA）
    ↓
部署上线（DevOps）
    ↓
监控运维（DevOps + DBA）
    ↓
安全审计（Security）
    ↓
文档归档（Technical Writer）
    ↓
迭代优化（All）
```

每个环节都可以使用 Claude Code 配合相应的 MCP 服务器来提升效率！

---

**🎯 选择适合你岗位的配置，开始高效工作吧！**
