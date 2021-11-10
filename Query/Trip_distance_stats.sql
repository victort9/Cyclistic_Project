--Creating new column "trip_distance"
ALTER TABLE Cyclists
ADD trip_distance REAL
ALTER TABLE Cyclists
ADD square_lat REAL
ALTER TABLE Cyclists
ADD square_lng REAL

UPDATE Cyclists
SET square_lat = square(end_lat-start_lat),
square_lng = square(end_lng-start_lng)

UPDATE Cyclists
SET trip_distance = (sqrt(square_lat+square_lng))

--Deleting all the outliers (261856rows)
DELETE FROM Cyclists
WHERE trip_distance <= 0

--Summary Stats
SELECT member_casual, rideable_type, date(started_at) as YMD,
sum(trip_distance) AS Sum,
avg(trip_distance) AS Mean,
max(trip_distance) AS Max,
min(trip_distance) AS Min,
count(trip_distance) AS TPD
FROM Cyclists
GROUP BY ymd, member_casual

--Deleting the temporal columns used to get the distance
ALTER TABLE Cyclists
DROP square_lng
ALTER TABLE Cyclists
DROPsquare_lat
