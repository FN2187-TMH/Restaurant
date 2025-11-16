<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Dishes</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1a1a1a;
            text-align: center;
            margin-top: 80px;
            color: #f5e6a1;
        }

        h1 {
            color: #f5e6a1;
            margin-bottom: 40px;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            background-color: #f5e6a1;
            color: #000;
            text-decoration: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #d4af37;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #f5e6a1;
            text-decoration: none;
            font-size: 15px;
        }

        .back-link:hover {
            color: #d4af37;
            text-decoration: underline;
        }
        .top-bar {
                width: 100%;
                background-color: #2b2b2b;
                padding: 12px 20px; /* cao hơn để chữ to thoải mái */
                box-sizing: border-box;
                position: fixed;
                top: 0;
                left: 0;
                display: flex;
                justify-content: flex-end;
                align-items: center;
                z-index: 1000;
                border-bottom: 1px solid #f5e6a1;
                font-size: 18px; /* chữ lớn hơn */
                font-weight: bold; /* in đậm */
            }

            .top-bar a, .top-bar span {
                color: #f5e6a1;
                margin-left: 10px;
                text-decoration: none;
            }

            .top-bar a:hover {
                color: #d4af37;
                text-decoration: underline;
            }

            .top-bar form {
                display: inline;
                margin-left: 10px;
            }

            .top-bar button {
                padding: 5px 10px;
                background-color: #d9534f;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .top-bar button:hover {
                background-color: #c9302c;
            }
    </style>
</head>
<body>
    <h1>Manage Dishes</h1>
    <div class="top-bar">
            <%
                User user = (User) session.getAttribute("user");
                if (user != null) {
            %>
            Hello, <%= user.getUsername()%> |
            <form action="<%= request.getContextPath()%>/User/UserServlet" method="post">
                <input type="hidden" name="action" value="logout">
                <button type="submit">Logout</button>
            </form>
            <%
            } else {
            %>
            <a href="<%= request.getContextPath()%>/User/StaffLoginView.jsp" style="color:#f5e6a1;">Staff Login</a> |
            <a href="<%= request.getContextPath()%>/User/CustomerLoginView.jsp" style="color:#f5e6a1;">Customer Login</a>
            <%
                }
            %>
        </div>

    <a href="EnterDishView.jsp" class="btn">Add Dish</a>

    <br><br>

    <a href="ManagementHomeView.jsp" class="back-link">← Back to Home</a>
</body>
</html>
