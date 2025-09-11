<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager - Dashboard</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <style>
        /* full-page gradient background */
        html, body { height: 100%; margin: 0; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e9f7ff 0%, #dff1ff 30%, #cfe8ff 60%, #b7dbff 100%);
            background-attachment: fixed;
            color: #333;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        /* Keep your original layout/styling mostly intact */
        .navbar {
            background: linear-gradient(135deg, #1565c0 0%, #1976d2 50%, #42a5f5 100%);
            color: white;
            padding: 1rem;
            text-align: center;
            box-shadow: 0 2px 10px rgba(21, 101, 192, 0.3);
        }
        .navbar h1 { margin: 0 0 10px 0; font-size: 1.8rem; font-weight: 300; }
        .navbar a { color: white; margin: 0 15px; text-decoration: none; font-weight: 500; padding: 8px 16px; border-radius: 20px; transition: background 0.3s; }
        .navbar a:hover { background: rgba(255,255,255,0.14); }

        header {
            text-align: center;
            padding: 2rem 1rem;
            background: rgba(255,255,255,0.9);
            box-shadow: 0 4px 20px rgba(21, 101, 192, 0.06);
            margin: 30px auto 20px;
            max-width: 1200px;
            border-radius: 0 0 20px 20px;
        }
        header h1 { margin: 0; color: #1565c0; font-size: 2.2rem; font-weight: 300; }
        .greeting { font-size: 1.3rem; margin-top: 1rem; color: #455a64; font-weight: 400; }

        main.dashboard {
            max-width: 1200px;
            margin: 0 auto 60px;
            padding: 0 16px;
        }

        /* Info / Quick inspiration blocks (kept from your original) */
        .info-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }
        .clock, .quote-card {
            background: linear-gradient(135deg, #1976d2 0%, #42a5f5 100%);
            color: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(25, 118, 210, 0.25);
            text-align: center;
            transition: transform 0.3s;
        }
        .clock h3, .quote-card h3 { margin: 0 0 10px 0; font-size: 1.1rem; opacity: 0.95; font-weight: 400; }
        .clock-time { font-size: 1.8rem; font-weight: 300; margin: 5px 0; }
        .clock-date { font-size: 1rem; opacity: 0.9; }
        .quote-text { font-style: italic; font-size: 0.95rem; line-height: 1.4; margin: 10px 0; }
        .quote-author { font-size: 0.9rem; opacity: 0.9; margin-top: 10px; }

        @media (max-width:768px) {
            .info-section { grid-template-columns: 1fr; }
        }

        /* Dashboard stat cards */
        .dashboard-stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px,1fr)); gap:20px; margin-bottom:30px; }
        .stat-card { background: white; padding:25px; border-radius:15px; text-align:center; box-shadow:0 8px 25px rgba(21,101,192,0.08); border-left:4px solid #1976d2; }
        .stat-card h3 { margin:0; color:#1565c0; font-size:1.1rem; font-weight:500; }
        .stat-card p { font-size:2.2rem; margin:12px 0 0; font-weight:300; color:#1976d2; }

        /* Recent tasks */
        .recent-tasks { margin-bottom:40px; }
        .recent-tasks h2 { color:#1565c0; margin-bottom:20px; font-size:1.8rem; font-weight:400; }
        .task-list { list-style:none; padding:0; }
        .task-item { background:white; padding:20px; border-radius:12px; margin-bottom:15px; box-shadow:0 4px 15px rgba(21,101,192,0.08); display:flex; justify-content:space-between; align-items:center; border-left:4px solid #42a5f5; }
        .task-info h4 { margin:0 0 8px 0; color:#1565c0; font-weight:500; }
        .task-actions a { margin-left:10px; padding:8px 16px; border-radius:8px; text-decoration:none; font-size:0.9rem; font-weight:500; transition:all 0.3s; }
        .btn-edit { background:#1976d2; color:white; } .btn-delete { background:#ef5350; color:white; }

        /* Quotes section */
        .quotes-section { background: linear-gradient(135deg,#1565c0 0%, #1976d2 50%, #42a5f5 100%); color:white; padding:40px; border-radius:20px; text-align:center; margin-bottom:30px; box-shadow:0 10px 30px rgba(21,101,192,0.18); }
        .main-quote { font-size:1.25rem; font-style:italic; line-height:1.6; margin:20px 0; opacity:0.95; }
        .quote-author-main { font-size:1rem; opacity:0.9; margin-top:15px; }
        .quote-btn { background: rgba(255,255,255,0.18); color:white; border: 2px solid rgba(255,255,255,0.26); padding:10px 18px; border-radius:20px; cursor:pointer; font-weight:500; }

        @keyframes fadeIn { from { opacity:0; transform:translateY(20px);} to { opacity:1; transform:translateY(0);} }
        .fade-in { animation: fadeIn 0.6s ease-out; }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>Task Manager</h1>
        <div>
            <a href="dashboard">Dashboard</a>
            <a href="tasks">My Tasks</a>
            <a href="profile">Profile</a>
            <a href="logout">Logout</a>
        </div>
    </div>

    <header>
        <h1>Welcome, ${user.username} 👋</h1>
        <p class="greeting">Stay productive and make today awesome!</p>
    </header>

    <main class="dashboard">
        <!-- Info row -->
        <div class="info-section">
            <div class="clock">
                <h3>Current Time</h3>
                <div id="clock-time" class="clock-time">Loading...</div>
                <div id="clock-date" class="clock-date">Loading...</div>
            </div>

            <div class="quote-card">
                <h3>Quick Inspiration</h3>
                <div id="mini-quote" class="quote-text">Loading...</div>
                <div id="mini-author" class="quote-author">—</div>
            </div>
        </div>

        <!-- Stats -->
        <div class="dashboard-stats">
            <div class="stat-card"><h3>Total Tasks</h3><p>${totalTasks}</p></div>
            <div class="stat-card"><h3>Completed</h3><p>${completedTasks}</p></div>
            <div class="stat-card"><h3>Pending</h3><p>${pendingTasks}</p></div>
            <div class="stat-card"><h3>Overdue</h3><p>${overdueTasks}</p></div>
        </div>

        <!-- Recent tasks -->
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
                <p>No tasks yet. <a href="tasks?action=new" style="color:#1976d2; font-weight:500;">Create your first task</a></p>
            </c:if>
        </div>

        <!-- Big daily inspiration -->
        <div class="quotes-section">
            <h2>Daily Inspiration</h2>
            <div id="main-quote" class="main-quote">Loading...</div>
            <div id="main-quote-author" class="quote-author-main">—</div>
            <div style="margin-top:18px;">
                <button id="main-quote-btn" class="quote-btn">New Quote</button>
            </div>
        </div>

        <div class="extra-section" style="background:white; padding:30px; border-radius:14px; box-shadow:0 8px 25px rgba(21,101,192,0.06); margin-bottom:60px;">
            <h2 style="color:#1565c0; margin-top:0;">Why Task Management Matters</h2>
            <p style="color:#455a64;">Effective task management helps you stay focused, reduces stress, and ensures you never miss a deadline. It allows you to prioritize work, track progress, and balance personal and professional responsibilities.</p>
            <ul style="color:#375b67;">
                <li>✅ Boosts productivity by breaking big goals into smaller tasks.</li>
                <li>✅ Reduces stress by organizing thoughts and deadlines.</li>
                <li>✅ Helps you track progress and celebrate achievements.</li>
                <li>✅ Improves accountability and team collaboration.</li>
            </ul>
        </div>
    </main>

    <script>
        // --- Clock (works immediately; elements are checked before use) ---
        function updateClock() {
            const now = new Date();
            const timeOptions = { hour:'2-digit', minute:'2-digit', second:'2-digit', hour12:true };
            const dateOptions = { weekday:'long', year:'numeric', month:'long', day:'numeric' };
            const t = document.getElementById('clock-time');
            const d = document.getElementById('clock-date');
            if (t) t.textContent = now.toLocaleTimeString('en-US', timeOptions);
            if (d) d.textContent = now.toLocaleDateString('en-US', dateOptions);
        }
        setInterval(updateClock, 1000);
        updateClock();

        // --- Quotes data (safe strings) ---
        const inspirationalQuotes = [
            { text: "The secret of getting ahead is getting started.", author: "Mark Twain" },
            { text: "The future depends on what you do today.", author: "Mahatma Gandhi" },
            { text: "Don't watch the clock; do what it does. Keep going.", author: "Sam Levenson" },
            { text: "Productivity is never an accident. It is always the result of commitment to excellence, intelligent planning, and focused effort.", author: "Paul J. Meyer" },
            { text: "Your mind is for having ideas, not holding them.", author: "David Allen" },
            { text: "The way to get started is to quit talking and begin doing.", author: "Walt Disney" },
            { text: "Success is not final, failure is not fatal: it is the courage to continue that counts.", author: "Winston Churchill" },
            { text: "The only impossible journey is the one you never begin.", author: "Tony Robbins" },
            { text: "Time is what we want most, but what we use worst.", author: "William Penn" },
            { text: "Focus on being productive instead of busy.", author: "Tim Ferriss" }
        ];

        const miniQuotes = [
            { text: "Success is not final, failure is not fatal: it is the courage to continue that counts.", author: "Winston Churchill" },
            { text: "The only way to do great work is to love what you do.", author: "Steve Jobs" },
            { text: "Innovation distinguishes between a leader and a follower.", author: "Steve Jobs" },
            { text: "Life is what happens to you while you're busy making other plans.", author: "John Lennon" },
            { text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt" }
        ];

        let currentQuoteIndex = 0;
        let currentMiniIndex = 0;

        // Safe updater for main quote
        function showNewQuote() {
            if (!Array.isArray(inspirationalQuotes) || inspirationalQuotes.length === 0) return;
            currentQuoteIndex = (currentQuoteIndex + 1) % inspirationalQuotes.length;
            const q = inspirationalQuotes[currentQuoteIndex];
            const el = document.getElementById('main-quote');
            const auth = document.getElementById('main-quote-author');
            if (!el || !auth) return;
            el.style.animation = 'none';
            auth.style.animation = 'none';
            void el.offsetWidth; void auth.offsetWidth;
            el.style.animation = 'fadeIn 0.6s ease-out';
            auth.style.animation = 'fadeIn 0.6s ease-out';
            el.textContent = '"' + (q.text || '') + '"';
            auth.textContent = '— ' + (q.author || '');
        }

        // Safe updater for mini quote
        function updateMiniQuote() {
            if (!Array.isArray(miniQuotes) || miniQuotes.length === 0) return;
            currentMiniIndex = (currentMiniIndex + 1) % miniQuotes.length;
            const q = miniQuotes[currentMiniIndex];
            const el = document.getElementById('mini-quote');
            const auth = document.getElementById('mini-author');
            if (!el || !auth) return;
            el.style.animation = 'none';
            auth.style.animation = 'none';
            void el.offsetWidth; void auth.offsetWidth;
            el.style.animation = 'fadeIn 0.6s ease-out';
            auth.style.animation = 'fadeIn 0.6s ease-out';
            el.textContent = '"' + (q.text || '') + '"';
            auth.textContent = '— ' + (q.author || '');
        }

        // Initialize and start timers after DOM is ready (prevents race conditions)
        document.addEventListener('DOMContentLoaded', function () {
            // set initial main quote
            const mainEl = document.getElementById('main-quote');
            const mainAuth = document.getElementById('main-quote-author');
            if (mainEl && mainAuth && Array.isArray(inspirationalQuotes) && inspirationalQuotes.length > 0) {
                mainEl.textContent = '"' + inspirationalQuotes[0].text + '"';
                mainAuth.textContent = '— ' + inspirationalQuotes[0].author;
            }

            // set initial mini quote
            const miniEl = document.getElementById('mini-quote');
            const miniAuth = document.getElementById('mini-author');
            if (miniEl && miniAuth && Array.isArray(miniQuotes) && miniQuotes.length > 0) {
                miniEl.textContent = '"' + miniQuotes[0].text + '"';
                miniAuth.textContent = '— ' + miniQuotes[0].author;
            }

            // start rotation timers AFTER elements exist
            setInterval(showNewQuote, 25000); // main every 25s
            setInterval(updateMiniQuote, 10000); // mini every 10s

            // Hook up manual button
            const btn = document.getElementById('main-quote-btn');
            if (btn) btn.addEventListener('click', showNewQuote);

            // initial fade-in for some elements (cosmetic)
            const elements = document.querySelectorAll('.stat-card, .task-item, .extra-section');
            elements.forEach((el, idx) => setTimeout(() => el.classList.add('fade-in'), idx * 80));
        });

    </script>
</body>
</html>
