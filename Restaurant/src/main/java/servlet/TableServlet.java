/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.TableDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.ArrayList;
import model.Table;

/**
 *
 * @author Admin
 */
@WebServlet(name = "TableServlet", urlPatterns = {"/TableServlet"})
public class TableServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    // 1. Nhận thông tin từ form
    String dateStr = request.getParameter("date");
    String timeSlot = request.getParameter("timeSlot");

    if (dateStr != null && timeSlot != null && !timeSlot.isEmpty()) {
        try {
            // 2. Chuyển sang LocalDateTime
            // dateStr là yyyy-MM-dd
            String[] times = timeSlot.split("-");
            LocalDateTime startDateTime = LocalDateTime.parse(dateStr + "T" + times[0]);
            LocalDateTime endDateTime = LocalDateTime.parse(dateStr + "T" + times[1]);

            // 3. Gọi DAO để tìm bàn trống
            TableDAO tableDAO = new TableDAO();
            ArrayList<Table> availableTables = tableDAO.searchAvailableTable(startDateTime, endDateTime);

            // 4. Set attribute cho JSP
            request.setAttribute("availableTables", availableTables);
            request.setAttribute("date", dateStr);
            request.setAttribute("timeSlot", timeSlot);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid date or time format");
        }
    }

    request.getRequestDispatcher("SearchAvailableTableView.jsp").forward(request, response);
}
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
