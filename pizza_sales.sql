SELECT * FROM pizza_sales;

--Q1 Total Revenue:the sum of the total price of all pizza orders.
select sum(total_price) as total_revenue from pizza_sales

--Q2 Average Order Value:The average amount spent per order, calculated by dividing the total revenue by the total number of orders.
Select sum(total_price) / count (distinct order_id) as avg_order_value from pizza_sales

--Q3 Total pizzas sold: The sum of the quantities of all pizzas sold.
select sum(quantity) as total_pizza_sold from  pizza_sales

--Q4 Total orders: The total number of orders placed.
select Count(distinct order_id) as total_order from  pizza_sales

--Q5 Average pizzas per Order: The average number of pizza sold per order, calculated by dividing the total number of pizzas sold by the DATENAME(DW, order_date)
select cast(sum(quantity) as Decimal(10,2)) / cast(count(distinct order_id) as Decimal(10,2)) as avg_pizza_perOder from pizza_sales

--Q6 Daily Trend for Total order -- create a bar chart that displays the daily 
-- trend of total orders over a specific time period.
-- this chart will help us identify any patterns or fluctuations in order volumes on a daily basis.
SELECT 
    TO_CHAR(order_date, 'Day') AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Day')

--Q7 Monthly trend for total Orders : Craete a line chart that illustrates 
-- the hourly frend of total orders throughout the day.
-- this chart will allow us to identify peak hours or periods of high order activity.
Select To_char(order_date, 'Month') as Month_name,
Count(Distinct order_id) as Total_orders from pizza_sales
group by To_char(order_date, 'Month') order by Total_orders DESC


--Q8 Percentage of Sales by pizzq Category : craete a pie chart that shows the distribuition
-- of sales across diffrent pizza categories.
-- This chart will provide insights into the popularity of various pizza categories and their contribution to overall sales.
Select pizza_category, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as PTC from pizza_sales
Group by pizza_category

select pizza_category, sum(total_price) as Total_sales, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as PTC from pizza_sales
Group by pizza_category

-- for filtering the data for just single month we can use this and this will show for january month data
select pizza_category, sum(total_price) as Total_sales, sum(total_price) * 100 / (select sum(total_price) from pizza_sales WHERE EXTRACT(MONTH FROM order_date) = 1) as PTC from pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 1
Group by pizza_category

--Q9 Percentage of Sales by Pizza Size: generate a pie chart that
-- represents the percentage of sales attributed to diffrent pizza sizes.
-- This chart will help us understand customer prefrences for pizza sizes and their impact on sales.
Select pizza_size, cast(sum(total_price) as decimal(10,3)) as total_sale, cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as decimal(10,2)) as PTC from pizza_sales
Group by pizza_size 
order by ptc desc

--Q10 Top 5 best sellers by Revenue, Total Quantity and Total Orders :
-- Craete a bar chart highlighting the top 5 best-selling pizzas 
-- based on the Revenue, Total Quantity, Total Orders. This chart will help us identify the most popular pizza options.
select pizza_name_id, sum(total_price) as total_revenue from pizza_sales 
group by pizza_name_id
order by total_revenue desc
limit 5

-- and for getting the bottom 5 we just have to remove desc in the above querie 
-- and for top 5 best seller quentity pizza we can use the bellow line 
select pizza_name_id, sum(quantity) as total_quantity from pizza_sales
group by pizza_name_id
order by total_quantity desc
limit 5
-- and for bottom 5 quantity pizza just remove desc
select pizza_name_id, sum(quantity) as total_quantity from pizza_sales
group by pizza_name_id
order by total_quantity
limit 5

--for getting top 5 count of pizza orders we can use ->
select pizza_name_id, count(distinct order_id) as total_order from pizza_sales
group by pizza_name_id
order by total_order desc
limit 5
-- and for getting the bottom 5 count of pizza orders we can use ->
select pizza_name_id, count(distinct order_id) as total_order from pizza_sales
group by pizza_name_id
order by total_order
limit 5






