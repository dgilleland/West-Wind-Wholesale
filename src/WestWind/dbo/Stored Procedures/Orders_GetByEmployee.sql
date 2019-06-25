
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
	[ShipAddressID],
	[Comments]
FROM Orders
WHERE
	[SalesRepID]=@EmployeeID
