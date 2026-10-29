-- ============================================================
-- E-COMMERCE DATA ANALYTICS PROJECT
-- SQL DATA ANALYSIS
-- ============================================================

-- Database Selection
USE ecommerce_analytics;


-- ============================================================
-- SECTION 1: BASIC DATA EXPLORATION
-- ============================================================


-- ------------------------------------------------------------
-- QUERY 1: COUNT TOTAL RECORDS
-- ------------------------------------------------------------

SELECT COUNT(*) AS total_records
FROM superstore;


-- ------------------------------------------------------------
-- QUERY 2: VIEW SAMPLE DATA
-- ------------------------------------------------------------

SELECT *
FROM superstore
LIMIT 10;


-- ------------------------------------------------------------
-- QUERY 3: CALCULATE TOTAL SALES AND TOTAL PROFIT
-- ------------------------------------------------------------

SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore;


-- ------------------------------------------------------------
-- QUERY 4: FIND THE DATE RANGE OF THE DATASET
-- ------------------------------------------------------------

SELECT
    MIN(Order_Date) AS first_order_date,
    MAX(Order_Date) AS last_order_date
FROM superstore;


-- ============================================================
-- SECTION 2: SALES AND PROFIT ANALYSIS
-- ============================================================


-- ------------------------------------------------------------
-- QUERY 5: SALES AND PROFIT BY CATEGORY
-- ------------------------------------------------------------

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Category
ORDER BY total_sales DESC;


-- ------------------------------------------------------------
-- QUERY 6: SALES AND PROFIT BY SUB-CATEGORY
-- ------------------------------------------------------------

SELECT
    Sub_Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Sub_Category
ORDER BY total_profit DESC;


-- ------------------------------------------------------------
-- QUERY 7: YEARLY SALES AND PROFIT TREND
-- ------------------------------------------------------------

SELECT
    Order_Year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Order_Year
ORDER BY Order_Year;


-- ------------------------------------------------------------
-- QUERY 8: SALES AND PROFIT BY REGION
-- ------------------------------------------------------------

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Region
ORDER BY total_profit DESC;


-- ------------------------------------------------------------
-- QUERY 9: SALES AND PROFIT BY MARKET
-- ------------------------------------------------------------

SELECT
    Market,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Market
ORDER BY total_profit DESC;


-- ------------------------------------------------------------
-- QUERY 10: MONTHLY SALES AND PROFIT ANALYSIS
-- ------------------------------------------------------------

SELECT
    Order_Month,
    Month_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Order_Month, Month_Name
ORDER BY Order_Month;


-- ============================================================
-- SECTION 3: CUSTOMER ANALYSIS
-- ============================================================


-- ------------------------------------------------------------
-- QUERY 11: TOP 10 CUSTOMERS BY SALES
-- ------------------------------------------------------------

SELECT
    Customer_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Customer_Name
ORDER BY total_sales DESC
LIMIT 10;


-- ------------------------------------------------------------
-- QUERY 12: TOP 10 CUSTOMERS BY PROFIT
-- ------------------------------------------------------------

SELECT
    Customer_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Customer_Name
ORDER BY total_profit DESC
LIMIT 10;


-- ============================================================
-- SECTION 4: PRODUCT ANALYSIS
-- ============================================================


-- ------------------------------------------------------------
-- QUERY 13: TOP 10 PRODUCTS BY SALES
-- ------------------------------------------------------------

SELECT
    Product_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Product_Name
ORDER BY total_sales DESC
LIMIT 10;


-- ------------------------------------------------------------
-- QUERY 14: TOP 10 PRODUCTS BY PROFIT
-- ------------------------------------------------------------

SELECT
    Product_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Product_Name
ORDER BY total_profit DESC
LIMIT 10;


-- ============================================================
-- SECTION 5: DISCOUNT AND LOSS ANALYSIS
-- ============================================================


-- ------------------------------------------------------------
-- QUERY 15: DISCOUNT IMPACT ON SALES AND PROFIT
-- ------------------------------------------------------------

SELECT
    Discount,
    ROUND(AVG(Sales), 2) AS average_sales,
    ROUND(AVG(Profit), 2) AS average_profit,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(*) AS transaction_count
FROM superstore
GROUP BY Discount
ORDER BY Discount;


-- ------------------------------------------------------------
-- QUERY 16: LOSS-MAKING TRANSACTIONS BY DISCOUNT
-- ------------------------------------------------------------

SELECT
    Discount,
    COUNT(*) AS loss_transactions,
    ROUND(SUM(Profit), 2) AS total_loss,
    ROUND(AVG(Profit), 2) AS average_loss
FROM superstore
WHERE Profit < 0
GROUP BY Discount
ORDER BY total_loss ASC;


-- ============================================================
-- SECTION 6: SHIPPING ANALYSIS
-- ============================================================


-- ------------------------------------------------------------
-- QUERY 17: SHIPPING MODE ANALYSIS
-- ------------------------------------------------------------

