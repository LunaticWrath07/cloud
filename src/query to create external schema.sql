
--Purpose: This query creates an external schema in Amazon Redshift for Amazon MSK. It enables querying streaming data from MSK in Redshift.


CREATE EXTERNAL SCHEMA msk_external_schema
FROM MSK
IAM_ROLE '<insert your redshift-role arn>'
AUTHENTICATION iam
CLUSTER_ARN '<insert your msk-cluster arn>';
