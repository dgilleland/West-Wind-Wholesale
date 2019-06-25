
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
	[ShipAddressID],
	[Comments]
FROM Orders
WHERE
	[CustomerID]=@CustomerID
