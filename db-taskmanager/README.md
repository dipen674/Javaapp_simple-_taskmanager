# Task Manager Web Application

A comprehensive, Dockerized task management web application built with Java Servlets, JSP, and MySQL. This application helps users organize their tasks with categories, priorities, and due dates.

## 🚀 Features

- **User Authentication**: Secure register, login, and logout functionality
- **Task Management**: Full CRUD operations for tasks
- **Categories**: Organize tasks with customizable categories and colors
- **Dashboard**: Overview of task statistics and recent activities
- **Responsive Design**: Modern UI that works on desktop and mobile devices
- **Database Persistence**: MySQL database for reliable data storage

## 🛠️ Technology Stack

- **Backend**: Java Servlets, JSP
- **Frontend**: HTML5, CSS3, JavaScript, JSTL
- **Database**: MySQL
- **Containerization**: Docker, Docker Compose
- **Web Server**: Apache Tomcat
- **Build Tool**: Maven

## 📁 Project Structure

```
taskmanager-webapp/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/example/taskmanager/
│       │       ├── controller/          # Servlets
│       │       ├── model/               # Data models
│       │       ├── service/             # Business logic
│       │       └── util/                # Utility classes
│       ├── resources/
│       └── webapp/
│           ├── css/
│           │   └── style.css            # Main stylesheet
│           ├── WEB-INF/
│           │   ├── views/               # JSP pages
│           │   └── web.xml              # Deployment descriptor
│           ├── META-INF/
│           │   └── context.xml          # Database configuration
│           └── index.jsp                # Home page
├── target/                              # Compiled output
├── docker-compose.yml                   # Multi-container setup
├── Dockerfile                           # App container definition
├── init.sql                             # Database initialization
├── pom.xml                              # Maven configuration
└── wait-for-it.sh                       # Database readiness script
```

## 🏗️ Application Architecture

The application follows the MVC (Model-View-Controller) pattern:

- **Model**: Data models and database entities
- **View**: JSP pages for user interface
- **Controller**: Servlets handling HTTP requests and responses

### Architecture Diagram

<div align="center">
  <img src="architecture.png" alt="Task Manager Application Architecture" width="800"/>
</div>

**Component Description:**

- **Web Browser**: User interface access point
- **Tomcat Server**: Java web server handling HTTP requests  
- **Frontend Layer**: JSP pages, CSS styling, JavaScript interactions, and JSTL tags
- **Java Servlets**: Controller layer handling HTTP requests and responses
- **Service Layer**: Business logic and data processing
- **Data Models**: Entity classes representing database structure
- **MySQL Database**: Persistent data storage with users, tasks, and categories tables

## ⚠️ Important: Servlet API Compatibility

### The Problem

This application may encounter **404 errors** due to Servlet API version conflicts between different Tomcat versions:

- **Tomcat 10+**: Uses **Jakarta Servlet API** (package: `jakarta.servlet`)
- **Tomcat 9 and below**: Uses **Java EE Servlet API** (package: `javax.servlet`)

### How to Identify Which API to Use

1. **Check your Tomcat version**:
   ```bash
   # In your Tomcat directory
   ./bin/version.sh  # Linux/Mac
   version.bat       # Windows
   ```

2. **Version mapping**:
   - **Tomcat 11.x**: Jakarta Servlet API 6.0+ (`jakarta.servlet`)
   - **Tomcat 10.x**: Jakarta Servlet API 5.0+ (`jakarta.servlet`)
   - **Tomcat 9.x and below**: Java EE Servlet API (`javax.servlet`)

3. **Check your current code**:
   ```java
   // If you see this - it's Java EE (old)
   import javax.servlet.*;
   import javax.servlet.http.*;
   
   // If you see this - it's Jakarta EE (new)
   import jakarta.servlet.*;
   import jakarta.servlet.http.*;
   ```

### Solutions

#### Solution 1: Update Code to Jakarta EE (Recommended for Tomcat 10+)

**For Tomcat 11.x users**, update your servlet imports:

```java
// OLD (Java EE)
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

// NEW (Jakarta EE)
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
```

**Update Maven dependencies** in `pom.xml`:

```xml
<dependencies>
    <!-- Jakarta Servlet API (for Tomcat 10+) -->
    <dependency>
        <groupId>jakarta.servlet</groupId>
        <artifactId>jakarta.servlet-api</artifactId>
        <version>6.0.0</version>
        <scope>provided</scope>
    </dependency>
    
    <!-- Jakarta JSP API -->
    <dependency>
        <groupId>jakarta.servlet.jsp</groupId>
        <artifactId>jakarta.servlet.jsp-api</artifactId>
        <version>3.1.0</version>
        <scope>provided</scope>
    </dependency>
    
    <!-- JSTL for Jakarta -->
    <dependency>
        <groupId>jakarta.servlet.jsp.jstl</groupId>
        <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
        <version>3.0.0</version>
    </dependency>
</dependencies>
```

