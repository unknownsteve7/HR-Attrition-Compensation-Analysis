-- age distribution

SELECT * FROM employee_raw;

WITH age_dis AS(
SELECT EXTRACT(YEAR FROM AGE(date_of_birth))
 AS "age" FROM employee_raw)

SELECT
CASE WHEN "age" BETWEEN 20 AND 29 THEN '20-29'
 WHEN "age" BETWEEN 30 AND 39 THEN '30-39'
 WHEN "age" BETWEEN 40 AND 49 THEN '40-49'
 WHEN "age" BETWEEN 50 AND 59 THEN '50-59'
ELSE '60+'
END AS "age_group",
COUNT("age") AS Employees FROM age_dis GROUP BY "age_group" ORDER BY age_group;


--average age by department

WITH age_dep AS(
SELECT department,EXTRACT(YEAR FROM AGE(date_of_birth))
 AS "age" FROM employee_raw)

SELECT department, ROUND(AVG("age")) AS Avg_age
 FROM age_dep GROUP BY department;