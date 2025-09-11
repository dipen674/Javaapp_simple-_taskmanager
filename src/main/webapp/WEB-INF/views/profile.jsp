<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager - Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #a2d9ff 0%, #6faedb 100%);
            color: #333;
            min-height: 100vh;
        }

        /* Navbar */
        .navbar {
            background: linear-gradient(135deg, #6faedb 0%, #4f8ec4 100%);
            color: white;
            padding: 1rem;
            text-align: center;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        .navbar h1 {
            margin: 0;
            font-size: 1.8rem;
        }
        .navbar a {
            color: white;
            margin: 0 10px;
            text-decoration: none;
            font-weight: 500;
            transition: opacity 0.3s;
        }
        .navbar a:hover {
            opacity: 0.85;
        }

        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 20px;
        }

        header {
            background: #f9fbfd;
            color: #2b4a66;
            padding: 20px;
            text-align: center;
            border-radius: 12px 12px 0 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        header h1 {
            margin: 0;
        }
        header p {
            margin: 0.5rem 0 0 0;
            font-size: 0.95rem;
            color: #555;
        }

        .profile-content {
            background: white;
            padding: 30px;
            border-radius: 0 0 12px 12px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        }
        .profile-content h2 {
            color: #2b4a66;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .form-group {
            margin-bottom: 1.2rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.4rem;
            font-weight: 500;
        }
        .form-group input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ccd9e6;
            border-radius: 6px;
            font-size: 1rem;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 0.75rem;
            border-radius: 6px;
            margin-bottom: 1rem;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 0.75rem;
            border-radius: 6px;
            margin-bottom: 1rem;
        }
        
        .btn {
            padding: 10px 20px;
            background: #4f8ec4;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 0.95em;
            display: block;
            width: 100%;
            text-align: center;
            margin-top: 10px;
        }
        .btn:hover {
            background: #3b739f;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <h1>Task Manager</h1>
        <div>
            <a href="dashboard">Dashboard</a>
            <a href="tasks">My Tasks</a>
            <a href="profile">Profile</a>
            <a href="logout">Logout</a>
        </div>
    </div> 

    <div class="container">
        <header>
            <h1>User Profile</h1>
            <p>Manage your account settings</p>
        </header>
        
        <div class="profile-content">
            <h2>Change Password</h2>
            
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            
            <c:if test="${not empty message}">
                <div class="success-message">${message}</div>
            </c:if>
            
            <form action="profile" method="post">
                <div class="form-group">
                    <label for="currentPassword">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" required>
                </div>
                
                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" required>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                
                <button type="submit" class="btn">Update Password</button>
            </form>
        </div>
    </div>
</body>
</html>