#### Solution 2: Use Tomcat 9.x (Java EE Compatible)

If you prefer to keep the current code structure, use Tomcat 9.x:

**Update Docker Compose** (`docker-compose.yml`):

```yaml
services:
  app:
    build: .
    ports:
      - "8080:8080"
    depends_on:
      - db
    environment:
      - CATALINA_OPTS=-Dfile.encoding=UTF-8
    # Use Tomcat 9 base image in Dockerfile
```

**Update Dockerfile**:

```dockerfile
FROM tomcat:9.0-jdk11
# Rest of your configuration...
```

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose
- Java JDK 11 or higher (for local development)
- Maven (for local development)

### Docker Setup (Recommended)

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd taskmanager-webapp
   ```

2. **Choose your approach**:
   - **For Tomcat 11**: Update code to Jakarta EE (see above)
   - **For compatibility**: Use Tomcat 9 Docker image

3. **Build the application**:
   ```bash
   mvn clean package
   ```

4. **Start the application**:
   ```bash
   docker-compose up --build
   ```

5. **Access the application**:
   - URL: http://localhost:8080
   - Default credentials:
     - Username: `admin`
     - Password: `password`

### Manual Setup (Without Docker)

1. **Set up MySQL database**:
   ```bash
   mysql -u root -p < init.sql
   ```

2. **Configure database connection**:
   Update `src/main/webapp/META-INF/context.xml` with your database credentials

3. **Build the application**:
   ```bash
   mvn clean package
   ```

4. **Deploy to Tomcat**:
   Copy `target/taskmanager-webapp.war` to your Tomcat `webapps` directory

5. **Start Tomcat** and access the application

## 🗄️ Database Schema

The application uses the following MySQL tables:

- **users**: User accounts and authentication
- **tasks**: Task information (titles, descriptions, due dates, priorities)
- **categories**: Task categories with custom names and colors

## 🛡️ API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | Home page |
| GET | `/login` | Login form |
| POST | `/login` | Authenticate user |
| GET | `/register` | Registration form |
| POST | `/register` | Create new user |
| GET | `/dashboard` | User dashboard |
| GET | `/tasks` | List all tasks |
| POST | `/tasks` | Create/update task |
| GET | `/profile` | User profile |
| POST | `/profile` | Update user password |
| GET | `/logout` | Logout user |
| POST | `/categories` | Create new category |

## 🎨 Customization

### Adding New Features

1. Create a new Servlet in `src/main/java/com/example/taskmanager/controller/`
2. Add the servlet mapping to `web.xml`
3. Create a JSP view in `src/main/webapp/WEB-INF/views/`
4. Update the navigation in the sidebar component

### Styling

The application uses CSS custom properties for easy theming. Modify the `:root` variables in `src/main/webapp/css/style.css`:

```css
:root {
  --primary: #4361ee;
  --secondary: #7209b7;
  --success: #06d6a0;
  --warning: #ffd60a;
  --danger: #ef476f;
  /* Add your custom colors */
}
```

## 🐛 Troubleshooting

### Common Issues

#### 1. 404 Errors / Servlet Not Found
**Symptoms**: Application loads but pages show 404 errors

**Solution**: Check Servlet API compatibility (see Servlet API section above)

#### 2. Database Connection Errors
**Symptoms**: Application starts but can't access data

**Troubleshooting steps**:
```bash
# Check if MySQL container is running
docker ps

# View database logs
docker-compose logs db

# Verify database credentials in docker-compose.yml
```

#### 3. Application Won't Start
**Symptoms**: Container fails to start or crashes

**Troubleshooting steps**:
```bash
# Check application logs
docker-compose logs app

# Verify Maven build succeeded
mvn clean package -X
```

#### 4. Static Resources Not Loading
**Symptoms**: CSS/JS files return 404

**Solutions**:
- Clear browser cache
- Check file paths in JSP pages
- Verify resource mapping in `web.xml`

### Viewing Logs

```bash
# Application logs
docker-compose logs app

# Database logs
docker-compose logs db

# All services
docker-compose logs
```

## 🔧 Development Tips

1. **Hot Reload**: For development, mount your source directory as a volume
2. **Database GUI**: Consider using Adminer or phpMyAdmin for database management
3. **IDE Setup**: Import as Maven project in IntelliJ IDEA or Eclipse
4. **Debugging**: Use remote debugging by exposing port 8000 in Docker

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit your changes: `git commit -am 'Add feature'`
4. Push to the branch: `git push origin feature-name`
5. Submit a pull request

## 📧 Support

If you encounter any issues or have questions:

1. Check the troubleshooting section above
2. Search existing issues in the GitHub repository
3. Open a new issue with detailed information about your problem

## 🙏 Acknowledgments

- Apache Tomcat community for excellent documentation
- MySQL team for reliable database engine
- Docker community for containerization best practices

---

**Note**: This README is regularly updated. Please check for the latest version before starting development.
