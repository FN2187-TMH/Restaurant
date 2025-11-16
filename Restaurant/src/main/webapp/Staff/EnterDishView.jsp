<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Enter Dish</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #1a1a1a;
                margin: 0;
                padding: 0;
                color: #f5e6a1;
            }

            .container {
                width: 420px;
                margin: 80px auto;
                background-color: #2a2a2a;
                border-radius: 10px;
                border: 1px solid #f5e6a1;
                box-shadow: 0 2px 12px rgba(0,0,0,0.5);
                padding: 30px 40px;
            }

            h2 {
                text-align: center;
                color: #f5e6a1;
                margin-bottom: 25px;
            }

            label {
                display: block;
                margin-bottom: 6px;
                font-weight: bold;
                color: #f5e6a1;
            }

            input[type="text"],
            input[type="number"],
            textarea {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #f5e6a1;
                border-radius: 5px;
                background-color: #1f1f1f;
                color: #f5e6a1;
                font-size: 14px;
                box-sizing: border-box;
            }

            textarea {
                resize: vertical;
                height: 80px;
            }

            .btn {
                display: inline-block;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 15px;
                cursor: pointer;
                transition: 0.3s;
                width: 100%;
                font-weight: bold;
            }

            .btn-preview {
                background-color: #f5e6a1;
                color: #000;
            }

            .btn-preview:hover {
                background-color: #d4af37;
            }

            .button-group {
                display: flex;
                justify-content: center;
                margin-top: 10px;
            }

            .back-link {
                display: block;
                margin-top: 15px;
                text-align: center;
                color: #f5e6a1;
                text-decoration: none;
                font-size: 14px;
            }

            .back-link:hover {
                color: #d4af37;
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
        <div class="container">
            <h2>Enter Dish Information</h2>

            <form action="DishServlet" method="post">
                <label for="name">Dish Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="category">Category:</label>
                <input type="text" id="category" name="category" required>

                <label for="price">Price ($):</label>
                <input type="number" min="0" step="0.01" id="price" name="price" required>

                <label for="unit">Unit:</label>
                <input type="text" id="unit" name="unit" placeholder="e.g., bowl, plate, piece" required>


                <label for="description">Description:</label>
                <textarea id="description" name="description" placeholder="Write a short description..."></textarea>

                <div class="button-group">
                    <button type="submit" name="action" value="preview" class="btn btn-preview">Next</button>
                </div>
            </form>

            <a href="ManageDishView.jsp" class="back-link">← Back to Manage Dish</a>
        </div>
    </body>
</html>
