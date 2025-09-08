<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager - Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="login-body">
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 1rem; text-align: center;">
    <h1>Task Manager</h1>
    <div>
        <a href="dashboard" style="color: white; margin: 0 10px; text-decoration: none;">Dashboard</a>
        <a href="tasks" style="color: white; margin: 0 10px; text-decoration: none;">My Tasks</a>
        <a href="profile" style="color: white; margin: 0 10px; text-decoration: none;">Profile</a>
        <a href="logout" style="color: white; margin: 0 10px; text-decoration: none;">Logout</a>
    </div>
</div>
    <c:if test="${not empty param.registered}">
    <div class="success-message" style="background-color: #d4edda; color: #155724; padding: 0.75rem; border-radius: 4px; margin-bottom: 1rem; text-align: center;">
        Registration successful! Please login.
    </div>
</c:if>
    <div class="login-container">
        <h1>Task Manager</h1>
        <form action="login" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit">Login</button>
        </form>
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        <p>Default credentials: admin / password</p>
    </div>
</body>
</html>