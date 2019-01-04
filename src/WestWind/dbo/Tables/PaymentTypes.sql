CREATE TABLE [dbo].[PaymentTypes] (
    [PaymentTypeID]          TINYINT      IDENTITY (10, 1) NOT NULL,
    [PaymentTypeDescription] VARCHAR (40) NOT NULL,
    CONSTRAINT [PK_PTYP_PayTypeID] PRIMARY KEY CLUSTERED ([PaymentTypeID] ASC)
);

