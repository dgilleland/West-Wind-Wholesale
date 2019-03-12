using System.Collections.Generic;

namespace WestWind.DataPopulation
{
    public class SupplierShipment
    {
        public IEnumerable<ShipmentItem> Items { get; internal set; }
        = new HashSet<ShipmentItem>();
        public decimal Total => Items.Sum(x => x.ExtendedPrice);
        public string SupplierName { get; internal set; }
    }
}
