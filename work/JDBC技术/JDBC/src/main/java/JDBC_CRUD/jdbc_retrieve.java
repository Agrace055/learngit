package JDBC_CRUD;

import java.sql.*;
import java.util.Scanner;

public class jdbc_retrieve {
    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/jdbc_homework?serverTimezone=GMT&characterEncoding=UTF-8";
        String user = "root";
        String password = "GAOYUAN202823";

        String sql = "SELECT * FROM teacher WHERE id = ?";
        Scanner input = new Scanner(System.in);

        try (Connection conn = DriverManager.getConnection(url, user, password);) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(sql);) {

                System.out.println("请输入要查询的教师id");
                int id = input.nextInt();

                // 设置参数
                ps.setInt(1, id);
                // 输出格式
                System.out.println("教师信息");
                System.out.println("id\t姓名\t课程\t生日");
                conn.commit();
                ResultSet rs = ps.executeQuery();
                // 输出查询结果
                while (rs.next()) {
                    System.out.println(rs.getObject(1)+"\t"+rs.getObject(2)+"\t"+rs.getObject(3)+"\t"+rs.getObject(4));
                }
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
