-- Select Data that we are going to use
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
Order BY 1,2;


-- Total Cases Vs. Total Deaths (Death Percentage) in America
SELECT location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM CovidDeaths
WHERE location like '%states%'
Order BY 1,2;


-- Total Cases Vs. Population 
-- What percentage has had COVID
SELECT location, date, total_cases, population, (total_cases/population)*100 AS PercentInfectedPopulation
FROM CovidDeaths
WHERE location like '%states%'
Order BY 1,2;

-- Countries with higesht infection rates compared to Population rate
SELECT location, MAX(total_cases) as HighestInfectionCount, population, MAX((total_cases/population))*100 AS HighestInfection
FROM CovidDeaths
GROUP BY population, location
ORDER BY HighestInfection DESC;


-- Countries with Highest Death Count per Population 
SELECT location, MAX(CAST(total_deaths as int)) as TotalDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC;


-- Total Deaths by Continent
SELECT continent, MAX(CAST(total_deaths as int)) as TotalDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC;


-- GLOBAL DEATH STATS
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths as int)) AS total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 AS GlobalDeathPercentage
FROM CovidDeaths
WHERE continent is not null
ORDER BY 1,2;


-- Join the Two Tables
SELECT * 
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location and dea.date = vac.date


-- Total Population, Daily Vaccinations and Total Vaccinations in America
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations AS DailyVaccinations, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS TotalVaccinations
FROM CovidDeaths dea 
JOIN CovidVaccinations vac 
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL AND dea.location LIKE '%states%'


 -- USE CTE to Figure out Percent Vaccinated
 WITH PopvsVac (continent, location, date, population, new_vaccinations, TotalVaccinations)
 AS
 (SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations AS DailyVaccinations, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS TotalVaccinations
FROM CovidDeaths dea 
JOIN CovidVaccinations vac 
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL AND dea.location LIKE '%states%')
SELECT *, ROUND((TotalVaccinations/population),4)*100 AS PercentVaccinated
FROM PopvsVac;


-- Creating a Temp Table 
DROP TABLE IF EXISTS #PercentPopulationVaccinatedAmerica
CREATE TABLE #PercentPopulationVaccinatedAmerica
( 
continent NVARCHAR(255),
location NVARCHAR(255),
date datetime,
population numeric, 
new_vaccinations numeric,
TotalVaccinations numeric,
)

INSERT INTO #PercentPopulationVaccinatedAmerica
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations AS DailyVaccinations, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS TotalVaccinations
FROM CovidDeaths dea 
JOIN CovidVaccinations vac 
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL AND dea.location LIKE '%states%'

SELECT *, (TotalVaccinations/population)*100 AS PercentVaccinated
FROM #PercentPopulationVaccinatedAmerica;


-- American Vaccination Percentage View
CREATE VIEW TotalAmericanVaccinations AS
 WITH PopvsVac (continent, location, date, population, new_vaccinations, TotalVaccinations)
 AS
 (SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations AS DailyVaccinations, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS TotalVaccinations
FROM CovidDeaths dea 
JOIN CovidVaccinations vac 
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL AND dea.location LIKE '%states%')
SELECT *, ROUND((TotalVaccinations/population),4)*100 AS PercentVaccinated
FROM PopvsVac;


