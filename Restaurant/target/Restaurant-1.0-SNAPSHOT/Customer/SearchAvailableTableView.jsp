<%@page import="model.Customer"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Table"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Search Available Tables</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                background-color: #1a1a1a;
                color: #f5e6a1;
                padding-top: 90px; /* tăng lên để tránh dính top-bar */
            }

            .container {
                max-width: 1200px;
                margin: 20px auto 40px auto;
                padding: 30px;
                background-color: #2b2b2b;
                border-radius: 8px;
                box-shadow: 2px 2px 12px rgba(245,230,161,0.5);
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
                color: #f5e6a1;
            }

            form {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin-bottom: 40px;
                align-items: center;
                flex-wrap: wrap;
            }

            select, input[type="date"], button {
                padding: 10px;
                font-size: 16px;
                border-radius: 5px;
                border: 1px solid #f5e6a1;
                background-color: #2b2b2b;
                color: #f5e6a1;
            }

            select:focus, input[type="date"]:focus {
                outline: none;
                box-shadow: 0 0 5px #d4af37;
            }

            button {
                background-color: #f5e6a1;
                color: #1a1a1a;
                border: none;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: bold;
            }

            button:hover {
                background-color: #d4af37;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(212,175,55,0.4);
            }

            /* ================== TOP BAR ================== */
            .top-bar {
                width: 100%;
                background-color: #2b2b2b;
                padding: 12px 20px;
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
                gap: 10px;
                box-sizing: border-box;
                flex-wrap: nowrap; /* không wrap */
            }

            .user-section {
                display: flex;
                align-items: center;
                gap: 10px;
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
                margin: 0;
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

            /* ================== FLOOR & TABLE ================== */
            .floor-row {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
                margin-bottom: 40px;
            }
            .floor-column {
                flex: 1;
                min-width: 400px;
                background-color: #3a3a3a;
                padding: 15px;
                border-radius: 8px;
                border: 1px solid #f5e6a1;
            }
            .floor-column h3 {
                margin-top: 0;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }
            th, td {
                padding: 12px;
                text-align: center;
                border: 1px solid #f5e6a1;
            }
            th {
                background-color: #d4af37;
                color: #1a1a1a;
            }
            td {
                background-color: #2b2b2b;
            }
            .select-btn {
                display: inline-block;
                padding: 6px 12px;
                background-color: #f5e6a1;
                color: #1a1a1a;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                transition: all 0.3s ease;
            }
            .select-btn:hover {
                background-color: #d4af37;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(212,175,55,0.4);
            }
            .back-home {
                display: inline-block;
                margin-top: 25px;
                padding: 12px 20px;
                background-color: #555;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                transition: all 0.3s ease;
            }
            .back-home:hover {
                background-color: #777;
                transform: translateY(-2px);
            }
        </style>
    </head>
    <body>
        <div class="top-bar">
            <%
                if (user != null) {
            %>
            <div class="user-section">
                <span>Hello, <%= user.getUsername()%></span>
                <form action="<%= request.getContextPath()%>/User/UserServlet" method="post">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit">Logout</button>
                </form>
            </div>
            <%
            } else {
            %>
            <a href="<%= request.getContextPath()%>/User/StaffLoginView.jsp">Staff Login</a> |
            <a href="<%= request.getContextPath()%>/User/CustomerLoginView.jsp">Customer Login</a>
            <%
                }
            %>
        </div>

        <div class="container">
            <h2>Search Available Tables</h2>
            <form action="TableServlet" method="get">
                <label for="date">Date:</label>
                <input type="date" name="date" id="date" required>
                <label for="timeSlot">Time Slot:</label>
                <select name="timeSlot" id="timeSlot" required>
                    <option value="">--Select Time--</option>
                    <option value="08:00-10:00">08:00 - 10:00</option>
                    <option value="10:00-12:00">10:00 - 12:00</option>
                    <option value="12:00-14:00">12:00 - 14:00</option>
                    <option value="14:00-16:00">14:00 - 16:00</option>
                    <option value="16:00-18:00">16:00 - 18:00</option>
                    <option value="18:00-20:00">18:00 - 20:00</option>
                    <option value="20:00-22:00">20:00 - 22:00</option>
                </select>
                <button type="submit">Search</button>
            </form>




            <%
                ArrayList<Table> availableTables = (ArrayList<Table>) request.getAttribute("availableTables");
                String date = (String) request.getAttribute("date");
                String timeSlot = (String) request.getAttribute("timeSlot");

            %>  
            <% if (date != null && timeSlot != null) { %>
    <p style="text-align:center; margin-bottom:20px; font-weight:bold; font-size:24px;">
        Currently searching for <%= date %> at <%= timeSlot %>
    </p>
<% } %>



            <%
                if (availableTables != null && !availableTables.isEmpty()) {
                    Map<Integer, List<Table>> tablesByFloor = new TreeMap<>();
                    for (Table t : availableTables) {
                        tablesByFloor.computeIfAbsent(t.getFloor(), k -> new ArrayList<>()).add(t);
                    }

                    List<Integer> floorList = new ArrayList<>(tablesByFloor.keySet());
                    for (int i = 0; i < floorList.size(); i += 2) {
            %>

            <div class="floor-row">
                <% for (int j = i; j < i + 2 && j < floorList.size(); j++) {
                        int floor = floorList.get(j);
                        List<Table> tables = tablesByFloor.get(floor);
                %>
                <div class="floor-column">
                    <h3>Floor <%= floor%> - Available Tables</h3>
                    <table>
                        <tr>
                            <th>Table Number</th>
                            <th>Floor</th>
                            <th>Capacity</th>
                            <th>Description</th>
                            <th>Action</th>
                        </tr>
                        <% for (Table t : tables) {
                                String[] times = timeSlot.split("-");
                                String startDateTime = date + " " + times[0] + ":00";
                                String endDateTime = date + " " + times[1] + ":00";
                        %>
                        <tr>
                            <td><%= t.getTableNumber()%></td>
                            <td><%= t.getFloor()%></td>
                            <td><%= t.getCapacity()%></td>
                            <td><%= t.getDescription()%></td>
                            <td>
                                <a class="select-btn" href="EnterCustomerView.jsp?tableId=<%= t.getId()%>&tableNumber=<%= t.getTableNumber()%>&floor=<%= t.getFloor()%>&capacity=<%= t.getCapacity()%>&description=<%= java.net.URLEncoder.encode(t.getDescription(), "UTF-8")%>&startDateTime=<%= startDateTime%>&endDateTime=<%= endDateTime%>">
                                    Select
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </table>
                </div>
                <% } %>
            </div>
            <%      }
            } else if (date != null && timeSlot != null) {
            %>
            <p style="text-align:center; margin-top:20px;">No available tables for selected date and time slot.</p>
            <% }%>

            <a href="CustomerHomeView.jsp" class="back-home">← Back to Home</a>
        </div>
    </body>
</html>
