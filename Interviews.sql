WITH groupedViewStats
AS
(
	SELECT
		challenge_id,
		SUM(total_views) AS total_views,
		SUM(total_unique_views) AS total_unique_views
	FROM View_Stats AS vs
	GROUP BY challenge_id
),
groupedSubmissionStats
AS
(
	SELECT
		challenge_id,
		SUM(total_submissions) AS total_submissions,
		SUM(total_accepted_submission) AS total_accepted_submission
	FROM Submission_Stats
	GROUP BY challenge_id
)

SELECT * FROM (
	SELECT
		con.contest_id,
		con.hacker_id,
		con.name,
		ISNULL(SUM(ss.total_submissions), 0) AS total_submissions,
		ISNULL(SUM(ss.total_accepted_submission), 0) AS total_accepted_submissions,
		ISNULL(SUM(vs.total_views), 0) AS total_views,
		ISNULL(SUM(vs.total_unique_views), 0) AS total_unique_views
	FROM Contests AS con
	JOIN Colleges AS coll ON coll.contest_id = con.contest_id
	JOIN Challenges AS chall ON chall.college_id = coll.college_id
	LEFT JOIN groupedViewStats AS vs ON vs.challenge_id = chall.challenge_id
	LEFT JOIN groupedSubmissionStats AS ss ON ss.challenge_id = chall.challenge_id
	GROUP BY con.contest_id, con.hacker_id, con.name
) AS Tbl
WHERE 
total_submissions > 0 
OR 
total_accepted_submissions > 0 
OR 
total_views > 0 
OR 
total_unique_views > 0
ORDER BY contest_id