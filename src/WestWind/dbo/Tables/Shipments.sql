CREATE TABLE [dbo].[Shipments]
(
    [ShipmentID] INT NOT NULL PRIMARY KEY, 
    [OrderID] INT NOT NULL, 
    [ShippedDate] DATETIME NOT NULL, 
    [ShipVia] INT NOT NULL, 
    [FreightCharge] MONEY NOT NULL, 
    [TrackingCode] VARCHAR(128) NULL
)
