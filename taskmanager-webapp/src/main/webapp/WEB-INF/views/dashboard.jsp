<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager - Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header>
        <h1>Task Manager</h1>
        <nav>
            <span>Welcome, ${user.username}</span>
            <a href="tasks">My Tasks</a>
            <a href="logout">Logout</a>
        </nav>
    </header>
    
    <main class="dashboard">
        <div class="dashboard-stats">
            <div class="stat-card">
                <h3>Total Tasks</h3>
                <p>${totalTasks}</p>
            </div>
            <div class="stat-card">
                <h3>Completed</h3>
                <p>${completedTasks}</p>
            </div>
            <div class="stat-card">
                <h3>Pending</h3>
                <p>${pendingTasks}</p>
            </div>
            <div class="stat-card">
                <h3>Overdue</h3>
                <p>${overdueTasks}</p>
            </div>
        </div>
        
        <div class="recent-tasks">
            <h2>Recent Tasks</h2>
            <c:if test="${not empty recentTasks}">
                <ul class="task-list">
                    <c:forEach items="${recentTasks}" var="task">
                        <li class="task-item priority-${task.priority}">
                            <div class="task-info">
                                <h4>${task.title}</h4>
                                <p>${task.description}</p>
                                <span class="due-date">Due: ${task.dueDate}</span>
                            </div>
                            <div class="task-actions">
                                <a href="tasks?action=edit&id=${task.id}" class="btn-edit">Edit</a>
                                <a href="tasks?action=delete&id=${task.id}" class="btn-delete">Delete</a>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
            <c:if test="${empty recentTasks}">
                <p>No tasks yet. <a href="tasks?action=new">Create your first task</a></p>
            </c:if>
        </div>
    </main>
</body>
</html>