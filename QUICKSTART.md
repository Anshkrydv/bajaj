# Quick Start Guide

Get your Spring Boot webhook solver running in minutes!

## 🚀 Quick Start (3 Steps)

### Step 1: Install Java 17
**Option A: Download and Install (Recommended)**
1. Go to: https://adoptium.net/temurin/releases/?version=17
2. Download **Windows x64 MSI Installer**
3. Run as Administrator
4. Check "Add to PATH" during installation

**Option B: Use Chocolatey (if available)**
```cmd
choco install openjdk17 -y
```

### Step 2: Build the Project
```cmd
# Using Maven Wrapper (no Maven installation needed)
.\mvnw.cmd clean package

# Or if you have Maven installed globally
mvn clean package
```

### Step 3: Run the Application
```cmd
# Using Maven Wrapper
.\mvnw.cmd spring-boot:run

# Or if you have Maven installed globally
mvn spring-boot:run

# Or run the JAR directly
java -jar target/webhook-solver-1.0.0.jar
```

## ✅ What Happens Next?

1. **Application starts** on port 8080
2. **Automatically sends** webhook generation request
3. **Determines question type** based on registration number (REG12347 → ODD → Question 1)
4. **Solves SQL problem** and stores in H2 database
5. **Submits solution** via webhook with JWT authentication
6. **Logs all activities** for monitoring

## 🔍 Monitor the Application

- **Console logs**: Watch the terminal for execution details
- **H2 Database**: http://localhost:8080/h2-console
  - JDBC URL: `jdbc:h2:mem:testdb`
  - Username: `sa`
  - Password: `password`

## 🛠️ Customization

- **Change registration number**: Edit `WebhookService.java` line 47
- **Modify SQL solutions**: Edit `SqlProblemSolver.java`
- **Change API URLs**: Edit constants in `WebhookService.java`

## ❓ Need Help?

- **Installation issues**: See [INSTALLATION.md](INSTALLATION.md)
- **Project details**: See [README.md](README.md)
- **Common problems**: Check troubleshooting sections

## 📱 Test the Webhook

The application will automatically:
1. Call: `POST https://bfhldevapigw.healthrx.co.in/hiring/generateWebhook/JAVA`
2. Submit solution to: `POST https://bfhldevapigw.healthrx.co.in/hiring/testWebhook/JAVA`

## 🎯 Expected Output

```
Application started. Initiating webhook flow...
Starting webhook flow execution...
Webhook generated successfully. URL: [webhook_url]
Question type determined: ODD for regNo: REG12347
SQL solution generated for question type: ODD
Solution saved to database with ID: 1
Solution submitted successfully via webhook
```

## 🚨 Troubleshooting

- **Port 8080 in use**: Change `server.port` in `application.properties`
- **Java not found**: Restart terminal after Java installation
- **Build fails**: Ensure Java 17+ is installed and in PATH

## 🎉 Success!

Once running, your application will:
- ✅ Generate webhooks automatically
- ✅ Solve SQL problems based on registration number
- ✅ Store solutions in database
- ✅ Submit solutions via webhook with JWT
- ✅ Provide comprehensive logging

Ready to go! 🚀
