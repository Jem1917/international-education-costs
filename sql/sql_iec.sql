create database praisie;
show databases;
CREATE TABLE education_costs (
    Country VARCHAR(100),
    City VARCHAR(100),
    University VARCHAR(150),
    Program VARCHAR(150),
    Level VARCHAR(50),
    Duration_Years DECIMAL(4,2),
    Tuition DECIMAL(12,2),
    Living_Cost_Index DECIMAL(6,2),
    Rent DECIMAL(10,2),
    Visa_Fee DECIMAL(10,2),
    Insurance DECIMAL(10,2),
    Exchange_Rate DECIMAL(8,4),
    Total_Cost DECIMAL(12,2)
);
SELECT * 
FROM education_costs
LIMIT 10;

SELECT University, Program, Tuition
FROM education_costs
WHERE Country = 'USA' AND Tuition > 30000;

SELECT DISTINCT Level
FROM education_costs;

SELECT AVG(Tuition) AS AvgTuition
FROM education_costs;

-- Average total cost by country
SELECT Country, ROUND(AVG(Total_Cost),2) AS AvgTotalCost
FROM education_costs
GROUP BY Country
ORDER BY AvgTotalCost DESC;

-- Top 5 most expensive universities by total cost
SELECT University, Program, Total_Cost
FROM education_costs
ORDER BY Total_Cost DESC
LIMIT 5;

--  Count of programs per level
SELECT Level, COUNT(*) AS ProgramCount
FROM education_costs
GROUP BY Level;

--  Conditional bucket: tuition category
SELECT 
  Country,
  University,
  Tuition,
  CASE
    WHEN Tuition < 5000   THEN 'Budget (<5k)'
    WHEN Tuition < 15000  THEN 'Moderate (5–15k)'
    WHEN Tuition < 25000  THEN 'Balanced (15–25k)'
    ELSE 'Premium (25k+)'
  END AS Tuition_Category
FROM education_costs;

-- Subquery: universities more expensive than their country’s avg
SELECT ec.University, ec.Country, ec.Total_Cost
FROM education_costs ec
WHERE ec.Total_Cost > (
  SELECT AVG(Total_Cost)
  FROM education_costs
  WHERE Country = ec.Country
);

--  Rank countries by affordability (local cost)
SELECT
  Country,
  ROUND(AVG(Total_Cost * Exchange_Rate),2) AS AvgCostLocal,
  RANK() OVER (ORDER BY AVG(Total_Cost * Exchange_Rate)) AS AffordRank
FROM education_costs
GROUP BY Country;

--  Calculate difference from global avg via CTE
WITH CountryAvg AS (
  SELECT Country, AVG(Total_Cost) AS CAvg
  FROM education_costs
  GROUP BY Country
), GlobalAvg AS (
  SELECT AVG(Total_Cost) AS GAvg
  FROM education_costs
)
SELECT 
  c.Country, 
  c.CAvg, 
  g.GAvg, 
  ROUND(c.CAvg - g.GAvg,2) AS DiffFromGlobal
FROM CountryAvg c, GlobalAvg g
ORDER BY DiffFromGlobal DESC;


--  Pivot: count of programs by level as columns
SELECT
  Country,
  SUM(Level = 'Bachelor') AS Bachelor_Count,
  SUM(Level = 'Master')   AS Master_Count,
  SUM(Level = 'PhD')      AS PhD_Count
FROM education_costs
GROUP BY Country;


CREATE VIEW vw_CostSummary AS
SELECT 
  Country,
  Level,
  ROUND(AVG(Tuition),2)   AS AvgTuition,
  ROUND(AVG(Rent),2)      AS AvgRent,
  ROUND(AVG(Total_Cost),2) AS AvgTotal_USD,
  ROUND(AVG(Total_Cost*Exchange_Rate),2) AS AvgTotal_Local
FROM education_costs
GROUP BY Country, Level;

--  Index to speed up country lookups
CREATE INDEX idx_country ON education_costs(Country);

--  Stored Procedure example
DELIMITER //
CREATE PROCEDURE GetCountryCostStats(IN p_Country VARCHAR(100))
BEGIN
  SELECT 
    Country,
    ROUND(AVG(Tuition),2)   AS AvgTuition,
    ROUND(AVG(Total_Cost),2) AS AvgTotalCost,
    MIN(Total_Cost)          AS MinCost,
    MAX(Total_Cost)          AS MaxCost
  FROM education_costs
  WHERE Country = p_Country
  GROUP BY Country;
END //
DELIMITER ;

-- Call it:
CALL GetCountryCostStats('Canada');


-- Supporting table
CREATE TABLE region_info (
    Country VARCHAR(100),
    Continent VARCHAR(50)
);

-- Sample data
INSERT INTO region_info VALUES 
('India', 'Asia'),
('USA', 'North America'),
('Germany', 'Europe');

-- Inner Join: Only matches countries that exist in both tables
SELECT ec.Country, ec.City, ri.Continent, ec.University, ec.Total_Cost
FROM education_costs ec
INNER JOIN region_info ri ON ec.Country = ri.Country;


-- Supporting table
CREATE TABLE university_info (
    University VARCHAR(150),
    Program VARCHAR(150)
);

-- Sample data
INSERT INTO university_info VALUES 
('Harvard University', 'Data Science'),
('Oxford University', 'Economics'),
('ABC College', 'Arts');


-- Left Join: Keep all education_costs rows, match if found
SELECT ec.University, ec.Program
FROM education_costs ec
LEFT JOIN university_info ui 
  ON ec.University = ui.University AND ec.Program = ui.Program;
  
  
-- Supporting table
CREATE TABLE city_info (
    City VARCHAR(100),
    Country VARCHAR(100)
);

-- Sample data
INSERT INTO city_info VALUES 
('Boston', 'USA'),
('Delhi', 'India'),
('Berlin', 'Germany');

-- Right Join: Keep all cities, even if not present in main table
SELECT ci.City, ci.Country, ec.Tuition
FROM education_costs ec
RIGHT JOIN city_info ci 
  ON ec.City = ci.City AND ec.Country = ci.Country;
  


  
