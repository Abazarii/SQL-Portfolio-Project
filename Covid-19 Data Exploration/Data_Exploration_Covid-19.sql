--- Maryam Abazari ---
--- SQL Data Exploration ---


-- select all the data from coviddeaths table and order it by the third and forth column
Select *
From PortfolioProject.coviddeaths
order by 3,4;


-- Select 6 specific columns that we are going to use
Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject.coviddeaths
order by 1,2;


-- Analyzes the relationship between total cases and total deaths
-- Determines the mortality rate due to COVID-19 in the United States
Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as MortalityRatePercentage
From PortfolioProject.coviddeaths
Where location like '%states%'
order by 1,2;


-- Analyzes the spread of COVID-19 relative to the population size
-- Determines the infection rate as a percentage of the total population
Select Location, date, Population, total_cases,  (total_cases/population)*100 as InfectionRatePercentage
From PortfolioProject.coviddeaths
order by 1,2;


-- Identifies countries with the highest infection rates relative to their population
-- Determines the maximum infection count and the infection rate percentage for each country
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as InfectionRatePercentage
From PortfolioProject.coviddeaths
Group by Location, Population
order by InfectionRatePercentage desc;




-- Identifies countries with the highest death counts due to COVID-19
SELECT Location, MAX(CONVERT(Total_deaths, UNSIGNED INTEGER)) AS TotalDeathCount
FROM PortfolioProject.coviddeaths
-- WHERE location LIKE '%states%'
GROUP BY Location
ORDER BY TotalDeathCount DESC;




-- Selecting the highest death count for each continent
SELECT continent, SUM(new_deaths) AS TotalDeathCount
FROM PortfolioProject.coviddeaths
-- WHERE location LIKE '%states%'
GROUP BY continent
ORDER BY TotalDeathCount DESC;



-- GLOBAL NUMBERS
-- Calculates the total number of new COVID-19 cases and deaths globally
-- Computes the death percentage as a proportion of total new cases
Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject.coviddeaths
-- Where location like '%states%'
-- Group By date
order by 1,2;




-- Join Two Tables
Select *
From PortfolioProject.coviddeaths dea
Join PortfolioProject.covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date;
    
    
    
    
-- Join Two Tables
-- Retrieves details about the COVID-19 vaccinations
-- Computes the cumulative sum of vaccinations for every location by using OVER and PARTITION BY
Select dea.continent, 
	   dea.location, 
	   dea.date, 
	   dea.population, 
	   vac.new_vaccinations,
       SUM(CONVERT(vac.new_vaccinations, UNSIGNED INTEGER)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject.coviddeaths dea
Join PortfolioProject.covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
order by 2,3;
    




-- Join Two Tables
-- Computes the percentage of the population vaccinated 
-- Using CTE to perform Calculation on Partition By in previous query
-- when we want to use a calculated variable and do some other calculations on it, we can use CTE
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, 
	   dea.location, 
       dea.date, 
       dea.population, 
       vac.new_vaccinations, 
       SUM(CONVERT(vac.new_vaccinations, UNSIGNED INTEGER)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject.coviddeaths dea
Join PortfolioProject.covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac;





-- Using Temp Table to perform Calculation on Partition By in previous query
-- Calculates the rolling number of people vaccinated for each location and date

-- Specify the database to use
USE PortfolioProject;

-- Drops the temporary table if it exists to avoid conflicts
DROP Table if exists PercentPopulationVaccinated;
Create Table PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
);

Insert into PercentPopulationVaccinated
Select dea.continent, 
       dea.location, 
       dea.date, 
       dea.population, 
       vac.new_vaccinations, 
       SUM(CONVERT(vac.new_vaccinations, UNSIGNED INTEGER)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject.coviddeaths dea
Join PortfolioProject.covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date;

Select *, (RollingPeopleVaccinated/Population)*100
From PercentPopulationVaccinated;





-- Creating View to store data for later visualizations
DROP View if exists NEW_TABLE;
Create View NEW_TABLE as
SELECT continent, MAX(CONVERT(Total_deaths, UNSIGNED INTEGER)) AS TotalDeathCount
FROM PortfolioProject.coviddeaths
GROUP BY continent
ORDER BY TotalDeathCount DESC;
