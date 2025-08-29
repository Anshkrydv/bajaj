gi@echo off
echo This script will install Java and Maven using Chocolatey
echo.
echo IMPORTANT: You must run this script as Administrator
echo.
echo To run as Administrator:
echo 1. Right-click on this file
echo 2. Select "Run as administrator"
echo 3. Click "Yes" when prompted
echo.
echo If you're not running as Administrator, the installation will fail.
echo.
pause

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running as Administrator - proceeding with installation...
    echo.
    
    REM Install Chocolatey
    echo Installing Chocolatey package manager...
    @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    
    REM Refresh environment
    call refreshenv
    
    REM Install Java 17
    echo Installing OpenJDK 17...
    choco install openjdk17 -y
    
    REM Install Maven
    echo Installing Maven...
    choco install maven -y
    
    REM Refresh environment again
    call refreshenv
    
    echo.
    echo Installation completed!
    echo.
    echo Please restart your terminal/command prompt for changes to take effect.
    echo.
    echo You can then build your project using:
    echo   mvn clean package
    echo   mvn spring-boot:run
    echo.
    echo Or use the Maven wrapper:
    echo   .\mvnw.cmd clean package
    echo   .\mvnw.cmd spring-boot:run
    echo.
    
) else (
    echo ERROR: This script must be run as Administrator!
    echo.
    echo Please:
    echo 1. Right-click on this file
    echo 2. Select "Run as administrator"
    echo 3. Click "Yes" when prompted
    echo.
    echo Or run Command Prompt as Administrator and navigate to this directory.
    echo.
)

pause
