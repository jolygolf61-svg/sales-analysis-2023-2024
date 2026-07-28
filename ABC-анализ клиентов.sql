WITH total_revenue AS (
    SELECT
        customer_name,
        SUM(revenue) AS total_rev
    FROM product_sales
    GROUP BY customer_name
),
total_prc AS (
    SELECT
        customer_name,
        total_rev,
        total_rev / SUM(total_rev) OVER () * 100 AS pct
    FROM total_revenue
),
cumulative AS (
    SELECT
        customer_name,
        total_rev,
        pct,
        SUM(pct) OVER (ORDER BY total_rev DESC) AS cumulative_pct
    FROM total_prc
)
SELECT
    COUNT(*)                                              AS group_a_customers,
    (SELECT COUNT(*) FROM total_revenue)                  AS total_customers,
    ROUND(
        COUNT(*)::numeric / (SELECT COUNT(*) FROM total_revenue) * 100, 1
    )                                                      AS group_a_share_pct
FROM cumulative
WHERE cumulative_pct <= 80;