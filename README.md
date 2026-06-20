# HR Attrition & Compensation Analytics

A SQL-driven analysis of employee attrition, compensation, performance, and tenure, built on a deliberately messy HR dataset to practice real-world data cleaning and reconciliation alongside business analysis.

## Project overview

This project simulates a typical HR analytics request: given employee, salary, and performance review data exported from separate systems, clean it, reconcile inconsistencies between tables, and answer business questions about attrition, compensation, and performance.

The raw data was intentionally generated with realistic data quality issues — inconsistent text formatting, duplicate and near-duplicate records, mixed data types, and broken references between tables — to mirror what real HR exports look like before any cleanup.

## Data sources

Three related tables, linked by `EmployeeID`:

| Table | Description |
|---|---|
| `employee_raw` | Employee master data: department, job title, gender, dates, city, manager, education |
| `salary_raw` | Compensation records per employee, including multiple revisions over time |
| `performance_raw` | Performance review records per employee per review period |

## Data quality issues identified and resolved

| Issue | Table(s) affected | Resolution |
|---|---|---|
| Inconsistent text casing/abbreviations (e.g. `Sales`, `sales`, `SALES`, `Sales Dept`) | `employee_raw` (Department, Gender, City) | Standardized using `TRIM(UPPER(...))` matching with `CASE` statements |
| Exact duplicate rows | `employee_raw`, `performance_raw` | Removed using `ctid`-based deduplication, keeping the first occurrence per group |
| Near-duplicate employee records (same email, slightly different name, new ID) | `employee_raw` | Identified via grouping on email; reconciled manually |
| Mixed data types in compensation field (numeric vs. text with currency symbol) | `salary_raw` (AnnualCTC) | Cleaned to a consistent numeric type |
| Zero-value compensation entries (data errors, not real salaries) | `salary_raw` | Identified and excluded from compensation analysis |
| Performance ratings stored as both numbers and spelled-out words (`4` vs `'Four'`) | `performance_raw` | Standardized to numeric scale via `CASE` statement |
| Multiple salary revisions per employee | `salary_raw` | Resolved using `LastRevisedDate` to identify the current salary per employee, not just MIN/MAX value |
| Orphaned references (ManagerID / EmployeeID values with no matching employee record) | `employee_raw`, `salary_raw`, `performance_raw` | Flagged via anti-join logic; handled explicitly rather than silently dropped |
| Inconsistent currency labeling (`INR`, `inr`, `Rs`) | `salary_raw` | Standardized to a single currency code |

## Analysis performed

SQL scripts are organized by business theme:

- **Workforce overview** — headcount, department/gender/location/education breakdown, active vs. exited
- **Attrition analysis** — overall and segmented attrition rate (department, location, gender, education, age group, tenure group)
- **Compensation analysis** — average/median CTC, salary by department/role/location, salary growth, salary distribution bands
- **Performance analysis** — average rating, top/bottom performers, rating distribution by department and location, rating trends over review periods
- **Promotion analysis** — promotion eligibility by department and rating, high performers not promoted, promotion trends over time
- **Tenure analysis** — average tenure overall and by department/location
- **Demographic analysis** — age distribution, average age by department
- **Manager analysis** — team size, team average rating, team attrition rate, team compensation vs. performance
- **Recruitment analysis** — hiring trend by month/year, hiring by department and location

## Tools used

- **PostgreSQL** — data cleaning, reconciliation, and all analytical queries
- **Power BI / Tableau** — dashboard layer (KPI summary, department breakdowns, salary and rating distributions, trend views)

## Key techniques demonstrated

- CTEs and window functions (`ROW_NUMBER`, `COUNT(*) OVER (PARTITION BY ...)`) for deduplication and per-employee record selection
- Self-joins for manager-to-report hierarchy analysis
- `CASE`-based standardization for inconsistent categorical data
- Anti-join patterns for referential integrity checks
- Aggregate and percentile functions (`AVG`, `PERCENTILE_CONT`) for compensation analysis
- Date logic (`AGE`, `EXTRACT`) for tenure and age bucketing

## Repository structure

```
├── raw/
│   ├── employees_table.sql        # Employee data cleaning
│   ├── salaries_table.sql         # Salary data cleaning
│   ├── performance_reviews_table.sql  # Performance data cleaning
│   ├── workforce_analysis.sql
│   ├── attrition_analysis.sql
│   ├── compensation_analysis.sql
│   ├── performance_analysis.sql
│   ├── promotion_analysis.sql
│   ├── tenure_analysis.sql
│   ├── demographic_analysis.sql
│   ├── manager_analysis.sql
│   └── recruitment_analysis.sql
├── dashboard/
│   └── (Power BI / Tableau file)
└── README.md
```

## Author

Mohan, final-year B.Tech CSE, RGUKT Ongole
[nagamohan.me](https://nagamohan.me) · [github.com/unknownsteve7](https://github.com/unknownsteve7)
