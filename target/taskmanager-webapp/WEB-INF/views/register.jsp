<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager - Register</title>
    <style>
        :root {
            --bg-1: #dff6ff;
            --bg-2: #9ad0ec;
            --accent: #3498db;
            --muted: #5c728a;
            --radius: 14px;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--bg-1), var(--bg-2));
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }

        /* Header */
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

        /* Register box */
        .register-container {
            background: rgba(255,255,255,0.9);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: 0 10px 28px rgba(0,0,0,0.15);
            max-width: 420px;
            width: 100%;
            animation: fadeIn 0.7s ease;
        }
        .register-container h1 {
            color: #2d3a4a;
            margin-bottom: 1.5rem;
            text-align: center;
            font-size: 24px;
        }

        /* Form */
        .form-group {
            margin-bottom: 1rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.4rem;
            font-weight: 600;
            font-size: 14px;
            color: #2d3a4a;
        }
        .form-group input {
            width: 100%;
            padding: 0.7rem;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
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
            background: linear-gradient(135deg, #5dade2, #3498db);
            color: white;
            border: none;
            padding: 0.8rem;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            width: 100%;
            font-weight: 600;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(0,0,0,0.15);
        }

        /* Error message */
        .error-message {
            background-color: #f8d7da;
            color: #842029;
            padding: 0.7rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
            text-align: center;
            font-size: 14px;
        }

        /* Login link */
        .login-link {
            text-align: center;
            margin-top: 1rem;
            font-size: 13px;
            color: var(--muted);
        }
        .login-link a {
            color: var(--accent);
            text-decoration: none;
            font-weight: 600;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(12px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="header">Task Manager</div>

    <div class="register-container">
        <h1>Create Account</h1>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form action="register" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="submit">Register</button>
        </form>

        <div class="login-link">
            <p>Already have an account? <a href="login">Login here</a></p>
        </div>
    </div>
</body>
</html>
