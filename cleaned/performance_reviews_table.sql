SELECT * FROM performance_raw;

SELECT "EmployeeID","ReviewPeriod", COUNT("EmployeeID") FROM performance_raw
GROUP BY "EmployeeID","ReviewPeriod" HAVING COUNT ("EmployeeID") >1;


SELECT "EmployeeID","ReviewPeriod" FROM (
SELECT "EmployeeID", "ReviewPeriod",COUNT(*)
OVER(PARTITION BY "EmployeeID") AS emp_count
 FROM performance_raw
) t
WHERE emp_count >1;

SELECT min(ctid)
    FROM performance_raw a
    GROUP BY "EmployeeID"


SELECT *
FROM performance_raw
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM performance_raw
    GROUP BY
        "EmployeeID",
        "ReviewPeriod",
        "PerformanceRating",
        "PromotionFlag",
        "ReviewerComments"
);


DELETE FROM performance_raw WHERE ctid NOT IN (
SELECT MIN(ctid)
    FROM performance_raw
    GROUP BY
        "EmployeeID",
        "ReviewPeriod",
        "PerformanceRating",
        "PromotionFlag",
        "ReviewerComments"

);