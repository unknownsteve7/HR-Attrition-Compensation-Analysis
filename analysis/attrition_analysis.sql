-- Overall Attrition Rate

SELECT COUNT(*) FROM employee_raw
 WHERE termination_date IS NOT NULL;

 SELECT COUNT(*) FROM employee_raw ;

 WITH employees_exited AS(
 	SELECT COUNT(*)::NUMERIC AS employees_left FROM employee_raw
 WHERE termination_date IS NOT NULL
 ),
 Total_employees AS(
  SELECT COUNT(*)::NUMERIC AS employees_count FROM employee_raw
 )

 SELECT le.employees_left ,
 te.employees_count,
 ROUND((le.employees_left/te.employees_count)*100,2)
 AS attrition_rate
 FROM employees_exited le,
 Total_employees te;

 SELECT
    COUNT(termination_date) AS employees_left,
    COUNT(*) AS total_employees,
    ROUND((COUNT(termination_date)::NUMERIC / COUNT(*)) * 100, 2)
    AS attrition_rate
FROM
    employee_raw;



-- Attrition by Department
 SELECT
  	department,
    COUNT(termination_date) AS employees_left,
    COUNT(*) AS total_employees,
    ROUND((COUNT(termination_date)::NUMERIC / COUNT(*)) * 100, 2)
    AS attrition_rate
FROM
    employee_raw
    GROUP BY department;

-- Attrition by Location
SELECT
  	location,
    COUNT(termination_date) AS employees_left,
    COUNT(*) AS total_employees,
    ROUND((COUNT(termination_date)::NUMERIC / COUNT(*)) * 100, 2)
    AS attrition_rate
FROM
    employee_raw
    GROUP BY location;

-- Attrition by Gender
SELECT
  	gender,
    COUNT(termination_date) AS employees_left,
    COUNT(*) AS total_employees,
    ROUND((COUNT(termination_date)::NUMERIC / COUNT(*)) * 100, 2)
    AS attrition_rate
FROM
    employee_raw
    GROUP BY gender;

-- Attrition by Education
SELECT
  	education_level,
    COUNT(termination_date) AS employees_left,
    COUNT(*) AS total_employees,
    ROUND((COUNT(termination_date)::NUMERIC / COUNT(*)) * 100, 2)
    AS attrition_rate
FROM
    employee_raw
    GROUP BY education_level;

--Attrition by Age Group
WITH age_extracted AS (
    SELECT
        termination_date,
        EXTRACT(YEAR FROM AGE(date_of_birth)) AS "age"
    FROM employee_raw
),
age_buckets AS (
    SELECT
        termination_date,
        CASE
            WHEN "age" BETWEEN 20 AND 29 THEN '20-29'
            WHEN "age" BETWEEN 30 AND 39 THEN '30-39'
            WHEN "age" BETWEEN 40 AND 49 THEN '40-49'
            WHEN "age" BETWEEN 50 AND 59 THEN '50-59'
            ELSE '60+'
        END AS age_group
    FROM age_extracted
)
SELECT
    age_group,
    COUNT(termination_date) AS employees_left,
    COUNT(*) AS total_employees,
    ROUND((COUNT(termination_date)::NUMERIC / COUNT(*)) * 100, 2) AS attrition_rate
FROM
    age_buckets
GROUP BY
    age_group
ORDER BY
    age_group;


-- attrition by tenure
WITH tenure_extracted AS (
    SELECT
        termination_date,
        EXTRACT(YEAR FROM AGE(
            COALESCE(termination_date, CURRENT_DATE),
            date_of_joining
        )) AS tenure_years
    FROM employee_raw
),
tenure_buckets AS (
    SELECT
        termination_date,
        CASE
            WHEN tenure_years < 1 THEN '0-1 Year (New Joinees)'
            WHEN tenure_years BETWEEN 1 AND 2 THEN '1-2 Years'
            WHEN tenure_years BETWEEN 3 AND 5 THEN '3-5 Years'
            ELSE '5+ Years (Tenured)'
        END AS tenure_group,
        tenure_years
    FROM tenure_extracted
)
SELECT
    tenure_group,
    COUNT(termination_date) AS employees_left,
    COUNT(*) AS total_employees,
    ROUND((COUNT(termination_date)::NUMERIC / COUNT(*)) * 100, 2) AS attrition_rate
FROM
    tenure_buckets
GROUP BY
    tenure_group
ORDER BY
    tenure_group;