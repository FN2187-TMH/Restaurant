/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import model.Table;

/**
 *
 * @author Admin
 */
public class TableDAO extends DAO {

    public TableDAO() {
        super();
    }

    public ArrayList<Table> searchAvailableTable(LocalDateTime startDateTime, LocalDateTime endDateTime) {
        ArrayList<Table> availableTables = new ArrayList<>();
        String sql = "SELECT * FROM tblTable t "
                + "WHERE t.id NOT IN ( "
                + "   SELECT r.tblTableid FROM tblReservation r "
                + "   WHERE r.status = 'confirmed' "
                + "     AND NOT (r.endDateTime <= ? OR r.startDateTime >= ?) "
                + ")";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            // Chuyển LocalDateTime sang Timestamp
            ps.setTimestamp(1, Timestamp.valueOf(startDateTime));
            ps.setTimestamp(2, Timestamp.valueOf(endDateTime));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Table t = new Table();
                    t.setId(rs.getInt("id"));
                    t.setTableNumber(rs.getInt("tableNumber"));
                    t.setCapacity(rs.getInt("capacity"));
                    t.setFloor(rs.getInt("floor"));
                    t.setDescription(rs.getString("description"));
                    availableTables.add(t);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return availableTables;
    }
    
}
