--Creating new column "trip_distance"
ALTER TABLE clean
ADD trip_distance REAL
ALTER TABLE clean
ADD square_lat REAL
ALTER TABLE clean
ADD square_lng REAL

UPDATE clean
SET square_lat = square(end_lat-start_lat),
square_lng = square(end_lng-start_lng)

UPDATE clean
SET trip_distance = (sqrt(square_lat+square_lng))

--Deleting all the outliers (261856rows)
DELETE FROM clean
WHERE trip_distance <= 0

--Summary Stats
SELECT member_casual, rideable_type, date(started_at) as YMD,
sum(trip_distance) AS Sum,
avg(trip_distance) AS Mean,
max(trip_distance) AS Max,
min(trip_distance) AS Min,
count(trip_distance) AS TPD
FROM clean
GROUP BY ymd, member_casual



ALTER TABLE clean
DROP trip_distance