# Source: https://oj.leetcode.com/problems/rank-scores/
# Author: Nocte (me@nocte.im)

/*

Write a SQL query to rank scores. If there is a tie between two scores, both should have the same ranking. Note that after a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no "holes" between ranks.

+----+-------+
| Id | Score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+

For example, given the above Scores table, your query should generate the following report (order by highest score):

+-------+------+
| Score | Rank |
+-------+------+
| 4.00  | 1    |
| 4.00  | 1    |
| 3.85  | 2    |
| 3.65  | 3    |
| 3.65  | 3    |
| 3.50  | 4    |
+-------+------+

*/

# Write your MySQL query statement below
select Score, Rank from
(
	select Score, @cur := @cur + if(@prev = Score, 0, 1) as Rank, @prev := Score
	from Scores s, (select @cur := 0) c, (SELECT @prev := null) p
	order by Score desc
) as t