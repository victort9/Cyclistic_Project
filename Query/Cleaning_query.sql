--Deleting all NULL values
DELETE FROM Cyclists
WHERE
  (ride_id IS NULL OR ride_id  = '')
  OR (rideable_type IS NULL OR rideable_type = '')
  OR (started_at IS NULL OR started_at = '')
  OR (ended_at IS NULL OR ended_at = '')
  OR (start_station_name IS NULL OR start_station_name = '')
  OR (start_station_id IS NULL OR start_station_id = '')
  OR (end_station_name IS NULL OR end_station_name = '')
  OR (end_station_id IS NULL OR end_station_id = '')
  OR (member_casual IS NULL OR member_casual = '')

  
--Separating started_at in 2 columns date and time
ALTER TABLE Cyclists
ADD started_at_date DATE
UPDATE Cyclists
SET started_at_date = strftime('%Y-%m-%d', started_at)

ALTER TABLE Cyclists
ADD started_at_hour TIME
UPDATE Cyclists
SET started_at_hour = strftime('%H:%M:%S', started_at)

--Separating ended_at_at in 2 columns date and time
ALTER TABLE Cyclists
ADD ended_at_date DATE
UPDATE Cyclists
SET ended_at_date = strftime('%Y-%m-%d', ended_at)

ALTER TABLE Cyclists
ADD ended_at_hour TIME
UPDATE Cyclists
SET ended_at_hour = strftime('%H:%M:%S', ended_at)


--Creating new column "trip_duration" en minutos
ALTER TABLE Cyclists
ADD trip_duration TIME
UPDATE Cyclists
SET trip_duration = (julianday(ended_at)-julianday(started_at))*1440
