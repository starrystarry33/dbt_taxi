select
    VendorID as vendor_id,
    tpep_pickup_datetime as pickup_datetime,
    tpep_dropoff_datetime as dropoff_datetime,
    passenger_count,
    trip_distance,
    PULocationID as pickup_location_id,
    DOLocationID as dropoff_location_id,
    payment_type,
    fare_amount,
    tip_amount,
    total_amount
from {{ source('taxi', 'yellow_taxi_2021_01_ext') }}
where tpep_pickup_datetime is not null
