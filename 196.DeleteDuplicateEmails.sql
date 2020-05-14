WITH DuplicatedEmailIds
AS
(
	SELECT Id, ROW_NUMBER() OVER (PARTITION BY Email ORDER BY Id) AS RowNumber FROM Person
)

DELETE FROM DuplicatedEmailIds
WHERE RowNumber > 1