SELECT Name FROM Students AS s
JOIN Packages AS sp ON sp.ID = s.ID
JOIN Friends AS f ON f.ID = s.Id
JOIN Packages AS fp ON fp.ID = f.Friend_ID
WHERE fp.Salary > sp.Salary
ORDER BY fp.Salary