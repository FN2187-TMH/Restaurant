/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.ReservationDAO;
import dao.TableDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.Customer;
import model.Reservation;
import model.Table;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ReservationServlet", urlPatterns = {"/ReservationServlet"})
public class ReservationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("preview".equals(action)) {
            // Lấy dữ liệu từ form
            int tableId = Integer.parseInt(request.getParameter("tableId"));
            int tableNumber = Integer.parseInt(request.getParameter("tableNumber"));
            int floor = Integer.parseInt(request.getParameter("floor"));
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String description = request.getParameter("description");
            String startStr = request.getParameter("startDateTime");
            String endStr = request.getParameter("endDateTime");

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime startDateTime = LocalDateTime.parse(startStr, formatter);
            LocalDateTime endDateTime = LocalDateTime.parse(endStr, formatter);

            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String dob = request.getParameter("dob");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            Customer customer = new Customer();
            customer.setId(Integer.valueOf(id));
            customer.setName(name);
            customer.setDob(dob);
            customer.setAddress(address);
            customer.setEmail(email);
            customer.setPhone(phone);

            Table table = new Table();
            table.setId(tableId);
            table.setTableNumber(tableNumber);
            table.setCapacity(capacity);
            table.setFloor(floor);
            table.setDescription(description);

            Reservation reservation = new Reservation();
            reservation.setTable(table);
            reservation.setStartDateTime(startDateTime);
            reservation.setEndDateTime(endDateTime);
            reservation.setCustomer(customer);

            String c_name = request.getParameter("c_name");
            String c_email = request.getParameter("c_email");
            String c_phone = request.getParameter("c_phone");
            String c_note = request.getParameter("c_note");

            reservation.setName(c_name);
            reservation.setEmail(c_email);
            reservation.setPhone(c_phone);
            reservation.setNote(c_note);

            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("ConfirmReservationView.jsp").forward(request, response);

        } else if ("save".equals(action)) {
            // 🔹 Lấy dữ liệu từ form
            int tableId = Integer.parseInt(request.getParameter("tableId"));
            int tableNumber = Integer.parseInt(request.getParameter("tableNumber"));
            int floor = Integer.parseInt(request.getParameter("floor"));
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String description = request.getParameter("description");
            String startStr = request.getParameter("startDateTime");
            String endStr = request.getParameter("endDateTime");

            LocalDateTime startDateTime = LocalDateTime.parse(startStr);
            LocalDateTime endDateTime = LocalDateTime.parse(endStr);

            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String dob = request.getParameter("dob");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");


 
            // 🔹 Gom dữ liệu thành Reservation
            Reservation reservation = new Reservation();
            reservation.setTable(new Table(tableId, tableNumber, floor, capacity, description));
            reservation.setStartDateTime(startDateTime);
            reservation.setEndDateTime(endDateTime);
            reservation.setCustomer(new Customer(Integer.valueOf(id), name, dob, address, email, phone));

            String c_name = request.getParameter("c_name");
            String c_email = request.getParameter("c_email");
            String c_phone = request.getParameter("c_phone");
            String c_note = request.getParameter("c_note");

            reservation.setName(c_name);
            reservation.setEmail(c_email);
            reservation.setPhone(c_phone);
            reservation.setNote(c_note);

            // 🔹 Lưu vào database
            ReservationDAO reservationDAO = new ReservationDAO();
            boolean success = reservationDAO.saveReservation(reservation);

            if (success) {
                request.setAttribute("message", "✅ Reservation saved successfully!");
            } else {
                request.setAttribute("message", "❌ Failed to save reservation!");
            }
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("ConfirmReservationView.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action!");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
