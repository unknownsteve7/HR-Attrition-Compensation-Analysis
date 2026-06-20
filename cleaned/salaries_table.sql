SELECT * FROM salary_raw;



SELECT "EmployeeID", "AnnualCTC","LastRevisedDate","BonusPercent"
FROM (
    SELECT "EmployeeID", "AnnualCTC","LastRevisedDate","BonusPercent",
           COUNT(*) OVER(PARTITION BY "EmployeeID") as emp_count
    FROM salary_raw
) temp
WHERE emp_count > 1;


UPDATE salary_raw
SET "Currency" = CASE
WHEN TRIM(UPPER("Currency")) IN('INR','RS') THEN 'INR'
ELSE TRIM(UPPER("Currency"))
END;

SELECT DISTINCT("Currency") FROM salary_raw;


SELECT employee_id,
       Termination_Date
FROM employee_raw
WHERE employee_id = 1185;

