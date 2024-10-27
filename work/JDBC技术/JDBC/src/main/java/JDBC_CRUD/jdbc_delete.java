package JDBC_CRUD;

import java.sql.*;
import java.util.Scanner;

public class jdbc_delete {
    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/jdbc_homework?serverTimezone=GMT&characterEncoding=UTF-8";
        String user = "root";
        String password = "GAOYUAN202823";

        String sql = "DELETE FROM teacher WHERE name = ?";
        Scanner input = new Scanner(System.in);

        try (Connection conn = DriverManager.getConnection(url, user, password);) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(sql);) {

                System.out.println("请输入要删除的教师姓名");
                String name = input.next();

                // 设置参数
                ps.setString(1, name);
                // 执行插入
                ps.executeUpdate();
                conn.commit();
                System.out.println("教师信息删除成功");
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
