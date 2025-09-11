<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Task Manager - Welcome</title>
    <style>
        :root {
            --bg-1: #dff6ff;
            --bg-2: #9ad0ec;
            --accent: #5dade2;
            --glass: rgba(255,255,255,0.25);
            --muted: #5c728a;
            --radius: 16px;
        }
        * { box-sizing: border-box; }
        html, body {
            height: 100%;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Calm sky-blue background */
        body {
            background: linear-gradient(135deg, #f0faff 0%, #dff6ff 45%, #9ad0ec 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            overflow: auto;
        }

        /* Gentle background blobs */
        .bg-blob {
            position: absolute;
            filter: blur(100px);
            opacity: 0.25;
            border-radius: 50%;
        }
        .bg-blob.one {
            width: 320px; height: 320px;
            background: #aee1f9;
            top: -80px; left: -80px;
        }
        .bg-blob.two {
            width: 280px; height: 280px;
            background: #c4f1f9;
            bottom: -60px; right: -60px;
        }

        /* Glassmorphic container */
        .welcome-container {
            position: relative;
            backdrop-filter: blur(20px) saturate(160%);
            -webkit-backdrop-filter: blur(20px) saturate(160%);
            background: rgba(255, 255, 255, 0.4);
            border-radius: var(--radius);
            border: 1px solid rgba(255,255,255,0.3);
            box-shadow: 0 18px 48px rgba(0,0,0,0.12);
            display: grid;
            grid-template-columns: 1fr 340px;
            max-width: 920px;
            width: 100%;
            overflow: hidden;
        }

        /* Left column */
        .left {
            padding: 36px 44px;
            color: #2d2d2d;
        }
        .logo-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }
        .logo-mark {
            width: 44px; height: 44px;
            border-radius: 12px;
            background: linear-gradient(135deg, #5dade2, #9ad0ec);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 18px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.18);
        }
        h1 {
            font-size: 28px;
            margin: 8px 0 14px;
        }
        p.lead {
            font-size: 15px;
            margin: 0 0 20px;
            color: #445;
        }

        /* Quote */
        .quote-box {
            margin: 18px 0 22px;
            padding: 18px;
            background: rgba(255,255,255,0.55);
            border-radius: 12px;
            border: 1px solid rgba(0,0,0,0.06);
            box-shadow: 0 6px 16px rgba(0,0,0,0.08);
        }
        .quote-text {
            font-style: italic;
            font-size: 15px;
            color: #2d3a4a;
            opacity: 0;
            transform: translateY(8px);
            transition: all 500ms ease;
        }
        .quote-text.show {
            opacity: 1;
            transform: translateY(0);
        }
        .quote-author {
            font-size: 13px;
            color: #666;
            text-align: right;
            margin-top: 6px;
        }

        /* Features */
        .feature-list h3 {
            font-size: 17px;
            color: #2d2d2d;
        }
        .feature-list ul {
            margin: 0;
            padding-left: 20px;
            color: #444;
            font-size: 14px;
        }
        .feature-list li {
            margin-bottom: 6px;
        }

        /* Buttons */
        .actions {
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
            margin-top: 18px;
        }
        .btn {
            padding: 0.7rem 1.3rem;
            border-radius: 10px;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            color: #fff;
            background: linear-gradient(135deg, #5dade2, #3498db);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            transition: all 0.25s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.18);
        }
        .btn.ghost {
            background: transparent;
            border: 1px solid rgba(0,0,0,0.1);
            color: #2d3a4a;
        }

        /* Right column mockup */
        .right {
            background: rgba(255,255,255,0.45);
            padding: 28px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 18px;
            min-height: 320px;
        }
        .mockup {
            width: 270px;
            height: 190px;
            border-radius: 14px;
            background: #fff;
            box-shadow: 0 10px 22px rgba(0,0,0,0.1);
            padding: 16px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            animation: float 8s ease-in-out infinite;
        }
        @keyframes float {
            0% { transform: translateY(0); }
            50% { transform: translateY(8px); }
            100% { transform: translateY(0); }
        }
        .mock-task {
            background: linear-gradient(90deg, rgba(157, 216, 255,0.15), transparent);
            padding: 8px;
            border-radius: 6px;
        }
        .task-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .dot {
            width: 9px; height: 9px;
            border-radius: 50%;
        }
        .dot.low { background: #a7f3d0; }
        .dot.mid { background: #fde68a; }
        .dot.high { background: #fca5a5; }

        .small {
            font-size: 12px;
            color: #666;
        }

        /* Entrance animation */
        .fade-up {
            opacity: 0;
            transform: translateY(10px);
            transition: all 600ms cubic-bezier(.2,.9,.3,1);
        }
        .fade-up.in {
            opacity: 1;
            transform: translateY(0);
        }

        @media (max-width: 768px) {
            .welcome-container {
                grid-template-columns: 1fr;
                max-width: 520px;
            }
            .right {
                order: -1;
            }
        }
    </style>
</head>
<body>
    <div class="bg-blob one"></div>
    <div class="bg-blob two"></div>

    <div class="welcome-container">
        <div class="left">
            <div class="logo-row fade-up">
                <div class="logo-mark">TM</div>
                <div>
                    <div style="font-weight:700;font-size:16px;">Task Manager</div>
                    <div style="font-size:12px;color:#666;margin-top:2px">Organize, Prioritize, Achieve</div>
                </div>
            </div>

            <h1 id="welcomeTitle" class="fade-up">Welcome to Task Manager</h1>
            <p class="lead fade-up">Your personal task management solution — built to help you stay focused and ship more.</p>

            <div class="quote-box fade-up">
                <div class="quote-text" id="quoteText">“Planning is bringing the future into the present so that you can do something about it now.”</div>
                <div class="quote-author" id="quoteAuthor">— Alan Lakein</div>
            </div>

            <div class="feature-list fade-up">
                <h3>Features:</h3>
                <ul>
                    <li>Create and manage tasks</li>
                    <li>Set priorities and due dates</li>
                    <li>Organize tasks by categories</li>
                    <li>Track your progress</li>
                </ul>
            </div>

            <div class="actions fade-up">
                <a href="login" class="btn" id="loginBtn">Login</a>
                <a href="register" class="btn ghost" id="registerBtn">Register</a>
                <div style="flex:1"></div>
                <div class="small">Tip: Use <kbd>Ctrl</kbd> + <kbd>K</kbd> to search tasks</div>
            </div>
        </div>

        <div class="right">
            <div class="mockup">
                <div style="display:flex;justify-content:space-between;align-items:center">
                    <strong style="font-size:13px;color:#2d2d2d">Today · 4 tasks</strong>
                    <small style="color:#666">Updated</small>
                </div>

                <div class="mock-task">
                    <div class="task-row">
                        <div style="display:flex;gap:8px;align-items:center">
                            <div class="dot high"></div>
                            <div style="font-weight:600;font-size:13px">Fix notification bug</div>
                        </div>
                        <div style="font-size:11px;color:#666">Today</div>
                    </div>
                </div>

                <div class="mock-task">
                    <div class="task-row">
                        <div style="display:flex;gap:8px;align-items:center">
                            <div class="dot mid"></div>
                            <div style="font-size:13px">Write onboarding docs</div>
                        </div>
                        <div style="font-size:11px;color:#666">Tomorrow</div>
                    </div>
                </div>

                <div class="mock-task">
                    <div class="task-row">
                        <div style="display:flex;gap:8px;align-items:center">
                            <div class="dot low"></div>
                            <div style="font-size:13px">Refactor auth flow</div>
                        </div>
                        <div style="font-size:11px;color:#666">Fri</div>
                    </div>
                </div>
            </div>

            <div style="text-align:center;color:#666;font-size:12px">Stay consistent — small steps compound into big progress.</div>
        </div>
    </div>

    <script>
        (function(){
            const quotes = [
                {text: '“Simplicity is the soul of efficiency.”', author: '— Austin Freeman'},
                {text: '“Plans are nothing; planning is everything.”', author: '— Dwight D. Eisenhower'},
                {text: '“Focus on being productive instead of busy.”', author: '— Tim Ferriss'},
                {text: '“What gets measured gets improved.”', author: '— Peter Drucker'},
                {text: '“The secret of getting ahead is getting started.”', author: '— Mark Twain'}
            ];
            let i = 0;
            const quoteText = document.getElementById('quoteText');
            const quoteAuthor = document.getElementById('quoteAuthor');

            function showQuote(idx){
                quoteText.classList.remove('show');
                setTimeout(()=>{
                    quoteText.textContent = quotes[idx].text;
                    quoteAuthor.textContent = quotes[idx].author;
                    quoteText.classList.add('show');
                }, 300);
            }
            showQuote(0);
            setInterval(()=>{ i = (i + 1) % quotes.length; showQuote(i); }, 7000);

            window.addEventListener('load', ()=>{
                document.querySelectorAll('.fade-up').forEach((el, idx)=>{
                    setTimeout(()=> el.classList.add('in'), 180 + idx*120);
                });
            });

            document.addEventListener('keydown', (e)=>{
                if((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'k'){
                    e.preventDefault();
                    const b = document.getElementById('loginBtn');
                    b.animate([{transform:'scale(1)'},{transform:'scale(1.05)'},{transform:'scale(1)'}], {duration:420});
                    b.focus();
                }
            });
        })();
    </script>
</body>
</html>
