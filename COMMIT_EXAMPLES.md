# BiliTools 项目 Commit 消息示例

## 🔄 项目迁移相关

```bash
# 包管理器迁移
git commit -m "build: 从 npm 迁移到 pnpm"

# 配置文件添加
git commit -m "config: 添加 pnpm 配置文件"

# 依赖安装
git commit -m "deps: 使用 pnpm 重新安装依赖"
```

## 📦 依赖更新相关

```bash
# 安全更新
git commit -m "deps: 修复安全漏洞"

# Vue 更新
git commit -m "deps: 更新 Vue 到 3.5.17"

# Vite 主版本更新
git commit -m "deps!: 更新 Vite 到 7.x"

# Tauri 更新
git commit -m "deps: 更新 Tauri 相关依赖"

# 开发依赖更新
git commit -m "deps(dev): 更新开发依赖"
```

## 🔧 配置相关

```bash
# 窗口配置
git commit -m "config(tauri): 优化窗口大小和可调整性"

# 构建配置
git commit -m "config(build): 更新 Vite 构建配置"

# TypeScript 配置
git commit -m "config(ts): 更新 TypeScript 配置"

# 环境变量配置
git commit -m "config: 添加开发环境变量配置"
```

## 🚀 功能开发相关

```bash
# 新功能
git commit -m "feat(ui): 添加用户头像上传功能"

# API 相关
git commit -m "feat(api): 添加视频下载 API"

# 前端功能
git commit -m "feat(frontend): 添加下载进度显示"

# 后端功能
git commit -m "feat(backend): 添加文件压缩功能"
```

## 🐛 Bug 修复相关

```bash
# UI 问题
git commit -m "fix(ui): 修复按钮样式在暗色模式下的显示问题"

# 功能问题
git commit -m "fix(download): 修复大文件下载中断问题"

# 兼容性问题
git commit -m "fix(compatibility): 修复 Windows 路径分隔符问题"

# 性能问题
git commit -m "fix(perf): 修复内存泄漏问题"
```

## 📚 文档相关

```bash
# README 更新
git commit -m "docs: 更新 README 安装说明"

# 贡献指南
git commit -m "docs: 添加贡献指南"

# API 文档
git commit -m "docs(api): 更新 API 文档"

# 更新日志
git commit -m "docs: 添加依赖更新日志"
```

## 🏗️ 构建和部署相关

```bash
# 构建系统
git commit -m "build: 优化构建性能"

# CI/CD
git commit -m "ci: 添加自动化测试流程"

# 发布相关
git commit -m "build: 准备 v1.4.1 版本发布"

# 环境配置
git commit -m "build: 添加 Docker 配置"
```

## 🧪 测试相关

```bash
# 单元测试
git commit -m "test: 添加用户认证模块测试"

# 集成测试
git commit -m "test: 添加下载功能集成测试"

# 测试配置
git commit -m "test: 配置测试环境"
```

## 🔄 重构相关

```bash
# 代码重构
git commit -m "refactor(auth): 重构用户认证逻辑"

# 文件结构调整
git commit -m "refactor: 调整项目目录结构"

# 组件重构
git commit -m "refactor(ui): 重构下载组件"
```

## 💄 样式相关

```bash
# 样式更新
git commit -m "style: 统一代码格式"

# UI 样式
git commit -m "style(ui): 更新按钮样式"

# 主题相关
git commit -m "style: 添加暗色主题支持"
```

## 🔧 维护相关

```bash
# 清理代码
git commit -m "chore: 清理未使用的代码"

# 版本号更新
git commit -m "chore: 更新版本号到 1.4.1"

# 工具链更新
git commit -m "chore: 更新开发工具链"
```

## 🎯 项目特定示例

```bash
# BiliTools 特定功能
git commit -m "feat(bilibili): 添加弹幕下载功能"
git commit -m "feat(parser): 支持 4K 视频解析"
git commit -m "fix(download): 修复批量下载问题"
git commit -m "feat(ui): 添加下载队列管理"
git commit -m "config(tauri): 优化窗口启动配置"
```

## 📋 当前更新的示例 Commit 消息

基于当前的更改，可以使用以下消息：

```bash
# 添加更新日志系统
git commit -m "feat(tools): 添加依赖更新日志管理系统

- 添加 .npmrc 配置优化 pnpm 行为
- 创建更新管理脚本 (Windows/Linux)
- 添加 package.json 更新相关脚本
- 创建 UPDATE_LOG.md 记录更新历史
- 添加 commit 消息生成工具

关联功能:
- 自动检查依赖更新
- 生成更新前快照
- 支持安全更新和版本控制
- 提供回滚功能"

# 或者分开提交：
git commit -m "config: 添加 pnpm 配置和更新日志支持"
git commit -m "feat(tools): 添加依赖更新管理工具"
git commit -m "feat(tools): 添加 commit 消息生成工具"
```
