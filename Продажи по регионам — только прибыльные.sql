SELECT
    ps.region,
    SUM(ps.revenue)                                       AS total_rev,
    SUM(ps.profit)                                        AS total_profit,
    ROUND(SUM(ps.profit)/NULLIF(SUM(ps.revenue),0)*100,1) AS margin_pct
FROM product_sales ps
GROUP BY ps.region
HAVING SUM(ps.profit) > 0       
ORDER BY total_profit DESC;