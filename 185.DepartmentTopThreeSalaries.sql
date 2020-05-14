SELECT Department, Employee, Salary FROM (
	SELECT DISTINCT
		d.Name AS Department,
		e.Name AS Employee,
		e.Salary AS Salary,
		DENSE_RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS SalaryRank
	FROM Employee AS E
	JOIN Department AS D on D.Id = E.DepartmentId
) AS tbl
WHERE SalaryRank <= 3