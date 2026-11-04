SELECT 
    member_casual,
    COUNT(ride_id) AS total_rides,
    AVG(ride_length) AS average_ride_length,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ride_length) AS median_ride_length
FROM bike_trips_cleaned
GROUP BY member_casual;

SELECT 
    member_casual,
    rideable_type,
    COUNT(ride_id) AS total_rides
FROM bike_trips_cleaned
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_rides DESC;

SELECT 
    member_casual,
    EXTRACT(HOUR FROM started_at) AS hour_of_day,
    COUNT(ride_id) AS total_rides
FROM bike_trips_cleaned
GROUP BY 
    member_casual, 
    EXTRACT(HOUR FROM started_at)
ORDER BY 
    EXTRACT(HOUR FROM started_at), 
    member_casual;


SELECT 
    member_casual,
    day_of_week,
    CASE day_of_week
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END AS day_name,
    COUNT(ride_id) AS total_rides
FROM bike_trips_cleaned
GROUP BY 
    member_casual, 
    day_of_week
ORDER BY 
    day_of_week, 
    member_casual;


SELECT 
    start_station_name,
    COUNT(ride_id) AS total_rides
FROM bike_trips_cleaned
WHERE member_casual = 'casual' 
  AND start_station_name != 'Dockless Location'
GROUP BY start_station_name
ORDER BY total_rides DESC
LIMIT 10;

SELECT 
    start_station_name,
    COUNT(ride_id) AS total_rides
FROM bike_trips_cleaned
WHERE member_casual = 'member' 
  AND start_station_name != 'Dockless Location'
GROUP BY start_station_name
ORDER BY total_rides DESC
LIMIT 10;


SELECT 
    end_station_name,
    COUNT(ride_id) AS total_rides
FROM bike_trips_cleaned
WHERE member_casual = 'casual' 
  AND end_station_name != 'Dockless Location'
GROUP BY end_station_name
ORDER BY total_rides DESC
LIMIT 10;


SELECT 
    end_station_name,
    COUNT(ride_id) AS total_rides
FROM bike_trips_cleaned
WHERE member_casual = 'member' 
  AND end_station_name != 'Dockless Location'
GROUP BY end_station_name
ORDER BY total_rides DESC
LIMIT 10;


SELECT 
    member_casual,
    EXTRACT(MONTH FROM started_at) AS month_num,
    CASE EXTRACT(MONTH FROM started_at)
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS month_name,
    COUNT(ride_id) AS total_rides
FROM bike_trips_cleaned
GROUP BY 
    member_casual, 
    EXTRACT(MONTH FROM started_at)
ORDER BY 
    month_num, 
    member_casual;


SELECT 
    member_casual,
    CASE 
        WHEN start_station_name = 'Dockless Location' THEN 'Dockless'
        ELSE 'Physical Station'
    END AS parking_behavior,
    COUNT(ride_id) AS total_rides
FROM bike_trips_cleaned
GROUP BY 
    member_casual,
    CASE 
        WHEN start_station_name = 'Dockless Location' THEN 'Dockless'
        ELSE 'Physical Station'
    END
ORDER BY 
    member_casual, 
    total_rides DESC;