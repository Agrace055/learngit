-- 创建数据库
CREATE DATABASE IF NOT EXISTS employee_management;
USE employee_management;

-- 创建部门表
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

-- 创建员工表
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    hire_date DATE,
    job_title VARCHAR(50),
    salary DECIMAL(10, 2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 创建项目表
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE
);

-- 创建员工项目关联表
CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- 插入部门数据
INSERT INTO departments (dept_name, location) VALUES
('HR', 'New York'),
('IT', 'San Francisco'),
('Finance', 'Chicago'),
('Marketing', 'Los Angeles'),
('Operations', 'Houston');

-- 插入员工数据
INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_title, salary, dept_id) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '2020-01-15', 'HR Manager', 75000.00, 1),
('Jane', 'Smith', 'jane.smith@example.com', '2345678901', '2019-05-20', 'Software Engineer', 85000.00, 2),
('Mike', 'Johnson', 'mike.johnson@example.com', '3456789012', '2018-11-10', 'Financial Analyst', 70000.00, 3),
('Emily', 'Brown', 'emily.brown@example.com', '4567890123', '2021-03-01', 'Marketing Specialist', 65000.00, 4),
('David', 'Wilson', 'david.wilson@example.com', '5678901234', '2017-09-15', 'Operations Manager', 80000.00, 5),
('Sarah', 'Lee', 'sarah.lee@example.com', '6789012345', '2020-07-01', 'IT Support', 60000.00, 2),
('Chris', 'Anderson', 'chris.anderson@example.com', '7890123456', '2019-12-01', 'Accountant', 68000.00, 3),
('Lisa', 'Taylor', 'lisa.taylor@example.com', '8901234567', '2022-01-10', 'HR Assistant', 55000.00, 1),
('Tom', 'Martin', 'tom.martin@example.com', '9012345678', '2018-06-15', 'Software Developer', 82000.00, 2),
('Amy', 'White', 'amy.white@example.com', '0123456789', '2021-09-01', 'Marketing Manager', 78000.00, 4);

-- 插入项目数据
INSERT INTO projects (project_name, start_date, end_date) VALUES
('Website Redesign', '2023-01-01', '2024-11-30'),
('ERP Implementation', '2023-03-15', '2025-03-14'),
('Marketing Campaign', '2023-05-01', '2023-08-31'),
('Financial Audit', '2023-07-01', '2025-09-30'),
('New Product Launch', '2023-09-01', '2024-02-29');

-- 插入员工项目关联数据
INSERT INTO employee_projects (emp_id, project_id) VALUES
(2, 1), (6, 1), (9, 1),
(2, 2), (5, 2), (6, 2), (9, 2),
(4, 3), (10, 3),
(3, 4), (7, 4),
(4, 5), (5, 5), (10, 5);

