# 11 - 新项目工作流程：从零开始

## 新项目完整工作流程

本章展示如何使用 Claude Code 从头开始开发一个新项目，覆盖需求确认、架构设计、编码、测试、部署等全生命周期。

## 工作流程概览

```
┌──────────────────────────────────────────────────────┐
│ 第一阶段：需求确认 (1-2 小时)                         │
│ - 理解业务需求                                        │
│ - 确认功能列表                                        │
│ - 定义验收标准                                        │
└──────────────────────────────────────────────────────┘
                        ↓
┌──────────────────────────────────────────────────────┐
│ 第二阶段：架构设计 (2-4 小时)                         │
│ - 技术选型                                            │
│ - 系统架构设计                                        │
│ - 数据库设计                                          │
│ - API 设计                                            │
└──────────────────────────────────────────────────────┘
                        ↓
┌──────────────────────────────────────────────────────┐
│ 第三阶段：详细设计 (2-3 小时)                         │
│ - 模块划分                                            │
│ - 类设计                                              │
│ - 接口定义                                            │
│ - 工作流编排                                          │
└──────────────────────────────────────────────────────┘
                        ↓
┌──────────────────────────────────────────────────────┐
│ 第四阶段：编码 (3-5 天)                               │
│ - 项目初始化                                          │
│ - 数据库建表                                          │
│ - 后端开发                                            │
│ - 前端开发                                            │
│ - 联调                                                │
└──────────────────────────────────────────────────────┘
                        ↓
┌──────────────────────────────────────────────────────┐
│ 第五阶段：测试 (1-2 天)                               │
│ - 单元测试                                            │
│ - 集成测试                                            │
│ - 系统测试                                            │
│ - 用户验收测试                                        │
└──────────────────────────────────────────────────────┘
                        ↓
┌──────────────────────────────────────────────────────┐
│ 第六阶段：部署 (0.5-1 天)                             │
│ - 环境准备                                            │
│ - 数据迁移                                            │
│ - 灰度发布                                            │
│ - 上线                                                │
└──────────────────────────────────────────────────────┘
```

## 第一阶段：需求确认

### 步骤 1：需求收集

```bash
# 创建需求文档
mkdir -p docs && touch docs/requirements.md

# 使用 Claude Code 整理需求
claude code . "根据以下需求写出详细的需求文档：
- 功能描述
- 业务流程
- 非功能需求（性能、安全等）
- 验收标准
"
```

**需求文档模板：**

```markdown
# 项目需求文档

## 一、项目概述
- 项目名称：电商管理系统
- 项目目标：提供商家后台管理功能
- 目标用户：店铺运营人员

## 二、核心功能需求
### 1. 商品管理
- [ ] 查看商品列表
- [ ] 添加新商品
- [ ] 编辑商品信息
- [ ] 删除商品
- [ ] 批量操作

### 2. 订单管理
- [ ] 查看订单列表
- [ ] 订单详情
- [ ] 订单状态更新
- [ ] 订单导出

## 三、非功能需求
- 性能：页面响应时间 < 2s
- 安全：支持两因素认证
- 可用性：99.9% 正常时间

## 四、数据量预测
- 用户数：10,000
- 商品数：100,000
- 订单/日：1,000

## 五、验收标准
- 所有功能正常工作
- 测试覆盖率 >= 80%
- 性能测试通过
```

### 步骤 2：需求验证

```bash
# 让 Claude 验证需求的完整性
claude code . "检查这些需求是否完整，有没有遗漏的地方：
- 用户认证和授权
- 错误处理
- 数据备份
- 审计日志
"
```

## 第二阶段：架构设计

### 步骤 1：技术选型

```bash
# 使用 Claude Code 进行技术选型
claude code . --subagent=architect \
  "为一个电商管理系统选型：
  - 前端框架（Vue/React）
  - 后端框架（Spring Boot/Node.js）
  - 数据库（PostgreSQL/MySQL）
  - 缓存（Redis）
  - 消息队列（RabbitMQ/Kafka）

  请考虑性能、成本、学习曲线、社区支持等因素。
  "
```

### 步骤 2：架构设计

