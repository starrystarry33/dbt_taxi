select
    pickup_date,
    count(*) as trip_count,
    sum(fare_amount) as total_fare_amount,
    round(avg(trip_distance), 2) as avg_trip_distance
from {{ ref('fct_trips') }}
group by pickup_date
order by pickup_date
