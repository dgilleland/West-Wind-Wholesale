CREATE VIEW dbo.InvoiceItems
AS
SELECT      dbo.Orders.ShipName,
            SA.Address AS 'ShipAddress',
            SA.City AS 'ShipCity',
            SA.Region AS 'ShipRegion',
            SA.PostalCode AS 'ShipPostalCode',
            SA.Country AS 'ShipCountry',
            dbo.Orders.CustomerID,
            dbo.Customers.CompanyName,
            A.Address,
            A.City,
            A.Region,
            A.PostalCode,
            A.Country,
            LTRIM(dbo.Employees.FirstName + ' ' + dbo.Employees.LastName) AS 'SalesRep',
            dbo.Orders.OrderID,
            dbo.Orders.OrderDate,
            dbo.Orders.RequiredDate,
            dbo.OrderDetails.ProductID,
            dbo.Products.ProductName,
            dbo.OrderDetails.UnitPrice,
            dbo.OrderDetails.Quantity,
            dbo.Products.QuantityPerUnit,
            dbo.OrderDetails.Discount,
            CONVERT(MONEY, (dbo.OrderDetails.UnitPrice * dbo.OrderDetails.Quantity) 
                         * (1 - dbo.OrderDetails.Discount) / 100) * 100 AS ExtendedPrice,
            dbo.Orders.Freight
FROM        dbo.Products
INNER JOIN  dbo.OrderDetails ON dbo.Products.ProductID = dbo.OrderDetails.ProductID
INNER JOIN  dbo.Orders ON dbo.Orders.OrderID = dbo.OrderDetails.OrderID
INNER JOIN  dbo.Employees ON dbo.Employees.EmployeeID = dbo.Orders.SalesRepID
INNER JOIN  dbo.Customers ON dbo.Customers.CustomerID = dbo.Orders.CustomerID
INNER JOIN  dbo.Addresses AS SA ON dbo.Orders.ShipAddressID = SA.AddressID
INNER JOIN  dbo.Addresses AS A ON dbo.Customers.AddressID = A.AddressID

GO
