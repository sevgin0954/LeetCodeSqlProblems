WITH hackerIdsWithEachDaySubmissions (id, name)
AS
(
	SELECT
		h.hacker_id,
		h.name
	FROM Hackers AS h
	JOIN Submissions AS s ON s.hacker_id = h.hacker_id
	WHERE submission_date BETWEEN '2016-03-01' AND '2016-03-15'
	GROUP BY h.hacker_id, h.name
	HAVING COUNT(DISTINCT s.submission_date) >= 15
),
hackersWithSubmissionsCountPerDay (id, name, submission_date, submissionCount)
AS
(
	SELECT
		h.id,
		h.name,
		s.submission_date,
		submissionCount = COUNT(s.submission_id)
	FROM hackerIdsWithEachDaySubmissions AS h
	JOIN Submissions AS s ON s.hacker_id = h.id
	GROUP BY h.id, h.name, s.submission_date
)

SELECT
	submission_date,
	[hackersCount]
	id,
	name
FROM (
	SELECT
		id,
		name,
		submission_date,
		[rank] = RANK() OVER (
			PARTITION BY submission_date
			ORDER BY submissionCount DESC, id
		),
		[hackersCount] = COUNT(id) OVER (PARTITION BY submission_date)
	FROM hackersWithSubmissionsCountPerDay
) AS Tbl
WHERE [rank] = 1
ORDER BY submission_date