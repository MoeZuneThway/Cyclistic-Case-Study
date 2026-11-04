DROP TABLE IF EXISTS bike_trips_raw;

CREATE TABLE bike_trips_raw (
    ride_id TEXT,
    rideable_type TEXT,
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    start_station_name TEXT,
    start_station_id TEXT,
    end_station_name TEXT,
    end_station_id TEXT,
    start_lat NUMERIC,
    start_lng NUMERIC,
    end_lat NUMERIC,
    end_lng NUMERIC,
    member_casual TEXT
);

DROP TABLE IF EXISTS bike_trips_cleaned;

CREATE TABLE bike_trips_cleaned AS
SELECT 
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    CASE 
        WHEN start_station_name IS NULL AND rideable_type = 'electric_bike' THEN 'Dockless Location'
        ELSE start_station_name 
    END AS start_station_name,
    CASE 
        WHEN end_station_name IS NULL AND rideable_type = 'electric_bike' THEN 'Dockless Location'
        ELSE end_station_name 
    END AS end_station_name,
    member_casual,
    (ended_at - started_at) AS ride_length,
    EXTRACT(DOW FROM started_at) + 1 AS day_of_week
FROM bike_trips_raw
WHERE ended_at > started_at + INTERVAL '1 minute'
  AND (start_station_name IS NOT NULL OR rideable_type = 'electric_bike')
  AND (end_station_name IS NOT NULL OR rideable_type = 'electric_bike');