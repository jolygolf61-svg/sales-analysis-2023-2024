WITH customers_orders AS (
    SELECT
        ps.customer_name,
        ps.region,                                              
        ps.order_date,
        ps.revenue AS total_revenue,
        COUNT(ps.order_id) OVER (PARTITION BY ps.customer_name) AS total_count
    FROM product_sales ps
)
SELECT
    customer_name,
    region,                                                    
    order_date,
    total_revenue
FROM customers_orders
WHERE total_count = 1
ORDER BY total_revenue DESC;