using System;
using System.Linq;
using WestWind.DataPopulation.Db;

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
}
