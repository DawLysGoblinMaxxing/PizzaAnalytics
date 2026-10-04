/*
====================================================
Analiza sprzedaży Pizza Place
Projekt analityczny SQL
====================================================

Baza danych: PizzaAnalytics
Narzędzia: SQL Server, SSMS, Power BI
Źródło danych: Maven Analytics - Pizza Place Sales

Cel projektu:
Analiza danych dotyczących sprzedaży pizzy w celu
identyfikacji trendów przychodów, wzorców zamówień
oraz wyników poszczególnych produktów.
====================================================
*/



USE PizzaAnalytics;
GO

-- ====================================================
-- 1. Całkowity przychód
-- ====================================================

SELECT
	SUM(CAST(price AS decimal(10, 2)) * quantity) AS Total_Revenue
FROM pizzas p
INNER JOIN order_details od ON p.pizza_id = od.pizza_id;

-- ====================================================
-- 2. Top 10 pizz według przychodu
-- ====================================================

SELECT
	TOP 10 SUM(CAST(price AS decimal(10,2)) * quantity)  AS Revenue, 
	pt.name AS Name
FROM pizzas p
INNER JOIN order_details od 
	ON p.pizza_id = od.pizza_id
INNER JOIN pizza_types pt 
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY SUM(CAST(price AS decimal(10,2)) * quantity) DESC;

-- ====================================================
-- 3. Przychód według miesiąca
-- ====================================================


SELECT 
	MONTH(date) AS Month, SUM(CAST(price AS decimal(10,2)) * quantity) AS Total_Revenue
FROM orders o
INNER JOIN order_details od 
	ON o.order_id = od.order_id
INNER JOIN pizzas p 
	ON p.pizza_id = od.pizza_id
GROUP BY MONTH(date)
ORDER BY Month;

-- ====================================================
-- 4. Przychód według kategorii
-- ====================================================

SELECT 
	category AS Category,
	SUM(CAST(price AS decimal(10,2)) * quantity) AS Total_Revenue
FROM orders o
INNER JOIN order_details od 
	ON o.order_id = od.order_id
INNER JOIN pizzas p 
	ON od.pizza_id = p.pizza_id
INNER JOIN pizza_types pt 
	ON pt.pizza_type_id = p.pizza_type_id
GROUP BY category
ORDER BY Total_Revenue DESC;

-- ====================================================
-- 5. Przychód według rozmiaru pizzy
-- ====================================================

SELECT 
	size AS Size,
	SUM(CAST(price AS decimal(10,2)) * quantity) AS Total_Revenue
FROM orders o
INNER JOIN order_details od 
	ON o.order_id = od.order_id
INNER JOIN pizzas p 
	ON od.pizza_id = p.pizza_id
GROUP BY size
ORDER BY Total_Revenue DESC;

-- ====================================================
-- 6. Liczba zamówień według dnia tygodnia
-- ====================================================

SELECT 
	DATENAME(WEEKDAY,date) AS Day,
	COUNT(o.order_id) AS Total_Orders
FROM orders o
GROUP BY DATENAME(WEEKDAY, date)
ORDER BY Total_Orders DESC;

-- ====================================================
-- 7. Przychód według godziny
-- ====================================================

SELECT 
	DATEPART(HOUR, time) AS Hour, 
	SUM(CAST(price AS decimal(10,2)) * quantity) AS Total_Revenue
FROM orders o
INNER JOIN order_details od 
	ON o.order_id = od.order_id
INNER JOIN pizzas p 
	ON p.pizza_id = od.pizza_id
GROUP BY DATEPART(HOUR, time)
ORDER BY DATEPART(HOUR, time);

-- ====================================================
-- 8. Średnia wartość zamówienia
-- ====================================================

SELECT 
	ROUND(SUM(CAST(price AS decimal(10,2)) * quantity) / COUNT(distinct o.order_id), 2) AS Average_Order_Value
FROM orders o 
INNER JOIN order_details od 
	ON o.order_id = od.order_id
INNER JOIN pizzas p 
	ON p.pizza_id = od.pizza_id;

-- ====================================================
-- 9. Średni przychód z jednej pizzy
-- ====================================================

SELECT 
	ROUND(SUM(CAST(price AS decimal(10,2)) * quantity) / SUM(quantity), 2) AS Revenue_Per_Pizza
FROM order_details od
INNER JOIN pizzas p 
	ON p.pizza_id = od.pizza_id;

-- ====================================================
-- 10. Liczba sprzedanych pizz według kategorii
-- ====================================================

SELECT 
	category AS Category,
	SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_types pt
INNER JOIN pizzas p 
	ON pt.pizza_type_id = p.pizza_type_id
INNER JOIN order_details od 
	ON p.pizza_id = od.pizza_id
GROUP BY category
ORDER BY SUM(quantity) DESC;

-- ====================================================
-- 11. Top 10 pizz według liczby sprzedanych sztuk
-- ====================================================

