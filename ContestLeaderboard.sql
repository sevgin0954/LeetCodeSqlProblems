SELECT hacker_id, [name], SUM(maxScore) AS totalScore FROM (
	SELECT
		h.hacker_id,
		h.name,
		MAX(s.score) AS maxScore,
		s.challenge_id
	FROM Hackers AS h
	JOIN Submissions AS s ON s.hacker_id = h.hacker_id
	GROUP BY h.hacker_id, h.[name], challenge_id
) AS Tbl
GROUP BY hacker_id, name
HAVING SUM(maxScore) != 0
ORDER BY totalScore DESC, hacker_id