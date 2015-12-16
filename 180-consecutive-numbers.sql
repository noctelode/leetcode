# Source: https://oj.leetcode.com/problems/consecutive-numbers/
# Author: Nocte (me@nocte.im)

/*

Write a SQL query to find all numbers that appear at least three times consecutively.

+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+

For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

**

本题可以先利用 178. Rank Scores 的方法求出临时表，再对该表进行分组判断。

*/

# Write your MySQL query statement below
select distinct Num from (
	select Num, count(Rank) as Times from (
		select num, @cur := @cur + if(@prev = Num, 0, 1) as Rank, @prev := Num
		from Logs s, (select @cur := 0) c, (select @prev := null) p
		order by Id asc
	) t
	group by Rank having Times >= 3
) tt;