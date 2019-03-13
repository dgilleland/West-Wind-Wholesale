using System.Collections.Generic;
using System.Linq;

namespace WestWind.DataPopulation
{
    public class SupplierShipment
    {
        public IEnumerable<ShipmentItem> Items { get; internal set; }
        = new HashSet<ShipmentItem>();
        public decimal Total => Items.Sum(x => x.ExtendedPrice);
        public int QuantityCount => Items.Sum(x => x.Quantity);
        public decimal Freight { get; internal set; }
        public void SetFreight(decimal amount)
        {
            Freight = amount < 0 ? throw new System.ArgumentException("Amount must be positive") : amount;
        }
        public string SupplierName { get; internal set; }
    }
}
