SELECT * FROM employee_raw;

-- avg tenure
SELECT ROUND(AVG(CURRENT_DATE - date_of_joining),2) / 365
AS Avg_Tenure_years
 FROM employee_raw ;

-- avg tenure by department
SELECT department,
ROUND(AVG(CURRENT_DATE - date_of_joining) / 365)
AS Avg_Tenure_years
 FROM employee_raw
 GROUP BY department
;


-- avg tenure by location
SELECT location,
ROUND(AVG(CURRENT_DATE - date_of_joining) / 365)
AS Avg_Tenure_years
 FROM employee_raw
 GROUP BY location
;

-- attrition vs tenure
