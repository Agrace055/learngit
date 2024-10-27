/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 24/09/2024 16:08:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE DATABASE school;
USE school;
CREATE TABLE `course`  (
  `course_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `teacher_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `credits` decimal(2, 1) NULL DEFAULT NULL,
  PRIMARY KEY (`course_id`) USING BTREE,
  INDEX `teacher_id`(`teacher_id`) USING BTREE,
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('C001', '高等数学', 'T001', 4.0);
INSERT INTO `course` VALUES ('C002', '大学物理', 'T002', 3.5);
INSERT INTO `course` VALUES ('C003', '程序设计', 'T003', 4.0);
INSERT INTO `course` VALUES ('C004', '数据结构', 'T004', 3.5);
INSERT INTO `course` VALUES ('C005', '数据库原理', 'T005', 4.0);
INSERT INTO `course` VALUES ('C006', '操作系统', 'T006', 3.5);

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `student_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `score` decimal(4, 1) NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`, `course_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  CONSTRAINT `score_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `score_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES ('2021001', 'C001', 85.5);
INSERT INTO `score` VALUES ('2021001', 'C002', 78.0);
INSERT INTO `score` VALUES ('2021001', 'C003', 90.5);
INSERT INTO `score` VALUES ('2021002', 'C001', 92.0);
INSERT INTO `score` VALUES ('2021002', 'C002', 83.5);
INSERT INTO `score` VALUES ('2021002', 'C004', 58.0);
INSERT INTO `score` VALUES ('2021003', 'C001', 76.5);
INSERT INTO `score` VALUES ('2021003', 'C003', 85.0);
INSERT INTO `score` VALUES ('2021003', 'C005', 69.5);
INSERT INTO `score` VALUES ('2021004', 'C002', 88.5);
INSERT INTO `score` VALUES ('2021004', 'C004', 92.5);
INSERT INTO `score` VALUES ('2021004', 'C006', 86.0);
INSERT INTO `score` VALUES ('2021005', 'C001', 61.0);
INSERT INTO `score` VALUES ('2021005', 'C003', 87.5);
INSERT INTO `score` VALUES ('2021005', 'C005', 84.0);
INSERT INTO `score` VALUES ('2021006', 'C002', 79.5);
INSERT INTO `score` VALUES ('2021006', 'C004', 83.0);
INSERT INTO `score` VALUES ('2021006', 'C006', 90.0);
INSERT INTO `score` VALUES ('2021007', 'C001', 93.5);
INSERT INTO `score` VALUES ('2021007', 'C003', 89.0);
INSERT INTO `score` VALUES ('2021007', 'C005', 94.5);
INSERT INTO `score` VALUES ('2021008', 'C002', 86.5);
INSERT INTO `score` VALUES ('2021008', 'C004', 91.0);
INSERT INTO `score` VALUES ('2021008', 'C006', 87.5);
INSERT INTO `score` VALUES ('2021009', 'C001', 80.0);
INSERT INTO `score` VALUES ('2021009', 'C003', 62.5);
INSERT INTO `score` VALUES ('2021009', 'C005', 85.5);
INSERT INTO `score` VALUES ('2021010', 'C002', 64.5);
INSERT INTO `score` VALUES ('2021010', 'C004', 89.5);
INSERT INTO `score` VALUES ('2021010', 'C006', 93.0);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `student_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `birth_date` date NULL DEFAULT NULL,
  `my_class` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2021001', '张三', '男', '2003-05-15', '计算机一班');
INSERT INTO `student` VALUES ('2021002', '李四', '女', '2003-08-22', '计算机一班');
INSERT INTO `student` VALUES ('2021003', '王五', '男', '2002-11-30', '数学一班');
INSERT INTO `student` VALUES ('2021004', '赵六', '女', '2003-02-14', '数学一班');
INSERT INTO `student` VALUES ('2021005', '钱七', '男', '2002-07-08', '物理一班');
INSERT INTO `student` VALUES ('2021006', '孙八', '女', '2003-09-19', '物理一班');
INSERT INTO `student` VALUES ('2021007', '周九', '男', '2002-12-01', '化学一班');
INSERT INTO `student` VALUES ('2021008', '吴十', '女', '2003-03-25', '化学一班');
INSERT INTO `student` VALUES ('2021009', '郑十一', '男', '2002-06-11', '生物一班');
INSERT INTO `student` VALUES ('2021010', '王十二', '女', '2003-10-05', '生物一班');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `teacher_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `birth_date` date NULL DEFAULT NULL,
  `title` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`teacher_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('T001', '张教授', '男', '1975-03-12', '教授');
INSERT INTO `teacher` VALUES ('T002', '李副教授', '女', '1980-07-22', '副教授');
INSERT INTO `teacher` VALUES ('T003', '王讲师', '男', '1985-11-08', '讲师');
INSERT INTO `teacher` VALUES ('T004', '赵助教', '女', '1990-05-15', '助教');
INSERT INTO `teacher` VALUES ('T005', '钱教授', '男', '1972-09-30', '教授');
INSERT INTO `teacher` VALUES ('T006', '孙副教授', '女', '1978-12-18', '副教授');
INSERT INTO `teacher` VALUES ('T007', '周讲师', '男', '1983-04-25', '讲师');
INSERT INTO `teacher` VALUES ('T008', '吴助教', '女', '1988-08-07', '助教');
INSERT INTO `teacher` VALUES ('T009', '郑教授', '男', '1970-01-01', '教授');
INSERT INTO `teacher` VALUES ('T010', '刘副教授', '女', '1976-06-14', '副教授');

SET FOREIGN_KEY_CHECKS = 1;


#1. 查询所有学生的信息。
SELECT *
FROM student;
#2. 查询所有课程的信息。
SELECT *
FROM course;
#3. 查询所有学生的姓名、学号和班级。
SELECT student.name,student.student_id,student.my_class
FROM student;
#4. 查询所有教师的姓名和职称。
SELECT teacher.name,teacher.title
FROM teacher;
#5. 查询不同课程的平均分数。
SELECT course_name,score.course_id,avg(score.score)
FROM score,course
WHERE score.course_id=course.course_id
GROUP BY course_id;
#6. 查询每个学生的平均分数。
SELECT name,score.student_id,avg(score.score)
FROM score,student
WHERE score.student_id=student.student_id
GROUP BY student_id;
#7. 查询分数大于85分的学生学号和课程号。
SELECT score.student_id,course.course_id
FROM course,score
WHERE score.course_id=course.course_id AND
score > 85;
#8. 查询每门课程的选课人数。
SELECT course_id,count(*)
FROM score
GROUP BY course_id;
#9. 查询选修了"高等数学"课程的学生姓名和分数。
SELECT student.name,score.score
FROM score,student,course
WHERE course.course_id=score.course_id AND score.student_id=student.student_id AND
course_name='高等数学';
#10. 查询没有选修"大学物理"课程的学生姓名。
SELECT student.name
FROM student
WHERE student_id NOT IN (
    SELECT student_id
    FROM score,course
    WHERE score.course_id=course.course_id AND
    course_name='大学物理'
);
#11. 查询C001比C002课程成绩高的学生信息及课程分数。
SELECT *
FROM student
WHERE student_id IN (
select distinct a.student_id
from score a,score b
where a.student_id=b.student_id and a.course_id='C001' and b.course_id='C002' and a.score > b.score);
#12. 统计各科成绩各分数段人数：课程编号，课程名称，[100-85]，[85-70]，[70-60]，[60-0] 及所占百分比
SELECT course_id,course_name
,(SELECT COUNT(*) FROM score WHERE score.course_id=course.course_id AND score.score<=100 AND score.score>85) "num"
,concat(((SELECT COUNT(*) FROM score WHERE score.course_id=course.course_id AND score.score<=100 AND score.score>85)/(SELECT COUNT(*) FROM score  WHERE score.course_id=course.course_id )*100),'%')  "100-85"
,(SELECT COUNT(*) FROM score WHERE score.course_id=course.course_id AND score.score<=85  AND score.score>70) "num"
,concat(((SELECT COUNT(*) FROM score WHERE score.course_id=course.course_id AND score.score<=85  AND score.score>70)/(SELECT COUNT(*) FROM score  WHERE score.course_id=course.course_id )*100),'%')  "85-70"
,(SELECT COUNT(*) FROM score WHERE score.course_id=course.course_id AND score.score<=70  AND score.score>60) "num"
,concat(((SELECT COUNT(*) FROM score WHERE score.course_id=course.course_id AND score.score<=70  AND score.score>60)/(SELECT COUNT(*) FROM score  WHERE score.course_id=course.course_id )*100),'%')  "70-60"
,(SELECT COUNT(*) FROM score WHERE score.course_id=course.course_id AND score.score<=60  AND score.score>0) "num"
,concat(((SELECT COUNT(*) FROM score WHERE score.course_id=course.course_id AND score.score<=60  AND score.score>=0)/(SELECT COUNT(*) FROM score  WHERE score.course_id=course.course_id )*100),'%')  "60-0"
FROM course
ORDER BY course_id;
#13. 查询选择C002课程但没选择C004课程的成绩情况(不存在时显示为 null )。
SELECT *
FROM score
WHERE student_id IN (
SELECT student_id
FROM score
WHERE course_id='C002' AND student_id NOT IN (
select distinct a.student_id
from score a,score b
where a.student_id=b.student_id and a.course_id='C002' and b.course_id = 'C004'));
#14. 查询平均分数最高的学生姓名和平均分数。
SELECT student.name,avg(score.score) "avg_score"
FROM score,student
WHERE score.student_id=student.student_id
GROUP BY score.student_id
ORDER BY avg_score DESC
LIMIT 1;
#15. 查询总分最高的前三名学生的姓名和总分。
SELECT student.name,sum(score.score) "total_score"
FROM student,score
WHERE score.student_id=student.student_id
GROUP BY score.student_id
ORDER BY total_score DESC
LIMIT 3;
#16. 查询各科成绩最高分、最低分和平均分。要求如下：
#以如下形式显示：课程 ID，课程 name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
#及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
#要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列
SELECT course.course_id,course.course_name,max(score.score) "max_score",min(score.score) "min_score",avg(score.score) "avg_score"
,concat(((SELECT count(*) FROM score WHERE score.course_id=course.course_id AND score >=60)/(SELECT count(*) FROM score WHERE score.course_id=course.course_id)*100),'%') "及格率"
,concat(((SELECT count(*) FROM score WHERE score.course_id=course.course_id AND score >=70 AND score <80)/(SELECT count(*) FROM score WHERE score.course_id=course.course_id)*100),'%') "中等率"
,concat(((SELECT count(*) FROM score WHERE score.course_id=course.course_id AND score >=80 AND score <90)/(SELECT count(*) FROM score WHERE score.course_id=course.course_id)*100),'%') "优良率"
,concat(((SELECT count(*) FROM score WHERE score.course_id=course.course_id AND score >=90)/(SELECT count(*) FROM score WHERE score.course_id=course.course_id)*100),'%') "优秀率"
FROM course,score
WHERE score.course_id=course.course_id
GROUP BY course_id;
#17. 查询男生和女生的人数。
SELECT (SELECT count(*) FROM student WHERE gender ='男')"男生人数",(SELECT count(*) FROM student WHERE gender ='女')"女生人数";
#18. 查询年龄最大的学生姓名。
SELECT student.name
FROM student
WHERE student.birth_date IN (
SELECT min(birth_date)
FROM student
);
#19. 查询年龄最小的教师姓名。
SELECT name
FROM teacher
WHERE birth_date IN (
SELECT max(birth_date)
FROM teacher
);
#20. 查询学过「张教授」授课的同学的信息。
SELECT *
FROM student
WHERE student_id IN
(SELECT score.student_id FROM score WHERE course_id IN
    (SELECT course_id FROM course WHERE teacher_id IN
        (SELECT teacher_id FROM teacher WHERE name='张教授')
    )
);
#21. 查询查询至少有一门课与学号为"2021001"的同学所学相同的同学的信息 。
SELECT *
FROM student
WHERE student_id IN (
SELECT DISTINCT (student.student_id)
FROM student,score
WHERE score.student_id=student.student_id AND
course_id IN
(
    SELECT course_id
    FROM score
    WHERE student_id = '2021001'
)AND
student.student_id NOT IN ('2021001'))
ORDER BY student_id;
#22. 查询每门课程的平均分数，并按平均分数降序排列。
SELECT course_name,score.course_id,avg(score.score)
FROM score,course
WHERE score.course_id=course.course_id
GROUP BY course_id
ORDER BY avg(score) DESC;
#23. 查询学号为"2021001"的学生所有课程的分数。
SELECT course_name,score
FROM score LEFT JOIN course ON course.course_id=score.course_id
WHERE  student_id ='2021001';
#24. 查询所有学生的姓名、选修的课程名称和分数。
SELECT student.name,course.course_name,score.score
FROM score,student,course
WHERE score.course_id=course.course_id AND score.student_id=student.student_id;
#25. 查询每个教师所教授课程的平均分数。
SELECT teacher.name,course.course_name,avg(score.score)
FROM score,teacher,course
WHERE teacher.teacher_id=course.teacher_id AND score.course_id=course.course_id
GROUP BY score.course_id;
#26. 查询分数在80到90之间的学生姓名和课程名称。
SELECT student.name,course.course_name
FROM student,course,score
WHERE score.student_id=student.student_id AND score.course_id=course.course_id AND
score >=80 AND score<=90;
#27. 查询每个班级的平均分数。
SELECT my_class,avg(score.score)
FROM score,student
WHERE score.student_id=student.student_id
GROUP BY my_class;
#28. 查询没学过"王讲师"老师讲授的任一门课程的学生姓名。
SELECT student.name
FROM student
WHERE name NOT IN (
SELECT DISTINCT (student.name)
FROM student,score
WHERE score.student_id=student.student_id AND course_id IN (
SELECT course_id
FROM course,teacher
WHERE course.teacher_id=teacher.teacher_id AND name ='王讲师'));
#29. 查询两门及其以上小于85分的同学的学号，姓名及其平均成绩 。
SELECT student.student_id,name,avg(score)
FROM score s1,student
WHERE (SELECT count(*) FROM score s2 WHERE s1.student_id=s2.student_id AND s2.score <85) >=2 AND s1.student_id=student.student_id
GROUP BY student_id;
#30. 查询所有学生的总分并按降序排列。
SELECT student_id,sum(score.score)
FROM score
GROUP BY student_id
ORDER BY sum(score) DESC ;
#31. 查询平均分数超过85分的课程名称。
SELECT course.course_name
FROM course,score
WHERE score.course_id=course.course_id
GROUP BY score.course_id
HAVING avg(score)>85;
#32. 查询每个学生的平均成绩排名。
SELECT student.name,avg(score.score),rank() OVER (
    ORDER BY avg(score.score) DESC
) AS avg_score
FROM score,student
WHERE score.student_id=student.student_id
GROUP BY score.student_id;
#33. 查询每门课程分数最高的学生姓名和分数。
SELECT  course_id,student.name,s1.score
FROM score s1,student
WHERE s1.student_id=student.student_id AND (
    SELECT count(*)
    FROM score s2
    WHERE s1.course_id=s2.course_id AND s2.score >=s1.score
)<=1
ORDER BY course_id;
#34. 查询选修了"高等数学"和"大学物理"的学生姓名。
SELECT student.name
FROM score,student
WHERE course_id IN (
    SELECT course_id
    FROM course
    WHERE course_name='高等数学' OR course_name='大学物理'
) AND score.student_id=student.student_id
GROUP BY student.name
HAVING count(score)='2';
#35. 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩（没有选课则为空）。
select student.name,course.course_name,score.score,avg_score
from score,course,student,
(select student_id,avg(score) as avg_score from score
GROUP BY student_id) as avg_student
where score.course_id=course.course_id and score.student_id=student.student_id and avg_student.student_id=student.student_id
order BY avg_score desc;
#36. 查询分数最高和最低的学生姓名及其分数。
SELECT
(SELECT name
FROM score,student
WHERE score.student_id=student.student_id AND
score IN (SELECT MAX(score.score) FROM score))"最高分学生",max(score)"分数",
(SELECT name
FROM score,student
WHERE score.student_id=student.student_id AND
score IN (SELECT MIN(score.score) FROM score))"最低分学生",min(score)"分数"
FROM score,student
WHERE score.student_id=student.student_id;
#37. 查询每个班级的最高分和最低分。
SELECT student.my_class,max(score.score)"最高分",min(score.score)"最低分"
FROM score,student
WHERE score.student_id=student.student_id
GROUP BY my_class;
#38. 查询每门课程的优秀率（优秀为90分）。
SELECT course.course_name,concat(((SELECT count(*) FROM score WHERE score.course_id=course.course_id AND score >=90)/(SELECT count(*) FROM score WHERE score.course_id=course.course_id)*100),'%') "优秀率"
FROM course;
#39. 查询平均分数超过班级平均分数的学生。
SELECT student.name
FROM
(SELECT my_class,avg(score) AS avg_class
FROM student,score
WHERE score.student_id=student.student_id
GROUP BY my_class) AS avg_class,
(SELECT name,avg(score) AS avg_student
FROM student,score
WHERE score.student_id=student.student_id
GROUP BY name) AS avg_student,
student
WHERE student.name=avg_student.name AND student.my_class=avg_class.my_class AND avg_student>avg_class;
#40. 查询每个学生的分数及其与课程平均分的差值。
SELECT name, course_name,score-avg_score "差值"
FROM score,student,
(SELECT course_name,score.course_id,avg(score) AS avg_score
FROM student,score,course
WHERE score.student_id=student.student_id AND score.course_id=course.course_id
GROUP BY course_id) AS avg_course
WHERE avg_course.course_id=score.course_id AND score.student_id=student.student_id;
#41. 查询至少有一门课程分数低于80分的学生姓名。
#42. 查询所有课程分数都高于85分的学生姓名。
#43. 查询查询平均成绩大于等于90分的同学的学生编号和学生姓名和平均成绩。
#44. 查询选修课程数量最少的学生姓名。
#45. 查询每个班级的第2名学生（按平均分数排名）。
#46. 查询每门课程分数前三名的学生姓名和分数。
#47. 查询平均分数最高和最低的班级。
#48. 查询每个学生的总分和他所在班级的平均分数。
#49. 查询每个学生的最高分的课程名称, 学生名称，成绩。
#50. 查询每个班级的学生人数和平均年龄。