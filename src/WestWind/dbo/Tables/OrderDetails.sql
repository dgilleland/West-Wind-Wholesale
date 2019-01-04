CREATE TABLE [dbo].[OrderDetails] (
    [OrderDetailID] INT NOT NULL IDENTITY, 
    [OrderID]   INT      NOT NULL,
    [ProductID] INT      NOT NULL,
    [UnitPrice] MONEY    CONSTRAINT [DF_Order_Details_UnitPrice] DEFAULT ((0)) NOT NULL,
    [Quantity]  SMALLINT CONSTRAINT [DF_Order_Details_Quantity] DEFAULT ((1)) NOT NULL,
    [Discount]  REAL     CONSTRAINT [DF_Order_Details_Discount] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [CK_Discount] CHECK ([Discount]>=(0) AND [Discount]<=(1)),
    CONSTRAINT [CK_Quantity] CHECK ([Quantity]>(0)),
    CONSTRAINT [CK_UnitPrice] CHECK ([UnitPrice]>=(0)),
    CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID]),
    CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID]), 
    CONSTRAINT [PK_OrderDetails] PRIMARY KEY ([OrderDetailID])
);


GO
CREATE NONCLUSTERED INDEX [OrderID]
    ON [dbo].[OrderDetails]([OrderID] ASC);


GO
CREATE NONCLUSTERED INDEX [OrdersOrder_Details]
    ON [dbo].[OrderDetails]([OrderID] ASC);


GO
CREATE NONCLUSTERED INDEX [ProductID]
    ON [dbo].[OrderDetails]([ProductID] ASC);


GO
CREATE NONCLUSTERED INDEX [ProductsOrder_Details]
    ON [dbo].[OrderDetails]([ProductID] ASC);

