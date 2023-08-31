CREATE TABLE categories (
  category_code VARCHAR(5) PRIMARY KEY,
  category VARCHAR(50)
);

CREATE TABLE countries (
  country_code CHAR(3) PRIMARY KEY,
  country VARCHAR(50),
  continent VARCHAR(20)
);

CREATE TABLE businesses (
  business VARCHAR(64) PRIMARY KEY,
  year_founded INT,
  category_code VARCHAR(5),
  country_code CHAR(3)
);

--- 1. The oldest business in the world

SELECT
    MIN(year_founded),
    MAX(year_founded)
FROM businesses;

--- 2. How many businesses were founded before 1000?

SELECT
    COUNT(*)
FROM businesses
WHERE year_founded < 1000;

--- 3. Which businesses were founded before 1000?

SELECT *
FROM businesses
WHERE year_founded < 1000
ORDER BY year_founded ASC;

--- 4. Exploring the categories

SELECT 
    b.business, 
    b.year_founded, 
    b.country_code, 
    c.category
FROM businesses AS b
LEFT JOIN categories AS c
ON b.category_code = c.category_code
WHERE year_founded < 1000
ORDER BY year_founded;

--- 5. Counting the categories

SELECT 
    category,
    COUNT(category) AS n
FROM categories AS c
LEFT JOIN businesses AS b
USING(category_code)
GROUP BY category
ORDER BY n DESC
LIMIT 10;

--- 6. Oldest business by continent

SELECT 
    MIN(year_founded) AS oldest,
    continent
FROM businesses AS b
LEFT JOIN countries AS c
ON b.country_code = c.country_code
GROUP BY continent
ORDER BY oldest ASC;

--- 7. Joining everything for further analysis

SELECT
    b.business,
    b.year_founded,
    c1.category,
    c2.country,
    c2.continent
FROM businesses AS b
LEFT JOIN categories  AS c1
ON b.category_code = c1.category_code
LEFT JOIN countries AS c2
ON b.country_code = c2.country_code;

--- 8. Counting categories by continent

SELECT 
    c2.continent, 
    c1.category, 
    COUNT(*) AS n
FROM businesses AS b
LEFT JOIN categories AS c1
ON b.category_code = c1.category_code
LEFT JOIN countries AS c2
ON b.country_code = c2.country_code
GROUP BY 
    c2.continent, 
    c1.category;

--- 9. Filtering counts by continent and category

SELECT 
    cnt.continent, 
    cat.category, 
    COUNT(*) AS n
FROM businesses AS bus
LEFT JOIN categories AS cat
ON bus.category_code = cat.category_code
LEFT JOIN countries AS cnt
ON bus.country_code = cnt.country_code
GROUP BY 
    cnt.continent, 
    cat.category
HAVING COUNT(*) > 5
ORDER BY n DESC;