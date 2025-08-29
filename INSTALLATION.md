# Installation Guide for Java and Maven

This guide will help you install Java 17 and Maven 3.6+ on your Windows system to run the Spring Boot application.

## Prerequisites
- Windows 10/11
- Administrator privileges (required for some installation methods)
- Internet connection

## Method 1: Automatic Installation (Recommended)

### Step 1: Run as Administrator
1. **Right-click** on `run-as-admin.bat`
2. Select **"Run as administrator"**
3. Click **"Yes"** when prompted by User Account Control

### Step 2: Follow the Installation
The script will automatically:
- Install Chocolatey package manager
- Install OpenJDK 17
- Install Maven
- Configure environment variables

### Step 3: Restart Terminal
After installation completes:
1. Close your current terminal/command prompt
2. Open a new terminal
3. Verify installation with:
   ```cmd
   java --version
   mvn --version
   ```

## Method 2: Manual Installation

### Installing Java 17

#### Option A: Using Adoptium (Recommended)
1. Go to: https://adoptium.net/temurin/releases/?version=17
2. Download **Windows x64 MSI Installer**
3. Run the installer as Administrator
4. Follow the installation wizard
5. **Important**: Check "Add to PATH" during installation

#### Option B: Using Oracle JDK
1. Go to: https://www.oracle.com/java/technologies/downloads/#java17
2. Download **Windows x64 Installer**
3. Run the installer as Administrator
4. Follow the installation wizard

### Installing Maven

#### Option A: Using Binary Archive
1. Go to: https://maven.apache.org/download.cgi
2. Download **Binary zip archive** (apache-maven-3.9.5-bin.zip)
3. Extract to `C:\Program Files\Apache\maven`
4. Add to PATH environment variable

#### Option B: Using Chocolatey (if available)
```cmd
choco install maven -y
```

### Setting Environment Variables

#### For Java
1. Open **System Properties** (Win + Pause/Break)
2. Click **Environment Variables**
3. Under **System Variables**, click **New**
4. Variable name: `JAVA_HOME`
5. Variable value: `C:\Program Files\Eclipse Adoptium\jdk-17.0.9.9-hotspot` (adjust path as needed)
6. Click **OK**

#### For Maven
1. Under **System Variables**, click **New**
2. Variable name: `M2_HOME`
3. Variable value: `C:\Program Files\Apache\maven` (adjust path as needed)
4. Click **OK**
5. Find **Path** variable, click **Edit**
6. Click **New**, add `%M2_HOME%\bin`
7. Click **OK** on all dialogs

## Method 3: Using Maven Wrapper (No Installation Required)

If you don't want to install Maven globally, the project includes Maven wrapper:

```cmd
# Build the project
.\mvnw.cmd clean package

# Run the application
.\mvnw.cmd spring-boot:run
```

**Note**: This still requires Java to be installed.

## Verification

After installation, verify everything works:

```cmd
# Check Java version
java --version

# Check Maven version
mvn --version

# Check environment variables
echo %JAVA_HOME%
echo %M2_HOME%
```

Expected output:
```
openjdk version "17.0.9" 2023-10-17
OpenJDK Runtime Environment Temurin-17.0.9+9 (build 17.0.9+9)
OpenJDK 64-Bit Server VM Temurin-17.0.9+9 (build 17.0.9+9, mixed mode, sharing)

Apache Maven 3.9.5 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: C:\Program Files\Apache\maven
Java version: 17.0.9, vendor: Eclipse Adoptium, runtime: C:\Program Files\Eclipse Adoptium\jdk-17.0.9.9-hotspot
```

## Troubleshooting

### Common Issues

#### 1. "java is not recognized"
- Java is not in PATH
- JAVA_HOME is not set correctly
- **Solution**: Restart terminal or restart computer

#### 2. "mvn is not recognized"
- Maven is not in PATH
- M2_HOME is not set correctly
- **Solution**: Restart terminal or restart computer

#### 3. "Permission denied" during installation
- Not running as Administrator
- **Solution**: Right-click and "Run as administrator"

#### 4. Chocolatey installation fails
- PowerShell execution policy restrictions
- **Solution**: Run `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

### Alternative Solutions

If you continue having issues:

1. **Use Maven Wrapper**: The project includes `mvnw.cmd` which doesn't require global Maven installation
2. **Use IDE**: Import the project into IntelliJ IDEA, Eclipse, or VS Code
3. **Use Docker**: Create a Docker container with Java and Maven pre-installed

## Building the Project

Once Java and Maven are installed:

```cmd
# Clean and build
mvn clean package

# Run the application
mvn spring-boot:run

# Or use the JAR file
java -jar target/webhook-solver-1.0.0.jar
```

## Next Steps

After successful installation:
1. Read the main [README.md](README.md) for project details
2. Build and run the application
3. Check the H2 console at http://localhost:8080/h2-console
4. Monitor application logs for webhook execution

## Support

If you encounter issues:
1. Check the troubleshooting section above
2. Verify environment variables are set correctly
3. Ensure you're running as Administrator when needed
4. Restart your terminal/computer after installation
