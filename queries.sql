-- Default rate by credit grade
SELECT grade, COUNT(*) AS loans, ROUND(AVG(is_default), 3) AS default_rate
FROM loans
GROUP BY grade
ORDER BY grade;

-- Default rate by debt-to-income band
SELECT CASE WHEN dti < 10 THEN '1. under 10'
            WHEN dti < 20 THEN '2. 10-20'
            WHEN dti < 30 THEN '3. 20-30'
            ELSE '4. 30+' END AS dti_band,
       COUNT(*) AS loans,
       ROUND(AVG(is_default), 3) AS default_rate
FROM loans
GROUP BY dti_band
ORDER BY dti_band;

-- Riskiest purpose and term combinations (groups over 5,000 loans)
SELECT purpose, term_months, COUNT(*) AS loans, ROUND(AVG(is_default), 3) AS default_rate
FROM loans
GROUP BY purpose, term_months
HAVING COUNT(*) > 5000
ORDER BY default_rate DESC
LIMIT 10;