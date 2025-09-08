<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager - Welcome</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .welcome-container {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 400px;
            width: 100%;
        }
        .welcome-container h1 {
            color: #333;
            margin-bottom: 1.5rem;
        }
        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin: 0.5rem;
            transition: opacity 0.3s;
        }
        .btn:hover {
            opacity: 0.9;
        }
        .feature-list {
            text-align: left;
            margin: 1.5rem 0;
        }
        .feature-list li {
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="welcome-container">
        <h1>Welcome to Task Manager</h1>
        <p>Your personal task management solution</p>
        
        <div class="feature-list">
            <h3>Features:</h3>
            <ul>
                <li>Create and manage tasks</li>
                <li>Set priorities and due dates</li>
                <li>Organize tasks by categories</li>
                <li>Track your progress</li>
            </ul>
        </div>
        
        <a href="login" class="btn">Login</a>
        <a href="register" class="btn">Register</a>
        
        <p style="margin-top: 1.5rem; font-size: 0.9rem; color: #666;">
            Demo credentials: admin / password
        </p>
    </div>
</body>
</html>