SELECT 
	TOP 10 name AS Name, 
	SUM(quantity) AS Pizzas_Sold
FROM order_details od
INNER JOIN pizzas p 
	ON	od.pizza_id = p.pizza_id
INNER JOIN pizza_types pt 
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY name
ORDER BY SUM(quantity) DESC;

-- ====================================================
-- 12. Udział kategorii w całkowitym przychodzie
-- ====================================================

-- Wykorzystanie podzapytania do obliczenia udziału procentowego

SELECT 
	category AS Category,
	SUM(CAST(price AS decimal(10,2)) * quantity) AS Revenue,
	SUM(CAST(price AS decimal(10,2)) * quantity) * 100.0/(SELECT SUM(CAST(price AS decimal(10,2)) * quantity) FROM order_details od INNER JOIN pizzas p ON od.pizza_id = p.pizza_id) AS Revenue_Share
FROM order_details od
INNER JOIN pizzas p 
	ON od.pizza_id = p.pizza_id
INNER JOIN pizza_types pt 
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY category;

-- ====================================================
-- 13. Najlepiej sprzedająca się pizza w każdym miesiącu
-- ====================================================

-- CTE + funkcja okna ROW_NUMBER() do znalezienia lidera w każdym miesiącu

WITH Pizzas_Ranked AS (
SELECT 
	MONTH(date) as Month,
	name AS Name,
	SUM(CAST(price as decimal(10,2)) * quantity) AS Revenue,
	ROW_NUMBER() OVER(PARTITION BY MONTH(date) ORDER BY SUM(CAST(price as decimal(10,2)) * quantity) DESC) AS Ranking
FROM orders o
INNER JOIN order_details od 
	ON o.order_id = od.order_id
INNER JOIN pizzas p 
	ON od.pizza_id = p.pizza_id
INNER JOIN pizza_types pt 
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY name, MONTH(date)
)

SELECT 
	Name, 
	Revenue, 
	Ranking, 
	Month
FROM Pizzas_Ranked 
WHERE Ranking = 1;

-- ====================================================
-- 14. Liczba zamówień według miesiąca
-- ====================================================

SELECT 
	MONTH(date) AS Month,
	COUNT(distinct order_id) AS Total_Orders
FROM orders
GROUP BY MONTH(date)
ORDER BY Month ASC;

-- ====================================================
-- 15. Średnia liczba pizz na zamówienie
-- ====================================================

SELECT 
	SUM(quantity) AS Total_Pizzas,
	COUNT(distinct order_id) AS Orders,
	CAST(SUM(quantity) AS decimal(10, 2))/COUNT(distinct order_id) AS Average_Pizzas_Per_Order
FROM order_details;

-- ====================================================
-- 16. Przychód: weekend vs dni robocze
-- ====================================================

SELECT 
	CASE 
		WHEN DATENAME(WEEKDAY, date) IN ('Saturday' , 'Sunday')  
			THEN 'Weekend' 
		ELSE 'Weekday' 
		END AS Day_Type,
	SUM(CAST(price as decimal(10,2)) * quantity) AS Revenue
FROM orders o
INNER JOIN order_details od 
	ON o.order_id = od.order_id
INNER JOIN pizzas p 
	ON p.pizza_id = od.pizza_id
GROUP BY 
	CASE 
		WHEN DATENAME(WEEKDAY, date) IN ('Saturday' , 'Sunday')  
			THEN 'Weekend' 
		ELSE 'Weekday' 
		END;

-- ====================================================
-- 17. Dzień z najwyższym przychodem
-- ====================================================

SELECT TOP 1 
	date as Date,
	SUM(CAST(price AS decimal(10,2)) * quantity) AS Revenue
FROM orders o
INNER JOIN order_details od 
	ON o.order_id = od.order_id
INNER JOIN pizzas p 
	ON p.pizza_id = od.pizza_id
GROUP BY date
ORDER BY Revenue DESC;

-- ====================================================
-- 18. Najlepsza pizza w każdym rozmiarze
-- ====================================================

-- CTE + ROW_NUMBER() z PARTITION BY do znalezienia lidera w każdym rozmiarze

WITH pizzas_revenue AS (
SELECT 
	size AS Size, 
	name AS Pizza,
	SUM(CAST(price AS decimal(10,2)) * quantity) AS Revenue,
	ROW_NUMBER() OVER(PARTITION BY size ORDER BY SUM(CAST(price AS decimal(10,2)) * quantity) DESC) AS Ranking
FROM order_details od 
INNER JOIN pizzas p 
	ON p.pizza_id = od.pizza_id
INNER JOIN pizza_types pt 
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY size, name
)

SELECT 
	Size,
	Pizza,
	Revenue,
	Ranking
FROM pizzas_revenue
WHERE Ranking = 1
ORDER BY Revenue DESC;
