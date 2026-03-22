-- ============================================================
-- Northwind Sales Analysis
-- Analyzes product-level sales trends using the Northwind database
-- Techniques: CTEs, window functions (LAG, RANK), aggregations
-- ============================================================

-- ------------------------------------------------------------
-- Monthly quantity sold per product with month-over-month change
-- ------------------------------------------------------------
WITH monthly_sales AS (
    SELECT
        p.ProductID,
        p.ProductName,
        YEAR(o.OrderDate) AS sale_year,
        MONTH(o.OrderDate) AS sale_month,
        SUM(od.Quantity) AS total_quantity
    FROM
        OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY
        p.ProductID, p.ProductName, YEAR(o.OrderDate), MONTH(o.OrderDate)
),
ranked_sales AS (
    SELECT
        *,
        LAG(total_quantity, 1, 0) OVER (
            PARTITION BY ProductID, sale_year ORDER BY sale_month
        ) AS prev_month_quantity,
        RANK() OVER (
            PARTITION BY ProductID, sale_year ORDER BY sale_month
        ) AS month_rank
    FROM
        monthly_sales
)
SELECT
    ProductID,
    ProductName,
    sale_year,
    sale_month,
    total_quantity,
    prev_month_quantity,
    CASE
        WHEN prev_month_quantity = 0 THEN NULL
        ELSE ROUND(
            ((total_quantity - prev_month_quantity) * 100.0) / prev_month_quantity, 2
        )
    END AS pct_change
FROM
    ranked_sales
ORDER BY
    ProductID, sale_year, sale_month;


-- ------------------------------------------------------------
-- Monthly revenue per product with month-over-month percentage change
-- ------------------------------------------------------------
WITH monthly_revenue AS (
    SELECT
        p.ProductName,
        YEAR(o.OrderDate) AS order_year,
        MONTH(o.OrderDate) AS order_month,
        SUM(od.Quantity * od.UnitPrice) AS total_revenue
    FROM
        OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY
        p.ProductName, YEAR(o.OrderDate), MONTH(o.OrderDate)
),
lagged_revenue AS (
    SELECT
        *,
        LAG(total_revenue, 1, 0) OVER (
            PARTITION BY ProductName, order_year ORDER BY order_month
        ) AS prev_month_revenue
    FROM
        monthly_revenue
)
SELECT
    ProductName,
    order_year,
    order_month,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(prev_month_revenue, 2) AS prev_month_revenue,
    CASE
        WHEN prev_month_revenue = 0 THEN NULL
        ELSE ROUND(
            ((total_revenue - prev_month_revenue) * 100.0) / prev_month_revenue, 2
        )
    END AS pct_change
FROM
    lagged_revenue
ORDER BY
    ProductName, order_year, order_month;


-- ------------------------------------------------------------
-- Top 3 products by annual revenue (ranked per year)
-- ------------------------------------------------------------
WITH product_revenue_by_year AS (
    SELECT
        p.ProductName,
        YEAR(o.OrderDate) AS order_year,
        SUM(od.Quantity * od.UnitPrice) AS total_revenue
    FROM
        OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY
        p.ProductName, YEAR(o.OrderDate)
),
ranked_products AS (
    SELECT
        ProductName,
        order_year,
        ROUND(total_revenue, 2) AS total_revenue,
        RANK() OVER (
            PARTITION BY order_year ORDER BY total_revenue DESC
        ) AS sales_rank
    FROM
        product_revenue_by_year
)
SELECT
    ProductName,
    order_year,
    total_revenue,
    sales_rank
FROM
    ranked_products
WHERE
    sales_rank <= 3
ORDER BY
    order_year,
    sales_rank;
