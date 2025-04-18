use Cars_sales
select * from Cars
select * from Customer
select * from Dealer

------------------------------------------------------------ Customer Analysis ---------------------------------------------------
--What is the distribution of customers by gender?
select Gender, count(*) as Customer_Count
from Customer 
group by Gender

--What is the average annual income of customers?
select avg(Annual_Income) as Avg_Annual_Income
from Customer

--How many customers have an annual income above $1,000,000?
select count(*) as High_Income_Customers
from Customer
where Annual_Income > 1000000

--What is the most common customer name in the dataset?
select top 1 with ties Customer_Name, count(*) as Name_Count
from Customer
group by Customer_Name
order by Name_Count desc

--How many unique customers are there in the dataset?
select count(distinct(Customer_Name)) as Unique_Names
from Customer

--------------------------------------------------------- Dealer Analysis ------------------------------------
--How many unique dealers are present in the dataset?
select count(distinct(Dealer_Name)) as Unique_Names
from Dealer

-- How many dealers are located in each region?
select Dealer_Region, count(Dealer_No) as Dealers_Count
from Dealer
group by Dealer_Region

------------------------------------------------------------------- Car Model and Company Analysis ----------------------------------------
--Which car model is the most popular (highest number of sales)?
select top 1 with ties Model, count(*) as Total_sales
from Cars
group by Model
order by Total_sales desc

--Which car company has the highest number of sales?
select top 1 with ties Company, count(*) as Total_sales
from Cars
group by Company
order by Total_sales desc

--What is the average price of cars sold by each company?
select Company, avg(price) as Avg_Car_Price
from Cars
group by Company
order by Avg_Car_Price desc

--Which car model has the highest average price?
select top 1 with ties Model, avg(price) as Avg_Car_Price
from Cars
group by Model
order by Avg_Car_Price desc

--What is the distribution of car models by body style?
select Body_Style, count(Model) as Model_Counts
from Cars
group by Body_Style
order by Model_Counts desc

--------------------------------------------------------- Engine and Transmission Analysis --------------------------------------------------------------
--What is the distribution of cars by engine type ?
select Engine, count(*) as Car_Counts
from Cars
group by Engine
order by Car_Counts desc

--What is the distribution of cars by transmission type (Manual vs. Auto)?
select Transmission, count(*) as Transmission_Counts
from Cars
group by Transmission
order by Transmission_Counts

--Which engine type is more common in SUVs?
select top 1 with ties Engine, count(*) as SUV_Counts
from Cars
where Body_Style = 'SUV'
group by Engine
order by SUV_Counts desc

--What is the average price of cars with manual transmission vs. automatic transmission?
select Transmission, avg(Price) Avg_Car_Price
from Cars
group by Transmission

--Which transmission type is more common in high-income customers? (joins)
select top 1 with ties C.Transmission, count(*) as Transmission_Counts
from Cars C
join Customer CU 
on C.Customer_ID = CU.Customer_ID
where CU.Annual_Income > 1000000
group by C.Transmission 
order by Transmission_Counts desc

------------------------------------------------------------------ Color Analysis --------------------------------------------------
--What is the most common car color in the dataset?
select top 1 with ties Color, count(*) as Color_Counts
from Cars
group by Color
order by Color_Counts desc

--Which color is associated with the highest average price?
select top 1 with ties Color, avg(Price) as Avg_Car_Price
from Cars
group by Color
order by Avg_Car_Price desc

--How does the distribution of car colors vary by body style?
select Color, Body_Style, count(*) as Color_Counts
from Cars
group by Color, Body_Style
order by Color_Counts, Body_Style desc

--Which color is most popular among high-income customers? (join)
select top 1 with ties C.Color, count(*) as Color_Counts
from Cars C
join Customer CU
on C.Customer_ID = CU.Customer_ID 
where CU.Annual_Income > 1000000
group by C.Color
order by Color_Counts desc

--What is the distribution of car colors by region?
select D.Dealer_Region, C.Color, count(*) as Color_Counts
from Cars C
join Dealer D 
on C.Dealer_No = D.Dealer_No  
group by D.Dealer_Region, C.Color
order by D.Dealer_Region, Color_Counts desc

------------------------------------------------------------------- Date and Time Analysis ------------------------------------------------
--What is the busiest month for car sales?
select top 1 with ties month(Date) as Sales_Month, count(*) as Total_Sales
from Dealer
group by month(Date)
order by  Total_Sales desc