#1. 查询所有员工的姓名、邮箱和工作岗位。
SELECT concat(first_name,last_name),email,job_title
FROM employees;
#2. 查询所有部门的名称和位置。
SELECT dept_name,location
FROM departments;
#3. 查询工资超过70000的员工姓名和工资。
SELECT concat(first_name,last_name),salary
FROM employees
WHERE salary>70000;
#4. 查询IT部门的所有员工。
SELECT concat(first_name,last_name)
FROM employees,departments
WHERE employees.dept_id=departments.dept_id AND dept_name IN('IT');
#5. 查询入职日期在2020年之后的员工信息。
SELECT *
FROM employees
WHERE year(hire_date) > 2020;
#6. 计算每个部门的平均工资。
SELECT dept_name,AVG(salary)
FROM employees,departments
WHERE employees.dept_id=departments.dept_id
GROUP BY departments.dept_id;
#7. 查询工资最高的前3名员工信息。
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 3;
#8. 查询每个部门员工数量。
SELECT dept_name,count(*)
FROM departments,employees
WHERE employees.dept_id=departments.dept_id
GROUP BY departments.dept_id;
#9. 查询没有分配部门的员工。
SELECT concat(first_name,last_name) AS name
FROM employees,departments
WHERE employees.dept_id=departments.dept_id
AND employees.dept_id IS NULL;
#10. 查询参与项目数量最多的员工。
WITH num_project AS (
SELECT CONCAT(first_name,last_name) AS name,count(project_id) AS num
FROM employees,employee_projects
WHERE employees.emp_id=employee_projects.emp_id
GROUP BY employees.emp_id)
SELECT num_project.name
FROM num_project
WHERE num IN(
SELECT max(num)
FROM num_project
);
#11. 计算所有员工的工资总和。
SELECT sum(salary)
FROM employees;
#12. 查询姓"Smith"的员工信息。
SELECT *
FROM employees
WHERE last_name IN ('Smith');
#13. 查询即将在半年内到期的项目。
SELECT project_name
FROM projects
WHERE end_date-curdate() < 180;
#14. 查询至少参与了两个项目的员工。
with project_num AS (
SELECT count(*) AS num,CONCAT(first_name,last_name) AS name
From employees,employee_projects
WHERE employees.emp_id=employee_projects.emp_id
GROUP BY employee_projects.emp_id
)
SELECT name
FROM project_num
WHERE num >=2;
#15. 查询没有参与任何项目的员工。
SELECT CONCAT(first_name,last_name)
FROM employees
WHERE emp_id NOT IN (
SELECT DISTINCT emp_id
FROM employee_projects
);
#16. 计算每个项目参与的员工数量。
SELECT project_name,count(emp_id) AS num
FROM projects,employee_projects
WHERE projects.project_id=employee_projects.project_id
GROUP BY employee_projects.project_id;
#17. 查询工资第二高的员工信息。
SELECT *
FROM employees
WHERE salary =
(
SELECT salary
FROM employees
ORDER BY salary DESC
LIMIT 1,1
);
#18. 查询每个部门工资最高的员工。
SELECT concat(first_name,last_name),dept_id
FROM employees
WHERE (dept_id,salary) IN
(SELECT dept_id, MAX(salary)
FROM employees
GROUP BY dept_id)
ORDER BY dept_id;
#19. 计算每个部门的工资总和,并按照工资总和降序排列。
WITH dept_salary_sum AS (
SELECT dept_id,sum(salary) AS sum_salary
FROM employees
GROUP BY employees.dept_id)
SELECT dept_name,sum_salary
FROM dept_salary_sum,departments
WHERE dept_salary_sum.dept_id=departments.dept_id
ORDER BY sum_salary DESC ;
#20. 查询员工姓名、部门名称和工资。
SELECT concat(employees.first_name,employees.last_name) AS name,departments.dept_name,employees.salary
FROM departments,employees
WHERE employees.dept_id=departments.dept_id;
#21. 查询每个员工的上级主管(假设emp_id小的是上级)。
SELECT concat(e1.first_name,e1.last_name) AS employee_name,
       concat(e2.first_name,e2.last_name) AS manager_name
FROM employees e1 LEFT JOIN employees e2 ON e1.dept_id = e2.dept_id
AND e1.emp_id > e2.emp_id
WHERE e2.emp_id IS NOT NULL;
#22. 查询所有员工的工作岗位,不要重复。
SELECT concat(first_name,last_name),employees.job_title
FROM employees;
#23. 查询平均工资最高的部门。
SELECT dept_name
FROM departments
WHERE dept_id =(
SELECT dept_id
FROM employees
GROUP BY dept_id
ORDER BY avg(salary) DESC
LIMIT 1);
#24. 查询工资高于其所在部门平均工资的员工。
with avg_salary as(
SELECT dept_id,avg(salary) AS a_salary
FROM employees
GROUP BY dept_id)
SELECT concat(first_name,last_name) AS name
FROM avg_salary LEFT JOIN employees ON employees.dept_id=avg_salary.dept_id
AND salary>a_salary
WHERE salary IS NOT NULL;
#25. 查询每个部门工资前两名的员工。
select dept_id, concat(first_name,last_name) AS name, salary
from employees e1
where (
    select count(*)
    from employees e2
    where e2.dept_id=e1.dept_id and e2.salary>=e1.salary
   ) <=2
