SET @start_date = '2022-01-01 00:00:00';
SET @end_date = '2022-01-12 00:00:00';

SELECT 
OM.Groups
,OM.Symbol
,OM.Description
,SUM(OM.Quantity) AS Qt
,OM.Unit
FROM OrdersMaterials OM 
WHERE OM.MatType = 0 AND OM.IdOrder IN
(
	SELECT f.IdJoin
	FROM Files f 
	LEFT JOIN Orders O ON f.IdJoin = O.Id
	WHERE f.OnlyFileName LIKE '%.ptx%' AND O.DateGeneration BETWEEN @start_date AND @end_date
	GROUP BY f.IdJoin
)
GROUP BY
OM.Groups
,OM.Symbol
,OM.Description
,OM.Unit
ORDER BY SUM(OM.Quantity) DESC;