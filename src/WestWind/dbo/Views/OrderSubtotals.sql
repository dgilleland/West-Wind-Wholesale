create view "OrderSubtotals" AS
SELECT OrderID,
       SUM(ExtendedPrice) AS 'Subtotal'
FROM ExtendedOrderDetails
GROUP BY OrderID