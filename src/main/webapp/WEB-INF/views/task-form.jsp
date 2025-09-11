<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager - ${empty task ? 'New Task' : 'Edit Task'}</title>
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
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header */
        .header {
            background: linear-gradient(135deg, var(--bg-1), var(--bg-2));
            color: #0f172a;
            padding: 1rem;
            text-align: center;
            font-size: 22px;
            font-weight: 700;
            box-shadow: 0 4px 14px rgba(0,0,0,0.08);
        }
        .header nav {
            margin-top: 0.5rem;
        }
        .header nav a {
            color: #0f172a;
            margin: 0 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }
        .header nav span {
            margin-right: 1rem;
            color: var(--muted);
            font-size: 14px;
        }

        /* Main container */
        main.task-form-page {
            flex: 1;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        main h2 {
            margin-bottom: 1.5rem;
            color: #2d3a4a;
        }

        /* Form card */
        form {
            background: rgba(255,255,255,0.95);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: 0 8px 24px rgba(0,0,0,0.12);
            width: 100%;
            max-width: 600px;
            margin-bottom: 2rem;
        }
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
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.7rem;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.2s ease;
        }
        .form-group textarea {
            min-height: 80px;
            resize: vertical;
        }
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(52,152,219,0.25);
        }

        /* Form actions */
        .form-actions {
            margin-top: 1.5rem;
            display: flex;
            gap: 1rem;
        }
        button, .btn-cancel {
            padding: 0.8rem 1.2rem;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        button {
            background: linear-gradient(135deg, #5dade2, #3498db);
            color: white;
            flex: 1;
        }
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.15);
        }
        .btn-cancel {
            background: #e5e7eb;
            color: #374151;
            text-decoration: none;
            text-align: center;
            flex: 1;
        }
        .btn-cancel:hover {
            background: #d1d5db;
        }

        /* Add category */
        .add-category {
            background: rgba(255,255,255,0.95);
            padding: 1.5rem;
            border-radius: var(--radius);
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 600px;
        }
        .add-category h3 {
            margin-bottom: 1rem;
            color: #2d3a4a;
            font-size: 18px;
        }
        .add-category button {
            margin-top: 1rem;
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Task Manager</h1>
        <nav>
            <span>Welcome, ${user.username}</span>
            <a href="dashboard">Dashboard</a>
            <a href="tasks">My Tasks</a>
            <a href="profile">Profile</a>
            <a href="logout">Logout</a>
        </nav>
    </div>

    <main class="task-form-page">
        <h2>${empty task ? 'Create New Task' : 'Edit Task'}</h2>

        <form action="tasks" method="post">
            <c:if test="${not empty task}">
                <input type="hidden" name="id" value="${task.id}">
            </c:if>

            <div class="form-group">
                <label for="title">Title *</label>
                <input type="text" id="title" name="title" value="${task.title}" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description">${task.description}</textarea>
            </div>

            <div class="form-group">
                <label for="dueDate">Due Date</label>
                <input type="date" id="dueDate" name="dueDate" value="${task.dueDate}">
            </div>

            <div class="form-group">
                <label for="priority">Priority</label>
                <select id="priority" name="priority">
                    <option value="low" ${task.priority == 'low' ? 'selected' : ''}>Low</option>
                    <option value="medium" ${task.priority == 'medium' ? 'selected' : ''}>Medium</option>
                    <option value="high" ${task.priority == 'high' ? 'selected' : ''}>High</option>
                </select>
            </div>

            <div class="form-group">
                <label for="status">Status</label>
                <select id="status" name="status">
                    <option value="pending" ${task.status == 'pending' ? 'selected' : ''}>Pending</option>
                    <option value="in-progress" ${task.status == 'in-progress' ? 'selected' : ''}>In Progress</option>
                    <option value="completed" ${task.status == 'completed' ? 'selected' : ''}>Completed</option>
                </select>
            </div>

            <div class="form-group">
                <label for="categoryId">Category</label>
                <select id="categoryId" name="categoryId">
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.id}" ${task.categoryId == category.id ? 'selected' : ''}>
                            ${category.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-actions">
                <button type="submit">${empty task ? 'Create Task' : 'Update Task'}</button>
                <a href="tasks" class="btn-cancel">Cancel</a>
            </div>
        </form>

        <div class="add-category">
            <h3>Add New Category</h3>
            <form action="categories" method="post">
                <div class="form-group">
                    <label for="categoryName">Category Name</label>
                    <input type="text" id="categoryName" name="name" required>
                </div>
                <div class="form-group">
                    <label for="categoryColor">Color</label>
                    <input type="color" id="categoryColor" name="color" value="#4CAF50">
                </div>
                <button type="submit">Add Category</button>
            </form>
        </div>
    </main>
</body>
</html>
