<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager - My Tasks</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #a2d9ff 0%, #6faedb 100%);
            min-height: 100vh;
            color: #333;
        }

        /* Top bar */
        .navbar {
            background: linear-gradient(135deg, #6faedb 0%, #4f8ec4 100%);
            color: white;
            padding: 1rem;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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

        /* Main content */
        main.task-list-page {
            max-width: 900px;
            margin: 2rem auto;
            background: #ffffffd9;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        }
        main h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #2b4a66;
        }

        /* Filters */
        .filters {
            margin-bottom: 1.5rem;
            text-align: center;
        }
        .filters select, .filters button {
            padding: 0.6rem;
            margin: 0.3rem;
            border: 1px solid #ccd9e6;
            border-radius: 6px;
            font-size: 0.95rem;
        }
        .filters button {
            background: linear-gradient(135deg, #6faedb 0%, #4f8ec4 100%);
            color: white;
            cursor: pointer;
            border: none;
            transition: opacity 0.3s;
        }
        .filters button:hover {
            opacity: 0.9;
        }

        /* Task list */
        .task-list {
            list-style: none;
            padding: 0;
        }
        .task-item {
            background: #f9fbfd;
            margin-bottom: 1rem;
            border-radius: 10px;
            padding: 1rem;
            display: flex;
            align-items: flex-start;
            box-shadow: 0 3px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .task-item:hover {
            transform: scale(1.02);
        }
        .task-color {
            width: 10px;
            height: 100%;
            border-radius: 6px 0 0 6px;
            margin-right: 1rem;
        }
        .task-info h4 {
            margin: 0 0 0.5rem 0;
            color: #2b4a66;
        }
        .task-info p {
            margin: 0 0 0.5rem 0;
            color: #555;
        }
        .task-meta {
            font-size: 0.85rem;
            color: #666;
        }
        .task-meta span {
            margin-right: 1rem;
        }

        /* Buttons inside tasks */
        .task-actions {
            margin-left: auto;
            display: flex;
            gap: 0.5rem;
        }
        .task-actions a {
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.9rem;
            transition: background 0.3s;
        }
        .btn-edit {
            background: #4f8ec4;
            color: white;
        }
        .btn-edit:hover {
            background: #3b739f;
        }
        .btn-delete {
            background: #e57373;
            color: white;
        }
        .btn-delete:hover {
            background: #c94747;
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            font-size: 1.1rem;
            margin-top: 2rem;
        }
        .empty-state a {
            color: #4f8ec4;
            font-weight: bold;
            text-decoration: none;
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

    <!-- Main -->
    <main class="task-list-page">
        <h2>My Tasks</h2>

        <!-- Filters -->
        <div class="filters">
            <form method="get" action="tasks">
                <select name="category">
                    <option value="">All Categories</option>
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.id}">${category.name}</option>
                    </c:forEach>
                </select>
                <select name="status">
                    <option value="">All Status</option>
                    <option value="pending">Pending</option>
                    <option value="in-progress">In Progress</option>
                    <option value="completed">Completed</option>
                </select>
                <button type="submit">Filter</button>
            </form>
        </div>

        <!-- Task list -->
        <c:if test="${not empty tasks}">
            <ul class="task-list">
                <c:forEach items="${tasks}" var="task">
                    <c:set var="category" value="${null}" />
                    <c:forEach items="${categories}" var="cat">
                        <c:if test="${cat.id == task.categoryId}">
                            <c:set var="category" value="${cat}" />
                        </c:if>
                    </c:forEach>
                    
                    <li class="task-item priority-${task.priority}">
                        <div class="task-color" style="background-color: ${category.color}"></div>
                        <div class="task-info">
                            <h4>${task.title}</h4>
                            <p>${task.description}</p>
                            <div class="task-meta">
                                <span class="category">${category.name}</span>
                                <span class="status status-${task.status}">${task.status}</span>
                                <span class="due-date">Due: ${task.dueDate}</span>
                            </div>
                        </div>
                        <div class="task-actions">
                            <a href="tasks?action=edit&id=${task.id}" class="btn-edit">Edit</a>
                            <a href="tasks?action=delete&id=${task.id}" class="btn-delete">Delete</a>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </c:if>

        <!-- Empty tasks -->
        <c:if test="${empty tasks}">
            <p class="empty-state">No tasks found. <a href="tasks?action=new">Create your first task</a></p>
        </c:if>
    </main>
</body>
</html>
