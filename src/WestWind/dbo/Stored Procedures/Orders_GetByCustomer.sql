
CREATE PROCEDURE [dbo].[Orders_GetByCustomer]
	@CustomerID nchar(5)
AS

SELECT
	[OrderID],
	[CustomerID],
	[SalesRepID],
	[OrderDate],
	[RequiredDate],
	[Freight],
	[ShipName],
	[ShipAddress],
	[ShipCity],
	[ShipRegion],
	[ShipPostalCode],
	[ShipCountry]
FROM Orders
WHERE
	[CustomerID]=@CustomerID