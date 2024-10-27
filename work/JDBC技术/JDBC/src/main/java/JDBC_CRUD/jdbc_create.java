package JDBC_CRUD;

import java.sql.*;
import java.text.ParseException;
import java.util.Scanner;

public class jdbc_create {
    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/jdbc_homework?serverTimezone=GMT&characterEncoding=UTF-8";
        String user = "root";
        String password = "GAOYUAN202823";

        String sql = "INSERT INTO teacher (id,name,course,birthday) VALUES (?,?,?,?)";
        Scanner input = new Scanner(System.in);

        try (Connection conn = DriverManager.getConnection(url, user, password);) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(sql);) {

                System.out.println("教师信息插入");

                System.out.println("请输入教师id");
                int id = input.nextInt();

                System.out.println("请输入教师姓名");
                String name = input.next();

                System.out.println("请输入教师所教授的课程名称");
                String course = input.next();

                System.out.println("请输入教师的生日(yyyy-mm-dd)");
                String date = input.next();

                // 设置参数
                ps.setInt(1,id);
                ps.setString(2, name);
                ps.setString(3, course);
                ps.setString(4, date);
                // 执行插入
                ps.executeUpdate();
                conn.commit();
                System.out.println("教师信息插入成功");
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