```markdown
# 系统架构设计

## 技术选择
- 前端: Vue 3 + TypeScript + Vite
- 后端: Spring Boot 3.x + Java 21
- 数据库: PostgreSQL 15
- 缓存: Redis 7.x
- 消息队列: RabbitMQ

## 架构图

```
┌────────────────────────────────────────┐
│          浏览器 (用户)                   │
└────────────────┬───────────────────────┘
                 │
        ┌────────▼────────┐
        │   前端应用       │
        │ (Vue 3 + TS)    │
        └────────┬────────┘
                 │
        ┌────────▼──────────────┐
        │   API 网关/负载均衡    │
        └────────┬──────────────┘
                 │
      ┌──────────┼──────────┐
      │          │          │
   ┌──▼──┐   ┌──▼──┐   ┌──▼──┐
   │服务1 │   │服务2 │   │服务3 │
   └──┬──┘   └──┬──┘   └──┬──┘
      │        │       │
   ┌──▼─────────▼─────────▼──┐
   │  PostgreSQL 数据库       │
   └───────────────────────────┘

      ┌──────────────────────┐
      │   Redis 缓存层        │
      └──────────────────────┘

      ┌──────────────────────┐
      │   RabbitMQ 队列       │
      └──────────────────────┘
```
```

### 步骤 3：数据库设计

```bash
# 使用 Claude Code 设计数据库
claude code . --subagent=database \
  "设计电商系统的数据库：
  - 用户表
  - 商品表
  - 订单表
  - 订单明细表

  包含字段定义、索引、关系等。
  "
```

**输出示例：**

```sql
-- 用户表
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  username VARCHAR(100) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_username (username),
  INDEX idx_email (email)
);

-- 商品表
CREATE TABLE products (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  stock INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  INDEX idx_user_id (user_id),
  INDEX idx_created_at (created_at)
);

-- 订单表
CREATE TABLE orders (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  status VARCHAR(50) NOT NULL DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  INDEX idx_user_id (user_id),
  INDEX idx_status (status),
  INDEX idx_created_at (created_at)
);
```

### 步骤 4：API 设计

```bash
# 使用 Claude Code 设计 API
claude code . --subagent=api-designer \
  "设计电商系统的 REST API：
  - 用户认证相关 API
  - 商品管理 API
  - 订单管理 API

  包含端点、请求/响应格式、错误处理等。
  "
```

**输出示例：**

```markdown
# API 设计文档

## 基础信息
- 基础 URL: https://api.example.com/api/v1
- 认证: Bearer Token (JWT)
- 内容类型: application/json

## 用户认证相关

### 1. 用户登录
- 端点: POST /auth/login
- 请求:
  ```json
  {
    "username": "user@example.com",
    "password": "password"
  }
  ```
- 响应:
  ```json
  {
    "code": 0,
    "message": "success",
    "data": {
      "token": "eyJhbGc...",
      "user": {
        "id": 1,
        "username": "user@example.com"
      }
    }
  }
  ```

## 商品管理相关

### 1. 获取商品列表
- 端点: GET /products?page=1&size=10
- 认证: 需要 Token
- 响应: 商品列表分页数据

### 2. 创建商品
- 端点: POST /products
- 认证: 需要 Token
- 请求: 商品信息
- 响应: 创建后的商品信息

## 订单管理相关

### 1. 获取订单列表
- 端点: GET /orders?page=1&size=10&status=all
- 认证: 需要 Token
- 响应: 订单列表分页数据

### 2. 创建订单
- 端点: POST /orders
- 认证: 需要 Token
- 请求: 订单信息和商品列表
- 响应: 创建后的订单信息
```

## 第三阶段：详细设计

```bash
# 创建详细设计文档
claude code . --subagent=architect \
  "创建详细设计文档：
  1. 核心模块划分
  2. 关键流程的时序图
  3. 关键功能的设计决策

  输出包括：
  - 模块关系图
  - 时序图
  - 状态机图
  - 设计决策记录
  "
```

## 第四阶段：编码

### 步骤 1：项目初始化

```bash
# 前端项目
npm create vite@latest ecommerce-admin -- --template vue-ts

# 后端项目
mkdir ecommerce-service && cd ecommerce-service
spring boot init --name=ecommerce

# 初始化 Claude Code
claude code init
```

