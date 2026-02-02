@echo off
echo 正在清理 Gradle 缓存...
echo.

REM 停止所有 Java 进程
echo 步骤 1: 终止 Java 进程...
taskkill /F /IM java.exe 2>nul
timeout /t 2 /nobreak >nul

REM 删除项目本地 build 目录
echo 步骤 2: 清理项目 build 目录...
if exist "build" rmdir /s /q "build"
if exist "android\build" rmdir /s /q "android\build"
if exist "android\app\build" rmdir /s /q "android\app\build"

REM 删除 Gradle 缓存中的 8.14 版本
echo 步骤 3: 清理 Gradle 8.14 缓存...
if exist "%USERPROFILE%\.gradle\wrapper\dists\gradle-8.14-all" (
    rmdir /s /q "%USERPROFILE%\.gradle\wrapper\dists\gradle-8.14-all"
    echo Gradle 8.14 缓存已删除
) else (
    echo Gradle 8.14 缓存不存在
)

echo.
echo 清理完成！现在可以重新运行 flutter run
echo.
pause
