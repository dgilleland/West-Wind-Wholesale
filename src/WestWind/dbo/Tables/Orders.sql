CREATE TABLE [dbo].[Orders] (
    [OrderID]        INT           IDENTITY (1, 1) NOT NULL,
    [SalesRepID]     INT           NULL,
    [CustomerID]     NCHAR (5)     NOT NULL,
    [OrderDate]      DATETIME      NULL,
    [RequiredDate]   DATETIME      NULL,
    [Freight]        MONEY         CONSTRAINT [DF_Orders_Freight] DEFAULT ((0)) NULL,
    [ShipName]       NVARCHAR (40) NULL,
    [ShipAddress]    NVARCHAR (60) NULL,
    [ShipCity]       NVARCHAR (15) NULL,
    [ShipRegion]     NVARCHAR (15) NULL,
    [ShipPostalCode] NVARCHAR (10) NULL,
    [ShipCountry]    NVARCHAR (15) NULL,
    [Comments] NVARCHAR(250) NULL, 
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC),
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


CREATE NONCLUSTERED INDEX [ShipPostalCode]
    ON [dbo].[Orders]([ShipPostalCode] ASC);

