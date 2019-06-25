CREATE TABLE [dbo].[Employees] (
    [EmployeeID]      INT             IDENTITY (1, 1) NOT NULL,
    [LastName]        NVARCHAR (20)   NOT NULL,
    [FirstName]       NVARCHAR (10)   NOT NULL,
    [TitleOfCourtesy] NVARCHAR (25)   NULL,
    [JobTitle]        NVARCHAR (30)   NULL,
    [ReportsTo]       INT             NULL,
    [HireDate]        DATETIME        NOT NULL,
    [OfficePhone]     NVARCHAR (24)   NULL,
    [Extension]       NVARCHAR (4)    NULL,
    [BirthDate]       DATETIME        NOT NULL,
    [AddressID]       INT             NOT NULL,
    [HomePhone]       NVARCHAR (24)   NOT NULL,
    [Photo]           VARBINARY (MAX) NULL,
    [PhotoMimeType]   NVARCHAR (40)   NULL,
    [Notes]           NTEXT           NULL,
    [Active]          BIT             CONSTRAINT [DF__Employees__Activ__5535A963] DEFAULT ((1)) NULL,
    [TerminationDate] DATETIME        NULL,
    [OnLeave]         BIT             CONSTRAINT [DF__Employees__OnLea__5629CD9C] DEFAULT ((0)) NOT NULL,
    [LeaveReason]     NVARCHAR (80)   NULL,
    [ReturnDate]      DATETIME        NULL,
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([EmployeeID] ASC),
    CONSTRAINT [CK_Birthdate] CHECK ([BirthDate]<getdate()),
    CONSTRAINT [CK_Categories_Photo_MimeType] CHECK ([Photo] IS NULL AND [PhotoMimeType] IS NULL OR [Photo] IS NOT NULL AND [PhotoMimeType] IS NOT NULL),
    CONSTRAINT [FK_Employees_Addresses] FOREIGN KEY ([AddressID]) REFERENCES [dbo].[Addresses] ([AddressID]),
    CONSTRAINT [FK_Employees_Employees] FOREIGN KEY ([ReportsTo]) REFERENCES [dbo].[Employees] ([EmployeeID])
);




GO
CREATE NONCLUSTERED INDEX [LastName]
    ON [dbo].[Employees]([LastName] ASC);


GO


