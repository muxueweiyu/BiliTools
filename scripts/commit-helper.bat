@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Git Commit 消息生成工具 (Windows 版本)
:: 遵循约定式提交规范 (Conventional Commits)

title Git Commit 消息生成工具

echo 🚀 Git Commit 消息生成工具
echo ==================================
echo.

:: 检查是否有待提交的更改
git diff --cached --quiet >nul 2>&1
if %errorlevel% neq 0 (
    echo ✅ 发现待提交的更改
) else (
    echo ⚠️  没有待提交的更改，请先使用 git add 添加文件
    pause
    exit /b 1
)

:: 显示待提交的文件
echo.
echo 📁 待提交的文件：
git diff --cached --name-status
echo.

:: 提交类型选择
echo 📋 选择提交类型：
echo 1.  feat     - 新功能
echo 2.  fix      - Bug 修复
echo 3.  docs     - 文档更新
echo 4.  style    - 代码格式化
echo 5.  refactor - 代码重构
echo 6.  perf     - 性能优化
echo 7.  test     - 测试相关
echo 8.  build    - 构建系统
echo 9.  ci       - CI/CD 相关
echo 10. chore    - 其他维护
echo 11. revert   - 回滚提交
echo 12. deps     - 依赖更新
echo 13. config   - 配置修改
echo 14. init     - 初始化项目
echo.

set /p type_choice="请选择提交类型 (1-14): "

set commit_type=feat
if "%type_choice%"=="1" set commit_type=feat
if "%type_choice%"=="2" set commit_type=fix
if "%type_choice%"=="3" set commit_type=docs
if "%type_choice%"=="4" set commit_type=style
if "%type_choice%"=="5" set commit_type=refactor
if "%type_choice%"=="6" set commit_type=perf
if "%type_choice%"=="7" set commit_type=test
if "%type_choice%"=="8" set commit_type=build
if "%type_choice%"=="9" set commit_type=ci
if "%type_choice%"=="10" set commit_type=chore
if "%type_choice%"=="11" set commit_type=revert
if "%type_choice%"=="12" set commit_type=deps
if "%type_choice%"=="13" set commit_type=config
if "%type_choice%"=="14" set commit_type=init

:: 如果是依赖更新，使用特殊模板
if "%commit_type%"=="deps" goto deps_template

:: 作用域选择
echo.
echo 🎯 选择作用域（可选）：
echo 1. frontend  - 前端相关
echo 2. backend   - 后端相关
echo 3. ui        - 用户界面
echo 4. api       - API 相关
echo 5. auth      - 认证相关
echo 6. config    - 配置相关
echo 7. deps      - 依赖相关
echo 8. build     - 构建相关
echo 9. test      - 测试相关
echo 10. docs     - 文档相关
echo 11. 自定义   - 输入自定义作用域
echo 12. 跳过     - 不指定作用域
echo.

set /p scope_choice="请选择作用域 (1-12): "

set scope=
if "%scope_choice%"=="1" set scope=frontend
if "%scope_choice%"=="2" set scope=backend
if "%scope_choice%"=="3" set scope=ui
if "%scope_choice%"=="4" set scope=api
if "%scope_choice%"=="5" set scope=auth
if "%scope_choice%"=="6" set scope=config
if "%scope_choice%"=="7" set scope=deps
if "%scope_choice%"=="8" set scope=build
if "%scope_choice%"=="9" set scope=test
if "%scope_choice%"=="10" set scope=docs
if "%scope_choice%"=="11" (
    set /p scope="请输入自定义作用域: "
)

:: 输入描述
echo.
set /p description="请输入简短描述（必填）: "

if "%description%"=="" (
    echo ❌ 描述不能为空
    pause
    exit /b 1
)

:: 输入详细说明
echo.
set /p body="请输入详细说明（可选，按回车跳过）: "

:: 询问是否有破坏性变更
echo.
set /p breaking_change="是否包含破坏性变更？(y/N): "

:: 输入关联问题
echo.
set /p issues="请输入关联的 Issue 编号（可选，格式: #123, #456）: "

:: 生成 commit 消息
set commit_message=%commit_type%
if not "%scope%"=="" (
    set commit_message=%commit_message%^(%scope%^)
)
if /i "%breaking_change%"=="y" (
    set commit_message=%commit_message%!
)
set commit_message=%commit_message%: %description%

if not "%body%"=="" (
    set commit_message=%commit_message%

%body%
)

if /i "%breaking_change%"=="y" (
    set commit_message=%commit_message%

BREAKING CHANGE: 这是一个破坏性变更
)

if not "%issues%"=="" (
    set commit_message=%commit_message%

关联问题: %issues%
)

goto show_commit

:deps_template
echo.
echo 📦 依赖更新模板
echo 1. 安全更新
echo 2. 补丁更新
echo 3. 小版本更新
echo 4. 主版本更新
echo 5. 新增依赖
echo 6. 删除依赖
echo 7. 自定义
echo.

set /p update_type="选择更新类型 (1-7): "

set commit_message=deps: 更新依赖
if "%update_type%"=="1" set commit_message=deps: 修复安全漏洞
if "%update_type%"=="2" set commit_message=deps: 更新补丁版本依赖
if "%update_type%"=="3" set commit_message=deps: 更新小版本依赖
if "%update_type%"=="4" set commit_message=deps: 更新主版本依赖
if "%update_type%"=="5" (
    set /p dep_name="请输入新增的依赖名: "
    set commit_message=deps: 添加 !dep_name!
)
if "%update_type%"=="6" (
    set /p dep_name="请输入删除的依赖名: "
    set commit_message=deps: 移除 !dep_name!
)
if "%update_type%"=="7" (
    set /p custom_desc="请输入自定义描述: "
    set commit_message=deps: !custom_desc!
)

:show_commit
:: 显示生成的 commit 消息
echo.
echo 📝 生成的 commit 消息：
echo ==================================
echo %commit_message%
echo ==================================
echo.

:: 确认提交
set /p confirm="确认提交吗？(y/N): "
if /i "%confirm%"=="y" (
    git commit -m "%commit_message%"
    echo ✅ 提交成功！
) else (
    echo ❌ 已取消提交
)

pause
exit /b 0
