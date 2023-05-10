--SECTION A--
--PROFIT ANALYSIS--

/*1. Within the space of the last three years, what was the profit worth of the breweries,
inclusive of the anglophone and the francophone territories?*/

SELECT SUM(profit) AS sum_profit
FROM dbo.International_Breweries$;


/*2. Compare the total profit between these two territories in order for the territory manager,
Mr. Mathew  make a strategic decision that will aid profit maximization in 2020.*/

SELECT territories,
	SUM(profit) AS Sum_profit
FROM dbo.International_Breweries$
GROUP BY territories
ORDER BY Sum_profit DESC;


--3. Country that generated the highest profit in 2019--

SELECT TOP 1 countries, SUM(profit) AS Sum_profit
FROM dbo.International_Breweries$
WHERE years= 2019
GROUP BY countries
ORDER BY Sum_profit DESC

--4. Help him find the year with the highest profit.--

SELECT years, SUM(profit) AS Sum_profit
FROM dbo.International_Breweries$
GROUP BY years
ORDER BY Sum_profit DESC

--5. Which month in the three years was the least profit generated?--

SELECT TOP 1 years, months, SUM(profit) AS Sum_profit
FROM dbo.International_Breweries$
GROUP BY years, months
ORDER BY Sum_profit


--6. What was the minimum profit in the month of December 2018?--

SELECT months, MIN(profit) AS Min_profit
FROM dbo.International_Breweries$
WHERE years= 2018
AND months = 'December'
GROUP BY months
ORDER BY  Min_profit;

--7. Compare the profit in percentage for each of the month in 2019--

	
SELECT months, round(SUM(profit*1.0)/(SELECT SUM(profit)
FROM dbo.International_Breweries$
WHERE years= 2019)*100.0,2) AA
FROM dbo.International_Breweries$
where years = 2019					 
GROUP BY months;


--8. Which particular brand generated the highest profit in Senegal?--

SELECT TOP 1 brands, SUM(profit) AS Highest_profit
FROM dbo.International_Breweries$
WHERE countries = 'Senegal'
GROUP BY brands
ORDER BY Highest_profit  DESC;


--Session B--
--BRAND ANALYSIS--

/*1. Within the last two years, the brand manager wants to know the top three brands
consumed in the francophone countries*/


SELECT Top 1 brands,SUM(profit) AS Total_Profit ,  SUM(quantity) AS Total_Quantity
FROM dbo.International_Breweries$
WHERE territories = 'francophone'
AND years IN (2018,2019)
GROUP BY brands
ORDER BY  Total_Quantity DESC;

--2. Find out the top two choice of consumer brands in Ghana--

SELECT TOP 2 brands, SUM(quantity) AS Top_Choice
FROM dbo.International_Breweries$
WHERE countries = 'Ghana'
GROUP BY brands
ORDER BY  Top_Choice DESC


/*3. Find out the details of beers consumed in the past three years in the most oil reached
country in West Africa.*/


SELECT DISTINCT brands, unit_price,SUM(quantity) AS quantity, SUM(profit) AS profit, SUM(costs) AS costs 
FROM dbo.International_Breweries$
WHERE countries ='Nigeria'
AND brands NOT LIKE '%malt%'
GROUP BY brands, unit_price
ORDER BY quantity DESC;

--4. Favorites malt brand in Anglophone region between 2018 and 2019--

SELECT brands, SUM(Quantity) As Total_Quantity
FROM dbo.International_Breweries$
WHERE countries IN ('Nigeria', 'Ghana')
AND brands LIKE '%malt%'
AND years BETWEEN 2018 AND 2019
GROUP BY brands
ORDER BY Total_Quantity DESC;

--5. Which brand sold the highest in 2019 in Nigeria?--

SELECT brands, SUM(quantity) As Total_Quantity
FROM dbo.International_Breweries$
WHERE countries='Nigeria'
AND years=2019
GROUP BY brands
ORDER BY Total_Quantity  DESC;


--6. Favorite brand in South_South region in Nigeria--

SELECT brands, SUM(quantity) AS Total_Quantity 
FROM dbo.International_Breweries$
WHERE region='southsouth'
AND countries='Nigeria'
GROUP BY brands
ORDER BY Total_Quantity DESC;


--7. Beer consumption in Nigeria--
SELECT  brands, SUM(quantity) AS Total_Quantity
FROM dbo.International_Breweries$
WHERE countries='Nigeria'
AND brands NOT LIKE '%malt%'
GROUP BY  brands
ORDER BY Total_Quantity;



--8. Level of consumption of Budweiser in the regions in Nigeria--
--Total brands consumption in Nigeria --
SELECT brands, SUM(quantity) AS Quantity
FROM International_Breweries$ 
WHERE countries = 'Nigeria' AND brands = 'Budweiser'
GROUP BY brands;


--Session C--
--COUNTRIES ANALYSIS--
--1. Country with the highest consumption of beer--
SELECT countries, SUM(quantity) AS Quantity
FROM  dbo.International_Breweries$
GROUP BY countries
ORDER BY Quantity DESC;


--2. Highest sales personnel of Budweiser in Senegal--

SELECT sales_rep, SUM(quantity) AS Sales_Quantity
FROM dbo.International_Breweries$
WHERE brands='budweiser'
AND countries = 'Senegal'
GROUP BY sales_rep
ORDER BY  Sales_Quantity DESC



--3. Country with the highest profit of the fourth quarter in 2019--

SELECT countries, SUM(profit) AS profit
FROM dbo.International_Breweries$
WHERE months IN ('October','November', 'December')
AND years=2019
GROUP BY countries
ORDER BY profit  DESC;
