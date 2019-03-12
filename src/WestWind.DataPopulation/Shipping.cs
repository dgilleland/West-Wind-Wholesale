using System.Linq;
using WestWind.DataPopulation.Db;

namespace WestWind.DataPopulation
{
    public class Shipping
    {
        void asdf()
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

            }
        }
    }
}
