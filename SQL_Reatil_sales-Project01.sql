--CREATE DATABASE sql_project01
--The data imported here is a clean data, have done cleaning in excel before importing it here
SELECT *
FROM [SQL - Retail Sales Analysis]


--CHECKING FOR NUMBER OF ROWS
SELECT
COUNT(*) AS row_count
FROM [SQL - Retail Sales Analysis]

--Data Exploration
--checking for how many customers we have
SELECT
COUNT(customer_id)
FROM [SQL - Retail Sales Analysis]
--IF YOU WANT TO CHECK FOR Unique costomer Use Distinct function
SELECT
COUNT(DISTINCT customer_id) AS unique_customers
FROM [SQL - Retail Sales Analysis] --We have 155 distinct customers
--How many categories we have
SELECT
DISTINCT category
FROM [SQL - Retail Sales Analysis] --Name of the categories we have

--Analysis
--Q1 Retrieve total sales made on '2022-11-05
SELECT
SUM(total_sale) AS Sales_05
FROM [SQL - Retail Sales Analysis]
WHERE sale_date = '2022-11-05'
--sales information made on '2022-11-05
SELECT
*
FROM [SQL - Retail Sales Analysis]
WHERE sale_date = '2022-11-05';

/*Retrieve the transactions where all category is clothing and the quantity sold is more than 3 in the 
month of nov-2022*/
SELECT 
category,
quantiy,
sale_date
FROM [SQL - Retail Sales Analysis]
WHERE
	category = 'clothing'
	AND
	quantiy > 3
	AND
	FORMAT(sale_date,'yyyy-MM')='2022-11';
--write sql query to calculate the total sales for each category and total orders

SELECT
category,
SUM(total_sale) AS Total_sales,
Count(*) AS total_orders
FROM [SQL - Retail Sales Analysis]
GROUP BY category

--write an sql query to find the average age of customers who purchased items from the 'Beauty' category
SELECT
AVG(age) Average_age
FROM [SQL - Retail Sales Analysis]
WHERE category = 'Beauty'

--write an sql query to find all  transactions where the total sale is greater than 1000
SELECT
transactions_id,
total_sale
FROM [SQL - Retail Sales Analysis]
WHERE total_sale>'1000'
ORDER BY total_sale DESC;

/*write an sql query to find the total number of transactions(transaction_id) 
made by each gender in each cartegory*/
SELECT
gender,
Category,
COUNT(transactions_id) AS total_transactions
FROM [SQL - Retail Sales Analysis]
GROUP BY gender,category
ORDER BY 2;

--Write an sql query to calculate the average sale for each month,find out best selling month in each year
--using subquery
SELECT *
FROM
	(
	SELECT 
	MONTH(sale_date) AS month,
	YEAR(sale_date) AS year,
	AVG(total_sale) AS average_sale,
	RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale)) rank
	FROM [SQL - Retail Sales Analysis]
	GROUP BY MONTH(sale_date) ,YEAR(sale_date)
	)t1
WHERE rank=1

--write an sql query to find the top 5 customers based on the highest total sales
SELECT TOP 5
customer_id,
SUM (total_sale) AS Total_sales
FROM [SQL - Retail Sales Analysis]
GROUP BY customer_id
ORDER BY Total_sales DESC

--write an sql query to find the number of unique customers who perchased items from each category
SELECT  
COUNT (DISTINCT customer_id) AS customers_id,
category
FROM [SQL - Retail Sales Analysis]
GROUP BY category
/*Write an sql query to create each shift and number of orders
[example morning >=12 am,afternoon between 12 & 17,evening >17*/
--using case function
SELECT
Shift_table,
COUNT(customer_id) AS count_orders FROM
	(SELECT *,
		 CASE WHEN DATEPART (HOUR,sale_time) < 12 THEN  'Morning'
			WHEN DATEPART (HOUR,sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
			END AS Shift_table
	FROM [SQL - Retail Sales Analysis])t1
GROUP BY Shift_table;

--END