package servlet;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "UserServlet", urlPatterns = {"/UserServlet"})
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); // logout có thể dùng GET
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("login".equalsIgnoreCase(action) || action == null) {
            // Nếu action null → mặc định login (trường hợp submit form cũ)
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String type = request.getParameter("role"); 

            UserDAO userDAO = new UserDAO();
            User user = userDAO.checkLogin(username, password, type);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                if ("staff".equalsIgnoreCase(type)) {
                    response.sendRedirect(request.getContextPath() + "/Staff/ManagementHomeView.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/Customer/CustomerHomeView.jsp");
                }
            } else {
                request.setAttribute("errorMessage", "Invalid username or password!");
                if ("staff".equalsIgnoreCase(type)) {
                    request.getRequestDispatcher("/User/StaffLoginView.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/User/CustomerLoginView.jsp").forward(request, response);
                }
            }

        } else if ("logout".equalsIgnoreCase(action)) {
            // Xử lý logout
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/User/Home.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "User login/logout servlet";
    }
}
