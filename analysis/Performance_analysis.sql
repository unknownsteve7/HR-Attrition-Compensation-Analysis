SELECT * FROM performance_raw;
SELECT * FROM employee_raw;
-- average performace rating
SELECT * FROM employee_raw;
-- least performers
SELECT p."EmployeeID",e.employee_name, ROUND(AVG("PerformanceRating"::NUMERIC),2)
 AS Rating FROM performance_raw p
JOIN employee_raw e ON p."EmployeeID" = e.employee_id
GROUP BY p."EmployeeID",e.employee_name
ORDER BY rating
;

-- top performers
SELECT p."EmployeeID",e.employee_name, ROUND(AVG("PerformanceRating"::NUMERIC),2)
 AS Rating FROM performance_raw p
JOIN employee_raw e ON p."EmployeeID" = e.employee_id
GROUP BY p."EmployeeID",e.employee_name
ORDER BY rating desc
;
-- rating distribution
SELECT p."PerformanceRating", COUNT(e.employee_id) FROM performance_raw p
JOIN employee_raw e ON e.employee_id = p."EmployeeID"
GROUP BY p."PerformanceRating" ORDER BY COUNT(e.employee_id)
;

--rating by department
SELECT  e.department , ROUND(AVG(p."PerformanceRating"::NUMERIC),2)
 AS rating
   FROM employee_raw e JOIN
performance_raw p
ON
e.employee_id = p."EmployeeID"
 GROUP BY e.department
 ORDER BY rating desc
;

-- rating distribution by department
SELECT  e.department , p."PerformanceRating"
 AS rating,
 COUNT(*) AS employees
   FROM employee_raw e JOIN
performance_raw p
ON
e.employee_id = p."EmployeeID"
 GROUP BY e.department, rating
 ORDER BY e.department,rating desc
;

--rating by location
SELECT  e.location , ROUND(AVG(p."PerformanceRating"::NUMERIC),2)
 AS rating
   FROM employee_raw e JOIN
performance_raw p
ON
e.employee_id = p."EmployeeID"
 GROUP BY e.location
 ORDER BY rating desc
;


--performance over time
SELECT "ReviewPeriod", ROUND(AVG("PerformanceRating"::NUMERIC),2)
FROM performance_raw
WHERE "PerformanceRating" IS NOT null
GROUP BY "ReviewPeriod" ORDER BY "ReviewPeriod";


-- top performance over trend
SELECT "ReviewPeriod", COUNT(*) AS top_performers
FROM performance_raw
WHERE "PerformanceRating"::NUMERIC = 5
GROUP BY "ReviewPeriod"
ORDER BY "ReviewPeriod";


-- low performance over trend
SELECT "ReviewPeriod", COUNT(*) AS low_performers
FROM performance_raw
WHERE "PerformanceRating"::NUMERIC IN(1,2)
GROUP BY "ReviewPeriod"
ORDER BY "ReviewPeriod";


-- Promotion Eligibility trend
SELECT "ReviewPeriod", COUNT(*) AS employees
FROM performance_raw
WHERE "PromotionFlag" = TRUE
GROUP BY "ReviewPeriod"
ORDER BY "ReviewPeriod";

