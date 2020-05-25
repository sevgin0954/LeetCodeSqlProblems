SELECT * FROM (
	SELECT id, revenue, month + '_Revenue' as month FROM Department
) AS Tbl
PIVOT(
	MAX(revenue)
	FOR month IN 
	(
		Jan_Revenue,
		Feb_Revenue,
		Mar_Revenue,
		Apr_Revenue,
		May_Revenue,
		Jun_Revenue,
		Jul_Revenue,
		Aug_Revenue, 
		Sep_Revenue,
		Oct_Revenue,
		Nov_Revenue,
		Dec_Revenue
	)
) AS PivotTbl