order by dept_id, salary desc;
#26. 查询跨部门的项目(参与员工来自不同部门)。
SELECT projects.project_id, projects.project_name
FROM projects
JOIN employee_projects ON projects.project_id = employee_projects.project_id
JOIN employees ON employee_projects.emp_id = employees.emp_id
GROUP BY projects.project_id, projects.project_name
HAVING COUNT(DISTINCT employees.dept_id) > 1;
#27. 查询每个员工的工作年限,并按工作年限降序排序。
SELECT concat(first_name,last_name) AS name, TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years_of_service
FROM employees
ORDER BY years_of_service DESC;
#28. 查询本月过生日的员工(假设hire_date是生日)。
SELECT concat(first_name,last_name) AS name, hire_date
FROM employees
WHERE MONTH(hire_date) = MONTH(CURDATE());
#29. 查询即将在90天内到期的项目和负责该项目的员工。
SELECT projects.project_name, employees.first_name, employees.last_name, projects.end_date
FROM projects
JOIN employee_projects ON projects.project_id = employee_projects.project_id
JOIN employees ON employee_projects.emp_id = employees.emp_id
WHERE projects.end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 90 DAY);
#30. 计算每个项目的持续时间(天数)。
SELECT project_name, DATEDIFF(end_date, start_date) "持续天数"
FROM projects;
#31. 查询没有进行中项目的部门。
SELECT DISTINCT (dept_name)
FROM departments
LEFT JOIN employees  ON departments.dept_id = employees.dept_id
LEFT JOIN employee_projects  ON employees.emp_id = employee_projects.emp_id
LEFT JOIN projects  ON employee_projects.project_id = projects.project_id AND projects.end_date >= CURDATE()
WHERE projects.project_id IS NULL;
#32. 查询员工数量最多的部门。
SELECT departments.dept_name, COUNT(employees.emp_id) "员工数"
FROM departments
JOIN employees  ON departments.dept_id = employees.dept_id
GROUP BY departments.dept_name
ORDER BY "员工数" DESC
LIMIT 1;
#33. 查询参与项目最多的部门。
SELECT departments.dept_name, COUNT(employee_projects.project_id) "项目数"
FROM departments
JOIN employees  ON departments.dept_id = employees.dept_id
JOIN employee_projects  ON employees.emp_id = employee_projects.emp_id
GROUP BY departments.dept_name
ORDER BY "项目数" DESC
LIMIT 1;
#34. 计算每个员工的薪资涨幅(假设每年涨5%)。
SELECT concat(first_name,last_name) AS name, salary, salary * POW(1.05, TIMESTAMPDIFF(YEAR, hire_date, CURDATE())) "涨幅"
FROM employees;
#35. 查询入职时间最长的3名员工。
SELECT concat(first_name,last_name) AS name
FROM employees
ORDER BY hire_date
LIMIT 3;
#36. 查询名字和姓氏相同的员工。
SELECT concat(first_name,last_name) AS name
FROM employees
WHERE first_name = last_name;
#37. 查询每个部门薪资最低的员工。
SELECT employees.dept_id, employees.first_name, employees.last_name, employees.salary
FROM employees
JOIN (
    SELECT dept_id, MIN(salary) AS min_salary
    FROM employees
    GROUP BY dept_id
) min_salaries ON employees.dept_id = min_salaries.dept_id AND employees.salary = min_salaries.min_salary
ORDER BY dept_id;
#38. 查询哪些部门的平均工资高于公司的平均工资。
SELECT dept_name
FROM departments
JOIN (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
) dept_avg_salaries ON departments.dept_id = dept_avg_salaries.dept_id
WHERE dept_avg_salaries.avg_salary > (
    SELECT AVG(salary)
    FROM employees);
#39. 查询姓名包含"son"的员工信息。
SELECT *
FROM employees
WHERE first_name LIKE '%son%' OR last_name LIKE '%son%';
#40. 查询所有员工的工资级别(可以自定义工资级别)。
SELECT emp_id, concat(first_name,last_name) AS name, salary,
       CASE
           WHEN salary < 60000 THEN '低'
           WHEN salary >= 60000 AND salary < 75000 THEN '中'
           ELSE '高'
       END AS salary_level
FROM employees;
#41. 查询每个项目的完成进度(根据当前日期和项目的开始及结束日期)。
#42. 查询每个经理(假设job_title包含'Manager'的都是经理)管理的员工数量。
#43. 查询工作岗位名称里包含"Manager"但不在管理岗位(salary<70000)的员工。
#44. 计算每个部门的男女比例(假设以名字首字母A-M为女性,N-Z为男性)。
#45. 查询每个部门年龄最大和最小的员工(假设hire_date反应了年龄)。
#46. 查询连续3天都有员工入职的日期。
#47. 查询员工姓名和他参与的项目数量。
#48. 查询每个部门工资最高的3名员工。
#49. 计算每个员工的工资与其所在部门平均工资的差值。
#50. 查询所有项目的信息,包括项目名称、负责人姓名(假设工资最高的为负责人)、开始日期和结束日期。