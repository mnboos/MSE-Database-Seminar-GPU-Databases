/* Query 1 */
EXPLAIN ANALYZE
SELECT cab_type_id,
       Count(*)
FROM   trips
GROUP  BY 1;

/* Query 2 */
EXPLAIN ANALYZE
SELECT passenger_count,
       Avg(total_amount)
FROM   trips
GROUP  BY 1;

/* Query 3 */
EXPLAIN ANALYZE
SELECT passenger_count,
       Extract(year FROM pickup_datetime),
       Count(*)
FROM   trips
GROUP  BY 1,
          2;

/* Query 4 */
EXPLAIN ANALYZE
SELECT passenger_count,
       Extract(year FROM pickup_datetime),
       Cast(trip_distance AS INT),
       Count(*)
FROM   trips
GROUP  BY 1,
          2,
          3
ORDER  BY 2,
          4 DESC;


/* Query 5 */
EXPLAIN ANALYZE
SELECT *
FROM   trips
WHERE  ( pickup_longitude BETWEEN -74.007511 AND -73.983479 )
       AND ( pickup_latitude BETWEEN 40.7105 AND 40.731071 ) LIMIT 10;



/* Query 6 average speed of Yellow taxi trips by hour of day */
EXPLAIN ANALYZE
SELECT Extract(dow FROM pickup_datetime) AS dow,
       Avg(Round(trip_distance / NULLIF(Date_part('hour',
                                            dropoff_datetime - pickup_datetime),
                                 0)))
                                         AS speed
FROM   trips
WHERE  trip_distance > 0
       AND fare_amount / trip_distance BETWEEN 2 AND 10
       AND dropoff_datetime > pickup_datetime
       AND cab_type_id = 1
GROUP  BY dow
ORDER  BY dow;


/* Query 7 average speed of Yellow taxi trips by hour of day in bounding box*/
EXPLAIN ANALYZE
SELECT Extract(dow FROM pickup_datetime) AS dow,
       Avg(Round(trip_distance / NULLIF(Date_part('hour',
                                            dropoff_datetime - pickup_datetime),
                                 0)))
                                         AS speed
FROM   trips
WHERE  ( pickup_longitude BETWEEN -74.007511 AND -73.983479 )
       AND ( pickup_latitude BETWEEN 40.7105 AND 40.731071 )
       AND trip_distance > 0
       AND fare_amount / trip_distance BETWEEN 2 AND 10
       AND dropoff_datetime > pickup_datetime
       AND cab_type_id = 1
GROUP  BY dow
ORDER  BY dow;


/* Query 8 average speed of Yellow taxi trips by day of week*/
EXPLAIN ANALYZE
SELECT Extract(dow FROM pickup_datetime) AS dow,
       Avg(Round(trip_distance / NULLIF(Date_part('day',
                                            dropoff_datetime - pickup_datetime),
                                 0)))
                                         AS speed
FROM   trips
WHERE  trip_distance > 0
       AND fare_amount / trip_distance BETWEEN 2 AND 10
       AND dropoff_datetime > pickup_datetime
       AND cab_type_id = 1
GROUP  BY dow
ORDER  BY dow;


/* Query 9 average speed of Yellow taxi trips by day of week in bounding box*/
EXPLAIN ANALYZE
SELECT Extract(dow FROM pickup_datetime) AS dow,
       Avg(Round(trip_distance / NULLIF(Date_part('day',
                                            dropoff_datetime - pickup_datetime),
                                 0)))
                                         AS speed
FROM   trips
WHERE  ( pickup_longitude BETWEEN -74.007511 AND -73.983479 )
       AND ( pickup_latitude BETWEEN 40.7105 AND 40.731071 )
       AND trip_distance > 0
       AND fare_amount / trip_distance BETWEEN 2 AND 10
       AND dropoff_datetime > pickup_datetime
       AND cab_type_id = 1
GROUP  BY dow
ORDER  BY dow;

