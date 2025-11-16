/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import model.Reservation;

/**
 *
 * @author Admin
 */
public class ReservationDAO extends DAO {

    public ReservationDAO() {
        super();
    }

    public boolean saveReservation(Reservation reservation) {
        String sql = "INSERT INTO tblReservation (startDateTime, endDateTime, tblCustomerid, tblTableid, name, phone, email, note) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            // Bắt đầu transaction
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setTimestamp(1, Timestamp.valueOf(reservation.getStartDateTime()));
                ps.setTimestamp(2, Timestamp.valueOf(reservation.getEndDateTime()));
                ps.setInt(3, reservation.getCustomer().getId());
                ps.setInt(4, reservation.getTable().getId());
                ps.setString(5, reservation.getName());
                ps.setString(6, reservation.getPhone());
                ps.setString(7, reservation.getEmail());
                ps.setString(8, reservation.getNote());

                int rows = ps.executeUpdate();

                // Commit nếu không lỗi
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

