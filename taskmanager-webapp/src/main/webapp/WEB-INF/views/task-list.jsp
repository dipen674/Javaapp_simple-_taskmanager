<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager - My Tasks</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header>
        <h1>Task Manager</h1>
        <nav>
            <span>Welcome, ${user.username}</span>
            <a href="dashboard">Dashboard</a>
            <a href="tasks?action=new">New Task</a>
            <a href="logout">Logout</a>
        </nav>
    </header>
    
    <main class="task-list-page">
        <h2>My Tasks</h2>
        
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
        <c:if test="${empty tasks}">
            <p>No tasks found. <a href="tasks?action=new">Create your first task</a></p>
        </c:if>
    </main>
</body>
</html>