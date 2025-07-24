use VacationVillaDB 
go 
drop table if exists Villa 
go 

create table dbo.Villa(
    VillaId int not null identity primary key,
--AS I split up the address since it is better practice so that querying is easier.
    Address varchar(50) not null constraint ck_Villa_Address_cannot_be_blank check(Address <> ''),
    City varchar(20) not null constraint ck_Villa_CIty_cannot_be_blank check(City <> ''),
    State char(2) not null constraint ck_Villa_State_cannot_be_blank check(State <> ''),
    Zip char(5) not null constraint ck_Villa_zip_all_numeric check(Zip like '[0-9][0-9][0-9][0-9][0-9]'),
    RoomCount int not null constraint ck_Villa_RoomCount_between_1_and_15 check (RoomCount between 1 and 15),
    Amenity varchar(8) not null constraint ck_Villa_Amenity_either_backyard_or_pool check(Amenity in ('Backyard', 'Pool')),
    RenterFirstName varchar(35) constraint ck_Villa_RenterFirstName_cannot_be_blank check(RenterFirstName <> ''),
    RenterLastName varchar(35) constraint ck_Villa_RenterLastName_cannot_be_blank check(RenterLastName <> ''),
    StartDate date constraint ck_Villa_StartDate_between_June_23_2025_and_current check(StartDate between '06-23-2025' and getdate()),
    EndDate date,
    PricePerNight decimal(6,2) not null constraint ck_Villa_PricePerNight_between_1_and_2500 check(PricePerNight between 1 and 2500),
    MaintenanceCrew varchar(35) not null constraint ck_Villa_MaintenanceCrew_cannot_be_blank check(MaintenanceCrew <> ''),
    ConditionNum int not null constraint ck_ConditionNum_between_1_and_5 check(ConditionNum between 1 and 5),
    ConditionDesc as case ConditionNum
                        when 1 then 'Needs maintenance'
                        when 2 then 'Needs cleaning'
                        when 3 then 'Needs restocking of supplies'
                        when 4 then 'Ready for guests!'
                        when 5 then 'Rented out'
                      end persisted,
--AS From one of your questions I got the answer that it's only available when it's clean and well maintained and obviously if it's rented out then it's not available, so I ignored the data and made it a computed column.
    Available as case ConditionNum
                    when  4 then 1
                    else 0
                 end persisted,
    constraint ck_Villa_StartDate_before_EndDate check(StartDate < EndDate)
) 
go