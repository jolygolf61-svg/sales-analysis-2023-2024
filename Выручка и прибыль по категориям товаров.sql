SELECT
    ps.category,
    SUM(revenue)                                          AS total_revenue,
    SUM(profit)                                           AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(revenue), 0) * 100, 1
    )                                                     AS margin_pct
FROM product_sales ps
GROUP BY ps.category
ORDER BY margin_pct DESC;