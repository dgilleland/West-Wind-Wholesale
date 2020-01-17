CREATE TABLE [dbo].[Suppliers] (
    [SupplierID]   INT           IDENTITY (1, 1) NOT NULL,
    [CompanyName]  NVARCHAR (40) NOT NULL,
    [ContactName]  NVARCHAR (30) NOT NULL,
    [ContactTitle] NVARCHAR (30) NULL,
    [Email]        NVARCHAR (50) NOT NULL,
    [AddressID]    INT           NOT NULL,
    [Phone]        NVARCHAR (24) NOT NULL,
    [Fax]          NVARCHAR (24) NULL,
    CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED ([SupplierID] ASC),
    CONSTRAINT [FK_Suppliers_Addresses] FOREIGN KEY ([AddressID]) REFERENCES [dbo].[Addresses] ([AddressID]),
    CONSTRAINT [UX_Suppliers_AddressID] UNIQUE ([AddressID])
);




GO
CREATE NONCLUSTERED INDEX [CompanyName]
    ON [dbo].[Suppliers]([CompanyName] ASC);


GO


