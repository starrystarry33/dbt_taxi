# dbt_taxi — NYC Yellow Taxi Analytics (dbt + BigQuery)

A dbt project that models NYC yellow taxi trip data (January 2021) in
BigQuery using a staging → core → mart layered design, with generic
data tests and generated documentation/lineage.

## Data flow

    source: yellow_taxi_2021_01_ext (external table over GCS parquet)
      → stg_yellow_tripdata → fct_trips → mart_daily_trips
    seed: taxi_zone_lookup (TLC zone CSV, 265 rows)
      → dim_zones

## Models

| Layer   | Model               | Description                                             |
|---------|---------------------|---------------------------------------------------------|
| staging | stg_yellow_tripdata | Raw trips from the external table, columns renamed      |
| core    | dim_zones           | Taxi zone dimension, one row per location_id            |
| core    | fct_trips           | One row per trip, fare_amount > 0                       |
| mart    | mart_daily_trips    | Daily aggregates: trip count, total fare, avg distance  |

All models are materialized as views.

## Data quality

8 generic tests defined in models/schema.yml, all passing:
- dim_zones.location_id: unique, not_null
- dim_zones.service_zone: accepted_values
- fct_trips.pickup_datetime / pickup_location_id /
  dropoff_location_id: not_null
- fct_trips pickup/dropoff location ids: relationships to
  dim_zones.location_id (no orphan foreign keys)

## Run it

    source ~/dbt-projects/venv/bin/activate
    dbt build          # seed + run + test in DAG order
    dbt docs generate
    dbt docs serve --port 8081

## Stack

dbt-core 1.13 (dbt-bigquery), Google BigQuery
(project: ny-rides-zoom, dataset: taxi_dataset)
