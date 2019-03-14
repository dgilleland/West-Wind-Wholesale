using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WestWind.DataPopulation.Db.Views
{
    public class OrderSubtotal
    {
        public const string Query = "SELECT OrderID, Subtotal FROM OrderSubtotals";

        public int OrderID { get; set; }
        public decimal Subtotal { get; set; }
    }
}
