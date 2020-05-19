DECLARE @lastId INT = (
	SELECT TOP(1) id FROM seat
	ORDER BY id DESC
);

SELECT 
	CASE
		WHEN id % 2 = 1 AND id != @lastId
			THEN id + 1
		WHEN id % 2 = 0
			THEN id - 1
		ELSE id
	END AS id,
	student
FROM seat
ORDER BY id