/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Customer;
import model.Staff;
import model.User;

/**
 *
 * @author Admin
 */
public class UserDAO extends DAO {
    public UserDAO() {
        super();
    }
    public User checkLogin(String username, String password, String type) {
    User user = null;
    try {
        if ("staff".equalsIgnoreCase(type)) {
            String sql = "SELECT u.*, s.position FROM tblUser u " +
                         "JOIN tblStaff s ON u.id = s.tblUserid " +
                         "WHERE u.username = ? AND u.password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Staff staff = new Staff();
                staff.setId(rs.getInt("id"));
                staff.setUsername(rs.getString("username"));
                staff.setPassword(rs.getString("password"));
                staff.setName(rs.getString("name"));
                staff.setDob(rs.getString("dob"));
                staff.setAddress(rs.getString("address"));
                staff.setEmail(rs.getString("email"));
                staff.setPhone(rs.getString("phone"));
                staff.setPosition(rs.getString("position"));
                user = staff;
            }
        } else if ("customer".equalsIgnoreCase(type)) {
            String sql = "SELECT u.* FROM tblUser u " +
                         "JOIN tblCustomer c ON u.id = c.tblUserid " +
                         "WHERE u.username = ? AND u.password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("id"));
                customer.setUsername(rs.getString("username"));
                customer.setPassword(rs.getString("password"));
                customer.setName(rs.getString("name"));
                customer.setDob(rs.getString("dob"));
                customer.setAddress(rs.getString("address"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                user = customer;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return user;
}

}
