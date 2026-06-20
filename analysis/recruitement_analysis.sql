SELECT * FROM employee_raw ;

-- monthly hiring trend
WITH "month" AS(
SELECT EXTRACT(MONTH FROM date_of_joining) AS "month"
FROM employee_raw
),
 month_names AS(
SELECT "month",
CASE
WHEN "month" = 1 THEN 'jan'
WHEN "month" = 2 THEN 'feb'
WHEN "month" = 3 THEN 'mar'
WHEN "month" = 4 THEN 'apr'
WHEN "month" = 5 THEN 'may'
WHEN "month" = 6 THEN 'jun'
WHEN "month" = 7 THEN 'jul'
WHEN "month" = 8 THEN 'aug'
WHEN "month" = 9 THEN 'sep'
WHEN "month" = 10 THEN 'oct'
WHEN "month" = 11 THEN 'nov'
WHEN "month" = 12 THEN 'dec'
END AS month_name FROM "month"
)
SELECT month_name , COUNT(*) AS hiring_count FROM  month_names

GROUP BY "month_name","month"
ORDER BY "month"
;

SELECT "year" , COUNT(*) AS hiring_count  FROM (
SELECT EXTRACT(year FROM date_of_joining) AS "year" FROM employee_raw
)
GROUP BY "year"
ORDER BY "year"
;


-- hiring by department
SELECT
    department,
    COUNT(*) AS total_hired
FROM
    employee_raw
GROUP BY
    department
ORDER BY
    total_hired DESC;

-- hiring by location
SELECT
    location,
    department,
    COUNT(*) AS total_hired
FROM
    employee_raw
GROUP BY
    location,
    department
ORDER BY
    location ASC,
    total_hired DESC;