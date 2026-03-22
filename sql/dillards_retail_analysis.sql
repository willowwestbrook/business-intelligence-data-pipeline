-- ============================================================
-- Dillards Retail Analysis
-- Analyzes sales, revenue, and profitability across the Dillards
-- retail database using store, SKU, department, and transaction data
-- Techniques: multi-table joins, aggregations, profit calculations
-- See: visuals/dillards_erd.png for the database schema
-- ============================================================

-- ------------------------------------------------------------
-- Total revenue by month
-- ------------------------------------------------------------
SELECT
    YEAR(SALEDATE) AS order_year,
    MONTH(SALEDATE) AS order_month,
    ROUND(SUM(AMT), 2) AS total_revenue
FROM
    transactions
GROUP BY
    YEAR(SALEDATE),
    MONTH(SALEDATE)
ORDER BY
    order_year,
    order_month;


-- ------------------------------------------------------------
-- Total revenue by city
-- ------------------------------------------------------------
SELECT
    s.CITY,
    ROUND(SUM(t.AMT), 2) AS total_revenue
FROM
    transactions t
JOIN
    store s ON t.STORE = s.STORE
GROUP BY
    s.CITY
ORDER BY
    total_revenue DESC;


-- ------------------------------------------------------------
-- Top 10 stores by total revenue
-- ------------------------------------------------------------
SELECT
    t.STORE,
    s.CITY,
    s.STATE,
    ROUND(SUM(t.AMT), 2) AS total_revenue
FROM
    transactions t
JOIN
    store s ON t.STORE = s.STORE
GROUP BY
    t.STORE, s.CITY, s.STATE
ORDER BY
    total_revenue DESC
LIMIT 10;


-- ------------------------------------------------------------
-- Total revenue and units sold by brand
-- ------------------------------------------------------------
SELECT
    sk.BRAND,
    ROUND(SUM(t.AMT), 2) AS total_revenue,
    SUM(t.QUANTITY) AS total_units_sold
FROM
    transactions t
JOIN
    sku sk ON t.SKU = sk.SKU
GROUP BY
    sk.BRAND
ORDER BY
    total_revenue DESC, total_units_sold DESC;


-- ------------------------------------------------------------
-- Total profit by brand
-- ------------------------------------------------------------
SELECT
    sk.BRAND,
    ROUND(SUM((t.ORGPRICE - t.SPRICE) * t.QUANTITY), 2) AS total_profit
FROM
    transactions t
JOIN
    sku sk ON t.SKU = sk.SKU
GROUP BY
    sk.BRAND
ORDER BY
    total_profit DESC;


-- ------------------------------------------------------------
-- Total profit by store
-- ------------------------------------------------------------
SELECT
    s.STORE,
    s.CITY,
    s.STATE,
    ROUND(SUM((t.ORGPRICE - t.SPRICE) * t.QUANTITY), 2) AS total_profit
FROM
    transactions t
JOIN
    store s ON t.STORE = s.STORE
GROUP BY
    s.STORE, s.CITY, s.STATE
ORDER BY
    total_profit DESC;


-- ------------------------------------------------------------
-- Total profit by department
-- ------------------------------------------------------------
SELECT
    d.DEPT,
    d.DEPTDESC,
    ROUND(SUM((t.ORGPRICE - t.SPRICE) * t.QUANTITY), 2) AS total_profit
FROM
    transactions t
JOIN
    sku sk ON t.SKU = sk.SKU
JOIN
    department d ON sk.DEPT = d.DEPT
GROUP BY
    d.DEPT, d.DEPTDESC
ORDER BY
    total_profit DESC;


-- ------------------------------------------------------------
-- Profit breakdown by store, department, and brand
-- ------------------------------------------------------------
SELECT
    t.STORE,
    sk.DEPT,
    sk.BRAND,
    ROUND(SUM((t.ORGPRICE - t.SPRICE) * t.QUANTITY), 2) AS total_profit
FROM
    transactions t
JOIN
    sku sk ON t.SKU = sk.SKU
GROUP BY
    t.STORE, sk.DEPT, sk.BRAND
ORDER BY
    total_profit DESC;
