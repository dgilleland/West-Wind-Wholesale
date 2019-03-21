
CREATE PROCEDURE [dbo].[Products_GetByPartialProductName]
	@PartialName varchar(40)
AS

SELECT
	[ProductID],
	[ProductName],
	[SupplierID],
	[CategoryID],
	[QuantityPerUnit],
    [MinimumOrderQuantity],
	[UnitPrice],
	[UnitsOnOrder],
	[Discontinued]
FROM Products
WHERE
	[ProductName] LIKE '%' + @PartialName + '%'