package dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.Dish;

public class DishDAO extends DAO {

    public DishDAO() {
        super();
    }

    public boolean addDish(Dish dish) {
        String sql = "INSERT INTO tblDish (name, description, price, category, unit) VALUES (?, ?, ?, ?, ?)";

        try {
            // Bắt đầu transaction
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, dish.getName());
                ps.setString(2, dish.getDescription());
                ps.setDouble(3, dish.getPrice());
                ps.setString(4, dish.getCategory());
                ps.setString(5, dish.getUnit()); 

                int rows = ps.executeUpdate();

                conn.commit();

                return rows > 0;

            } catch (SQLException e) {
                // Rollback nếu xảy ra lỗi
                conn.rollback();
                e.printStackTrace();
                return false;
            } finally {
                // Khôi phục auto-commit về true
                conn.setAutoCommit(true);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
