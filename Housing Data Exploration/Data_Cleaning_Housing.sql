/*

Data Cleaning
Maryam Abazari

*/
USE PortfolioProject;

Select *
From PortfolioProject.nashvillehousing;

-- ***************************************************************************** --

-- Standardize Date Format
-- The saledate column typ eis string. First, I converted the string to date, then I changed the date format to be as '%Y-%m-%d'

SELECT SaleDate, DATE_FORMAT(STR_TO_DATE(SaleDate, '%M %d, %Y'), '%Y-%m-%d') AS formatted_saledate
From PortfolioProject.nashvillehousing;

-- update the saleDate column
Update NashvilleHousing
SET SaleDate = DATE_FORMAT(STR_TO_DATE(SaleDate, '%M %d, %Y'), '%Y-%m-%d');

Select SaleDate
From PortfolioProject.nashvillehousing;

-- ***************************************************************************** --

-- Fill the null values in PropertyAddress column 
Select *
From PortfolioProject.nashvillehousing
-- Where PropertyAddress is null
order by ParcelID;


-- Each property has the same parcel ID. we can use this fact to populate the PropertyAddress column. 
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, IFNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.nashvillehousing a
JOIN PortfolioProject.nashvillehousing b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID  <> b.UniqueID 
Where a.PropertyAddress is null;


Update a
SET PropertyAddress = IFNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.nashvillehousing  a
JOIN PortfolioProject.nashvillehousing  b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID 
Where a.PropertyAddress is null

-- ***************************************************************************** --

-- Breaking out Address into three Columns (Address, City)

Select PropertyAddress
From PortfolioProject.nashvillehousing

-- Split the PropertyAddress column by address and city
SELECT PropertyAddress,
 TRIM(SUBSTRING_INDEX(PropertyAddress, ',', 1)) AS address,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(PropertyAddress, ',', -1), ' ', 2)) AS city
From PortfolioProject.nashvillehousing

-- Add the two new columns to the table
ALTER TABLE nashvillehousing
Add column PropertySplitAddress Nvarchar(255),
Add column PropertySplitCity Nvarchar(255);

Update nashvillehousing
SET PropertySplitAddress = TRIM(SUBSTRING_INDEX(PropertyAddress, ',', 1)),
PropertySplitCity = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(PropertyAddress, ',', -1), ' ', 2));


Select *
From PortfolioProject.nashvillehousing;

-- ***************************************************************************** --
-- Breaking out OwnerAddress into three Columns (Address, City, State)
Select OwnerAddress
From PortfolioProject.nashvillehousing;

Select
OwnerAddress,
TRIM(SUBSTRING_INDEX(OwnerAddress, ',', 1)),
TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1)),
TRIM(SUBSTRING_INDEX(OwnerAddress, ' ', -1))
From PortfolioProject.nashvillehousing;

-- Add new columns to the table
ALTER TABLE nashvillehousing
ADD COLUMN OwnerSplitaddress VARCHAR(255),
ADD COLUMN OwnerSplitcity VARCHAR(255),
ADD COLUMN OwnerSplitstate VARCHAR(2);

-- Update the new columns with the parsed values
UPDATE nashvillehousing
SET
    OwnerSplitaddress = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', 1)),
    OwnerSplitcity = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1)),
    OwnerSplitstate = TRIM(SUBSTRING_INDEX(OwnerAddress, ' ', -1));

-- ***************************************************************************** --


-- Change Y and N to Yes and No in "Sold as Vacant" column

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject.nashvillehousing
Group by SoldAsVacant
order by 2;



Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From PortfolioProject.nashvillehousing;


Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END;

-- ***************************************************************************** --

-- Remove Duplicates
-- using a Common Table Expression (CTE)
-- If ParcelID, PropertyAddress, SalePrice, SaleDate and LegalReference of rows are the same we consider them as duplicate

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject.nashvillehousing
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress;



Select *
From PortfolioProject.nashvillehousing;
-- ***************************************************************************** --
-- Delete Unused Columns


Select *
From PortfolioProject.nashvillehousing;


ALTER TABLE PortfolioProject.nashvillehousing
DROP COLUMN OwnerAddress,
DROP COLUMN TaxDistrict,
DROP COLUMN PropertyAddress,
DROP COLUMN SaleDate;

-- ***************************************************************************** --



