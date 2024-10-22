--Purpose: This query calculates the hospitalization rate for each age group based on the flu outbreak data.

SELECT age_group,
    COUNT(case_id) AS total_cases,
    SUM(CASE WHEN admitted = 'Yes' THEN 1 ELSE 0 END) AS hospitalized_cases,
    ROUND(SUM(CASE WHEN admitted = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(case_id), 2) AS hospitalization_rate
FROM flu_outbreak_stream
GROUP BY age_group
ORDER BY hospitalization_rate DESC;
