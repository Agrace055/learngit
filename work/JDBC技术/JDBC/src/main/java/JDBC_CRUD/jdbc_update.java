package JDBC_CRUD;

import java.sql.*;
import java.util.Scanner;

public class jdbc_update {
    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/jdbc_homework?serverTimezone=GMT&characterEncoding=UTF-8";
        String user = "root";
        String password = "GAOYUAN202823";

        String sql = "UPDATE teacher SET course = ? WHERE id = ?";
        Scanner input = new Scanner(System.in);

        try (Connection conn = DriverManager.getConnection(url, user, password);) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(sql);) {

                System.out.println("教师课程更改");
                System.out.println("请输入教师id");
                int id = input.nextInt();

                System.out.println("请输入更改后的课程名称");
                String course = input.next();

                // 设置参数
                ps.setString(1, course);
                ps.setInt(2,id);
                // 执行插入
                ps.executeUpdate();
                conn.commit();
                System.out.println("教师信息更改成功");
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
