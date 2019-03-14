﻿using System.Text;
using System.Threading.Tasks;

namespace WestWind.DataPopulation
{
    class Program
    {
        static void Main(string[] args)
        {
            DateShifting.CorrectForWeekdays();
            Shipping.ShipOrders();
            Invoicing.PayInvoices();
        }
    }
}
