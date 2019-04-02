
CREATE PROCEDURE [dbo].[Orders_GetByShipper]
	@ShipVia int
AS

SELECT
	O.[OrderID],
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
	[ShipCountry],
	[Comments]
FROM Orders O
INNER JOIN Shipments S ON O.OrderID = S.OrderID
WHERE
	[ShipVia]=@ShipVia
