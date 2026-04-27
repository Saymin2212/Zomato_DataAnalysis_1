create database Zomato;
use zomato;
show tables;
select * from main_table_zomato;
select * from calender_table_zomato;
select * from country_map_table;
SET SQL_SAFE_UPDATES = 0;


/* 3.Find the Numbers of Resturants based on City and Country. */
  
SELECT 
    c.`Country name` AS CountryName,
    m.City,
    COUNT(*) AS NumberOfRestaurants
FROM 
    main_table_zomato m
JOIN 
    Country_map_table c
    ON m.CountryCode= c.`CountryCode`
GROUP BY 
    c.`Country name`, m.City
ORDER BY 
    NumberOfRestaurants DESC;



#4 .Numbers of Resturants opening based on Year , Quarter , Month


SELECT 
    YEAR(Datekey_Opening) AS Opening_Year,
    QUARTER(Datekey_Opening) AS Opening_Quarter,
    MONTH(Datekey_Opening) AS Opening_Month,
    COUNT(*) AS Restaurant_Count
FROM 
    calender_table_zomato
WHERE 
    Datekey_Opening IS NOT NULL
GROUP BY 
    YEAR(Datekey_Opening),
    QUARTER(Datekey_Opening),
    MONTH(Datekey_Opening)
ORDER BY 
    Opening_Year,
    Opening_Quarter,
    Opening_Month;
    
   # 5.  Count of Resturants based on Average Ratings 
    SELECT 
    Average_Cost_for_two,
    COUNT(*) AS restaurant_count
FROM 
	main_table_zomato
WHERE 
	Average_Cost_for_two IS NOT NULL
GROUP BY 
	Average_Cost_for_two
ORDER BY 
	Average_Cost_for_two DESC;
    
 
 #6.Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets#
  
   SELECT 
    CASE 
        WHEN Average_Cost_for_two <= 250 THEN '₹0 – ₹250'
        WHEN Average_Cost_for_two BETWEEN 251 AND 500 THEN '₹251 – ₹500'
        WHEN Average_Cost_for_two BETWEEN 501 AND 1000 THEN '₹501 – ₹1000'
        WHEN Average_Cost_for_two BETWEEN 1001 AND 2000 THEN '₹1001 – ₹2000'
        ELSE '₹2000+'
    END AS Price_Bucket,
    COUNT(*) AS Restaurant_Count
FROM main_table_zomato
GROUP BY Price_Bucket
ORDER BY MIN(Average_Cost_for_two);

#7.Percentage of Resturants based on "Has_Table_booking"

SELECT 
    Has_Table_booking,
    COUNT(*) AS Restaurant_Count,
    CONCAT(ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM main_table_zomato)), 2), '%') AS Percentage
FROM main_table_zomato
GROUP BY Has_Table_booking;

#8. Percentage of Resturants based on "Has_Online_delivery"

SELECT 
    Has_Online_delivery,
    COUNT(*) AS Restaurant_Count,
    CONCAT(ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM main_table_zomato)), 2), '%') AS Percentage
FROM main_table_zomato
GROUP BY Has_Online_delivery;

#9. write a sql query to count number of  city wise cuisines and ratings


SELECT 
    City,
    COUNT(*) AS TotalRestaurants,
    COUNT(DISTINCT Cuisines) AS DistinctCuisineCombinations,
    ROUND(AVG(Rating), 2) AS AvgRating
FROM 
    main_table_zomato
GROUP BY 
    City
ORDER BY 
    TotalRestaurants DESC;





