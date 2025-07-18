# 依赖更新日志

本文档记录了 BiliTools 项目的依赖包更新历史。

## 更新记录

### 2025-07-18 - 项目初始化
- 🎉 项目切换到 pnpm 包管理器
- 📦 添加依赖更新管理系统
- 🔧 配置 .npmrc 文件
- 📝 创建更新日志管理脚本

**当前依赖版本:**
- vue: 3.5.16
- vite: 6.3.5
- @tauri-apps/api: 2.6.0
- @tauri-apps/cli: 2.6.2
- typescript: 5.8.3

---

## 使用说明

### 检查更新
```bash
# 使用 pnpm 脚本
pnpm run update-check

# 直接使用 pnpm 命令
pnpm outdated
```

### 执行更新
```bash
# 安全更新（推荐）
pnpm run update-security

# 补丁更新
pnpm run update-patch

# 小版本更新（谨慎）
pnpm run update-minor
```

### 创建快照
```bash
# 在更新前创建快照
pnpm run update-snapshot
```

### 使用更新管理器
```bash
# Windows 系统
pnpm run update-manager

# 或直接运行
scripts/update-manager.bat
```

---

## 更新策略

### 🟢 立即更新
- 安全漏洞修复
- 关键 Bug 修复

### 🟡 定期更新
- 补丁版本更新
- 小版本更新（测试后）

### 🔴 谨慎更新
- 主版本更新
- 框架核心更新

---

## 回滚说明

如果更新后出现问题，可以使用备份文件回滚：

1. 找到对应时间戳的备份文件
2. 恢复 package.json 和 pnpm-lock.yaml
3. 运行 `pnpm install` 重新安装依赖

---

**注意事项：**
- 更新前请确保代码已提交
- 重要更新请在开发分支进行测试
- 生产环境更新需要充分测试
