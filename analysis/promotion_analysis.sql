-- promotion eligibility by department
SELECT e.department, COUNT(e.employee_id) AS employees
 FROM employee_raw e
JOIN performance_raw p ON e.employee_id = p."EmployeeID"
WHERE p."PromotionFlag" = TRUE
GROUP BY e.department
;

--Promotion Eligible by Performance Rating

SELECT "ReviewPeriod","PerformanceRating" ,COUNT(*) AS employees
FROM performance_raw
WHERE "PromotionFlag" = TRUE
GROUP BY "ReviewPeriod","PerformanceRating"
ORDER BY "ReviewPeriod","PerformanceRating";

-- High Performers Not Eligible for Promotion
SELECT e.employee_name,p."PerformanceRating",e.department,p."PromotionFlag"
FROM employee_raw e JOIN performance_raw p
ON e.employee_id = p."EmployeeID"
WHERE p."PerformanceRating"::NUMERIC = 5 AND
p."PromotionFlag" = FALSE;


-- Promotion Eligibility trend
SELECT "ReviewPeriod", COUNT(*) AS employees
FROM performance_raw
WHERE "PromotionFlag" = TRUE
GROUP BY "ReviewPeriod"
ORDER BY "ReviewPeriod";