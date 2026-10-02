CREATE DATABASE bank_analytics;
USE bank_analytics;

## KPI 1 Year-wise Loan Amount Stats

SELECT 
    YEAR(STR_TO_DATE(issue_d, '%d-%m-%Y')) AS issue_year,
    SUM(loan_amnt) AS total_loan_amount
FROM finance1
GROUP BY YEAR(STR_TO_DATE(issue_d, '%d-%m-%Y'))
ORDER BY issue_year;

## KPI Grade and Sub-grade-wise Revol balance

SELECT 
    f1.grade,
    f1.sub_grade,
    SUM(f2.revol_bal) AS total_revol_bal
FROM finance1 f1
INNER JOIN finance2 f2
    ON f1.id = f2.id
GROUP BY 
    f1.grade,
    f1.sub_grade
ORDER BY 
    f1.grade,
    f1.sub_grade;
    
    ## KPI 3 Total Payment for Verified vs Non-Verified Status
    
    SELECT 
    CASE
        WHEN f1.verification_status = 'Verified'
            THEN 'Verified'
        ELSE 'Non Verified'
    END AS verification_group,

    ROUND(SUM(f2.total_pymnt),2) AS total_payment

FROM finance1 f1

INNER JOIN finance2 f2
    ON f1.id = f2.id

GROUP BY
    CASE
        WHEN f1.verification_status = 'Verified'
            THEN 'Verified'
        ELSE 'Non Verified'
    END;
    
    ## KPI 4 State-wise and last_credit_pull_d-wise Loan Status
SELECT
    f1.addr_state,

    YEAR(
        STR_TO_DATE(f2.last_credit_pull_d,'%d-%m-%Y')
    ) AS credit_pull_year,

    f1.loan_status,

    COUNT(f1.id) AS number_of_loans

FROM finance1 f1

INNER JOIN finance2 f2
    ON f1.id = f2.id

WHERE f2.last_credit_pull_d IS NOT NULL

GROUP BY
    f1.addr_state,
    YEAR(STR_TO_DATE(f2.last_credit_pull_d,'%d-%m-%Y')),
    f1.loan_status

ORDER BY
    f1.addr_state,
    credit_pull_year;
    
    ## KPI 5 Home Ownership vs Last Payment Date Stats
    SELECT
    f1.home_ownership,

    YEAR(
        STR_TO_DATE(f2.last_pymnt_d,'%d-%m-%Y')
    ) AS last_payment_year,

    COUNT(f1.id) AS number_of_loans

FROM finance1 f1

INNER JOIN finance2 f2
    ON f1.id = f2.id

WHERE f2.last_pymnt_d IS NOT NULL

GROUP BY
    f1.home_ownership,
    YEAR(STR_TO_DATE(f2.last_pymnt_d,'%d-%m-%Y'))

ORDER BY
    last_payment_year,
    f1.home_ownership;
    
    
    