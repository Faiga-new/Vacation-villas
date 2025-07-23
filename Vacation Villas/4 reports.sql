--1)	How many villas am I currently in charge of?
select NumVillas = count(*)
from villa v 
--2)	How many villas are rented now, and how many are not (for whatever reason)?
select NumVillas = count(*), v.ConditionDesc
from villa v
group by v.ConditionDesc
--3)	What is the average, minimum, and maximum rental duration?
select AvgDuration = avg(datediff(day,v.StartDate, v.EndDate)), MinDuration = min(datediff(day,v.StartDate, v.EndDate)), MaxDuration = max(datediff(day,v.StartDate, v.EndDate))
from villa v 
--4)	What is the condition of each villa written out in words?
select v.ConditionDesc, v.Address, v.City, v.State, v.Zip
from villa v 

