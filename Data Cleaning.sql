use Cars_sales

-- Create Customer ID Column --
alter table Customer
add Customer_ID int;

with CTE as (
	select Customer_Name, ROW_NUMBER() over (order by(select null)) as rn from Customer
)

update C
set C.Customer_ID = CTE.rn
from Customer C
join CTE 
on C.Customer_Name = CTE.Customer_Name

select Customer_ID
from Customer

---------------------------------------------------------------------------------
select *
from Customer

select *
from Dealer

select *
from Cars
-----------------------------------------------------------------------------------------
-- Statical Calculations --
select 
    'Annual_Income' as ColumnName,
   count(Annual_Income) as Count,
    avg(Annual_Income) as Mean,
    min(Annual_Income) as Min,
    max(Annual_Income) as Max,
    stdev(Annual_Income) as StdDev
from Customer

SELECT 
    'Price' as ColumnName,
    count(Price) as Count,
    avg(Price) as Mean,
    min(Price) as Min,
    max(Price) as Max,
    stdev(Price) as StdDev
FROM Cars

select 
    'Annual_Income' as ColumnName,
	Gender,
    count(Annual_Income) as Count,
    avg(Annual_Income) as Mean,
    min(Annual_Income) as Min,
    max(Annual_Income) as Max,
    stdev(Annual_Income) as StdDev
from Customer
group by Gender
---------------------------------------------------------------------------------------
-- Check and Fill Missing Values --
select count(*) as MissingCount
from Customer
where Customer_Name is null

--ok there is no missing data 
----------------------------------------------------------------------------
-- Remove Duplicates--
select *, 
       ROW_NUMBER() over (partition by Customer_Name, Phone, Gender, Annual_Income order by Customer_ID) as RowNum
from Customer
-- all the values are unique, there is no duplicates
------------------------------------------------------------------------------------------
-- Outliers --
--Calculate Q1 (25th Percentile) and Q3 (75th Percentile) for Price
select 
    PERCENTILE_CONT(0.25) within group (order by Price) over() as Q1,
    PERCENTILE_CONT(0.75) within group (order by Price) over() as Q3
from Cars
--Calculate IQR and Lower Bound and Upper Bound
with Percentiles as(
    select 
    PERCENTILE_CONT(0.25) within group (order by Price) over() as Q1,
    PERCENTILE_CONT(0.75) within group (order by Price) over() as Q3
   from Cars
)
select 
    Q1, 
    Q3,
    (Q3 - Q1) as IQR,
    (Q1 - 1.5 * (Q3 - Q1)) as LowerBound,
    (Q3 + 1.5 * (Q3 - Q1)) as UpperBound
from Percentiles


