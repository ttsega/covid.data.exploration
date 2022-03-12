Select *
From PortfolioProject..CovidDeaths
order by 3,4
Select *
From PortfolioProject..CovidVaccinations
order by 3,4

--Select Data that we are going to be using 

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2

--Looking at Total Cases vs Total Deaths
--Shows liklihood of dying if one contracts covid in U.S.

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
From PortfolioProject..CovidDeaths
Where location like '%United States%'
order by 1,2


--Looking at Total Cases vs Population
--Shows what percentage of population got covid

Select Location, date, Population, total_cases, (total_cases/population)*100 as Pecent_Pop_Infected
From PortfolioProject..CovidDeaths
Where location like '%United States%'
order by 1,2


-- Looking at countries with highest infection rate compared to population

Select Location, Population, MAX(total_cases) as Highest_Infection_Count, MAX((total_cases/population))*100 as Pecent_Pop_Infected
From PortfolioProject..CovidDeaths
Group by location, Population
order by Pecent_Pop_Infected desc

--Showing countries with highest death count per population

Select Location, MAX(cast(Total_deaths as int)) as Total_Death_Count
From PortfolioProject..CovidDeaths
Where continent is not null
Group by Location
order by Total_Death_Count desc

----Now by continent

Select continent, MAX(cast(Total_deaths as int)) as Total_Death_Count
From PortfolioProject..CovidDeaths
Where continent is not null
Group by continent
order by Total_Death_Count desc

--Now globally

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Death_Percentage
From PortfolioProject..CovidDeaths
Where continent is not null
order by 1,2


--Looking at total pop vs vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

