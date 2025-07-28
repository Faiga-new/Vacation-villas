/*
As summer is just around the corner, people are starting to book. I need your help in keeping all the information clear and accessible. This will not only save time and reduce errors (like double bookings) but also enhance the guest experience.

I need to know about the villas I am renting out: the address, room count, does it have a backyard or a pool (must have only 1), is it currently available, the name of the renter, rented from [start date] to [end date], how much I charge per night, and which crew is in charge of that villa.

I also need to know the condition of each villa. Fill in just the number. It can be either:
1.	Needs maintenance
2.	Needs cleaning
3.	Needs restocking of supplies
4.	Ready for guests!
5.	Rented out

Questions:
Q: When did you start this business?
A: We started advertising in May, but bookings only started on the twenty-third of June 2025.
Q: Can more than one crew maintain a villa?
A: No.
Q: Can a crew maintain more than one villa?
A: Yes.
Q: What is the most you ever rented a villa for?
A: The largest villa is usually rented for $2,500 a night.
Q: Do you ever schedule a booking when the condition of the villa is 1, 2, or 3?
A: No, a villa is only considered available when it is clean and well-maintained.
Q: How many rooms does your largest villa have?
A: Including its 10 bedrooms, it has 15 rooms.


Reports:
1)	How many villas am I currently in charge of?
2)	How many villas are rented now, and how many are not (for whatever reason)?
3)	What is the average, minimum, and maximum rental duration?
4)	What is the condition of each villa written out in words?

Sample Data:
Address, RoomCount, Backyard/Pool, Available, RenterName, RentedFrom, RentedUntil, RentPerNight, MaintenanceCrew, ConditionOfVilla
35 First St., Brooklyn, NY 11256, 8, pool, 0, John Brown, 07-15-2025, 07-20-2025, 950, Haven Home Care, 5
254 N. Dogwood Street, West Des Moines, IA 50265, 10, pool, 1, null, null, null, 1000, Reliable Villa Keepers, 1
7948 Sherwood Lane, Jenison, MI 49428, 7, backyard, 1, null, null, null, 675, Oceanview Villa Services, 1
8958 Honey Creek Ave. Queensbury, NY 12804, 9, pool, 0, Gary Monroe, 07-19-2025, 07-27-2025, 975, Haven Home Care, 5
8314 Meadowbrook St., Massillon, OH 44647, 11, backyard, 0, Mike Bailey, 07-14-2025, 07-20-2025, 1200, Tranquil Retreat Services, 5
53 Lake Forest Street, Harrisburg, PA 17104, 8, backyard, 0, Steven Holmes, 07-20-2025, 07-24-2025, 800, Serenity Clean Team, 5
96 Bear Hill Rd. Whitehall, PA 18052, 12, pool, 1, null, null, null, 1500, Peak Performance Cleaners, 2
546 Glendale Lane, Princeton, NJ 08540, 10, backyard, 0, Charlie Beckham, 07-18-2025, 07-25-2025, 1100, Prime Property Care, 5
69 Mayfield Drive, Clifton, NY 12065, 9, pool, 0, Benjamin Madden, 07-15-2025, 07-24-2025, 975, Sunrise Property Management, 5
790 Halifax Ave., Joliet, IL 60431, 13, pool, 1, null, null, null, 2000, Sapphire Cleaners, 4
9501 E. Military Avenue, Algonquin, IL 60102, 11, pool, 1, null, null, null, 1400, Prime Property Care, 3
242 Inverness Ave., Niceville, FL 32578, 15, backyard, 0, Theodore Moses, 07-15-2025, 07-26-2025, 2500, Elite Villa Maintenance, 5
*/
-- create and populate database based on the above specification
USE master;
GO
DROP DATABASE IF EXISTS VacationVillaDB;
GO
CREATE DATABASE VacationVillaDB;
GO
USE VacationVillaDB;
GO

IF OBJECT_ID('dbo.Villa', 'U') IS NOT NULL
    DROP TABLE dbo.Villa;
GO

