using System;
using System.Collections.Generic;
using System.Linq;
using WestWind.DataPopulation.Db;
using WestWind.DataPopulation.Db.Views;

namespace WestWind.DataPopulation
{
    public class DateShifting
    {
        public static void CorrectForWeekdays()
        {
            using (var context = new WestWindContext())
            {
                int offset = 0;
                var info = context.Orders.Where(x => x.OrderDate.HasValue).Select(x => x.OrderDate.Value).ToList();
                if (info.Any(x => (x.DayOfWeek == DayOfWeek.Saturday || x.DayOfWeek == DayOfWeek.Sunday)))
                {
                    offset = info.Count(x => x.DayOfWeek == DayOfWeek.Saturday) == 0 ? 1
                           : info.Count(x => x.DayOfWeek == DayOfWeek.Friday) == 0 ? 2
                           : info.Count(x => x.DayOfWeek == DayOfWeek.Thursday) == 0 ? 3
                           : info.Count(x => x.DayOfWeek == DayOfWeek.Wednesday) == 0 ? 4
                           : info.Count(x => x.DayOfWeek == DayOfWeek.Tuesday) == 0 ? 5
                           : 6;
                    var orders = context.Orders;
                    foreach (var order in orders)
                        order.OrderDate = order.OrderDate.Value.AddDays(offset);
                    context.SaveChanges();
                    Console.WriteLine("Fixed order dates");
                }

            }
        }
    }
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
        static void SetPaymentDueDate()
        {
            using (var context = new WestWindContext())
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
    public class Shipping
    {
        public static void ShipOrders()
        {
            int currentShipments = ShipmentCount();
            if (currentShipments == 0)
            {
                var orders = ListOrdersByDate();
                var ids = ListShipperIds();
                foreach (var order in orders)
                {
                    if (order.FreightCharge.HasValue && order.FreightCharge > 0)
                    {
                        var charged = order.FreightCharge.Value;
                        foreach (var shipment in order.Details)
                        {
                            // Divide freight expenses
                            var freight = System.Math.Round(charged * shipment.QuantityCount * 1.0m / order.QuantityCount, 2);
                            shipment.SetFreight(freight);
                            var shipDate = order.OrderedOn.Value.AddDays(Rnd.Next((order.RequiredBy - order.OrderedOn).Value.Days - 7));
                            if (shipDate.DayOfWeek == DayOfWeek.Sunday) shipDate.AddDays(-1);
                            int shipvia = ids[Rnd.Next(ids.Count())];
                            ShipToCustomer(shipment, order.OrderID, shipDate, shipvia);
                        }
                    }
                }
            }
        }

        static int ShipmentCount()
        {
            using (var context = new WestWindContext())
            {
                return context.Shipments.Count();
            }
        }

        static Random Rnd = new Random();

        static List<int> ListShipperIds()
        {
            using (var context = new WestWindContext())
            {
                return context.Shippers.Select(x => x.ShipperID).ToList();
            }
        }

        static void ShipToCustomer(SupplierShipment shipment, int orderId, DateTime shipDate, int shipvia)
        {
            using (var context = new WestWindContext())
            {
                var ship = new Shipment
                {
                    OrderID = orderId,
                    ShippedDate = shipDate,
                    ShipVia = shipvia,
                    FreightCharge = shipment.Freight,
                    TrackingCode = Guid.NewGuid().ToString()
                };
                foreach (var item in shipment.Items)
                    ship.ManifestItems.Add(new ManifestItem
                    {
                        ProductID = item.ProductID,
                        ShipQuantity = item.Quantity
                    });
                context.Shipments.Add(ship);
                context.Orders.Find(orderId).Shipped = true;
                context.SaveChanges();
                System.Console.WriteLine($"{counter++} - {ship.TrackingCode}");
            }
        }

        static int counter = 0;

        static List<OrderShipment> ListOrdersByDate()
        {
            using (var context = new WestWindContext())
            {
                var orders = from order in context.Orders
                             orderby order.OrderDate
                             select new OrderShipment
                             {
                                 OrderID = order.OrderID,
                                 OrderedOn = order.OrderDate,
                                 RequiredBy = order.RequiredDate,
                                 FreightCharge = order.Freight,
                                 Details = from item in order.OrderDetails
                                           group item by item.Product.Supplier into dropShippers
                                           select new SupplierShipment
                                           {
                                               SupplierName = dropShippers.Key.CompanyName,
                                               Items = from i in dropShippers
                                                       select new ShipmentItem
                                                       {
                                                           ProductID = i.ProductID,
                                                           Quantity = i.Quantity,
                                                           Price = i.UnitPrice,
                                                           Discount = i.Discount,
                                                           QuantityPerUnit = i.Product.QuantityPerUnit
                                                       }
                                           }
                             };
                return orders.ToList();
            }
        }
    }
}
