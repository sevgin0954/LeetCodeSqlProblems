SELECT ISNULL(
(
	SELECT DISTINCT Salary AS SecondHighestSalary FROM Employee
	ORDER BY Salary DESC
	OFFSET 1 ROW
	FETCH FIRST 1 ROW ONLY
),
NULL) AS SecondHighestSalary