CREATE TABLE [dbo].[Payments] (
    [PaymentID]     INT            IDENTITY (10000, 1) NOT NULL,
    [PaymentDate]   DATETIME       CONSTRAINT [DF_PAY_PDate_Today] DEFAULT (getdate()) NOT NULL,
    [Amount]        SMALLMONEY CONSTRAINT [DF_PAY_PayAmt_0] DEFAULT ((0)) NOT NULL,
    [PaymentTypeID] TINYINT        NOT NULL,
    [OrderID]     INT            NOT NULL,
    [TransactionID] UNIQUEIDENTIFIER NOT NULL, 
    [ClearedDate] DATETIME NULL, 
    CONSTRAINT [PK_PAY_PayID] PRIMARY KEY CLUSTERED ([PaymentID] ASC),
    CONSTRAINT [CK_PAY_PayAmt_GE0] CHECK ([Amount]>=(0)),
    CONSTRAINT [CK_PAY_PDate_Not_Old] CHECK ([PaymentDate]>=getdate()),
    CONSTRAINT [FK_PAY_PTYP_PayTypeID] FOREIGN KEY ([PaymentTypeID]) REFERENCES [dbo].[PaymentTypes] ([PaymentTypeID]), 
    CONSTRAINT [FK_Payments_ToTable] FOREIGN KEY ([OrderID]) REFERENCES [Orders]([OrderID])
);

