select
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    pickup_location_id,
    dropoff_location_id,
    fare_amount,
    tip_amount,
    total_amount,
    date(pickup_datetime) as pickup_date
from {{ ref('stg_yellow_tripdata') }}
where fare_amount > 0
