SELECT 
    product_name,
    SUM(profit) AS profit,
    SUM(revenue) AS total_sales,
    ROUND(
        (SUM(profit) / NULLIF(SUM(revenue), 0) * 100)::numeric, 
        1
    ) AS margin_percent
FROM product_sales ps 
GROUP BY product_name 
order by total_sales desc
limit 10За