SELECT
    Ship_Mode,
    COUNT(*) AS transaction_count,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Shipping_Days), 2) AS average_shipping_days
FROM superstore
GROUP BY Ship_Mode
ORDER BY total_sales DESC;


-- ============================================================
-- SECTION 7: ADVANCED SQL ANALYSIS
-- ============================================================


-- ------------------------------------------------------------
-- QUERY 18: HAVING CLAUSE
-- FIND CATEGORIES WITH SALES GREATER THAN 4 MILLION
-- ------------------------------------------------------------

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Category
HAVING SUM(Sales) > 4000000
ORDER BY total_sales DESC;


-- ------------------------------------------------------------
-- QUERY 19: CASE WHEN ANALYSIS
-- CLASSIFY TRANSACTIONS AS PROFIT, LOSS, OR BREAK-EVEN
-- ------------------------------------------------------------

SELECT
    CASE
        WHEN Profit > 0 THEN 'Profit'
        WHEN Profit < 0 THEN 'Loss'
        ELSE 'Break-Even'
    END AS transaction_status,

    COUNT(*) AS transaction_count,

    ROUND(SUM(Sales), 2) AS total_sales,

    ROUND(SUM(Profit), 2) AS total_profit

FROM superstore

GROUP BY transaction_status;


-- ------------------------------------------------------------
-- QUERY 20: COMMON TABLE EXPRESSION (CTE)
-- FIND CATEGORIES WITH PROFIT GREATER THAN 300,000
-- ------------------------------------------------------------

WITH category_analysis AS (

    SELECT
        Category,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit

    FROM superstore

    GROUP BY Category
)

SELECT
    Category,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(total_profit, 2) AS total_profit

FROM category_analysis

WHERE total_profit > 300000

ORDER BY total_profit DESC;


-- ============================================================
-- SECTION 8: WINDOW FUNCTIONS
-- ============================================================


-- ------------------------------------------------------------
-- QUERY 21: RANK CATEGORIES BY SALES
-- ------------------------------------------------------------

SELECT
    Category,

    ROUND(SUM(Sales), 2) AS total_sales,

    ROUND(SUM(Profit), 2) AS total_profit,

    RANK() OVER (
        ORDER BY SUM(Sales) DESC
    ) AS sales_rank

FROM superstore

GROUP BY Category;


-- ------------------------------------------------------------
-- QUERY 22: RANK PRODUCTS WITHIN EACH CATEGORY
-- ------------------------------------------------------------

WITH product_sales AS (

    SELECT
        Category,
        Product_Name,
        SUM(Sales) AS total_sales

    FROM superstore

    GROUP BY Category, Product_Name
)

SELECT
    Category,

    Product_Name,

    ROUND(total_sales, 2) AS total_sales,

    RANK() OVER (
        PARTITION BY Category
        ORDER BY total_sales DESC
    ) AS product_rank

FROM product_sales

ORDER BY Category, product_rank;


-- ------------------------------------------------------------
-- QUERY 23: YEAR-OVER-YEAR SALES GROWTH USING LAG()
-- ------------------------------------------------------------

WITH yearly_sales AS (

    SELECT
        Order_Year,
        SUM(Sales) AS total_sales

    FROM superstore

    GROUP BY Order_Year
)

SELECT
    Order_Year,

    ROUND(total_sales, 2) AS total_sales,

    ROUND(
        LAG(total_sales) OVER (
            ORDER BY Order_Year
        ),
        2
    ) AS previous_year_sales,

    ROUND(
        total_sales -
        LAG(total_sales) OVER (
            ORDER BY Order_Year
        ),
        2
    ) AS sales_growth

FROM yearly_sales

ORDER BY Order_Year;


-- ------------------------------------------------------------
-- QUERY 24: RUNNING TOTAL OF YEARLY SALES
-- ------------------------------------------------------------

WITH yearly_sales AS (

    SELECT
        Order_Year,
        SUM(Sales) AS total_sales

    FROM superstore

    GROUP BY Order_Year
)

SELECT
    Order_Year,

    ROUND(total_sales, 2) AS yearly_sales,

    ROUND(
        SUM(total_sales) OVER (
            ORDER BY Order_Year
        ),
        2
    ) AS running_total_sales

FROM yearly_sales

ORDER BY Order_Year;


-- ------------------------------------------------------------
-- QUERY 25: FIND HIGH-VALUE CUSTOMERS
-- CUSTOMERS WITH TOTAL SALES GREATER THAN 25,000
-- ------------------------------------------------------------

SELECT
    Customer_Name,

    ROUND(SUM(Sales), 2) AS total_sales,

    ROUND(SUM(Profit), 2) AS total_profit

FROM superstore

GROUP BY Customer_Name

HAVING SUM(Sales) > 25000

ORDER BY total_sales DESC;


-- ============================================================
-- END OF E-COMMERCE DATA ANALYSIS
-- ============================================================