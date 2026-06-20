-- team size per mangager

SELECT * FROM employee_raw
 WHERE manager_id IS NULL;

SELECT
    e.employee_id AS emp_id,
    e.employee_name AS employee_name,
    e.department AS department,
    m.employee_id AS manager_id,
    m.employee_name AS manager_name
FROM
    employee_raw e
LEFT JOIN
    employee_raw m ON e.manager_id = m.employee_id
ORDER BY
    manager_name;

SELECT DISTINCT(manager_id) FROM employee_raw;


SELECT
    m.employee_id AS manager_id,
    m.employee_name AS manager_name,
    COUNT(e.employee_id) AS total_reports
FROM
    employee_raw e
JOIN
    employee_raw m ON e.manager_id = m.employee_id
GROUP BY
    m.employee_id, m.employee_name
ORDER BY
    total_reports DESC;


-- Manager Performance Impact

SELECT
    m.employee_id AS manager_id,
    m.employee_name AS manager_name,
    ROUND(AVG(p."PerformanceRating"::NUMERIC), 2) AS team_avg_rating,
    COUNT(DISTINCT e.employee_id) AS team_size
FROM employee_raw e
JOIN employee_raw m ON e.manager_id = m.employee_id
JOIN performance_raw p ON e.employee_id = p."EmployeeID"
GROUP BY m.employee_id, m.employee_name
ORDER BY team_avg_rating DESC;

-- Team Attrition / Exit Rate
    SELECT
    m.employee_id AS manager_id,
    m.employee_name AS manager_name,
    COUNT(e.employee_id) AS total_team_members,
    COUNT(e.termination_date) AS exited_members,
    ROUND((COUNT(e.termination_date)::NUMERIC / COUNT(e.employee_id)) * 100, 2) AS team_attrition_rate
FROM employee_raw e
JOIN employee_raw m ON e.manager_id = m.employee_id
GROUP BY m.employee_id, m.employee_name
ORDER BY team_attrition_rate DESC;


--Team Salary vs Performance (ROI Analysis)

SELECT
    m.employee_name AS manager_name,
    ROUND(AVG(s."AnnualCTC"::NUMERIC), 2) AS team_avg_ctc,
    ROUND(AVG(p."PerformanceRating"::NUMERIC), 2) AS team_avg_rating
FROM employee_raw e
JOIN employee_raw m ON e.manager_id = m.employee_id
JOIN salary_raw s ON e.employee_id = s."EmployeeID"
JOIN performance_raw p ON e.employee_id = p."EmployeeID"
GROUP BY m.employee_id, m.employee_name
ORDER BY team_avg_rating DESC, team_avg_ctc ASC;