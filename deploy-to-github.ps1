# GitHub Deployment Script for PowerShell
# Run this script to deploy your Spring Boot application to GitHub

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    GitHub Deployment Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if git is installed
try {
    $gitVersion = git --version
    Write-Host "Git is available: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Git is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Git from: https://git-scm.com/" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Proceeding with deployment..." -ForegroundColor Green
Write-Host ""

# Check if this is already a git repository
if (Test-Path ".git") {
    Write-Host "This directory is already a git repository." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Current git status:" -ForegroundColor Cyan
    git status --porcelain
    Write-Host ""
    
    $choice = Read-Host "Do you want to continue with existing repository? (y/n)"
    if ($choice -ne "y" -and $choice -ne "Y") {
        Write-Host "Deployment cancelled." -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit 0
    }
} else {
    Write-Host "Initializing new git repository..." -ForegroundColor Green
    git init
    Write-Host ""
}

# Get repository information
Write-Host "Please provide your GitHub repository information:" -ForegroundColor Cyan
Write-Host ""
$username = Read-Host "GitHub Username"
$reponame = Read-Host "Repository Name"

# Set remote origin
Write-Host ""
Write-Host "Setting up remote origin..." -ForegroundColor Green
git remote remove origin 2>$null
git remote add origin "https://github.com/$username/$reponame.git"

# Add all files
Write-Host ""
Write-Host "Adding files to git..." -ForegroundColor Green
git add .

# Create initial commit
Write-Host ""
Write-Host "Creating initial commit..." -ForegroundColor Green
$commitMessage = @"
Initial commit: Spring Boot Webhook Solver Application

- Complete Spring Boot application with webhook functionality
- Automatic SQL problem solving based on registration number
- H2 database integration and JWT authentication
- Comprehensive documentation and GitHub Actions workflows
- Maven wrapper for easy building and running
"@

git commit -m $commitMessage

# Create and switch to main branch
Write-Host ""
Write-Host "Creating main branch..." -ForegroundColor Green
git branch -M main

# Push to GitHub
Write-Host ""
Write-Host "Pushing to GitHub..." -ForegroundColor Green
Write-Host "This will open your browser for authentication if needed." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "    DEPLOYMENT SUCCESSFUL!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your application has been deployed to:" -ForegroundColor Green
    Write-Host "https://github.com/$username/$reponame" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Check the Actions tab for build status" -ForegroundColor White
    Write-Host "2. Download JAR files from successful builds" -ForegroundColor White
    Write-Host "3. Create releases for public JAR downloads" -ForegroundColor White
    Write-Host "4. Share your repository with others" -ForegroundColor White
    Write-Host ""
    Write-Host "Build artifacts will be available in the Actions tab." -ForegroundColor Green
    Write-Host ""
    
    # Open GitHub repository in browser
    $openBrowser = Read-Host "Would you like to open the repository in your browser? (y/n)"
    if ($openBrowser -eq "y" -or $openBrowser -eq "Y") {
        Start-Process "https://github.com/$username/$reponame"
    }
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "    DEPLOYMENT FAILED!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Possible issues:" -ForegroundColor Yellow
    Write-Host "1. Repository doesn't exist on GitHub" -ForegroundColor White
    Write-Host "2. Authentication failed" -ForegroundColor White
    Write-Host "3. Network connectivity issues" -ForegroundColor White
    Write-Host ""
    Write-Host "Please check the error messages above and try again." -ForegroundColor Red
    Write-Host ""
}

Write-Host "Press Enter to exit..."
Read-Host
