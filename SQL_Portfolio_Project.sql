select *
From SQLProject..covidvaccines
order by 3,4

select location,date,total_cases,new_cases,total_deaths,population
From SQLProject..CovidDeaths
order by 1,2


--Looking at the total cases vs total deaths
--Shows the likelihood of dying if you cotract covid in your country
select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From SQLProject..CovidDeaths
where location like '%states%'
order by 1,2



--Looking at the Total Cases vs Population
--Shows what percentage of population got Covid

select location,date,population,total_cases, (total_cases/population)*100 as CasesPercentage
From SQLProject..CovidDeaths
where location like '%states%'
order by 1,2


--Looking at Countries with Highest Infection Rate Compared to Population

select location,population,MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From SQLProject..CovidDeaths
--where location like '%states%'
Group by location,population
order by PercentPopulationInfected desc

--Showing Countries with Highest Death Per Population

select location,MAX(total_deaths) as TotalDeathCount
From SQLProject..CovidDeaths
where continent is not null
--where location like '%states%'
Group by location,population
order by TotalDeathCount desc

--Breaking Down by Continent

select continent,MAX(total_deaths) as TotalDeathCount
From SQLProject..CovidDeaths
where continent is not null
--where location like '%states%'
Group by continent
order by TotalDeathCount desc


--Showing continents with highest death count per population

select continent,MAX(total_deaths) as TotalDeathCount
From SQLProject..CovidDeaths
where continent is not null
--where location like '%states%'
Group by continent
order by TotalDeathCount desc




--Global Numbers
select SUM(new_cases) as total_cases,SUM(new_deaths) as total_deaths,SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
from SQLProject..CovidDeaths
where continent is not null
--group by date
order by 1,2


select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations
From SQLProject..CovidDeaths dea
Join SQLProject..covidvaccines vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3


select *
From SQLProject..covid_vaccine


select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations
From SQLProject..CovidDeaths dea
Join SQLProject..covid_vaccine vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3


--Looking at Total Population vs Vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(convert(int,vac.new_vaccinations)) OVER ( Partition by dea.location )
From SQLProject..CovidDeaths dea
Join SQLProject..covid_vaccine vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3

--Crating View

Create View Vaccinations as
select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations
From SQLProject..CovidDeaths dea
Join SQLProject..covid_vaccine vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3


Select * from Vaccinations

select * 
From SQLProject..covidvaccines


select location, MAX(new_vaccinations)/MAX(population)*100
from Vaccinations
group by location

select location, SUM(convert(int,new_vaccinations))/MAX(population)*100
from Vaccinations
group by location

select location, MAX(new_vaccinations)
from SQLProject..covid_vaccine
where new_vaccinations not like 'NULL'
group by location
