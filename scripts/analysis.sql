/*

Analysis Queries

*/

-- Average Sale Price by Year

SELECT YEAR(SaleDateConverted) AS SaleYear,
       AVG(SalePrice) AS AvgSalePrice
FROM PortfolioProject.dbo.NashvilleHousing
WHERE SalePrice > 0
GROUP BY YEAR(SaleDateConverted)
ORDER BY SaleYear;


-- Average Sale Price by Neighborhood (PropertyCity)

SELECT PropertyCity,
       AVG(SalePrice) AS AvgSalePrice,
       COUNT(*) AS TotalSales
FROM PortfolioProject.dbo.NashvilleHousing
WHERE SalePrice > 0
GROUP BY PropertyCity
ORDER BY AvgSalePrice DESC;

-- Top 10 Most Expensive Parcels

SELECT TOP 10 ParcelID,
       PropertyStreet,
       PropertyCity,
       MAX(SalePrice) AS MaxSalePrice
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY ParcelID, PropertyStreet, PropertyCity
ORDER BY MaxSalePrice DESC;

-- Distribution of Sales (Vacant vs Non-Vacant)

SELECT SoldAsVacant,
       COUNT(*) AS NumSales,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS Percentage
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY SoldAsVacant;


-- Window Functions: Ranking Expensive Properties per City
SELECT PropertyCity,
       PropertyStreet,
       SalePrice,
       RANK() OVER (PARTITION BY PropertyCity ORDER BY SalePrice DESC) AS RankInCity
FROM PortfolioProject.dbo.NashvilleHousing
WHERE SalePrice > 0;