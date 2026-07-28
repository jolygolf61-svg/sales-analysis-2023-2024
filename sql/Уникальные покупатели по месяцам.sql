SELECT 
        DATE_TRUNC('month', TO_TIMESTAMP(ps.order_date,'MM-DD-YY')) AS sales_month,
        COUNT (DISTINCT customer_name) as Distinct_Cust,
        count (order_id) as Orders_Count,
        ROUND(
    COUNT(order_id)::numeric / COUNT(DISTINCT customer_name), 2
) AS orders_per_cust
       from product_sales ps 
group by sales_month
