use cleaned;
 -- . Year-wise total loan amount by status
  -- only year by loan amount   
SELECT
    2000 + CAST(RIGHT(TRIM(issue_d), 2) AS UNSIGNED) AS year,
    SUM(loan_amnt) AS total_loan_amount
FROM cleaned
WHERE issue_d IS NOT NULL
  AND TRIM(issue_d) <> ''
  AND CAST(RIGHT(TRIM(issue_d), 2) AS UNSIGNED) BETWEEN 7 AND 11
GROUP BY
    2000 + CAST(RIGHT(TRIM(issue_d), 2) AS UNSIGNED)
ORDER BY
    year;
-- year wise total loan amount by status 
-- display loan amount by status also
SELECT
    2000 + CAST(RIGHT(TRIM(issue_d), 2) AS UNSIGNED) AS year,

    SUM(CASE
        WHEN loan_status = 'Fully Paid'
        THEN loan_amnt ELSE 0
    END) AS fully_paid,

    SUM(CASE
        WHEN loan_status = 'Current'
        THEN loan_amnt ELSE 0
    END) AS current,

    SUM(CASE
        WHEN loan_status = 'Charged Off'
        THEN loan_amnt ELSE 0
    END) AS charged_off,

    SUM(loan_amnt) AS total_loan_amount

FROM cleaned

WHERE issue_d IS NOT NULL
  AND TRIM(issue_d) <> ''
  AND CAST(RIGHT(TRIM(issue_d), 2) AS UNSIGNED) BETWEEN 7 AND 11

GROUP BY
    2000 + CAST(RIGHT(TRIM(issue_d), 2) AS UNSIGNED)

ORDER BY
    year;

 -- loan amount by loan status:
 SELECT
    loan_status,
    SUM(loan_amnt) AS total_loan_amount
FROM cleaned
GROUP BY loan_status
ORDER BY total_loan_amount DESC;

