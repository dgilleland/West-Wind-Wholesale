CREATE PROCEDURE [dbo].[Products_GetByPriceRange]
    @MinPrice money,
    @MaxPrice money
AS

IF @MinPrice IS NULL OR @MaxPrice IS NULL
BEGIN
    RAISERROR('Min and Max prices are both required (cannot be empty)',16,1)
END
ELSE
BEGIN
    IF @MinPrice > @MaxPrice
    BEGIN
        RAISERROR('Min price cannot be greater than the max price',16,1)
    END
    ELSE
    BEGIN
        SELECT
            [ProductID],
            [ProductName],
            [SupplierID],
            [CategoryID],
            [QuantityPerUnit],
            [MinimumOrderQuantity],
            [UnitPrice],
            [UnitsOnOrder],
            [Discontinued]
        FROM Products
    WHERE
        UnitPrice BETWEEN @MinPrice AND @MaxPrice
    END
END