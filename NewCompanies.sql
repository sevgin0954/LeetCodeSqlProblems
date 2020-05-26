SELECT 
	c.company_code, 
	c.founder,
	COUNT(DISTINCT lm.lead_manager_code) AS leadManagersCount,
	COUNT(DISTINCT sm.senior_manager_code) AS seniorManagersCount,
	COUNT(DISTINCT m.manager_code) AS managersCount,
	COUNT(DISTINCT e.employee_code) AS employeeCode
FROM Company AS c
JOIN Lead_Manager AS lm ON lm.company_code = c.company_code
JOIN Senior_Manager AS sm ON sm.company_code = c.company_code
JOIN Manager AS m ON m.company_code = c.company_code
JOIN Employee AS e ON e.company_code = c.company_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code