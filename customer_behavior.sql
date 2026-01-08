select * from customer limit 20;
show columns from customer;

SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'customer_behavior'
  AND TABLE_NAME = 'customer';
  

-- Q1. Total revenue by gender
select gender, sum(purchase_amount) as revenue
from customer
group by gender;
 
-- Q2. Customers who used a discount and spent more than the average purchase amount
select customer_id, purchase_amount
from customer
where discount_applied = 'yes'
  and purchase_amount > (select avg(purchase_amount) from customer);


-- Q3. top 5 products with the highest average review rating
select item_purchased,
       round(avg(review_rating), 2) as average_rating
from customer
group by item_purchased
order by avg(review_rating) desc
limit 5;


-- Q4. average purchase amount for standard vs express shipping
select shipping_type,
       round(avg(purchase_amount), 2) as average_purchase
from customer
where shipping_type in ('standard', 'express')
group by shipping_type;


-- Q5. compare spending of subscribed vs non-subscribed customers
select subscription_status,
       count(customer_id) as total_customers,
       round(avg(purchase_amount), 2) as avg_spend,
       round(sum(purchase_amount), 2) as total_revenue
from customer
group by subscription_status;


-- Q6. top 5 products with highest percentage of discounted purchases
select item_purchased,
       round(100 * sum(case when discount_applied = 'yes' then 1 else 0 end) / count(*), 2 ) as discount_percentage
from customer
group by item_purchased
order by discount_percentage desc
limit 5;


-- Q7. customer segmentation into new, returning, and loyal customers
select
    case
        when previous_purchases = 1 then 'new'
        when previous_purchases between 2 and 10 then 'returning'
        else 'loyal'
    end as customer_segment,
    count(*) as number_of_customers
from customer
group by customer_segment;


-- Q8. most purchased products in each category
select category,
       item_purchased,
       count(*) as total_orders
from customer
group by category, item_purchased
order by category, total_orders desc;


-- Q9. subscription status of repeat buyers (more than 5 previous purchases)
select subscription_status,
       count(customer_id) as repeat_buyers
from customer
where previous_purchases > 5
group by subscription_status;


-- Q10. revenue contribution of each age group
select age_group,
       sum(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc;

