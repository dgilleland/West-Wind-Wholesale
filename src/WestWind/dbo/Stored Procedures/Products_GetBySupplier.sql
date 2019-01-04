
CREATE PROCEDURE [dbo].[Products_GetBySupplier]
	@SupplierID int = NULL
AS
IF @SupplierID IS NULL
	BEGIN
		SELECT
			[ProductID],
			[ProductName],
			[SupplierID],
			[CategoryID],
			[QuantityPerUnit],
			[UnitPrice],
			[UnitsOnOrder],
			[Discontinued]
		FROM Products
		WHERE
			[SupplierID] IS NULL
	END
ELSE
	BEGIN	
		SELECT
			[ProductID],
			[ProductName],
			[SupplierID],
			[CategoryID],
			[QuantityPerUnit],
			[UnitPrice],
			[UnitsOnOrder],
			[Discontinued]
		FROM Products
		WHERE
			[SupplierID]=@SupplierID
	END