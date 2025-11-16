<%@page import="model.Customer"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User user = (User) session.getAttribute("user");
    Customer customer = null;
    if (user != null && user instanceof Customer) {
        customer = (Customer) user;
    }
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #1a1a1a;
            color: #f5e6a1;
            padding-top: 60px; /* tạo khoảng cách cho top-bar cố định */
        }

        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 30px;
            background-color: #2b2b2b;
            border-radius: 8px;
            box-shadow: 2px 2px 12px rgba(245,230,161,0.5);
            text-align: center;
        }

        h1 {
            margin-bottom: 30px;
            color: #f5e6a1;
        }

        /* Nút theme chung */
        .btn {
            display: inline-block;
            padding: 12px 30px;
            font-size: 16px;
            border-radius: 6px;
            background-color: #f5e6a1;
            color: #1a1a1a;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
            margin: 5px;
        }

        .btn:hover {
            background-color: #d4af37;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(212,175,55,0.4);
        }

        .top-bar {
            width: 100%;
            background-color: #2b2b2b;
            padding: 12px 20px;
            box-sizing: border-box;
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            z-index: 1000;
            border-bottom: 1px solid #f5e6a1;
            font-size: 18px;
            font-weight: bold;
        }

        .top-bar span {
            color: #f5e6a1;
            margin-left: 15px;
        }

        .top-bar form {
            display: inline;
            margin-left: 15px;
        }

        .top-bar button {
            padding: 6px 12px;
            background-color: #d9534f;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .top-bar button:hover {
            background-color: #c9302c;
        }

    </style>
</head>
<body>
    <div class="top-bar">
        <%
            if (user != null) {
        %>
            <span>Hello, <%= user.getUsername()%></span>
            <form action="<%= request.getContextPath()%>/User/UserServlet" method="post">
                <input type="hidden" name="action" value="logout">
                <button type="submit">Logout</button>
            </form>
        <%
            } else {
        %>
            <a href="<%= request.getContextPath()%>/User/StaffLoginView.jsp" class="btn">Staff Login</a>
            <a href="<%= request.getContextPath()%>/User/CustomerLoginView.jsp" class="btn">Customer Login</a>
        <%
            }
        %>
    </div>

    <div class="container">
        <h1>Welcome to Our Restaurant</h1>
        <a href="SearchAvailableTableView.jsp" class="btn">Book Table</a>
    </div>
</body>
</html>
