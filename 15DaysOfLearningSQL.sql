WITH hackersWithConsecutiveSubmissions (hacker_id, submission_date)
AS
(
	SELECT DISTINCT hacker_id, submission_date FROM (
		SELECT
			h.hacker_id,
			s.submission_date,
			[rank] = ROW_NUMBER() OVER (PARTITION BY h.hacker_id ORDER BY h.hacker_id DESC)
		FROM Hackers AS h
		JOIN Submissions AS s ON s.hacker_id = h.hacker_id
		GROUP BY h.hacker_id, submission_date
	) AS Tbl
	WHERE [rank] = DAY(submission_date)
),
datesWithUniqueHackersCount (submission_date, hackers_count)
AS
(
	SELECT
		s.submission_date,
		unique_hackers_count = COUNT(DISTINCT h.hacker_id)
	FROM Hackers AS h
	JOIN Submissions AS s ON s.hacker_id = h.hacker_id
	WHERE h.hacker_id IN (SELECT hacker_id FROM hackersWithConsecutiveSubmissions)
	GROUP BY s.submission_date
),
hackersWithSubmissionCountPerDay (hacker_id, name, submission_date, submission_count)
AS
(
	SELECT
		h.hacker_id,
		h.name,
		s.submission_date,
		COUNT(*) AS submission_count
	FROM Hackers AS h
	JOIN Submissions AS s ON s.hacker_id = h.hacker_id
	WHERE h.hacker_id IN (SELECT hacker_id FROM hackersWithConsecutiveSubmissions)
	GROUP BY h.hacker_id, h.name, s.submission_date
)

SELECT
	submission_date,
	hackers_count,
	hacker_id,
	name
FROM (
	SELECT 
		d.submission_date,
		d.hackers_count,
		h.hacker_id,
		h.name,
		[rank] = ROW_NUMBER() OVER (
			PARTITION BY d.submission_date
			ORDER BY h.submission_count DESC
		)
	FROM hackersWithSubmissionCountPerDay AS h
	JOIN datesWithUniqueHackersCount AS d ON d.submission_date = h.submission_date
	JOIN hackersWithConsecutiveSubmissions AS validHackers ON 
	validHackers.hacker_id = h.hacker_id
	AND
	validHackers.submission_date = h.submission_date
) AS Tbl
WHERE [rank] = 1
ORDER BY submission_date

SELECT * FROM Submissions AS h
ORDER BY submission_date