# 快速开始：新项目 vs 老项目

## 🆕 新项目开发

### 完整案例：在线图书管理系统

**项目地址**: [examples/new-project-demo/](examples/new-project-demo/)

**技术栈**:
- 后端：Spring Boot 2.7 + JDK 1.8 + MyBatis + MySQL
- 前端：Vue 3 + Element Plus + Axios
- 测试：JUnit 5 + Playwright

**快速开始**:

```bash
# 1. 创建项目目录
mkdir book-management-system
cd book-management-system

# 2. 初始化 Claude Code
claude code init

# 3. 配置 MCP
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
claude mcp add playwright -- npx -y mcp-server-playwright

# 4. 启动 Claude Code
claude code .

# 5. 复制项目 Prompt
# 从 examples/new-project-demo/README.md 复制完整的开发 Prompt

# 6. 粘贴到 Claude Code 并开始开发
```

**包含功能**:
- ✅ 用户认证（登录/注册）
- ✅ 图书管理（增删改查）
- ✅ 借阅管理
- ✅ 后端 API + 前端页面
- ✅ 单元测试（覆盖率 > 80%）
- ✅ E2E 测试（Playwright）
- ✅ API 文档（Swagger）

**预计开发时间**: 30 分钟

**详细指南**: 查看 [examples/new-project-demo/README.md](examples/new-project-demo/README.md)

---

## 🔧 老项目开发

### 详细指南

**文档地址**: [docs/21-legacy-project-guide.md](docs/21-legacy-project-guide.md)

### 核心步骤

#### 1. 准备工作（10 分钟）

```bash
# 1. 创建开发分支
git checkout -b feature/claude-code-integration

# 2. 备份当前状态
git add .
git commit -m "feat: 准备接入 Claude Code"

# 3. 初始化 Claude Code
claude code init

# 4. 配置 MCP
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add git -- npx -y @modelcontextprotocol/server-git --repository .
```

#### 2. 项目分析（20 分钟）

**启动 Claude Code**:
```bash
claude code .
```

**使用分析 Prompt**（复制以下内容）:

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

现在开始分析吧！
```

#### 3. 创建项目规范（30 分钟）

基于分析结果，创建 `CLAUDE.md`。

**模板**: 查看 [docs/21-legacy-project-guide.md](docs/21-legacy-project-guide.md#创建项目规范文件)

**关键内容**:
- ✅ 现有代码的命名规范
- ✅ 项目结构说明
- ✅ 依赖使用规范
- ✅ 特殊约定和注意事项
- ✅ 代码示例（重要！）

#### 4. 渐进式接入（持续）

**策略 1: 按模块接入**
```
选择独立模块 → 完善规范 → 新功能使用 Claude → 积累经验 → 推广
```

**策略 2: 按任务类型接入**
```
简单任务（文档、测试）→ 中等难度（CRUD）→ 复杂任务（核心业务）
```

**策略 3: 双轨制运行**
```
核心开发者先行 → 建立规范 → 培训团队 → 逐步推广
```

### 常见场景 Prompt

#### 场景 1：添加新功能

```markdown
请为本项目开发 [功能描述]。

⚠️ 重要：这是一个老项目，请遵循以下规范：

## 必须遵守的规则

1. **命名规范**
   [根据你的项目填写]

2. **依赖使用**
   [根据你的项目填写]

3. **返回结果**
   [根据你的项目填写]

## 功能需求
[详细描述]

## 实现要求
1. 保持与现有代码风格一致
2. 添加必要的注释
3. 编写单元测试

请开始开发。
```

#### 场景 2：修复 Bug

```markdown
请修复以下 Bug：

## Bug 描述
[详细描述]

## 修复要求

⚠️ 这是 Bug 修复，请注意：
1. 最小化修改
2. 保持原有代码风格
3. 不改变方法签名
4. 充分测试

请开始修复。
```

#### 场景 3：代码重构

```markdown
我想重构 [模块/类/方法]。

## 重构步骤

### 阶段 1：分析现状
### 阶段 2：编写测试
### 阶段 3：执行重构
### 阶段 4：验证结果

⚠️ 重要：小步重构，频繁测试！

请开始重构。
```

### 最佳实践

1. **✅ 充分分析** - 深入理解现有代码
2. **✅ 详细规范** - 创建完善的 CLAUDE.md
3. **✅ 小步前进** - 渐进式接入，不要激进
4. **✅ 测试保障** - 先测试后修改
5. **✅ 持续优化** - 不断改进规范和流程

### 常见问题

**Q: Claude 生成的代码风格与项目不一致？**
A: 在 CLAUDE.md 中增加更多代码示例。

**Q: Claude 修改了不应该修改的文件？**
A: 明确指定修改范围："请只修改 UserController.java"。

**Q: 生成的代码破坏了现有功能？**
A: 回滚代码，先补充测试，再进行修改。

**Q: 不知道如何描述需求？**
A: 使用结构化的 Prompt（需求、背景、验收标准）。

**Q: Claude 对项目理解不准确？**
A: 提供更多上下文，参考现有的正确实现。

---

## 对比总结

| 特性 | 新项目 | 老项目 |
|-----|--------|--------|
| **开发速度** | 🚀 极快 | 🐢 较慢 |
| **规范遵循** | ✅ 容易 | ⚠️ 需要适配 |
| **风险** | ✅ 低 | ⚠️ 中高 |
| **测试要求** | ✅ 标准 | 🔴 更严格 |
| **文档需求** | ✅ 标准 | 🔴 更详细 |
| **学习曲线** | ✅ 平缓 | ⚠️ 陡峭 |
| **推荐策略** | 一步到位 | 渐进接入 |

---

## 选择建议

### 适合立即使用新项目方式：

- ✅ 正在启动新项目
- ✅ 项目没有历史包袱
- ✅ 团队对新技术开放
- ✅ 时间充裕

### 适合使用老项目方式：

- ✅ 已有成熟项目
- ✅ 不能大规模重构
- ✅ 需要保持兼容性
- ✅ 团队成员技能差异大

---

## 下一步

### 新项目开发者

👉 直接查看 [新项目演示案例](examples/new-project-demo/README.md)

### 老项目维护者

👉 仔细阅读 [老项目开发详细指南](docs/21-legacy-project-guide.md)

---

**开始你的 Claude Code 之旅吧！** 🚀
