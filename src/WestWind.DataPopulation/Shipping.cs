using System;
using System.Collections.Generic;
using System.Linq;
using WestWind.DataPopulation.Db;

namespace WestWind.DataPopulation
{
    public class Invoicing
    {
        public static void PayInvoices()
        {

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