### 步骤 2：设置规则文件

创建完整的 `CLAUDE.md`：

```markdown
# 电商管理系统 Claude Code 规则

## 项目概述
电商商家后台管理系统，Vue 3 + Spring Boot 3.x

## 代码风格
- 前端: Vue 3 Composition API + TypeScript
- 后端: Spring Boot 最佳实践
- 数据库: PostgreSQL
- 测试覆盖率: >= 80%

## 提交规范
- feat: 新功能
- fix: bug 修复
- refactor: 重构
- test: 测试
- docs: 文档

[更详细的规则...]
```

### 步骤 3：后端开发

```bash
# 创建数据库迁移
claude code . --subagent=database \
  "创建数据库迁移文件，创建所有必要的表"

# 创建实体类和 Repository
claude code . --subagent=codegen \
  "创建用户、商品、订单的实体类和 Repository"

# 创建业务逻辑
claude code . --subagent=codegen \
  "创建 UserService、ProductService、OrderService，实现所有业务逻辑"

# 创建 API 端点
claude code . --subagent=codegen \
  "创建 UserController、ProductController、OrderController，实现所有 API 端点"

# 生成文档
claude code . --subagent=documentation \
  "为所有 Controller 生成 Swagger 文档"
```

### 步骤 4：前端开发

```bash
# 创建页面结构
claude code . --subagent=codegen \
  "创建用户管理、商品管理、订单管理页面的基础结构"

# 创建组件
claude code . --subagent=codegen \
  "创建必要的可复用组件（表格、表单、对话框等）"

# 创建状态管理
claude code . --subagent=codegen \
  "创建 Pinia store，管理用户状态、商品列表、订单列表等"

# 创建 API 服务
claude code . --subagent=codegen \
  "创建 API 服务类，定义所有 HTTP 请求"

# 实现页面功能
claude code . --subagent=codegen \
  "实现用户管理、商品管理、订单管理页面的完整功能"
```

### 步骤 5：联调

```bash
# 运行前后端，测试整个流程
claude code . "运行前后端应用，测试以下功能：
- 用户登录
- 商品列表显示
- 商品创建/编辑/删除
- 订单列表显示
- 订单创建

找出并列举所有问题。"
```

## 第五阶段：测试

```bash
# 后端单元测试
claude code . --subagent=testing \
  "为 UserService、ProductService、OrderService 生成完整的单元测试，覆盖率 >= 80%"

# 前端单元测试
claude code . --subagent=testing \
  "为关键组件生成单元测试，覆盖率 >= 80%"

# 集成测试
claude code . --subagent=testing \
  "创建集成测试，测试以下场景：
  - 用户注册流程
  - 商品购买流程
  - 订单支付流程
  "

# 性能测试
claude code . "运行性能测试，检查：
- 列表查询性能（1000+ 条记录）
- 并发请求处理（100+ 并发）
- 内存使用情况
- 缓存命中率
"
```

## 第六阶段：部署

```bash
# 生成部署脚本
claude code . --subagent=devops \
  "生成部署脚本：
  - Docker 镜像
  - Kubernetes 配置
  - 数据库初始化
  - 环境配置
  "

# 灰度发布
claude code . "创建灰度发布计划：
- 第一阶段: 1% 流量
- 第二阶段: 10% 流量
- 第三阶段: 100% 流量

包含监控告警和回滚方案。"
```

## 关键命令速查

```bash
# 初始化新项目
claude code init

# 需求分析
claude code . "分析这些需求..."

# 架构设计
claude code . --subagent=architect "设计系统架构..."

# 代码生成
claude code . --subagent=codegen "创建用户模块..."

# 测试生成
claude code . --subagent=testing "生成单元测试..."

# 代码审查
claude code . --subagent=review "审查代码质量..."

# 文档生成
claude code . --subagent=documentation "生成 API 文档..."

# 提交代码
claude code . "完成用户管理功能，自动提交"
```

## 下一章

👉 **[第 12 章：老项目迁移](12-legacy-project-workflow.md)** - 平滑接入现有项目

---

**时间提示：** 本章阅读 20 分钟，应用 2-3 天（实际项目开发） ⏱️
