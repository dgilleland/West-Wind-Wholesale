
CREATE PROCEDURE [dbo].[Orders_GetByEmployee]
	@EmployeeID int
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
	[SalesRepID]=@EmployeeID