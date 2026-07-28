WITH prod_rank AS (
    SELECT
        category,
        sub_category,
        product_name,
        SUM(revenue) AS total_revenue,
        RANK() OVER (
            PARTITION BY category 
            ORDER BY SUM(revenue) DESC
        ) AS product_rank
    FROM product_sales
    GROUP BY category, sub_category, product_name
)
SELECT
    category,
    sub_category,
    product_name,
    total_revenue,
    product_rank
FROM prod_rank
WHERE product_rank <= 3
ORDER BY category, product_rank;