--Purpose: This query retrieves flu cases categorized as severe by age group

SELECT age_group,
    symptom_severity,
    COUNT(case_id) AS total_cases
FROM flu_outbreak_stream
WHERE symptom_severity = 'severe'
GROUP BY age_group, symptom_severity
ORDER BY total_cases DESC;