<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Customer Login</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #1a1a1a;
                color: #f5e6a1;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 400px;
                margin: 100px auto;
                padding: 30px;
                background-color: #2b2b2b;
                border-radius: 8px;
                box-shadow: 2px 2px 12px rgba(245,230,161,0.5);
            }
            h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #f5e6a1;
            }
            label {
                display: block;
                margin-bottom: 6px;
                font-weight: bold;
            }
            input[type="text"], input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border-radius: 5px;
                border: 1px solid #f5e6a1;
                background-color: #1a1a1a;
                color: #f5e6a1;
            }
            input[type="text"]:focus, input[type="password"]:focus {
                outline: none;
                box-shadow: 0 0 5px #d4af37;
            }
            .btn-login {
                display: block;
                width: 100%;
                padding: 12px;
                background-color: #f5e6a1;
                color: #1a1a1a;
                font-weight: bold;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            .btn-login:hover {
                background-color: #d4af37;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(212,175,55,0.4);
            }
            .back-link {
                display: block;
                text-align: center;
                margin-top: 15px;
                color: #f5e6a1;
                text-decoration: none;
            }
            .back-link:hover {
                text-decoration: underline;
                color: #d4af37;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Customer Login</h2>

            <%-- Hiển thị lỗi nếu có --%>
            <%
                String error = (String) request.getAttribute("errorMessage");
                if (error != null) {
            %>
            <p style="color:#ff6b6b; text-align:center; margin-bottom:15px;"><%= error%></p>
            <% }%>

            <form action="UserServlet" method="post">
                <input type="hidden" name="role" value="customer">
                <input type="hidden" name="action" value="login">

                <label for="username">Username:</label>
                <input type="text" name="username" id="username" required>

                <label for="password">Password:</label>
                <input type="password" name="password" id="password" required>

                <button type="submit" class="btn-login">Login</button>
            </form>

            <a href="Home.jsp" class="back-link">← Back to Home</a>
        </div>

    </body>
</html>
