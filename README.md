This set of SQL queries analyzes COVID-19 data from the "CovidDeaths" and "CovidVaccinations" tables. The queries focus on various aspects such as total cases, total deaths, death percentage, infection rates, vaccination statistics, and more.

Queries Overview:
Select Data:

Selects relevant columns from the "CovidDeaths" table, ordering by location and date.
Total Cases Vs. Total Deaths in America:

Calculates the death percentage in America based on total cases and total deaths.
Total Cases Vs. Population:

Calculates the percentage of the population that has had COVID-19 in American states.
Countries with Highest Infection Rates Compared to Population:

Identifies countries with the highest infection rates relative to their populations.
Countries with Highest Death Count per Population:

Lists countries with the highest death count per population.
Total Deaths by Continent:

Presents the total death count for each continent.
Global Death Statistics:

Provides global death statistics, including total cases, total deaths, and global death percentage.
Join Two Tables:

Joins the "CovidDeaths" and "CovidVaccinations" tables.
Total Population, Daily Vaccinations, and Total Vaccinations in America:

Retrieves data on population, daily vaccinations, and total vaccinations in American states.
Calculate Percent Vaccinated Using CTE:

Utilizes a Common Table Expression (CTE) to calculate the percentage of the population vaccinated.
Creating a Temporary Table:

Creates and populates a temporary table "#PercentPopulationVaccinatedAmerica" with vaccination data.
American Vaccination Percentage View:

Creates a view "TotalAmericanVaccinations" using a CTE, showing the percentage of the population vaccinated in American states.
Note: Ensure the data in the "CovidDeaths" and "CovidVaccinations" tables is appropriate and up-to-date for accurate analysis as of April 20, 2021.
