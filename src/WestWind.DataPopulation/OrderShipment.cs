using System;
using System.Collections.Generic;
using System.Linq;

namespace WestWind.DataPopulation
{
    public class OrderShipment
    {
        public IEnumerable<SupplierShipment> Details { get; internal set; }
        = new HashSet<SupplierShipment>();
        public decimal TotalExtendedCost => Details.Sum(x => x.Total);
        public int QuantityCount => Details.Sum(x => x.QuantityCount);
        public double FreightPercentOfTotal => FreightCharge.HasValue ? Math.Round(Convert.ToDouble(FreightCharge.Value / TotalExtendedCost) * 100, 2) : 0.0;
        public decimal? FreightCharge { get; internal set; }
        public DateTime? RequiredBy { get; internal set; }
        public DateTime? OrderedOn { get; internal set; }
        public int OrderID { get; internal set; }
    }
}
