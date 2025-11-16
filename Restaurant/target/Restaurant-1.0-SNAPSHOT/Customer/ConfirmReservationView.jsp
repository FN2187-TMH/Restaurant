<%@page import="model.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Reservation" %>
<%@ page import="model.Customer" %>
<%@ page import="model.Table" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    Reservation reservation = (Reservation) request.getAttribute("reservation");
    String message = (String) request.getAttribute("message");
    Customer customer = reservation != null ? reservation.getCustomer() : null;
    Table table = reservation != null ? reservation.getTable() : null;
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    boolean disabled = (message != null); // disable nút khi có message
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Reservation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding-top: 70px; /* Khoảng cách cho top-bar */
            background-color: #1a1a1a;
            color: #f5e6a1;
        }

        h2 {
            text-align: center;
            padding: 20px 0;
            border-bottom: 2px solid #f5e6a1;
            margin: 0 0 30px 0;
        }

        .container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            padding: 0 60px 60px 60px;
            box-sizing: border-box;
            min-height: calc(100vh - 70px);
        }

        .section {
            background-color: #2a2a2a;
            padding: 25px;
            border-radius: 10px;
            border: 1px solid #f5e6a1;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.7);
        }

        .section h3 {
            border-bottom: 1px solid #f5e6a1;
            padding-bottom: 10px;
            margin-bottom: 15px;
            color: #ffd700;
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
            color: #f5e6a1;
        }

        .buttons {
            grid-column: span 2;
            text-align: center;
            margin-top: 30px;
        }

        .buttons button {
            padding: 12px 25px;
            font-size: 18px;
            margin: 0 15px;
            cursor: pointer;
            border-radius: 6px;
            border: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .buttons button.save,
        .buttons button.cancel {
            background-color: #f5e6a1;
            color: #000;
        }

        .buttons button:hover {
            background-color: #d4af37;
        }

        .buttons button:disabled {
            background-color: #999;
            cursor: not-allowed;
            color: #333;
        }

        .message-box {
            grid-column: span 2;
            margin-top: 25px;
            padding: 20px;
            background-color: #333;
            border-left: 5px solid #f5e6a1;
            border-radius: 8px;
            text-align: center;
        }

        .message-box a {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #f5e6a1;
            color: #000;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .message-box a:hover {
            background-color: #d4af37;
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
    <% if (user != null) { %>
        Hello, <%= user.getUsername() %> |
        <form action="<%= request.getContextPath() %>/User/UserServlet" method="post">
            <input type="hidden" name="action" value="logout">
            <button type="submit">Logout</button>
        </form>
    <% } else { %>
        <a href="<%= request.getContextPath() %>/User/StaffLoginView.jsp">Staff Login</a> |
        <a href="<%= request.getContextPath() %>/User/CustomerLoginView.jsp">Customer Login</a>
    <% } %>
</div>

<h2>Confirm Reservation</h2>

<div class="container">
    <% if (reservation != null && customer != null && table != null) { %>

        <!-- Cột trái: Thông tin liên hệ Reservation -->
        <div class="section">
            <h3>Reservation Contact Info</h3>
            <div class="field"><label>Name:</label><span><%= reservation.getName() != null ? reservation.getName() : "-" %></span></div>
            <div class="field"><label>Email:</label><span><%= reservation.getEmail() != null ? reservation.getEmail() : "-" %></span></div>
            <div class="field"><label>Phone:</label><span><%= reservation.getPhone() != null ? reservation.getPhone() : "-" %></span></div>
            <div class="field"><label>Note:</label><span><%= reservation.getNote() != null ? reservation.getNote() : "None" %></span></div>
        </div>

        <!-- Cột phải: Thông tin Table + thời gian -->
        <div class="section">
            <h3>Table & Reservation Details</h3>
            <div class="field"><label>Table Number:</label><span><%= table.getTableNumber() %></span></div>
            <div class="field"><label>Floor:</label><span><%= table.getFloor() %></span></div>
            <div class="field"><label>Capacity:</label><span><%= table.getCapacity() %></span></div>
            <div class="field"><label>Description:</label><span><%= table.getDescription() %></span></div>
            <div class="field"><label>Start Time:</label><span><%= reservation.getStartDateTime().format(formatter) %></span></div>
            <div class="field"><label>End Time:</label><span><%= reservation.getEndDateTime().format(formatter) %></span></div>
        </div>

        <!-- Buttons -->
        <div class="buttons">
            <form action="ReservationServlet" method="post" style="display:inline;">
                <input type="hidden" name="action" value="save">

                <!-- Table info -->
                <input type="hidden" name="tableId" value="<%= table.getId() %>">
                <input type="hidden" name="tableNumber" value="<%= table.getTableNumber() %>">
                <input type="hidden" name="floor" value="<%= table.getFloor() %>">
                <input type="hidden" name="capacity" value="<%= table.getCapacity() %>">
                <input type="hidden" name="description" value="<%= table.getDescription() %>">
                <input type="hidden" name="startDateTime" value="<%= reservation.getStartDateTime() %>">
                <input type="hidden" name="endDateTime" value="<%= reservation.getEndDateTime() %>">

                <!-- Customer info (logged-in user) -->
                <input type="hidden" name="id" value="<%= customer.getId() %>">
                <input type="hidden" name="name" value="<%= customer.getName() %>">
                <input type="hidden" name="dob" value="<%= customer.getDob() %>">
                <input type="hidden" name="address" value="<%= customer.getAddress() %>">
                <input type="hidden" name="email" value="<%= customer.getEmail() %>">
                <input type="hidden" name="phone" value="<%= customer.getPhone() %>">

                <!-- Reservation contact info -->
                <input type="hidden" name="c_name" value="<%= reservation.getName() %>">
                <input type="hidden" name="c_email" value="<%= reservation.getEmail() %>">
                <input type="hidden" name="c_phone" value="<%= reservation.getPhone() %>">
                <input type="hidden" name="c_note" value="<%= reservation.getNote() %>">

                <button type="submit" class="save" <%= disabled ? "disabled" : "" %>>Confirm</button>
            </form>

            <form action="CustomerHomeView.jsp" method="get" style="display:inline;">
    <button type="submit" class="cancel" <%= disabled ? "disabled" : "" %>
        onclick="return confirm('Are you sure you want to cancel this reservation?');">
        Cancel
    </button>
</form>

        </div>

        <% if (message != null) { %>
            <div class="message-box">
                <p><%= message %></p>
                <a href="CustomerHomeView.jsp">Return to Home</a>
            </div>
        <% } %>

    <% } else { %>
        <p style="text-align:center; grid-column:span 2;">No reservation data found.</p>
    <% } %>
</div>

</body>
</html>
