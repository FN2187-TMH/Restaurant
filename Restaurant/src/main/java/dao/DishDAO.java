/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.Dish;

/**
 *
 * @author Admin
 */
public class DishDAO extends DAO {

    public DishDAO() {
        super();
    }

    public boolean addDish(Dish dish) {
        String sql = "INSERT INTO tblDish (name, description, price, category) VALUES (?, ?, ?, ?)";

        try {
            // Bắt đầu transaction
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, dish.getName());
                ps.setString(2, dish.getDescription());
                ps.setDouble(3, dish.getPrice());
                ps.setString(4, dish.getCategory());

                int rows = ps.executeUpdate();

                // Commit nếu insert thành công
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
