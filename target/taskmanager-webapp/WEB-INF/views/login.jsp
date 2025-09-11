<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager - Login</title>
    <style>
        :root {
            --bg-1: #dff6ff;
            --bg-2: #9ad0ec;
            --accent: #3498db;
            --muted: #5c728a;
            --radius: 14px;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body.login-body {
            height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--bg-1), var(--bg-2));
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }

        /* Header bar */
        .header {
            background: linear-gradient(135deg, var(--bg-1), var(--bg-2));
            color: #0f172a;
            padding: 1rem;
            text-align: center;
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 1.5rem;
            border-radius: var(--radius);
            box-shadow: 0 4px 14px rgba(0,0,0,0.08);
        }

        /* Messages */
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 0.75rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
            text-align: center;
            font-size: 14px;
        }
        .error-message {
            background-color: #f8d7da;
            color: #842029;
            padding: 0.6rem;
            border-radius: var(--radius);
            margin-top: 0.75rem;
            font-size: 14px;
            text-align: center;
        }

        /* Login container */
        .login-container {
            background: rgba(255,255,255,0.85);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: 0 10px 28px rgba(0,0,0,0.15);
            width: 100%;
            max-width: 380px;
            animation: fadeIn 0.7s ease;
        }
        .login-container h1 {
            text-align: center;
            font-size: 24px;
            margin-bottom: 1.5rem;
            color: #2d3a4a;
        }

        /* Form styling */
        .form-group {
            margin-bottom: 1rem;
        }
        .form-group label {
            display: block;
            font-size: 14px;
            margin-bottom: 0.4rem;
            color: #2d3a4a;
            font-weight: 600;
        }
        .form-group input {
            width: 100%;
            padding: 0.7rem;
            border-radius: 8px;
            border: 1px solid #cbd5e1;
            font-size: 14px;
            transition: all 0.2s ease;
        }
        .form-group input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(52,152,219,0.25);
        }

        /* Button */
        button {
            width: 100%;
            padding: 0.8rem;
            font-size: 15px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            background: linear-gradient(135deg, #5dade2, #3498db);
            color: white;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(0,0,0,0.15);
        }

        /* Small text */
        .login-container p {
            font-size: 13px;
            text-align: center;
            margin-top: 1rem;
            color: var(--muted);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(12px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body class="login-body">
    <div class="header">Task Manager</div>

    <c:if test="${not empty param.registered}">
        <div class="success-message">
            Registration successful! Please login.
        </div>
    </c:if>

    <div class="login-container">
        <h1>Login</h1>
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

        <p>Don’t have an account? <a href="register" style="color: var(--accent); text-decoration: none; font-weight: 600;">Register here</a></p>
    </div>
</body>
</html>
