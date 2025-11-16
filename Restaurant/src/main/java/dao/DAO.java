package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
    public Connection conn;

    public DAO() {
        try {
            String url = "jdbc:mysql://localhost:3306/restaurant";
            String user = "root";
            String password = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(url, user, password);
            System.out.println("✅ Kết nối DB thành công!");
        } catch (Exception e) {
            System.out.println("❌ Kết nối DB thất bại!");
            e.printStackTrace();
        }
    }

    // Main test trực tiếp trong DAO
    public static void main(String[] args) {
        System.out.println("=== Test DAO ===");
        DAO dao = new DAO();

        if (dao.conn != null) {
            try {
                if (!dao.conn.isClosed()) {
                    System.out.println("✅ Connection đang hoạt động!");
                } else {
                    System.out.println("❌ Connection đã đóng!");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("❌ Connection null!");
        }

        System.out.println("=== Kết thúc test DAO ===");
    }
}
