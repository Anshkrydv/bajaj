# Java 17 Download Helper Script
# This script will help you download Java 17 automatically

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    Java 17 Download Helper" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "This script will help you download Java 17 automatically." -ForegroundColor Green
Write-Host ""

# Check if we can download directly
Write-Host "Attempting to download Java 17..." -ForegroundColor Yellow

try {
    # Create downloads directory if it doesn't exist
    $downloadDir = "$env:USERPROFILE\Downloads\Java17"
    if (!(Test-Path $downloadDir)) {
        New-Item -ItemType Directory -Path $downloadDir -Force
    }
    
    # Java 17 download URL (Eclipse Temurin)
    $javaUrl = "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.9%2B9/OpenJDK17U-jdk_x64_windows_hotspot_17.0.9_9.msi"
    $outputPath = "$downloadDir\OpenJDK17.msi"
    
    Write-Host "Downloading Java 17 from:" -ForegroundColor Cyan
    Write-Host $javaUrl -ForegroundColor White
    Write-Host ""
    Write-Host "This may take a few minutes depending on your internet speed..." -ForegroundColor Yellow
    
    # Download the file
    Invoke-WebRequest -Uri $javaUrl -OutFile $outputPath -UseBasicParsing
    
    if (Test-Path $outputPath) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "    DOWNLOAD SUCCESSFUL!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Java 17 has been downloaded to:" -ForegroundColor Green
        Write-Host $outputPath -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Next steps:" -ForegroundColor Yellow
        Write-Host "1. Right-click on the downloaded file" -ForegroundColor White
        Write-Host "2. Select 'Run as administrator'" -ForegroundColor White
        Write-Host "3. Follow the installation wizard" -ForegroundColor White
        Write-Host "4. Make sure to check 'Add to PATH' during installation" -ForegroundColor White
        Write-Host ""
        
        # Ask if user wants to open the folder
        $openFolder = Read-Host "Would you like to open the downloads folder? (y/n)"
        if ($openFolder -eq "y" -or $openFolder -eq "Y") {
            Start-Process "explorer.exe" -ArgumentList $downloadDir
        }
        
        # Ask if user wants to run the installer
        $runInstaller = Read-Host "Would you like to run the installer now? (y/n)"
        if ($runInstaller -eq "y" -or $runInstaller -eq "Y") {
            Write-Host "Starting Java installer..." -ForegroundColor Green
            Start-Process $outputPath -Verb RunAs
        }
        
    } else {
        Write-Host "Download failed. File not found at expected location." -ForegroundColor Red
    }
    
} catch {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "    DOWNLOAD FAILED" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Automatic download failed. Here are manual options:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Option 1: Manual Download" -ForegroundColor Cyan
    Write-Host "1. Go to: https://adoptium.net/temurin/releases/?version=17" -ForegroundColor White
    Write-Host "2. Download 'Windows x64 MSI Installer'" -ForegroundColor White
    Write-Host "3. Run as Administrator" -ForegroundColor White
    Write-Host ""
    Write-Host "Option 2: Use Chocolatey (if available)" -ForegroundColor Cyan
    Write-Host "1. Run: choco install openjdk17 -y" -ForegroundColor White
    Write-Host ""
    Write-Host "Option 3: Use the automatic installer script" -ForegroundColor Cyan
    Write-Host "1. Right-click 'run-as-admin.bat'" -ForegroundColor White
    Write-Host "2. Select 'Run as administrator'" -ForegroundColor White
    Write-Host ""
}

Write-Host "Press Enter to exit..."
Read-Host
