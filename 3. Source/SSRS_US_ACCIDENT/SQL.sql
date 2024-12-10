CREATE DATABASE DOAN_OLAP
USE DOAN_OLAP

SELECT * from dbo.Fact

--id fact
ALTER TABLE dbo.Fact
ADD Temperature_Id INT,
    Traffic_Condition_Id INT,
    Visibility_Id INT,
    Weather_Id INT,
    Wind_Id INT,
	Airport_Id INT,
	Location_Id INT,
	Precipitation_Id INT;
--id dim
ALTER TABLE dbo.Dim_Precipitation
ADD Precipitation_Id INT IDENTITY(1,1) PRIMARY KEY;
ALTER TABLE dbo.Dim_Location
ADD Location_Id INT IDENTITY(1,1) PRIMARY KEY;
ALTER TABLE dbo.Dim_Airport
ADD Airport_Id INT IDENTITY(1,1) PRIMARY KEY;
ALTER TABLE dbo.Dim_Temperature
ADD Temperature_Id INT IDENTITY(1,1) PRIMARY KEY;
ALTER TABLE dbo.Dim_Traffic_Condition
ADD Traffic_Condition_Id INT IDENTITY(1,1) PRIMARY KEY;
ALTER TABLE dbo.Dim_Visibility
ADD Visibility_Id INT IDENTITY(1,1) PRIMARY KEY;
ALTER TABLE dbo.Dim_Weather
ADD Weather_Id INT IDENTITY(1,1) PRIMARY KEY;
ALTER TABLE dbo.Dim_Wind
ADD Wind_Id INT IDENTITY(1,1) PRIMARY KEY;
-- MATCH ID
-- Cập nhật Temperature_Id
UPDATE b
SET b.Temperature_Id = t.Temperature_Id
FROM dbo.Fact b
JOIN dbo.Dim_Temperature t
ON b.Temperature_F = t.Temperature_F;
-- Cập nhật TrafficCondition_Id
UPDATE b
SET b.Traffic_Condition_Id = t.Traffic_Condition_Id
FROM dbo.Fact b
JOIN dbo.Dim_Traffic_Condition t
ON b.Bump = t.Bump and b.Crossing = t.Crossing and b.Junction = t.Junction and b.Railway = t.Railway and b.Roundabout = t.Roundabout and b.Station = t.Station and b.Stop= t.Stop and b.Traffic_Calming = t.Traffic_Calming and b.Traffic_Signal = t.Traffic_Signal and b.Turning_Loop = t.Turning_Loop
-- Cập nhật Visibility_Id
UPDATE b
SET b.Visibility_Id = v.Visibility_Id
FROM dbo.Fact b
JOIN dbo.Dim_Visibility v
ON b.Visibility_mi = v.Visibility_mi;
-- Cập nhật Weather_Id
UPDATE b
SET b.Weather_Id = w.Weather_Id
FROM dbo.Fact b
JOIN dbo.Dim_Weather w
ON b.Weather_Condition = w.Weather_Condition
-- Cập nhật Wind_Id
UPDATE b
SET b.Wind_Id = w.Wind_Id
FROM dbo.Fact b
JOIN dbo.Dim_Wind w
ON b.Wind_Direction = w.Wind_Direction and b.Wind_Speed_mph =  w.Wind_Speed_mph
--Cập nhật Location_Id
UPDATE b
SET b.Location_Id = l.Location_Id
FROM dbo.Fact b
JOIN dbo.Dim_Location l
ON b.Street = l.Street AND b.City = l.City AND b.Country = l.County AND b.State = l.State;
--Caapj nhataj airrport_id
UPDATE b
SET b.Airport_Id = a.Airport_Id
FROM dbo.Fact b
JOIN dbo.Dim_Airport a
ON b.Airport_Code = a.Airport_Code;
--Caaph nhaatj recipitation
UPDATE b
SET b.Precipitation_Id = p.Precipitation_Id
FROM dbo.Fact b
JOIN dbo.Dim_Precipitation p
ON b.Precipitation_in = p.Precipitation_in
-- Xóa cột không cần thiết
ALTER TABLE dbo.Fact
DROP COLUMN Street
ALTER TABLE dbo.Fact
DROP COLUMN City
ALTER TABLE dbo.Fact
DROP COLUMN Country
ALTER TABLE dbo.Fact
DROP COLUMN State
ALTER TABLE dbo.Fact
DROP COLUMN Temperature_F
ALTER TABLE dbo.Fact
DROP COLUMN Bump
ALTER TABLE dbo.Fact
DROP COLUMN Crossing
ALTER TABLE dbo.Fact
DROP COLUMN Junction
ALTER TABLE dbo.Fact
DROP COLUMN Railway
ALTER TABLE dbo.Fact
DROP COLUMN Roundabout
ALTER TABLE dbo.Fact
DROP COLUMN Station
ALTER TABLE dbo.Fact
DROP COLUMN Stop
ALTER TABLE dbo.Fact
DROP COLUMN Traffic_Calming
ALTER TABLE dbo.Fact
DROP COLUMN Traffic_Signal
ALTER TABLE dbo.Fact
DROP COLUMN Turning_Loop
ALTER TABLE dbo.Fact
DROP COLUMN Visibility_mi
ALTER TABLE dbo.Fact
DROP COLUMN Weather_Condition
ALTER TABLE dbo.Fact
DROP COLUMN Wind_Direction
ALTER TABLE dbo.Fact
DROP COLUMN Precipitation_in
ALTER TABLE dbo.Fact
DROP COLUMN Airport_Code
ALTER TABLE dbo.Fact
DROP COLUMN Wind_Speed_mph
--KHÓA NGOẠI
ALTER TABLE dbo.Fact
ADD CONSTRAINT FK_Fact_Dim_Airport
FOREIGN KEY (Airport_Id) REFERENCES dbo.Dim_Airport(Airport_Id);

