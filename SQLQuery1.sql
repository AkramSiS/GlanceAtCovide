-- Retrieve all data from the 'coviddeaths' table and order it by columns 3 and 4.
SELECT * 
FROM PortfolioProject..coviddeaths
ORDER BY 3, 4;

-- Select specific columns for analysis.
SELECT
    location,
    date,
    total_cases,
    New_cases,
    total_deaths,
    population_density
FROM PortfolioProject..coviddeaths
ORDER BY 1, 2;

-- Analyzing the relationship between total cases and total deaths.
SELECT
    location,
    date,
    CAST(total_cases AS INT) AS TotalCases,
    CAST(total_deaths AS INT) AS TotalDeaths,
    (CAST(total_deaths AS DECIMAL) / CAST(total_cases AS DECIMAL)) * 100 AS DeathPercentage
FROM PortfolioProject..coviddeaths
ORDER BY location, date;

-- Calculate the Death Percentage.
SELECT
    location,
    date,
    total_cases,
    total_deaths,
    (CAST(total_deaths AS DECIMAL) / CAST(total_cases AS DECIMAL)) * 100 AS DeathPercentage
FROM PortfolioProject..coviddeaths
ORDER BY location, date;

-- Analyzing the Death Percentage in Yemen.
SELECT
    location,
    date,
    total_cases,
    total_deaths,
    (CAST(total_deaths AS DECIMAL) / CAST(total_cases AS DECIMAL)) * 100 AS DeathPercentage
FROM PortfolioProject..coviddeaths
WHERE location LIKE '%yemen%'
ORDER BY location, date;

-- Group the Death Percentage by year in Yemen.
SELECT
    YEAR(date) AS Year,
    location,
    SUM(CAST(total_cases AS DECIMAL)) AS TotalCases,
    SUM(CAST(total_deaths AS DECIMAL)) AS TotalDeaths,
    (SUM(CAST(total_deaths AS DECIMAL)) / SUM(CAST(total_cases AS DECIMAL))) * 100 AS DeathPercentage
FROM PortfolioProject..coviddeaths
WHERE location LIKE '%yemen%'
GROUP BY YEAR(date), location
ORDER BY Year, location;

-- Calculate the Death Percentage for the world, grouped by country.
SELECT
    location AS Country,
    SUM(CAST(total_cases AS DECIMAL)) AS TotalCases,
    SUM(CAST(total_deaths AS DECIMAL)) AS TotalDeaths,
    (SUM(CAST(total_deaths AS DECIMAL)) / SUM(CAST(total_cases AS DECIMAL))) * 100 AS DeathPercentage
FROM PortfolioProject..coviddeaths
GROUP BY location
ORDER BY DeathPercentage DESC;

-- Calculate the Death Percentage for the world, grouped by year.
SELECT
    YEAR(date) AS Year,
    (SUM(CAST(total_deaths AS DECIMAL)) / SUM(CAST(total_cases AS DECIMAL))) * 100 AS WorldDeathPercentage
FROM PortfolioProject..coviddeaths
GROUP BY YEAR(date)
ORDER BY Year;

-- Calculate the Death Percentage for the world, grouped by country and year.
SELECT
    YEAR(date) AS Year,
    location AS Country,
    SUM(CAST(total_cases AS DECIMAL)) AS TotalCases,
    SUM(CAST(total_deaths AS DECIMAL)) AS TotalDeaths,
    (SUM(CAST(total_deaths AS DECIMAL)) / SUM(CAST(total_cases AS DECIMAL))) * 100 AS DeathPercentage
FROM PortfolioProject..coviddeaths
GROUP BY YEAR(date), location
ORDER BY location, YEAR(date);

-- Retrieve countries with the highest death count.
SELECT
    Location,
    MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..coviddeaths
--WHERE location LIKE '%states%'
WHERE continent IS NOT NULL 
GROUP BY Location
ORDER BY TotalDeathCount DESC;

-- Retrieve continents with the highest death count.
SELECT
    continent,
    MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%states%'
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY TotalDeathCount DESC;


-- Calculate the average death percentage for each continent.
-- This query provides an overview of the average death percentage on different continents.

SELECT
    continent,
    AVG((CAST(total_deaths AS DECIMAL) / CAST(total_cases AS DECIMAL)) * 100) AS AverageDeathPercentage
FROM PortfolioProject..coviddeaths
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY AverageDeathPercentage DESC;
