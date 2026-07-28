WITH calculated_margins AS (
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
)
SELECT 
    product_name,
    profit,
    total_sales,
    margin_percent,
    CASE 
        WHEN margin_percent > 20 THEN 'Высокая'
        WHEN margin_percent >= 5  THEN 'Средняя'
        WHEN margin_percent >= 0  THEN 'Низкая'
        ELSE 'Убыток' 
    END AS margin_category
FROM calculated_margins
ORDER BY margin_percent DESC;