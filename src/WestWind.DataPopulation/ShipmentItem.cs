using System;

namespace WestWind.DataPopulation
{
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
}
