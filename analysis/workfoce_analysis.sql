SELECT * FROM employee_raw;
-- Total Employees
SELECT COUNT(*) FROM employee_raw;

-- Employees By Department

SELECT department,COUNT(*) AS Employees FROM employee_raw GROUP BY department ORDER BY
Employees DESC;



-- Roles by Department
SELECT department, job_title , COUNT(*) AS Jobs FROM employee_raw
GROUP BY department,job_title ORDER BY department;

-- department wise genders
SELECT department,gender, COUNT(gender) AS gender_count FROM employee_raw

GROUP BY department,gender ORDER BY department;

-- employees BY gender

SELECT gender, COUNT(*) FROM employee_raw GROUP BY gender;

-- employees by location

SELECT location,COUNT(*) FROM employee_raw GROUP BY LOCATION;

-- employees by educatin

SELECT education_level, COUNT(*) FROM employee_raw GROUP BY education_level;

-- Active vs Inactive

SELECT status, COUNT(*) FROM ( SELECT
CASE WHEN termination_date IS NOT NULL  THEN 'Exited'
ELSE 'Active'
END AS status FROM employee_raw
) t
GROUP BY status;



