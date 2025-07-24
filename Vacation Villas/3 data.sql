use VacationVillaDB 
go 
delete Villa 
go 

insert Villa(Address, City, State, Zip, RoomCount, Amenity, RenterFirstName, RenterLastName, StartDate, EndDate, PricePerNight, MaintenanceCrew, ConditionNum)
select '35 First St.', 'Brooklyn', 'NY', '11256', 8, 'pool', 'John', 'Brown', '07-15-2025', '07-20-2025', 950, 'Haven Home Care', 5
union select '254 N. Dogwood Street', 'West Des Moines', 'IA', '50265', 10, 'pool',  null, null, null, null, 1000, 'Reliable Villa Keepers', 1
union select '7948 Sherwood Lane', 'Jenison', 'MI', '49428', 7, 'backyard', null, null, null, null, 675, 'Oceanview Villa Services', 1
union select '8958 Honey Creek Ave.', 'Queensbury', 'NY', '12804', 9, 'pool', 'Gary', 'Monroe', '07-19-2025', '07-27-2025', 975, 'Haven Home Care', 5
union select '8314 Meadowbrook St.', 'Massillon', 'OH', '44647', 11, 'backyard', 'Mike', 'Bailey', '07-14-2025', '07-20-2025', 1200, 'Tranquil Retreat Services', 5
union select '53 Lake Forest Street', 'Harrisburg', 'PA', '17104', 8, 'backyard', 'Steven', 'Holmes', '07-20-2025', '07-24-2025', 800, 'Serenity Clean Team', 5
union select '96 Bear Hill Rd.', 'Whitehall', 'PA', '18052', 12, 'pool', null, null, null, null, 1500, 'Peak Performance Cleaners', 2
union select '546 Glendale Lane', 'Princeton', 'NJ', '08540', 10, 'backyard',  'Charlie', 'Beckham', '07-18-2025', '07-25-2025', 1100, 'Prime Property Care', 5
union select '69 Mayfield Drive', 'Clifton', 'NY', '12065', 9, 'pool', 'Benjamin', 'Madden', '07-15-2025', '07-24-2025', 975, 'Sunrise Property Management', 5
union select '790 Halifax Ave.', 'Joliet', 'IL', '60431', 13, 'pool', null, null, null, null, 2000, 'Sapphire Cleaners', 4
union select '9501 E. Military Avenue', 'Algonquin', 'IL', '60102', 11, 'pool', null, null, null, null, 1400, 'Prime Property Care', 3
union select '242 Inverness Ave.', 'Niceville', 'FL', '32578', 15, 'backyard', 'Theodore', 'Moses', '07-15-2025', '07-26-2025', 2500, 'Elite Villa Maintenance', 5



