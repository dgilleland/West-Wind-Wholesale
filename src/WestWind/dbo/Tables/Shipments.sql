CREATE TABLE [dbo].[Shipments]
(
    [ShipmentID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [OrderID] INT NOT NULL, 
    [ShippedDate] DATETIME NOT NULL, 
    [ShipVia] INT NOT NULL, 
    [FreightCharge] MONEY NOT NULL, 
    [TrackingCode] VARCHAR(128) NULL, 
    CONSTRAINT [FK_Shipments_ToTShippers] FOREIGN KEY ([ShipVia]) REFERENCES [Shippers]([ShipperID]), 
    CONSTRAINT [FK_Shipments_ToOrders] FOREIGN KEY ([OrderID]) REFERENCES [Orders]([OrderID])
)
