-- Create an external table using the Green Taxi Trip Records Data for 2022.

CREATE OR REPLACE EXTERNAL TABLE `terraform-demo-413615.ny_taxi.green_cab_data`
OPTIONS(
  format = 'PARQUET',
  uris = ['gs://week3-homework/green_tripdata_2022-*.parquet']
);

--Create a table in BQ using the Green Taxi Trip Records for 2022 (do not partition or cluster this table).

CREATE OR REPLACE TABLE `terraform-demo-413615.ny_taxi.green_cab_data_non_partitioned` AS
SELECT * FROM `terraform-demo-413615.ny_taxi.green_cab_data`;


--Question 2
Select distinct(PULocationID) from `terraform-demo-413615.ny_taxi.green_cab_data_non_partitioned`
Select distinct(PULocationID) from `terraform-demo-413615.ny_taxi.green_cab_data`

--Question 3
Select Count(1) from `terraform-demo-413615.ny_taxi.green_cab_data_non_partitioned`
where fare_amount = 0;

--Question 4: Create a new table with Partitioned by lpep_pickup_datetime and clustered by PUlocationID
CREATE OR REPLACE TABLE `terraform-demo-413615.ny_taxi.green_cab_data_partitioned`
PARTITION BY DATE(lpep_pickup_datetime) 
CLUSTER BY PUlocationID AS
SELECT * FROM `terraform-demo-413615.ny_taxi.green_cab_data`

--Question 5
SELECT COUNT(DISTINCT PULocationID) FROM `terraform-demo-413615.ny_taxi.green_cab_data_non_partitioned` WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30'
SELECT COUNT(DISTINCT PULocationID) FROM `terraform-demo-413615.ny_taxi.green_cab_data_partitioned` WHERE lpep_pickup_datetime BETWEEN '2022-06-01' AND '2022-06-30'