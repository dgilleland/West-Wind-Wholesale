<Query Kind="Program">
  <Connection>
    <ID>9f795fec-6525-43c5-bbd0-2819df27768a</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

void Main()
{
    var orders = from order in Orders
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
    orders.Dump();
}

// Define other methods and classes here
    public class SupplierShipment
    {
        public IEnumerable<ShipmentItem> Items { get; internal set; }
        public decimal Total {get{ return Items.Sum(x => x.ExtendedPrice); }}
        public string SupplierName { get; internal set; }
        public SupplierShipment()
        {
            Items = new HashSet<ShipmentItem>();
        }
    }
    public class OrderShipment
    {
        public IEnumerable<SupplierShipment> Details { get; internal set; }        
        public decimal Total { get { return Details.Sum(x => x.Total); } }
        public decimal? FreightCharge { get; internal set; }
        public double FreightPercent { get { return FreightCharge.HasValue ? Math.Round(Convert.ToDouble(FreightCharge.Value / Total) * 100, 2) : 0.0;}}
        public DateTime? RequiredBy { get; internal set; }
        public DateTime? OrderedOn { get; internal set; }
        public int OrderID { get; internal set; }
        public OrderShipment()
        {
            Details= new HashSet<SupplierShipment>();
        }
    }
    public class ShipmentItem
    {
        public string QuantityPerUnit { get; internal set; }
        public float Discount { get; internal set; }
        public decimal Price { get; internal set; }
        public short Quantity { get; internal set; }
        public int ProductID { get; internal set; }
        public decimal ExtendedPrice
        {
            get { return Quantity * Price * (1 - Convert.ToDecimal(Discount)); }
        }
    }
