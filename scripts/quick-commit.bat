@echo off
chcp 65001 >nul

:: 快速 commit 命令集合
:: 用于常见的提交场景

if "%1"=="" goto help
if "%1"=="deps" goto deps
if "%1"=="config" goto config
if "%1"=="docs" goto docs
if "%1"=="fix" goto fix
if "%1"=="feat" goto feat
if "%1"=="style" goto style
if "%1"=="refactor" goto refactor
if "%1"=="test" goto test
if "%1"=="build" goto build
if "%1"=="ci" goto ci
if "%1"=="chore" goto chore
goto help

:help
echo 🚀 快速 Commit 命令
echo ===================
echo.
echo 用法: quick-commit.bat [类型] [描述]
echo.
echo 支持的类型：
echo   deps      - 依赖更新
echo   config    - 配置修改
echo   docs      - 文档更新
echo   fix       - Bug 修复
echo   feat      - 新功能
echo   style     - 代码格式化
echo   refactor  - 代码重构
echo   test      - 测试相关
echo   build     - 构建系统
echo   ci        - CI/CD 相关
echo   chore     - 其他维护
echo.
echo 示例：
echo   quick-commit.bat deps "更新 Vue 到 3.5.17"
echo   quick-commit.bat fix "修复登录按钮样式"
echo   quick-commit.bat feat "添加用户头像上传功能"
echo.
goto end

:deps
if "%2"=="" (
    git commit -m "deps: 更新依赖包"
) else (
    git commit -m "deps: %~2"
)
echo ✅ 依赖更新提交完成
goto end

:config
if "%2"=="" (
    git commit -m "config: 更新配置文件"
) else (
    git commit -m "config: %~2"
)
echo ✅ 配置更新提交完成
goto end

:docs
if "%2"=="" (
    git commit -m "docs: 更新文档"
) else (
    git commit -m "docs: %~2"
)
echo ✅ 文档更新提交完成
goto end

:fix
if "%2"=="" (
    git commit -m "fix: 修复问题"
) else (
    git commit -m "fix: %~2"
)
echo ✅ 问题修复提交完成
goto end

:feat
if "%2"=="" (
    git commit -m "feat: 添加新功能"
) else (
    git commit -m "feat: %~2"
)
echo ✅ 新功能提交完成
goto end

:style
if "%2"=="" (
    git commit -m "style: 代码格式化"
) else (
    git commit -m "style: %~2"
)
echo ✅ 样式更新提交完成
goto end

:refactor
if "%2"=="" (
    git commit -m "refactor: 代码重构"
) else (
    git commit -m "refactor: %~2"
)
echo ✅ 代码重构提交完成
goto end

:test
if "%2"=="" (
    git commit -m "test: 添加测试"
) else (
    git commit -m "test: %~2"
)
echo ✅ 测试提交完成
goto end

:build
if "%2"=="" (
    git commit -m "build: 构建系统更新"
) else (
    git commit -m "build: %~2"
)
echo ✅ 构建更新提交完成
goto end

:ci
if "%2"=="" (
    git commit -m "ci: CI/CD 配置更新"
) else (
    git commit -m "ci: %~2"
)
echo ✅ CI/CD 提交完成
goto end

:chore
if "%2"=="" (
    git commit -m "chore: 其他维护更新"
) else (
    git commit -m "chore: %~2"
)
echo ✅ 维护更新提交完成
goto end

:end
