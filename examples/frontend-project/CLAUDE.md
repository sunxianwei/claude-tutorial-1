# 项目规范文件

> 本文件定义了本项目使用 Claude Code 时的规范和约定

## 代码风格

### TypeScript/JavaScript
- 使用 TypeScript 严格模式
- 2 空格缩进
- 使用单引号（字符串）
- 函数和变量使用驼峰命名
- 组件使用 PascalCase 命名
- 文件名使用 kebab-case

### 代码注释
- 所有公共 API 必须有 JSDoc 注释
- 复杂逻辑必须添加说明注释
- 注释使用中文

## 组件规范

### Vue 组件
- 使用 Composition API
- 使用 `<script setup>` 语法
- Props 必须定义类型
- Emit 事件必须声明类型
- 组件必须有单文件测试

### 组件结构顺序
```vue
<template>
  <!-- 模板 -->
</template>

<script setup lang="ts">
// 1. 导入
// 2. Props/Emits 定义
// 3. 响应式状态
// 4. 计算属性
// 5. 方法
// 6. 生命周期钩子
</script>

<style scoped lang="scss">
/* 样式 */
</style>
```

## 测试要求

- 最低测试覆盖率: 80%
- 所有组件必须有单元测试
- 关键业务逻辑必须有集成测试
- 使用 Vitest 进行测试

## Git 提交规范

使用 Conventional Commits:

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type 类型
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `style`: 代码格式（不影响代码运行）
- `refactor`: 重构
- `test`: 测试相关
- `chore`: 构建过程或辅助工具变动

### 示例
```
feat(user): 添加用户列表分页功能

- 实现分页查询
- 添加页码组件
- 更新 API 接口

Closes #123
```

## API 规范

### 命名约定
- 使用 RESTful 风格
- URL 使用小写和连字符
- 返回数据使用驼峰命名

### 错误处理
- 统一使用 try-catch
- 使用 ElMessage 显示错误
- 记录错误日志

## 性能优化

- 大列表使用虚拟滚动
- 图片使用懒加载
- 组件使用异步加载
- 合理使用 computed 和 watch

## Claude Code 使用约定

### 提示词模板

**创建组件:**
```
创建一个 [组件名] 组件，功能包括：
- [功能1]
- [功能2]
要求: TypeScript、响应式设计、包含单元测试
```

**添加功能:**
```
为 [组件名] 添加 [功能描述]
要求: 遵循项目规范、更新测试用例
```

**Bug 修复:**
```
修复 [组件名] 中的 [问题描述]
要求: 保持代码风格一致、添加回归测试
```

## 依赖管理

- 优先使用 npm
- 定期更新依赖（每月）
- 新增依赖需要团队评审

## 工具配置

- 使用 ESLint 进行代码检查
- 使用 Prettier 进行代码格式化
- 使用 Husky 进行 Git Hooks

---

**最后更新**: 2025-01-20
**维护者**: 开发团队
