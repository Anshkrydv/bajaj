@echo off
echo ========================================
echo    GitHub Deployment Script
echo ========================================
echo.

REM Check if git is installed
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Git is not installed or not in PATH
    echo Please install Git from: https://git-scm.com/
    pause
    exit /b 1
)

echo Git is available. Proceeding with deployment...
echo.

REM Check if this is already a git repository
if exist .git (
    echo This directory is already a git repository.
    echo.
    echo Current git status:
    git status --porcelain
    echo.
    
    set /p choice="Do you want to continue with existing repository? (y/n): "
    if /i "%choice%" neq "y" (
        echo Deployment cancelled.
        pause
        exit /b 0
    )
) else (
    echo Initializing new git repository...
    git init
    echo.
)

REM Get repository information
echo Please provide your GitHub repository information:
echo.
set /p username="GitHub Username: "
set /p reponame="Repository Name: "

REM Set remote origin
echo.
echo Setting up remote origin...
git remote remove origin 2>nul
git remote add origin https://github.com/%username%/%reponame%.git

REM Add all files
echo.
echo Adding files to git...
git add .

REM Create initial commit
echo.
echo Creating initial commit...
git commit -m "Initial commit: Spring Boot Webhook Solver Application

- Complete Spring Boot application with webhook functionality
- Automatic SQL problem solving based on registration number
- H2 database integration and JWT authentication
- Comprehensive documentation and GitHub Actions workflows
- Maven wrapper for easy building and running"

REM Create and switch to main branch
echo.
echo Creating main branch...
git branch -M main

REM Push to GitHub
echo.
echo Pushing to GitHub...
echo This will open your browser for authentication if needed.
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo    DEPLOYMENT SUCCESSFUL!
    echo ========================================
    echo.
    echo Your application has been deployed to:
    echo https://github.com/%username%/%reponame%
    echo.
    echo Next steps:
    echo 1. Check the Actions tab for build status
    echo 2. Download JAR files from successful builds
    echo 3. Create releases for public JAR downloads
    echo 4. Share your repository with others
    echo.
    echo Build artifacts will be available in the Actions tab.
    echo.
) else (
    echo.
    echo ========================================
    echo    DEPLOYMENT FAILED!
    echo ========================================
    echo.
    echo Possible issues:
    echo 1. Repository doesn't exist on GitHub
    echo 2. Authentication failed
    echo 3. Network connectivity issues
    echo.
    echo Please check the error messages above and try again.
    echo.
)

echo Press any key to exit...
pause >nul
