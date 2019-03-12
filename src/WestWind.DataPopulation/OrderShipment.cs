using System;
using System.Collections.Generic;

namespace WestWind.DataPopulation
{
    public class OrderShipment
    {
        public IEnumerable<SupplierShipment> Details { get; internal set; }
        = new HashSet<SupplierShipment>();
        public decimal Total => Details.Sum(x => x.Total);
        public double FreightPercent => FreightCharge.HasValue ? Math.Round(Convert.ToDouble(FreightCharge.Value / Total) * 100, 2) : 0.0;
        public decimal? FreightCharge { get; internal set; }
        public DateTime? RequiredBy { get; internal set; }
        public DateTime? OrderedOn { get; internal set; }
        public int OrderID { get; internal set; }
    }
}
