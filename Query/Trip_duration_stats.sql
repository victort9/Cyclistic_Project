--Creating new column "trip_duration"
ALTER TABLE clean
ADD trip_duration TIME
UPDATE clean
SET trip_duration = (julianday(ended_at)-julianday(started_at))*1440


--deleting all the outliers (40974rows)
DELETE FROM clean
WHERE trip_duration <=0.45 AND start_station_id = end_station_id
OR trip_duration <=0

--Summary Stats (in minutes)
SELECT member_casual, rideable_type, date(started_at) as YMD,
sum(trip_duration) AS Sum,
avg(trip_duration) AS Mean,
max(trip_duration) AS Max,
min(trip_duration) AS Min,
count(trip_duration) AS TPD
FROM clean
GROUP BY ymd, member_casual

