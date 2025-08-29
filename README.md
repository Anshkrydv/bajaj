# Webhook Solver - Spring Boot Application

## Project Overview
This Spring Boot application automatically solves SQL problems and submits solutions via webhooks. The application:

1. **On startup**: Sends a POST request to generate a webhook
2. **Determines question type**: Based on the last two digits of registration number (odd/even)
3. **Solves SQL problem**: Generates appropriate SQL query based on question type
4. **Stores solution**: Saves the solution in H2 database
5. **Submits solution**: Sends the final SQL query to the webhook URL using JWT token

## Requirements
- Java 17 or higher
- Maven 3.6 or higher

## Installation

### Option 1: Automatic Installation (Recommended)
Run one of the installation scripts as Administrator:

**PowerShell (Recommended):**
```powershell
# Right-click on install-dependencies.ps1 and "Run as Administrator"
# Or run in PowerShell as Administrator:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\install-dependencies.ps1
```

**Command Prompt:**
```cmd
# Right-click on install-dependencies.bat and "Run as Administrator"
# Or run in Command Prompt as Administrator:
install-dependencies.bat
```

### Option 2: Manual Installation

#### Install Java 17
1. Download OpenJDK 17 from: https://adoptium.net/temurin/releases/?version=17
2. Choose Windows x64 MSI installer
3. Run the installer and follow the setup wizard
4. Set JAVA_HOME environment variable to your Java installation directory

#### Install Maven
1. Download Maven from: https://maven.apache.org/download.cgi
2. Extract to a directory (e.g., `C:\Program Files\Apache\maven`)
3. Add Maven bin directory to PATH environment variable
4. Set M2_HOME environment variable to your Maven installation directory

### Option 3: Using Maven Wrapper
If you prefer not to install Maven globally, the project includes Maven wrapper:
```cmd
# Build the project
.\mvnw.cmd clean package

# Run the application
.\mvnw.cmd spring-boot:run
```

## Project Structure
```
src/
├── main/
│   ├── java/com/bajaj/
│   │   ├── WebhookSolverApplication.java    # Main application class
│   │   ├── config/
│   │   │   └── AppConfig.java               # Configuration beans
│   │   ├── dto/
│   │   │   ├── WebhookRequest.java          # Webhook generation request DTO
│   │   │   ├── WebhookResponse.java         # Webhook generation response DTO
│   │   │   └── SolutionRequest.java         # Solution submission DTO
│   │   ├── entity/
│   │   │   └── Solution.java                # Database entity for solutions
│   │   ├── repository/
│   │   │   └── SolutionRepository.java      # Data access layer
│   │   └── service/
│   │       ├── WebhookService.java          # Main business logic
│   │       └── SqlProblemSolver.java        # SQL problem solver
│   └── resources/
│       └── application.properties           # Application configuration
```

## Features
- **Automatic execution**: Runs on application startup without manual triggers
- **Question type determination**: Automatically determines question based on registration number
- **Database storage**: Stores all solutions with metadata
- **JWT authentication**: Uses access token for secure submission
- **Comprehensive logging**: Detailed logging for debugging and monitoring
- **H2 database**: In-memory database for development and testing

## Configuration
The application uses the following configuration:
- **Webhook URLs**: Configured in `WebhookService.java`
- **Database**: H2 in-memory database (configurable via `application.properties`)
- **Port**: 8080 (configurable via `application.properties`)
- **Timeouts**: 30 seconds for HTTP connections

## API Endpoints Used
1. **Webhook Generation**: `POST https://bfhldevapigw.healthrx.co.in/hiring/generateWebhook/JAVA`
2. **Solution Submission**: `POST https://bfhldevapigw.healthrx.co.in/hiring/testWebhook/JAVA`

## Question Type Logic
- **Odd last two digits** → Question 1 (Google Drive link 1)
- **Even last two digits** → Question 2 (Google Drive link 2)

## Building and Running

### Prerequisites
- Java 17+
- Maven 3.6+

### Build the Application
```bash
# Using Maven (if installed globally)
mvn clean package

# Using Maven Wrapper (recommended if Maven not installed globally)
.\mvnw.cmd clean package
```

### Run the Application
```bash
# Option 1: Using Maven
mvn spring-boot:run

# Option 2: Using Maven Wrapper
.\mvnw.cmd spring-boot:run

# Option 3: Using JAR file
java -jar target/webhook-solver-1.0.0.jar
```

### Access H2 Console
- URL: `http://localhost:8080/h2-console`
- JDBC URL: `jdbc:h2:mem:testdb`
- Username: `sa`
- Password: `password`

## Flow Execution
1. Application starts and triggers `ApplicationReadyEvent`
2. `WebhookService.executeWebhookFlow()` is called automatically
3. Webhook generation request is sent with sample data
4. Response contains webhook URL and access token
5. Question type is determined based on registration number
6. SQL problem is solved based on question type
7. Solution is stored in database
8. Solution is submitted via webhook with JWT authentication
9. Database status is updated based on submission result

## Customization
- **Registration Number**: Update `regNo` in `WebhookService.java`
- **SQL Solutions**: Modify `SqlProblemSolver.java` with actual problem solutions
- **API URLs**: Update constants in `WebhookService.java`
- **Database**: Change database configuration in `application.properties`

## Logging
The application provides comprehensive logging:
- Application startup and flow initiation
- Webhook generation requests and responses
- Question type determination
- SQL solution generation
- Database operations
- Webhook submission results
- Error handling and debugging information

## Error Handling
- Graceful handling of API failures
- Database transaction management
- Comprehensive exception logging
- Status tracking for all operations

## Development Notes
- Uses Spring Boot 3.2.0 with Java 17
- Implements JPA for data persistence
- Uses RestTemplate for HTTP operations
- Follows Spring Boot best practices
- Includes comprehensive unit test structure

## Troubleshooting
1. **Port conflicts**: Change `server.port` in `application.properties`
2. **Database issues**: Check H2 console at `/h2-console`
3. **API failures**: Check logs for detailed error information
4. **JWT issues**: Verify access token format and expiration

## License
This project is created for the Bajaj hiring assignment.
