using System;
using System.Linq;
using WestWind.DataPopulation.Db;
using WestWind.DataPopulation.Db.Views;

namespace WestWind.DataPopulation
{
    public class Invoicing
    {
        public static void PayInvoices()
        {
            // Policy of setting the payment due date to at least 28 days after the order date, unless the required date is longer than 28 days away. In that case, we will add a week at a time until the required date is passed.
            SetPaymentDueDate();
            MakePayments();
        }
        static Random Rnd = new Random();
        static void MakePayments()
        {
            using (var context = new WestWindContext())
            {
                if (!context.Payments.Any())
                {
                    context.Database.ExecuteSqlCommand("ALTER TABLE Payments NOCHECK CONSTRAINT [CK_PAY_PDate_Not_Old]");
                    var subtotals = context.Database.SqlQuery<OrderSubtotal>(OrderSubtotal.Query);
                    var methods = context.PaymentTypes.Select(x => x.PaymentTypeID).ToList();
                    foreach (var order in subtotals)
                    {
                        var ord = context.Orders.Find(order.OrderID);
                        if (ord.Shipped)
                        {
                            // Make payment(s)
                            var amountDue = order.Subtotal + (ord.Freight.HasValue ? ord.Freight.Value : 0m);
                            var date = ord.PaymentDueDate.Value.AddDays(Rnd.Next(4) * -1);
                            var method = methods[Rnd.Next(methods.Count)];

                            var pay = new Payment
                            {
                                Amount = amountDue,
                                OrderID = order.OrderID,
                                PaymentDate = date,
                                PaymentTypeID = method,
                                TransactionID = Guid.NewGuid()
                            };
                            if (date.AddDays(14) < DateTime.Today)
                                pay.ClearedDate = date.AddDays(Rnd.Next(3, 14));
                            context.Payments.Add(pay);
                            Console.WriteLine($"Paying order {pay.OrderID} - {pay.Amount:C}");
                        }
                    }
                    context.SaveChanges();
                    context.Database.ExecuteSqlCommand("ALTER TABLE Payments CHECK CONSTRAINT [CK_PAY_PDate_Not_Old]");
                    context.SaveChanges();
                }
            }
        }
        static void SetPaymentDueDate()
        {
            using (var context = new WestWindContext())
            {
                if (!context.Payments.Any())
                {
                    foreach (var order in context.Orders)
                    {
                        if (order.OrderDate.HasValue && order.RequiredDate.HasValue)
                        {
                            var due = order.OrderDate.Value.AddDays(28);
                            while (due < order.RequiredDate) due = due.AddDays(7);
                            order.PaymentDueDate = due;
                        }
                    }
                    context.SaveChanges();
                }
            }
        }
    }
}
