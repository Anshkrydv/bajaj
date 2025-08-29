@echo off
echo Installing Java and Maven dependencies...
echo.

REM Check if Chocolatey is installed
choco --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing Chocolatey package manager...
    
    REM Install Chocolatey
    @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    
    echo Chocolatey installed successfully!
    echo.
) else (
    echo Chocolatey is already installed.
    echo.
)

REM Install Java 17
echo Installing OpenJDK 17...
choco install openjdk17 -y

REM Install Maven
echo Installing Maven...
choco install maven -y

echo.
echo Installation completed!
echo.

REM Refresh environment variables
call refreshenv

echo Verifying installations...
echo.

REM Verify Java
java --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Java: Installed successfully
) else (
    echo Java: Installation verification failed. Please check your PATH.
)

REM Verify Maven
mvn --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Maven: Installed successfully
) else (
    echo Maven: Installation verification failed. Please check your PATH.
)

echo.
echo If you see any errors above, you may need to:
echo 1. Restart your terminal/Command Prompt
echo 2. Restart your computer
echo 3. Check that JAVA_HOME and M2_HOME are set correctly
echo.

echo You can now build your Spring Boot project using:
echo   mvn clean package
echo   mvn spring-boot:run
echo.

pause
