SELECT
	Doctor, 
	Professor, 
	Singer, 
	Actor
FROM (
	SELECT 
		Name, 
		Occupation
		, DENSE_RANK() OVER (PARTITION BY Occupation ORDER BY Name) AS [Rank]
	FROM OCCUPATIONS
) AS Tbl
PIVOT (
	MAX(Name)
	FOR Occupation IN (
		Doctor, 
		Professor, 
		Singer, 
		Actor
	)
) AS PivotTbl
ORDER BY [Rank]