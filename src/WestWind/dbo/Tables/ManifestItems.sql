CREATE TABLE [dbo].[ManifestItems]
(
    [ManifestItemID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [ShipmentID] INT NOT NULL, 
    [ProductID] INT NOT NULL, 
    [ShipQuantity] SMALLINT NOT NULL
)
