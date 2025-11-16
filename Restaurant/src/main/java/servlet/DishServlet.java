/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.DAO;
import dao.DishDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Dish;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DishServlet", urlPatterns = {"/DishServlet"})
public class DishServlet extends HttpServlet {

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
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            String priceStr = request.getParameter("price");
            String unit = request.getParameter("unit");
            String description = request.getParameter("description");

            float price = 0;
            try {
                price = Float.parseFloat(priceStr);
            } catch (NumberFormatException e) {
                price = 0;
            }

            // 🔹 Gom dữ liệu thành 1 đối tượng Dish
            Dish dish = new Dish();
            dish.setName(name);
            dish.setDescription(description);
            dish.setPrice(price);
            dish.setUnit(unit);
            dish.setCategory(category);

            request.setAttribute("dish", dish);
            request.getRequestDispatcher("ConfirmDishView.jsp").forward(request, response);

        } else if ("save".equals(action)) {
            // Lấy dữ liệu từ form
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            String priceStr = request.getParameter("price");
            String unit = request.getParameter("unit");
            String description = request.getParameter("description");

            float price = 0;
            try {
                price = Float.parseFloat(priceStr);
            } catch (NumberFormatException e) {
                price = 0;
            }

            // 🔹 Gom dữ liệu thành đối tượng Dish
            Dish dish = new Dish();
            dish.setName(name);
            dish.setCategory(category);
            dish.setPrice(price);
            dish.setUnit(unit);
            dish.setDescription(description);

            // 🔹 Lưu vào database qua DAO
            DishDAO dishDAO = new DishDAO();
            boolean success = dishDAO.addDish(dish);

            if (success) {
                request.setAttribute("message", "✅ Thêm món ăn thành công!");
            } else {
                request.setAttribute("message", "❌ Thêm món ăn thất bại! Vui lòng thử lại.");
            }
            request.setAttribute("dish", dish);
            request.getRequestDispatcher("ConfirmDishView.jsp").forward(request, response);

        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
