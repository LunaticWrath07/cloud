
--Create a table to store information about hospital facilities, including location details.

CREATE TABLE hospital_facilities (
   location_id INTEGER NOT NULL,
   name_of_facility VARCHAR(255) NOT NULL,
   latitude DECIMAL(9,6) NOT NULL,
   longitude DECIMAL(9,6) NOT NULL,
   state_code CHAR(2) NOT NULL,
   zipcode CHAR(5) NOT NULL,
   PRIMARY KEY (location_id)
)
DISTSTYLE ALL;
