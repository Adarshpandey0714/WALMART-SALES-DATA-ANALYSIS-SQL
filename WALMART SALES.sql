Create table sales(
invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
branch VARCHAR(5) NOT NULL,
city VARCHAR(30),
customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(10) NOT NULL,
product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL (10,2) NOT NULL,
quantity INT not null,
vat FLOAT(6,4) NOT NULL,
total DECIMAL(12,4) NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment_method VARCHAR(15) NOT NULL,
cogs DECIMAL (10,2) NOT NULL,
gross_margin_pct FLOAT(11, 9) NOT NULL,
gross_income DECIMAL (12,4) NOT NULL,
rating FLOAT (2,1)
);
-- -------------------------DATA CLEANING--------------------------------- --
SELECT * FROM sales;

-- -----------------------FEATURE ENGINERING------------------------------- --
-- time_of_day --

ALTER TABLE sales
ADD time_of_day VARCHAR(15);

UPDATE sales
SET time_of_day = (CASE
    WHEN time BETWEEN '00:00:00' AND  '12:00:00' THEN 'Morning'
    WHEN time BETWEEN '12:01:00' AND  '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
END);

-- DAY_NAME --

ALTER TABLE sales
ADD day_name VARCHAR(15);

UPDATE sales
SET day_name = dayname(date);

-- MONTH_NAME --

ALTER TABLE sales
ADD month_name VARCHAR(10);

UPDATE sales
SET month_name = monthname(date);

-- ----------------------------GENERIC QUES---------------------------------- --

-- How many unique cities does the data have? --
SELECT CITY FROM sales
GROUP BY CITY;

-- In which city is each branch? --
SELECT DISTINCT CITY , BRANCH  
FROM Sales;

-- ---------------------------PRODUCT---------------------------------------- --

-- How many unique product lines does the data have? --
SELECT PRODUCT_LINE FROM SALES
GROUP BY PRODUCT_LINE;

-- What is the most common payment method? --
SELECT PAYMENT_METHOD , COUNT(*)
FROM SALES
GROUP BY PAYMENT_METHOD
ORDER BY COUNT(*) DESC;

-- What is the most selling product line? --
SELECT PRODUCT_LINE, COUNT(quantity)
FROM sales
GROUP BY PRODUCT_LINE
ORDER BY COUNT(quantity) DESC;

-- What is the total revenue by month? --
SELECT MONTH_NAME , SUM(TOTAL)
FROM sales 
GROUP BY MONTH_NAME
ORDER BY SUM(TOTAL) DESC;

-- What month had the largest COGS? --
SELECT MONTH_NAME , SUM(COGS)
FROM sales 
GROUP BY MONTH_NAME
ORDER BY SUM(COGS) DESC;

-- What product line had the largest revenue? --
SELECT PRODUCT_LINE, SUM(TOTAL)
FROM sales
GROUP BY PRODUCT_LINE
ORDER BY SUM(TOTAL) DESC;

 -- What is the city with the largest revenue? --
 SELECT CITY , SUM(TOTAL)
FROM SALES
GROUP BY CITY
ORDER BY SUM(TOTAL) DESC;

-- What product line had the largest VAT? --
SELECT PRODUCT_LINE, AVG(VAT)
FROM sales
GROUP BY PRODUCT_LINE
ORDER BY AVG(VAT) DESC;

-- Which branch sold more products than average product sold? -- 
SELECT BRANCH , SUM(QUANTITY) FROM SALES
GROUP BY BRANCH
HAVING SUM(QUANTITY) > (SELECT AVG(QUANTITY) FROM SALES)
ORDER BY SUM(QUANTITY) DESC;

-- What is the most common product line by gender? --
SELECT GENDER,PRODUCT_LINE, COUNT(GENDER)
FROM SALES
GROUP BY GENDER, PRODUCT_LINE
ORDER BY  COUNT(GENDER) DESC;

-- What is the average rating of each product line? --
SELECT PRODUCT_LINE , AVG(RATING)
FROM SALES
GROUP BY PRODUCT_LINE
ORDER BY AVG(RATING) DESC ;

-- ---------------------------------SALES------------------------------- --

-- Number of sales made in each time of the day per weekday --
SELECT TIME_OF_DAY, COUNT(*)
FROM  SALES
WHERE DAY_NAME = 'MONDAY' 
GROUP BY TIME_OF_DAY;

-- Which of the customer types brings the most revenue? -- 
SELECT CUSTOMER_TYPE , SUM(TOTAL)
FROM SALES
GROUP BY CUSTOMER_TYPE 
ORDER BY SUM(TOTAL) DESC;

-- Which city has the largest tax percent/ VAT (Value Added Tax)? --
SELECT CITY, AVG(VAT)
FROM SALES
GROUP BY CITY
ORDER BY AVG(VAT) DESC;

-- Which customer type pays the most in VAT? --
SELECT CUSTOMER_TYPE, AVG(VAT)
FROM SALES
GROUP BY CUSTOMER_TYPE
ORDER BY AVG(VAT) DESC;

-- ---------------------------------------CUSTOMER-------------------------------- --
-- How many unique customer types does the data have? --
SELECT CUSTOMER_TYPE FROM SALES
GROUP BY CUSTOMER_TYPE;

-- How many unique payment methods does the data have? --
SELECT PAYMENT_METHOD FROM SALES
GROUP BY PAYMENT_METHOD;

-- What is the most common customer type? --
SELECT CUSTOMER_TYPE, COUNT(*) 
 FROM SALES
GROUP BY CUSTOMER_TYPE;

-- Which customer type buys the most? --
SELECT CUSTOMER_TYPE, COUNT(*) 
 FROM SALES
GROUP BY CUSTOMER_TYPE;

-- What is the gender of most of the customers? --
SELECT GENDER ,  COUNT(*)
FROM SALES
GROUP BY GENDER;

-- What is the gender distribution per branch? --
SELECT  GENDER , COUNT(*) AS CNT
FROM SALES
WHERE BRANCH = 'A'
GROUP BY GENDER
ORDER BY CNT DESC;

-- Which time of the day do customers give most ratings? --
SELECT TIME_OF_DAY , AVG(RATING)
FROM SALES
GROUP BY TIME_OF_DAY
ORDER BY AVG(RATING) DESC;

-- Which time of the day do customers give most ratings per branch? --
SELECT TIME_OF_DAY , AVG(RATING)
FROM SALES
WHERE BRANCH = 'A'
GROUP BY TIME_OF_DAY
ORDER BY AVG(RATING) DESC;

-- Which day for the week has the best avg ratings? --
SELECT DAY_NAME , AVG(RATING)
FROM SALES
GROUP BY DAY_NAME
ORDER BY AVG(RATING)DESC;

-- Which day of the week has the best average ratings per branch? --
SELECT DAY_NAME , AVG(RATING)
FROM SALES
WHERE BRANCH = 'B'
GROUP BY DAY_NAME
ORDER BY AVG(RATING)DESC;




















