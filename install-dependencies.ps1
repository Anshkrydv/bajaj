# PowerShell script to install Java and Maven
# Run this script as Administrator

Write-Host "Installing Java and Maven dependencies..." -ForegroundColor Green

# Check if Chocolatey is installed
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey package manager..." -ForegroundColor Yellow
    
    # Install Chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    
    # Refresh environment variables
    refreshenv
    Write-Host "Chocolatey installed successfully!" -ForegroundColor Green
} else {
    Write-Host "Chocolatey is already installed." -ForegroundColor Green
}

# Install Java 17
Write-Host "Installing OpenJDK 17..." -ForegroundColor Yellow
choco install openjdk17 -y

# Install Maven
Write-Host "Installing Maven..." -ForegroundColor Yellow
choco install maven -y

# Refresh environment variables
refreshenv

Write-Host "Installation completed!" -ForegroundColor Green
Write-Host ""

# Verify installations
Write-Host "Verifying installations..." -ForegroundColor Yellow

try {
    $javaVersion = java --version 2>&1 | Select-String "version" | Select-Object -First 1
    Write-Host "Java: $javaVersion" -ForegroundColor Green
} catch {
    Write-Host "Java installation verification failed. Please check your PATH." -ForegroundColor Red
}

try {
    $mavenVersion = mvn --version 2>&1 | Select-String "Apache Maven" | Select-Object -First 1
    Write-Host "Maven: $mavenVersion" -ForegroundColor Green
} catch {
    Write-Host "Maven installation verification failed. Please check your PATH." -ForegroundColor Red
}

Write-Host ""
Write-Host "If you see any errors above, you may need to:" -ForegroundColor Yellow
Write-Host "1. Restart your terminal/PowerShell" -ForegroundColor Yellow
Write-Host "2. Restart your computer" -ForegroundColor Yellow
Write-Host "3. Check that JAVA_HOME and M2_HOME are set correctly" -ForegroundColor Yellow

Write-Host ""
Write-Host "You can now build your Spring Boot project using:" -ForegroundColor Green
Write-Host "  mvn clean package" -ForegroundColor Cyan
Write-Host "  mvn spring-boot:run" -ForegroundColor Cyan
