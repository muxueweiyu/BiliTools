@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: BiliTools 更新日志管理脚本 (Windows 版本)
:: 用于管理项目依赖更新和生成更新日志

title BiliTools 依赖更新管理器

echo 📦 BiliTools 依赖更新日志管理器
echo ==================================

:menu
echo.
echo 请选择操作：
echo 1. 检查可更新的包
echo 2. 生成更新前的快照
echo 3. 执行安全更新
echo 4. 执行补丁更新
echo 5. 执行小版本更新
echo 6. 查看更新日志
echo 7. 回滚到上一个版本
echo 8. 清理缓存
echo 9. 退出
echo.

set /p choice="选择操作 (1-9): "

if "%choice%"=="1" goto check_outdated
if "%choice%"=="2" goto create_snapshot
if "%choice%"=="3" goto security_update
if "%choice%"=="4" goto patch_update
if "%choice%"=="5" goto minor_update
if "%choice%"=="6" goto view_changelog
if "%choice%"=="7" goto rollback
if "%choice%"=="8" goto clean_cache
if "%choice%"=="9" goto exit
echo ❌ 无效选择
goto menu

:check_outdated
echo 🔍 检查可更新的包...
pnpm outdated
echo.
echo 🔒 检查安全漏洞...
pnpm audit
goto continue

:create_snapshot
echo 📸 生成更新前快照...
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "timestamp=%dt:~0,4%%dt:~4,2%%dt:~6,2%_%dt:~8,2%%dt:~10,2%%dt:~12,2%"

copy package.json "package.json.backup_%timestamp%" >nul
copy pnpm-lock.yaml "pnpm-lock.yaml.backup_%timestamp%" >nul
pnpm list --depth=0 > "dependencies_snapshot_%timestamp%.txt"

echo ✅ 快照已保存:
echo   - package.json.backup_%timestamp%
echo   - pnpm-lock.yaml.backup_%timestamp%
echo   - dependencies_snapshot_%timestamp%.txt
goto continue

:security_update
echo 🔒 执行安全更新...
pnpm audit --fix
echo ✅ 安全更新完成
goto continue

:patch_update
echo 🔧 执行补丁更新...
pnpm update
echo ✅ 补丁更新完成
goto continue

:minor_update
echo 🚀 执行小版本更新...
echo ⚠️  这可能包含破坏性变更，请确保已备份！
set /p confirm="继续吗? (y/N): "
if /i "%confirm%"=="y" (
    pnpm update --latest
    echo ✅ 小版本更新完成
) else (
    echo 已取消更新
)
goto continue

:view_changelog
echo 📋 项目更新日志
if exist "CHANGELOG.md" (
    more +1 CHANGELOG.md | findstr /n "^" | findstr /r "^[1-9][0-9]*:"
) else (
    echo 未找到 CHANGELOG.md 文件
)
echo.
echo 📋 最近的快照文件
dir *.backup_* dependencies_snapshot_* 2>nul || echo 无备份文件
goto continue

:rollback
echo 🔄 回滚到上一个版本...
echo 可用的备份文件：
dir *.backup_* 2>nul || echo 无备份文件
echo.
set /p timestamp="输入要回滚的时间戳 (格式: YYYYMMDD_HHMMSS): "

if exist "package.json.backup_%timestamp%" if exist "pnpm-lock.yaml.backup_%timestamp%" (
    copy "package.json.backup_%timestamp%" package.json >nul
    copy "pnpm-lock.yaml.backup_%timestamp%" pnpm-lock.yaml >nul
    pnpm install
    echo ✅ 回滚完成
) else (
    echo ❌ 备份文件不存在
)
goto continue

:clean_cache
echo 🧹 清理缓存...
pnpm store prune
echo ✅ 缓存清理完成
goto continue

:continue
echo.
pause
goto menu

:exit
echo 👋 再见！
exit /b 0
