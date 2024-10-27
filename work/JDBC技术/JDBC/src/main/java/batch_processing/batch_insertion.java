package batch_processing;

import java.sql.*;
import java.util.Random;

public class batch_insertion {
    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/jdbc_homework?serverTimezone=GMT&characterEncoding=UTF-8";
        String user = "root";
        String password = "GAOYUAN202823";
        // 批量插入数据
        String sql = "INSERT INTO teacher(id, name, course, birthday) VALUES(?, ?, ?, ?)";
        String[] courses = {"JavaWeb","高等数学","计算机网络","大学物理","数据结构","MVVM"};
        String[] names ={"alex","grace","fox","shy","musk"};

        try (Connection conn = DriverManager.getConnection(url, user, password);) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(sql);) {
                // 设置参数
                for (int i = 0; i < 500; i++) {

                    //按顺序编入id
                    ps.setInt(1, i);

                    //随机插入姓名
                    Random rand = new Random();
                    ps.setString(2,courses[rand.nextInt(courses.length)]);

                    //随机插入课程
                    ps.setString(3,names[rand.nextInt(names.length)]);

                    int year = rand.nextInt(1970,2024);
                    int month = rand.nextInt(1,12);
                    int day = rand.nextInt(1,28);
                    //随机输入生日日期
                    ps.setString(4,year+"-"+month+"-"+day);
                    // 添加到批处理
                    ps.addBatch();
                    if (i % 100 == 0) { // 每100条记录执行一次批处理
                        ps.executeBatch();
                        ps.clearBatch();
                    }
                }
                ps.executeBatch();
                conn.commit();
                System.out.println("完成批量插入数据");
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
