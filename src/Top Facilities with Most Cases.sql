--This query retrieves the top 10 hospital facilities with the most flu cases.

SELECT hf.name_of_facility,
    hf.location_id,
    hf.zipcode,
    hf.latitude,
    hf.longitude,
    COUNT(f.case_id) AS total_cases
FROM flu_outbreak_stream f
JOIN hospital_facilities hf ON f.facility_id = hf.location_id
GROUP BY hf.name_of_facility, hf.location_id, hf.zipcode, hf.latitude, hf.longitude
ORDER BY total_cases DESC
LIMIT 10;
