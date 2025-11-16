<%@page import="model.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Dish" %>

<%
    Dish dish = (Dish) request.getAttribute("dish");
    String message = (String) request.getAttribute("message");
    boolean disabled = (message != null); // Disable nút khi có message
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Confirm Dish</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                background-color: #1a1a1a;
                color: #f5e6a1;
            }

            /* TOP BAR */
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
                flex-wrap: wrap;
                z-index: 1000;
                border-bottom: 1px solid #f5e6a1;
                font-size: 18px;
                font-weight: bold;
                gap: 10px;
            }

            .top-bar-group {
                display: flex;
                align-items: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .top-bar a, .top-bar span {
                color: #f5e6a1;
                text-decoration: none;
            }

            .top-bar a:hover {
                color: #d4af37;
                text-decoration: underline;
            }

            .top-bar form {
                display: inline-flex;
                align-items: center;
            }

            .top-bar button {
                padding: 5px 10px;
                background-color: #d9534f;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                white-space: nowrap;
            }

            .top-bar button:hover {
                background-color: #c9302c;
            }

            /* CONTAINER FORM */
            .container {
                max-width: 500px;
                margin: 120px auto 40px auto; /* cách top-bar 120px */
                padding: 20px;
                background-color: #2a2a2a;
                border: 1px solid #f5e6a1;
                border-radius: 8px;
                box-shadow: 2px 2px 12px #000;
            }

            .container h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            .field {
                margin-bottom: 15px;
            }

            .field label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }

            .field span {
                display: block;
                padding: 8px;
                background-color: #1f1f1f;
                border-radius: 4px;
            }

            /* BUTTONS */
            .buttons {
                margin-top: 20px;
                display: flex;
                justify-content: center;
                gap: 20px;
            }

            .buttons form {
                display: inline-flex;
            }

            .buttons button {
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                border-radius: 4px;
                border: none;
                font-weight: bold;
                transition: 0.3s;
            }

            .buttons button.save,
            .buttons button.back {
                background-color: #f5e6a1;
                color: #000;
            }

            .buttons button.save:hover,
            .buttons button.back:hover {
                background-color: #d4af37;
            }

            .buttons button:disabled {
                background-color: #555;
                color: #aaa;
                cursor: not-allowed;
                opacity: 0.7;
            }

            /* MESSAGE BOX */
            .message-box {
                margin-top: 25px;
                padding: 15px;
                background-color: #333;
                border-left: 4px solid #f5e6a1;
                border-radius: 6px;
                text-align: center;
            }

            .message-box p {
                margin: 0;
                font-size: 16px;
            }

            .message-box a {
                display: inline-block;
                margin-top: 10px;
                padding: 8px 15px;
                background-color: #f5e6a1;
                color: #000;
                border-radius: 4px;
                text-decoration: none;
                font-weight: bold;
            }

            .message-box a:hover {
                background-color: #d4af37;
            }

        </style>
    </head>
    <body>

        <!-- TOP BAR -->
        <div class="top-bar">
            <%
                User user = (User) session.getAttribute("user");
                if (user != null) {
            %>
            <div class="top-bar-group">
                <span>Hello, <%= user.getUsername()%></span>
                <form action="<%= request.getContextPath()%>/User/UserServlet" method="post">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit">Logout</button>
                </form>
            </div>
            <%
            } else {
            %>
            <div class="top-bar-group">
                <a href="<%= request.getContextPath()%>/User/StaffLoginView.jsp">Staff Login</a>
                <a href="<%= request.getContextPath()%>/User/CustomerLoginView.jsp">Customer Login</a>
            </div>
            <%
                }
            %>
        </div>

        <!-- MAIN CONTAINER -->
        <div class="container">
            <h2>Confirm Dish</h2>

            <div class="field">
                <label>Name:</label>
                <span><%= dish.getName()%></span>
            </div>

            <div class="field">
                <label>Category:</label>
                <span><%= dish.getCategory()%></span>
            </div>

            <div class="field">
                <label>Price:</label>
                <span><%= dish.getPrice()%></span>
            </div>

            <div class="field">
                <label>Unit:</label>
                <span><%= dish.getUnit()%></span>
            </div>


            <div class="field">
                <label>Description:</label>
                <span><%= dish.getDescription()%></span>
            </div>

            <!-- BUTTONS -->
            <div class="buttons">
                <form action="DishServlet" method="post">
                    <input type="hidden" name="action" value="save">
                    <input type="hidden" name="name" value="<%= dish.getName()%>">
                    <input type="hidden" name="category" value="<%= dish.getCategory()%>">
                    <input type="hidden" name="price" value="<%= dish.getPrice()%>">
                    <input type="hidden" name="unit" value="<%= dish.getUnit() %>">
                    <input type="hidden" name="description" value="<%= dish.getDescription()%>">
                    <button type="submit" class="save" <%= disabled ? "disabled" : ""%>>Save</button>
                </form>

                <form action="ManagementHomeView.jsp" method="get">
                    <button type="submit" class="back" <%= disabled ? "disabled" : ""%>
                            onclick="return confirm('Are you sure you want to cancel?');">
                        Cancel
                    </button>
                </form>

            </div>

            <!-- MESSAGE BOX -->
            <% if (message != null) {%>
            <div class="message-box">
                <p><%= message%></p>
                <a href="ManageDishView.jsp">Return to Manage Dish</a>
            </div>
            <% }%>

        </div>

    </body>
</html>
