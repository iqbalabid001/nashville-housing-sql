-- Create a View for Reusable Analysis

CREATE OR ALTER VIEW vw_Nashville_SalesSummary AS
SELECT PropertyCity,
       YEAR(SaleDateConverted) AS SaleYear,
       AVG(SalePrice) AS AvgSalePrice,
       COUNT(*) AS NumSales
FROM PortfolioProject.dbo.NashvilleHousing
WHERE SalePrice > 0
GROUP BY PropertyCity, YEAR(SaleDateConverted);

-- Use view
SELECT * FROM vw_Nashville_SalesSummary
WHERE SaleYear >= 2015
ORDER BY AvgSalePrice DESC;

-- Stored Procedure: Top Properties by City

CREATE OR ALTER PROCEDURE sp_TopPropertiesByCity 
    @City NVARCHAR(255), 
    @TopN INT
AS
BEGIN
    SELECT TOP (@TopN) PropertyStreet,
                       SalePrice,
                       SaleDateConverted
    FROM PortfolioProject.dbo.NashvilleHousing
    WHERE LTRIM(RTRIM(UPPER(PropertyCity))) = UPPER(@City)
    ORDER BY SalePrice DESC;
END;

-- Execute
EXEC sp_TopPropertiesByCity @City = 'NASHVILLE', @TopN = 5;