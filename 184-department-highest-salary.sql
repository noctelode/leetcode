# Source: https://oj.leetcode.com/problems/department-highest-salary/
# Author: Nocte (me@nocte.im)

/*

The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
+----+-------+--------+--------------+

The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+

Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, Max has the highest salary in the IT department and Henry has the highest salary in the Sales department.

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+

**

此题难点在于 GROUP BY 没有排序功能，查询记录永远是按照默认索引顺序排列的，需要先用一个子查询来进行前排序。

另外 Highest Salary 可能有多个，需要将其都列出来，用 max 的话只能取到其中一个，就掉进坑里了。

*/

# Write your MySQL query statement below
select s.Department, e.Name as Employee, e.Salary from Employee e inner join
(
	select * from
	(
		# 生成各部门 Highest Salary 表供最终查询使用
		select
			max(t.Salary) as Salary, t.DepartmentId, t.Department
		from
		(
			# 这里利用子查询对 Salary 进行排序
			select e.Salary, e.DepartmentId, d.Name as Department
			from Employee e inner join Department d on e.DepartmentId = d.Id
			order by e.Salary desc
		) as t
		group by t.DepartmentId
	) as s
) s
on e.Salary = s.Salary and e.DepartmentId = s.DepartmentId