ALTER TABLE dbo.Fact
ADD CONSTRAINT FK_Fact_Dim_Location
FOREIGN KEY (Location_Id) REFERENCES dbo.Dim_Location(Location_Id);

ALTER TABLE dbo.Fact
ADD CONSTRAINT FK_Fact_Dim_Precipitation
FOREIGN KEY (Precipitation_Id) REFERENCES dbo.Dim_Precipitation(Precipitation_Id);

ALTER TABLE dbo.Fact
ADD CONSTRAINT FK_Fact_Dim_Time
FOREIGN KEY (Start_Time) REFERENCES dbo.Dim_Time(Start_Time);

ALTER TABLE dbo.Fact
ADD CONSTRAINT FK_Fact_Dim_Visibility
FOREIGN KEY (Visibility_Id) REFERENCES dbo.Dim_Visibility(Visibility_Id);

ALTER TABLE dbo.Fact
ADD CONSTRAINT FK_Fact_Dim_Weather
FOREIGN KEY (Weather_Id) REFERENCES dbo.Dim_Weather(Weather_Id);

ALTER TABLE dbo.Fact
ADD CONSTRAINT FK_Fact_Dim_Wind
FOREIGN KEY (Wind_Id) REFERENCES dbo.Dim_Wind(Wind_Id);

ALTER TABLE dbo.Fact
ADD CONSTRAINT FK_Fact_Dim_Traffic_Condition
FOREIGN KEY (Traffic_Condition_Id) REFERENCES dbo.Dim_Traffic_Condition(Traffic_Condition_Id)

ALTER TABLE dbo.Fact
ADD CONSTRAINT FK_Fact_Dim_Temperature
FOREIGN KEY (Temperature_Id) REFERENCES dbo.Dim_Temperature(Temperature_Id)

ALTER TABLE dbo.Dim_Time
ADD Weak_od_Day Tinyint,
    Quarter Tinyint

UPDATE b
SET b.Quarter = v.Quarter
FROM dbo.Dim_Time b
JOIN dbo.Dim_Time2 v
ON b.Start_Time = v.Start_Time;
select * from dbo.Dim_Time