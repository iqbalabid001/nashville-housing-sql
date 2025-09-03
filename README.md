# Nashville Housing Data Cleaning and Analysis (SQL)

This project focuses on cleaning and analyzing housing sales data from Nashville, Tennessee. The dataset contains property sales records, 
including details like addresses, sale dates, sale prices, and whether properties were sold as vacant.
The goal is to transform messy, incomplete, and inconsistent data into a clean format that’s ready for meaningful analysis.

---

## Dataset Information

* **Source**: Nashville Housing Dataset (public dataset often used for SQL/data cleaning projects)
* **Size**: \~56,000 property sales records
* **Key Columns**:

  * `UniqueID` → unique identifier for each record
  * `ParcelID` → property parcel identifier
  * `PropertyAddress` → address of the property sold
  * `OwnerAddress` → address of the property owner
  * `SaleDate` → date the property was sold (messy format initially)
  * `SalePrice` → price at which the property was sold
  * `LegalReference` → legal reference for the transaction
  * `SoldAsVacant` → whether the property was sold as vacant (`Y`, `N`, Yes/No)

##  Data Cleaning Workflow

### Standardize Date Format

* Converted `SaleDate` from text format into a proper SQL `DATE` column.
* Added a new column `SaleDateConverted` to store clean date values.

### 2. Handle Missing Property Addresses

* Some properties had missing addresses.
* Filled missing values by matching rows with the same `ParcelID` and borrowing the address from duplicate entries.

### 3. Split Property Address into Columns

* Broke `PropertyAddress` into separate fields:

  * `PropertyStreet`
  * `PropertyCity`

### 4. Split Owner Address into Columns

* Broke `OwnerAddress` into:

  * `OwnerSplitAddress`
  * `OwnerSplitCity`
  * `OwnerSplitState`

### 5. Standardize "Sold As Vacant" Field

* Replaced inconsistent values:

  * `Y` → `Yes`
  * `N` → `No`

### 6. Remove Duplicates

* Used `ROW_NUMBER()` with `PARTITION BY` to identify and remove duplicate records based on `ParcelID`, `PropertyAddress`, `SalePrice`, `SaleDate`, and `LegalReference`.

### 7. Drop Unused Columns

* Removed unnecessary fields after splitting/cleaning:

  * `OwnerAddress`, `TaxDistrict`, `PropertyAddress`, `SaleDate`

### 8. Check for Outliers

* Identified properties with unusual sale prices (e.g., < \$1,000 or > \$50,000,000).

---

## Analysis Queries

Once the data was cleaned, several analysis queries were created:

1. **Average Sale Price by Year**

   * Understand trends in property prices over time.

2. **Average Sale Price by Neighborhood (City)**

   * Compare housing markets across different Nashville neighborhoods.

3. **Top 10 Most Expensive Parcels**

   * Identify high-value properties.

4. **Sales Distribution (Vacant vs. Non-Vacant)**

   * Check what percentage of sales were vacant vs occupied properties.

5. **Ranking Expensive Properties per City**

   * Used window functions to rank properties within each city.

6. **View: Sales Summary**

   * Created a reusable SQL view `vw_Nashville_SalesSummary` to show sales by year and city.

7. **Stored Procedure: Top Properties by City**

   * A parameterized stored procedure `sp_TopPropertiesByCity` returns the top N most expensive properties in a given city.

---

## How to Use

1. Import the dataset into your SQL Server database under:

   ```
   PortfolioProject.dbo.NashvilleHousing
   ```
2. Run the cleaning scripts step by step (Cleaning, Analysis, then Views and stored procedures).
3. Use the analysis queries to explore the cleaned dataset.
4. Run the stored procedure for insights, e.g.:

   ```sql
   EXEC sp_TopPropertiesByCity @City = 'NASHVILLE', @TopN = 5;
   ```
---

## Results

* Clean, standardized dataset ready for analysis.
* Reusable queries, views, and stored procedures for housing market insights.
* A workflow that can be adapted for other real estate datasets.

