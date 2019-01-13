CREATE TABLE [dbo].[ManifestItems]
(
    [ManifestItemID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [ShipmentID] INT NOT NULL, 
    [ProductID] INT NOT NULL, 
    [ShipQuantity] SMALLINT NOT NULL, 
    CONSTRAINT [FK_ManifestItems_ToShipments] FOREIGN KEY ([ShipmentID]) REFERENCES [Shipments]([ShipmentID]), 
    CONSTRAINT [FK_ManifestItems_ToProducts] FOREIGN KEY ([ProductID]) REFERENCES [Products]([ProductID])
)
