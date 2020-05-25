SELECT
	MIN(Start_Date) AS Start_Date,
	MAX(End_Date) AS End_Date
FROM (
	SELECT
		Task_ID,
		Start_Date,
		End_Date,
		[Group] = Start_Date_Total_Days - ROW_NUMBER() OVER (ORDER BY Task_ID)
	FROM (
		SELECT
			Task_ID,
			Start_Date,
			Next_Start_Date = LEAD(Start_Date, 1) OVER (ORDER BY Task_ID),
			End_Date,
			Start_Date_Total_Days = DATEDIFF(DAY, '01-01-0001', Start_Date)
		FROM Projects
	) AS Tbl
) AS Tbl2
GROUP BY [Group]
ORDER BY DATEDIFF(DAY, MIN(Start_Date), MAX(End_Date))