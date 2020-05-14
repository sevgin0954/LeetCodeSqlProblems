----------------------------------------------------------------------------------------------
-- Solution 1
----------------------------------------------------------------------------------------------
SELECT Id FROM (
	SELECT 
		Id, 
		Temperature,
		RecordDate,
		LAG(Temperature, 1) OVER (ORDER BY RecordDate) AS YesterdaysTemp,
		LAG(RecordDate, 1) OVER (ORDER BY RecordDate) AS YesterdaysDate
	FROM Weather
) AS Tbl
WHERE Temperature > YesterdaysTemp AND DATEDIFF(DAY, YesterdaysDate, RecordDate) = 1

----------------------------------------------------------------------------------------------
-- Solution 2
----------------------------------------------------------------------------------------------
SELECT todaysWeather.Id FROM Weather AS yesterdaysWeather
JOIN Weather AS todaysWeather ON DATEDIFF(DAY, yesterdaysWeather.RecordDate, todaysWeather.RecordDate) = 1
WHERE todaysWeather.Temperature > yesterdaysWeather.Temperature