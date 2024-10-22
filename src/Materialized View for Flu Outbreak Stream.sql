--Purpose: This query creates a materialized view to store and process flu outbreak data streaming from MSK, using Redshift as the data warehouse.



CREATE MATERIALIZED VIEW flu_outbreak_stream
DISTKEY(case_id)
SORTKEY(age_group)
AS
SELECT 
   json_extract_path_text(from_varbyte(kafka_value, 'utf-8'), 'case_id', true) AS case_id,
   json_extract_path_text(from_varbyte(kafka_value,'utf-8'),'age_group',true)::INTEGER as age_group,
   json_extract_path_text(from_varbyte(kafka_value, 'utf-8'), 'gender', true) AS gender,
   json_extract_path_text(from_varbyte(kafka_value, 'utf-8'), 'vaccination_status', true) AS vaccination_status,
   json_extract_path_text(from_varbyte(kafka_value, 'utf-8'), 'symptom_severity', true) AS symptom_severity,
   json_extract_path_text(from_varbyte(kafka_value, 'utf-8'), 'admitted', true) AS admitted,
   CASE 
      WHEN json_extract_path_text(from_varbyte(kafka_value, 'utf-8'), 'admitted', true) = 'Yes' 
      THEN CAST(json_extract_path_text(from_varbyte(kafka_value, 'utf-8'), 'facility_id', true) AS INTEGER)
      ELSE NULL
   END AS facility_id,
   CASE 
      WHEN json_extract_path_text(from_varbyte(kafka_value, 'utf-8'), 'admitted', true) = 'Yes' 
      THEN CAST(json_extract_path_text(from_varbyte(kafka_value, 'utf-8'), 'days_admitted', true) AS INTEGER)
      ELSE NULL
   END AS days_admitted
FROM msk_external_schema.flu_season
WHERE LENGTH(kafka_value) < 65355 AND CAN_JSON_PARSE(kafka_value);


REFRESH MATERIALIZED VIEW flu_outbreak_stream; -- Purpose: Refresh the materialized view to get the latest streaming data from MSK.

ALTER MATERIALIZED VIEW flu_outbreak_stream AUTO REFRESH YES;
