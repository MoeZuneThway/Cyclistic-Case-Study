SELECT * FROM bike_trips_raw
LIMIT 10;

SELECT DISTINCT member_casual
FROM bike_trips_raw;

SELECT DISTINCT rideable_type
FROM bike_trips_raw;

SELECT COUNT(*)
FROM bike_trips_raw
WHERE start_station_name IS NULL
AND rideable_type = 'electric_bike';

SELECT ride_id,
		COUNT(*)
FROM bike_trips_raw
GROUP BY ride_id
HAVING COUNT(*) >1;

WITH ride_time AS(
SELECT
    ride_id,
    started_at,
    ended_at,
    ended_at - started_at AS ride_length
FROM bike_trips_raw
LIMIT 10)

SELECT ride_id
FROM ride_time
WHERE ride_length < INTERVAL '0';

SELECT COUNT(*)
FROM bike_trips_cleaned;

SELECT ride_id, ride_length
FROM bike_trips_cleaned
ORDER BY ride_length DESC
LIMIT 10;

SELECT * 
FROM bike_trips_cleaned
WHERE start_station_name = 'Dockless Location'
AND rideable_type != 'electric_bike';

SELECT * 
FROM bike_trips_cleaned
WHERE rideable_type = 'electric_bike';

SELECT count(*), max(ride_length)
FROM bike_trips_cleaned
WHERE ride_length >= INTERVAL '24 hours';

DELETE FROM bike_trips_cleaned
WHERE ride_length >= INTERVAL '24 hours';
