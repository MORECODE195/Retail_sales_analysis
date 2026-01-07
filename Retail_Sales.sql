-----------------*** Data Analysis & Business Key Problems & Answers ***-----------------

select * from Retail_Data

--** Data_Cleaning **--
select *
from Retail_Data
where Transactions_id is NULL
OR Sale_date is NULL
OR Sale_time is NULL
OR Customer_id is NULL
OR Gender is NULL
OR Category is NULL
OR Quantity is NULL
OR Price_per_unit is NULL
OR Cogs is NULL
OR Total_sales is NULL

Delete from Retail_Data
where Transactions_id is NULL
OR Sale_date is NULL
OR Sale_time is NULL
OR Customer_id is NULL
OR Gender is NULL
OR Category is NULL
OR Quantity is NULL
OR Price_per_unit is NULL
OR Cogs is NULL
OR Total_sales is NULL

--** Calculating Average value of non-null values in age column and Updating it with all null values in age column **--
select avg(Age) AS AverageAge
from Retail_Data
where Age is not null

update Retail_Data
set Age = (
    select avg(Age)
    from Retail_Data
    where Age is not null
)
where Age is null


--** Deleting rows with Multiple null values **--
delete from Retail_Data
where quantity is null
    or price_per_unit is null
    or cogs is null
    or Total_sales is null


--** Data Exploration **--

select count(*) from Retail_Data

-- How many sales we have?
Select COUNT(*) as total_sale from Retail_Data

-- How many uniuque customers we have ?
Select COUNT(DISTINCT Customer_id) as total_sale from Retail_Data
Select DISTINCT Category from Retail_Data
select * from Retail_Data

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select *
from Retail_Data
where Sale_date = '2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and
--     the quantity sold is more than 4 in the month of Nov-2022
select *
from Retail_Data
where Category = 'Clothing' and Quantity >= 4
	and Sale_date >= '2022-11-1'
	and Sale_date < '2022-12-1'


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select Category,
sum(Total_sales) as Total_Sales, count(*) as Total_Orders
from Retail_Data
group by Category
order by Total_Sales


-- Q.4 Write a SQL query to find the average age of customers who purchased items from
--     the 'Beauty' category.
select
avg(Age) as Average_Age_of_Customers
from Retail_Data
where Category = 'Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from Retail_Data
where Total_sales > 1000
order by Total_sales asc


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by 
--     each gender in each category.
select Category, Gender, count(*) as Total_Transactions
from Retail_Data
group by Category,Gender
order by Total_Transactions


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling
--     month in each year
--select * from
--(
select 
    YEAR(sale_date) AS Year,
    MONTH(sale_date) AS Month,
    round(AVG(Total_sales),2) AS AvgMonthlySale,
	rank() over(partition by YEAR(sale_date) order by round(AVG(Total_sales),2) desc) as Rank
from Retail_Data
group by YEAR(sale_date), MONTH(sale_date)
--order by Year, AvgMonthlySale desc
--) as T1
--where Rank = 1


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
select Top 5
Customer_id,
sum(Total_sales) as Total_Sales
from Retail_Data
group by Customer_id
order by Total_Sales desc


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from
--     each category.
select 
    category,
    count(distinct customer_id) as UniqueCustomers
from Retail_Data
group by category
order by UniqueCustomers desc


-- Q.10 Write a SQL query to create each shift and number of orders
--      (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select 
    case 
        when DATEPART(HOUR, Sale_time) < 12 then 'Morning'
        when DATEPART(HOUR, Sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
    end as Shift,
    count(transactions_id) as NumberOfOrders
from Retail_Data
group by 
    case 
        when DATEPART(HOUR, Sale_time) < 12 then 'Morning'
        when DATEPART(HOUR, Sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
    end
order by Shift
