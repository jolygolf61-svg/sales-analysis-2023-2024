SELECT 
    sales_month,
    total_profit AS sales_profit,
    sales_count,
    ROUND(avg_check::numeric, 2) AS average_check,
    ROUND(
        ( ((total_profit - prev_month_profit) / NULLIF(prev_month_profit, 0)) * 100.0 )::numeric, 
        2
    ) AS profit_change_percent
FROM (
    SELECT 
        DATE_TRUNC('month', TO_TIMESTAMP(order_date, 'MM-DD-YY')) AS sales_month,
        SUM(profit) AS total_profit,
        COUNT(order_id) AS sales_count,
        AVG(revenue) AS avg_check,
        LAG(SUM(profit)) OVER (ORDER BY DATE_TRUNC('month', TO_TIMESTAMP(order_date, 'MM-DD-YY'))) AS prev_month_profit
    FROM product_sales
    GROUP BY DATE_TRUNC('month', TO_TIMESTAMP(order_date, 'MM-DD-YY'))
) AS monthly_metrics
ORDER BY sales_month;
