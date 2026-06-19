SELECT employee_id, COUNT(*) as occurrence_count
FROM employee_raw
GROUP BY employee_id
HAVING COUNT(*) > 1;

DELETE FROM employee_raw
WHERE ctid NOT IN (
    SELECT min(ctid)
    FROM employee_raw
    GROUP BY employee_id
);

SELECT * FROM employee_raw ORDER BY employee_id;
SELECT DISTINCT(department) FROM employee_raw ORDER BY department;
UPDATE employee_raw
SET department = CASE
 WHEN UPPER(department) IN ('CS', 'CUSTOMER SUPPORT', 'SUPPORT') THEN 'Customer Support'
    WHEN UPPER(department) IN ('ENGG', 'ENGINEERING') THEN 'Engineering'
    WHEN UPPER(department) IN ('FIN', 'FINANCE') THEN 'Finance'
    WHEN UPPER(department) IN ('H.R.', 'HR', 'HUMAN RESOURCES') THEN 'Human Resources'
    WHEN UPPER(department) IN ('I.T.', 'IT', 'INFORMATION TECHNOLOGY') THEN 'Information Technology'
    WHEN UPPER(department) IN ('MKTG', 'MARKETING') THEN 'Marketing'
    WHEN UPPER(department) IN ('OPERATIONS', 'OPS') THEN 'Operations'
    WHEN UPPER(department) IN ('SALES', 'SALES DEPT') THEN 'Sales'
    ELSE department
 END;
 SELECT department, LENGTH(department) FROM employee_raw ORDER BY department;

 UPDATE employee_raw
SET department = CASE
    WHEN TRIM(UPPER(department)) IN ('CS', 'CUSTOMER SUPPORT', 'SUPPORT') THEN 'Customer Support'
    WHEN TRIM(UPPER(department)) IN ('ENGG', 'ENGINEERING') THEN 'Engineering'
    WHEN TRIM(UPPER(department)) IN ('FIN', 'FINANCE') THEN 'Finance'
    WHEN TRIM(UPPER(department)) IN ('H.R.', 'HR', 'HUMAN RESOURCES') THEN 'Human Resources'
    WHEN TRIM(UPPER(department)) IN ('I.T.', 'IT', 'INFORMATION TECHNOLOGY') THEN 'Information Technology'
    WHEN TRIM(UPPER(department)) IN ('MKTG', 'MARKETING') THEN 'Marketing'
    WHEN TRIM(UPPER(department)) IN ('OPERATIONS', 'OPS') THEN 'Operations'
    WHEN TRIM(UPPER(department)) IN ('SALES', 'SALES DEPT') THEN 'Sales'
    ELSE TRIM(department)
END;

SELECT DISTINCT(gender) FROM employee_raw;
SELECT gender, LENGTH(gender) FROM employee_raw ORDER BY gender;

UPDATE employee_raw SET gender = CASE
WHEN TRIM(UPPER(gender)) IN('FEMALE','F') THEN 'FEMALE'
WHEN TRIM(UPPER(gender)) IN('MALE','M') THEN 'MALE'
ELSE TRIM(gender)
END;
SELECT * FROM employee_raw ;
SELECT date_of_birth, pg_typeof(date_of_birth) FROM employee_raw ;
SELECT employee_name , COUNT(employee_name) FROM employee_raw GROUP BY employee_name
HAVING COUNT(employee_name) >1;
SELECT employee_name,email, COUNT(email) FROM employee_raw GROUP BY email,employee_name
HAVING COUNT(email)>1
SELECT * FROM employee_raw WHERE email IS NULL;
SELECT DISTINCT(location),LENGTH(location) FROM employee_raw ORDER BY location;
UPDATE employee_raw
SET location =
    CASE
        WHEN UPPER(TRIM(location)) IN ('AHMEDABAD') THEN 'Ahmedabad'
        WHEN UPPER(TRIM(location)) IN ('BANGALORE', 'BENGALURU') THEN 'Bangalore'
        WHEN UPPER(TRIM(location)) IN ('CHENNAI') THEN 'Chennai'
        WHEN UPPER(TRIM(location)) IN ('DELHI', 'NEW DELHI') THEN 'Delhi'
        WHEN UPPER(TRIM(location)) IN ('HYDERABAD', 'HYD') THEN 'Hyderabad'
        WHEN UPPER(TRIM(location)) IN ('KOLKATA', 'CALCUTTA') THEN 'Kolkata'
        WHEN UPPER(TRIM(location)) IN ('MUMBAI', 'BOMBAY') THEN 'Mumbai'
        WHEN UPPER(TRIM(location)) IN ('PUNE') THEN 'Pune'
        WHEN UPPER(TRIM(location)) IN ('VIJAYAWADA') THEN 'Vijayawada'
        WHEN UPPER(TRIM(location)) IN ('VISAKHAPATNAM', 'VIZAG') THEN 'Visakhapatnam'
        ELSE INITCAP(TRIM(location))
    END;
SELECT * FROM employee_raw  WHERE LOCATION IS NULL;

SELECT DISTINCT(education_level) FROM employee_raw ;
SELECT * FROM employee_raw WHERE manager_id IS NULL;


