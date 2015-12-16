# Source: https://oj.leetcode.com/problems/employees-earning-more-than-their-managers/
# Author: Nocte (me@nocte.im)

/*

The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+

Given the Employee table, write a SQL query that finds out employees who earn more than their managers. For the above table, Joe is the only employee who earns more than his manager.

+----------+
| Employee |
+----------+
| Joe      |
+----------+

*/

# Write your MySQL query statement below
select t.Name as Employee from
(
    select Name, Salary, (select m.Salary from Employee m where m.Id = e.ManagerId) as ManagerSalary
    from Employee e
    where e.ManagerId is not null
) as t
where t.Salary > t.ManagerSalary