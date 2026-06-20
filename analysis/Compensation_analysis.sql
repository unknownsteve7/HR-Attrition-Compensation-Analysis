SELECT ROUND(AVG("AnnualCTC"::NUMERIC),2) FROM salary_raw;

SELECT
    ROUND(
        (PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "AnnualCTC"::NUMERIC))::NUMERIC,
        2
    ) AS median_salary
FROM
    salary_raw;

SELECT * FROM salary_raw;

--salary by department
SELECT e.department, ROUND(AVG(s."AnnualCTC"),2) FROM employee_raw e
JOIN salary_raw s ON e.employee_id = s."EmployeeID"
GROUP BY e.department;
--salary by job role
SELECT e.job_title, ROUND(AVG(s."AnnualCTC"),2) FROM employee_raw e
JOIN salary_raw s ON e.employee_id = s."EmployeeID"
GROUP BY e.job_title;

--salary by location
SELECT e.location, ROUND(AVG(s."AnnualCTC"),2) FROM employee_raw e
JOIN salary_raw s ON e.employee_id = s."EmployeeID"
GROUP BY e.location;

SELECT e.employee_name, ROUND(s."AnnualCTC",2) AS salary FROM employee_raw e
JOIN salary_raw s ON e.employee_id = s."EmployeeID"
GROUP BY e.employee_name,salary
ORDER BY salary desc;



--salary growth analysis
-- overall salary growth
WITH salary_change AS(
SELECT e.employee_name AS employee,
MIN(s."AnnualCTC") AS first_salary,
MAX(s."AnnualCTC") AS latest_salary
FROM employee_raw e JOIN salary_raw s
ON e.employee_id = s."EmployeeID"
GROUP BY e.employee_name
)

SELECT employee,ROUND(
        AVG(
            (latest_salary - first_salary) * 100.0
            / NULLIF(first_salary,0)
        ),2
    ) AS avg_salary_growth_pct FROM salary_change

    GROUP BY employee
ORDER BY avg_salary_growth_pct desc
;

-- Salary Growth by Department
WITH salary_change AS (
    SELECT
        "EmployeeID",
        MIN("AnnualCTC") AS first_salary,
        MAX("AnnualCTC") AS latest_salary
    FROM salary_raw
    GROUP BY "EmployeeID"
)
SELECT
    e.department,
    ROUND(
        AVG(
            (latest_salary - first_salary) * 100.0
            / NULLIF(first_salary,0)
        ),2
    ) AS avg_growth_pct
FROM salary_change s
JOIN employee_raw e
ON s."EmployeeID" = e.employee_id
GROUP BY e.department
ORDER BY avg_growth_pct DESC;




-- Salary Distribution
WITH latest_salary AS (
SELECT "EmployeeID",MAX("AnnualCTC") AS salary FROM salary_raw GROUP BY "EmployeeID"
)
SELECT
    CASE
        WHEN salary < 500000 THEN '< 5 LPA'
        WHEN salary < 1000000 THEN '5-10 LPA'
        WHEN salary < 1500000 THEN '10-15 LPA'
        WHEN salary < 2000000 THEN '15-20 LPA'
        ELSE '20+ LPA'
    END AS salary_band,
    COUNT(*) AS employees
FROM latest_salary
GROUP BY salary_band ORDER BY employees;
