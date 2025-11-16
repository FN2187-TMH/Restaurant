<%@page import="model.Table"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Customer" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    Customer customer = null;
    if (user != null && user instanceof Customer) {
        customer = (Customer) user;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Enter Customer Info</title>
        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                margin: 0;
                background-color: #1a1a1a;
                color: #f5e6a1;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                width: 90%;
                max-width: 700px;
                padding: 40px;
                background-color: #2b2b2b;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(245,230,161,0.4);
            }
            h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #f5e6a1;
                font-size: 22px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            label {
                display: block;
                margin-bottom: 6px;
                font-weight: bold;
                color: #f5e6a1;
            }
            input[type="text"], input[type="email"], input[type="tel"], textarea {
                width: 100%;
                padding: 10px;
                margin-bottom: 18px;
                border-radius: 5px;
                border: 1px solid #f5e6a1;
                background-color: #1a1a1a;
                color: #f5e6a1;
                font-size: 15px;
            }
            input:focus, textarea:focus {
                outline: none;
                box-shadow: 0 0 6px #d4af37;
            }
            textarea {
                resize: none;
                height: 80px;
            }
            .btn-container {
                display: flex;
                gap: 10px;
                margin-top: 20px;
                flex-wrap: wrap;
            }
            button {
                flex: 1;
                padding: 12px;
                font-size: 16px;
                font-weight: bold;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: 0.3s;
            }
            .btn-submit {
                background-color: #f5e6a1;
                color: #1a1a1a;
            }
            .btn-submit:hover {
                background-color: #d4af37;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(212,175,55,0.4);
            }
            .btn-back {
                background-color: #555;
                color: #fff;
            }
            .btn-back:hover {
                background-color: #777;
            }
            .btn-fill {
                background-color: transparent;
                border: 1px solid #f5e6a1;
                color: #f5e6a1;
            }
            .btn-fill:hover {
                background-color: #f5e6a1;
                color: #1a1a1a;
                transform: translateY(-2px);
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
            <h2>Customer Information & Selected Table</h2>

            <!-- Thông tin bàn đã chọn -->
            <%
                String tableId = request.getParameter("tableId");
                String tableNumber = request.getParameter("tableNumber");
                String floor = request.getParameter("floor");
                String capacity = request.getParameter("capacity");
                String description = request.getParameter("description");
                String startDateTime = request.getParameter("startDateTime");
                String endDateTime = request.getParameter("endDateTime");
                
                Table table = new Table(tableId, tableNumber, floor, capacity, description);
            %>
            <h3>Selected Table</h3>
            <table style="border-collapse: collapse; width: 100%; border: 1px solid #f5e6a1;">
    <tr>
        <th style="border: 1px solid #f5e6a1; padding: 8px;">Table Number</th>
        <th style="border: 1px solid #f5e6a1; padding: 8px;">Floor</th>
        <th style="border: 1px solid #f5e6a1; padding: 8px;">Capacity</th>
        <th style="border: 1px solid #f5e6a1; padding: 8px;">Description</th>
        <th style="border: 1px solid #f5e6a1; padding: 8px;">Start</th>
        <th style="border: 1px solid #f5e6a1; padding: 8px;">End</th>
    </tr>
    <tr>
        <td style="border: 1px solid #f5e6a1; padding: 8px;"><%= tableNumber %></td>
        <td style="border: 1px solid #f5e6a1; padding: 8px;"><%= floor %></td>
        <td style="border: 1px solid #f5e6a1; padding: 8px;"><%= capacity %></td>
        <td style="border: 1px solid #f5e6a1; padding: 8px;"><%= description %></td>
        <td style="border: 1px solid #f5e6a1; padding: 8px;"><%= startDateTime %></td>
        <td style="border: 1px solid #f5e6a1; padding: 8px;"><%= endDateTime %></td>
    </tr>
</table>


            <!-- Form thông tin khách hàng -->
            <form action="ReservationServlet" method="post" id="customerForm">
                <input type="hidden" name="action" value="preview">
                <input type="hidden" name="tableId" value="<%= tableId%>">
                <input type="hidden" name="tableNumber" value="<%= tableNumber%>">
                <input type="hidden" name="floor" value="<%= floor%>">
                <input type="hidden" name="capacity" value="<%= capacity%>">
                <input type="hidden" name="description" value="<%= description%>">
                <input type="hidden" name="startDateTime" value="<%= startDateTime%>">
                <input type="hidden" name="endDateTime" value="<%= endDateTime%>">

                <% if (customer != null) {%>
                <input type="hidden" name="id" value="<%= customer.getId()%>">
                <input type="hidden" name="name" value="<%= customer.getName()%>">
                <input type="hidden" name="dob" value="<%= customer.getDob() != null ? customer.getDob() : ""%>">
                <input type="hidden" name="address" value="<%= customer.getAddress() != null ? customer.getAddress() : ""%>">
                <input type="hidden" name="email" value="<%= customer.getEmail() != null ? customer.getEmail() : ""%>">
                <input type="hidden" name="phone" value="<%= customer.getPhone() != null ? customer.getPhone() : ""%>">
                <% }%>




                <input type="hidden" name="customerId" value="<%= customer.getId()%>">
                <input type="hidden" name="customerName" value="<%= customer.getName()%>">
                <input type="hidden" name="customerPhone" value="<%= customer.getPhone()%>">
                <input type="hidden" name="customerEmail" value="<%= customer.getEmail()%>">
                <input type="hidden" name="customerAddress" value="<%= customer.getAddress() != null ? customer.getAddress() : ""%>">


                <label for="c_name">Full Name</label>
                <input type="text" id="c_name" name="c_name" required>

                <label for="c_phone">Phone</label>
                <input type="tel" id="c_phone" name="c_phone" required>

                <label for="c_email">Email</label>
                <input type="email" id="c_email" name="c_email">

                <label for="c_note">Note</label>
                <textarea id="c_note" name="c_note" placeholder="Special requests, allergies, etc."></textarea>

                <div class="btn-container">
                    <button type="button" class="btn-fill" onclick="autoFill()">Book for Myself</button>
                    <button type="submit" class="btn-submit">Next</button>
                    <button type="button" class="btn-back" onclick="window.location.href = 'SearchAvailableTableView.jsp'">Back</button>
                </div>
            </form>
        </div>


        <script>
            function autoFill() {
                // Dữ liệu lấy từ session (JSP in ra JSON)
                const customer = {
                    name: "<%= customer != null ? customer.getName() : ""%>",
                    phone: "<%= customer != null ? customer.getPhone() : ""%>",
                    email: "<%= customer != null ? customer.getEmail() : ""%>"
                };

                // Kiểm tra có thông tin không
                if (!customer.name && !customer.phone && !customer.email) {
                    alert("No customer information found in session.");
                    return;
                }

                // Gán dữ liệu vào form
                document.getElementById("c_name").value = customer.name;
                document.getElementById("c_phone").value = customer.phone;
                document.getElementById("c_email").value = customer.email;
            }
        </script>
    </body>
</html>
