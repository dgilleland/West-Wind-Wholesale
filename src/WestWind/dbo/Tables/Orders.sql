CREATE TABLE [dbo].[Orders] (
    [OrderID]        INT            IDENTITY (1, 1) NOT NULL,
    [SalesRepID]     INT            NULL,
    [CustomerID]     NCHAR (5)      NOT NULL,
    [OrderDate]      DATETIME       NULL,
    [RequiredDate]   DATETIME       NULL,
    [PaymentDueDate] DATETIME       NULL,
    [Freight]        MONEY          CONSTRAINT [DF_Orders_Freight] DEFAULT ((0)) NULL,
    [Shipped]        BIT            CONSTRAINT [DF__Orders__Shipped__5AEE82B9] DEFAULT ((0)) NOT NULL,
    [ShipName]       NVARCHAR (40)  NULL,
    [ShipAddressID]  INT            NULL,
    [Comments]       NVARCHAR (250) NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC),
    CONSTRAINT [FK_Orders_Addresses] FOREIGN KEY ([ShipAddressID]) REFERENCES [dbo].[Addresses] ([AddressID]),
    CONSTRAINT [FK_Orders_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID]),
    CONSTRAINT [FK_Orders_Employees] FOREIGN KEY ([SalesRepID]) REFERENCES [dbo].[Employees] ([EmployeeID])
);




GO
CREATE NONCLUSTERED INDEX [CustomerID]
    ON [dbo].[Orders]([CustomerID] ASC);


GO
CREATE NONCLUSTERED INDEX [CustomersOrders]
    ON [dbo].[Orders]([CustomerID] ASC);


GO
CREATE NONCLUSTERED INDEX [EmployeeID]
    ON [dbo].[Orders]([SalesRepID] ASC);


GO
CREATE NONCLUSTERED INDEX [EmployeesOrders]
    ON [dbo].[Orders]([SalesRepID] ASC);


GO
CREATE NONCLUSTERED INDEX [OrderDate]
    ON [dbo].[Orders]([OrderDate] ASC);


GO




