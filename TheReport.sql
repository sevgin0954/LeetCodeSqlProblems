SELECT 
	CASE
		WHEN g.Grade < 8 THEN NULL
		ELSE g.Grade
	END AS Name, 
	g.Grade, 
	s.Marks
FROM Students AS s
JOIN Grades AS g ON s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY g.Grade DESC, s.Name, s.Marks