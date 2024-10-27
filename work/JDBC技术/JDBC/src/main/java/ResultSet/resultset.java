package ResultSet;

import java.sql.*;

public class resultset {
    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/jdbc_homework?serverTimezone=GMT&characterEncoding=UTF-8";
        String user = "root";
        String password = "GAOYUAN202823";
        String sql = "SELECT * FROM teacher WHERE teacher.id > ?";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement ps = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ) {
            // 设置参数
            ps.setInt(1,20);
            // 执行查询
            try (ResultSet rs = ps.executeQuery()) {
                //移到倒数第二行
                rs.absolute(-2);
                System.out.println(rs.getInt("id") + " " + rs.getString("name")+" "+rs.getString("course")+" "+rs.getString("birthday"));

            }catch (SQLException e) {
                e.printStackTrace();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
