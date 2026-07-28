with Produt_total as (
select
category,
product_name,
sum (revenue) as Total_Rev
from product_sales ps 
group by category, product_name 
),
category_avg as (
select
category,
product_name,
Total_Rev,
avg (Total_Rev) over (partition by category) as AVG_REV_CATEGORY
from Produt_total 
)
select *
from category_avg
where Total_Rev > AVG_REV_CATEGORY
order by category, AVG_REV_CATEGORY