CREATE TABLE dbo.Villa(
    VillaId INT IDENTITY PRIMARY KEY,
    Address       VARCHAR(50) NOT NULL CHECK(Address <> ''),
    City          VARCHAR(20) NOT NULL CHECK(City <> ''),
    State         CHAR(2)    NOT NULL CHECK(State <> ''),
    Zip           CHAR(5)    NOT NULL CHECK(Zip LIKE '[0-9][0-9][0-9][0-9][0-9]'),
    RoomCount     INT        NOT NULL CHECK(RoomCount BETWEEN 1 AND 15),
    Amenity       VARCHAR(8) NOT NULL CHECK(Amenity IN ('backyard','pool')),
    RenterFirstName VARCHAR(35) NULL CHECK(RenterFirstName <> ''),
    RenterLastName  VARCHAR(35) NULL CHECK(RenterLastName <> ''),
    StartDate     DATE NULL CHECK(StartDate BETWEEN '06-23-2025' AND GETDATE()),
    EndDate       DATE NULL,
    PricePerNight DECIMAL(6,2) NOT NULL CHECK(PricePerNight BETWEEN 1 AND 2500),
    MaintenanceCrew VARCHAR(35) NOT NULL CHECK(MaintenanceCrew <> ''),
    ConditionNum  INT NOT NULL CHECK(ConditionNum BETWEEN 1 AND 5),
    ConditionDesc AS CASE ConditionNum
                        WHEN 1 THEN 'Needs maintenance'
                        WHEN 2 THEN 'Needs cleaning'
                        WHEN 3 THEN 'Needs restocking of supplies'
                        WHEN 4 THEN 'Ready for guests!'
                        WHEN 5 THEN 'Rented out'
                      END PERSISTED,
    Available AS CASE WHEN ConditionNum = 4 THEN 1 ELSE 0 END PERSISTED,
    CONSTRAINT ck_Villa_StartDate_before_EndDate CHECK(StartDate < EndDate OR EndDate IS NULL)
);
GO

INSERT INTO dbo.Villa(Address, City, State, Zip, RoomCount, Amenity,
                       RenterFirstName, RenterLastName, StartDate, EndDate,
                       PricePerNight, MaintenanceCrew, ConditionNum)
VALUES
('35 First St.', 'Brooklyn', 'NY', '11256', 8, 'pool', 'John', 'Brown', '2025-07-15', '2025-07-20',  950, 'Haven Home Care', 5),
('254 N. Dogwood Street', 'West Des Moines', 'IA', '50265', 10, 'pool', NULL, NULL, NULL, NULL, 1000, 'Reliable Villa Keepers', 1),
('7948 Sherwood Lane', 'Jenison', 'MI', '49428', 7, 'backyard', NULL, NULL, NULL, NULL,  675, 'Oceanview Villa Services', 1),
('8958 Honey Creek Ave.', 'Queensbury', 'NY', '12804', 9, 'pool', 'Gary', 'Monroe', '2025-07-19', '2025-07-27',  975, 'Haven Home Care', 5),
('8314 Meadowbrook St.', 'Massillon', 'OH', '44647', 11, 'backyard', 'Mike', 'Bailey', '2025-07-14', '2025-07-20', 1200, 'Tranquil Retreat Services', 5),
('53 Lake Forest Street', 'Harrisburg', 'PA', '17104', 8, 'backyard', 'Steven', 'Holmes', '2025-07-20', '2025-07-24',  800, 'Serenity Clean Team', 5),
('96 Bear Hill Rd.', 'Whitehall', 'PA', '18052', 12, 'pool', NULL, NULL, NULL, NULL, 1500, 'Peak Performance Cleaners', 2),
('546 Glendale Lane', 'Princeton', 'NJ', '08540', 10, 'backyard', 'Charlie', 'Beckham', '2025-07-18', '2025-07-25', 1100, 'Prime Property Care', 5),
('69 Mayfield Drive', 'Clifton', 'NY', '12065', 9, 'pool', 'Benjamin', 'Madden', '2025-07-15', '2025-07-24',  975, 'Sunrise Property Management', 5),
('790 Halifax Ave.', 'Joliet', 'IL', '60431', 13, 'pool', NULL, NULL, NULL, NULL, 2000, 'Sapphire Cleaners', 4),
('9501 E. Military Avenue', 'Algonquin', 'IL', '60102', 11, 'pool', NULL, NULL, NULL, NULL, 1400, 'Prime Property Care', 3),
('242 Inverness Ave.', 'Niceville', 'FL', '32578', 15, 'backyard', 'Theodore', 'Moses', '2025-07-15', '2025-07-26', 2500, 'Elite Villa Maintenance', 5);
GO

-- Reports

-- 1) How many villas am I currently in charge of?
SELECT COUNT(*) AS NumVillas
FROM dbo.Villa;

-- 2) How many villas are rented now, and how many are not?
SELECT COUNT(*) AS NumVillas, ConditionDesc
FROM dbo.Villa
GROUP BY ConditionDesc;

-- 3) Average, minimum, and maximum rental duration
SELECT AVG(DATEDIFF(day, StartDate, EndDate)) AS AvgDuration,
       MIN(DATEDIFF(day, StartDate, EndDate)) AS MinDuration,
       MAX(DATEDIFF(day, StartDate, EndDate)) AS MaxDuration
FROM dbo.Villa
WHERE StartDate IS NOT NULL AND EndDate IS NOT NULL;

-- 4) Condition of each villa written out in words
SELECT Address, City, State, Zip, ConditionDesc
FROM dbo.Villa;
GO
