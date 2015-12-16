# Source: https://oj.leetcode.com/problems/department-top-three-salaries/
# Author: Nocte (me@nocte.im)

/*

The Employee table holds all employees. Every employee has an Id, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
+----+-------+--------+--------------+

The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+

Write a SQL query to find employees who earn the top three salaries in each of the department. For the above tables, your SQL query should return the following rows.

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Randy    | 85000  |
| IT         | Joe      | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+

**

本题基本上就是 178. Rank Scores 和 184. Department Highest Salary 的组合。

另外和 Department Highest Salary 的坑类似，这里要求的是列出 Salary 前三高的成员，而不是前三位成员。

*/

# Write your MySQL query statement below
select Department, Employee, Salary from
(
	select
		*,
		@cur := if(
			@prevDep = t.DepartmentId,
			if(
				# 这里需要判断 Salary 与上一条记录是否相同，是则不增加 Rank
				# 因为题目要求的是列出 Salary 前三高的成员，而不是前三位成员
				@prevSalary != t.Salary,
				@cur + 1,
				@cur
			),
			0
		) as Rank,
		@prevDep := t.DepartmentId,
		@prevSalary := t.Salary
	from
	(
		# 这里利用子查询对 Salary 进行排序
		select e.Salary, e.Name as Employee, e.DepartmentId, d.Name as Department
		from Employee e inner join Department d on e.DepartmentId = d.Id
		order by e.DepartmentId asc, e.Salary desc
	) as t, (select @cur := 0) c, (select @prevDep := null) d, (select @prevSalary := null) s
) as f
where f.Rank < 3