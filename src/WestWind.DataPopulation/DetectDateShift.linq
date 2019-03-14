<Query Kind="Program">
  <Connection>
    <ID>05a2444e-14ea-4451-ad3d-3398e9ff7898</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

void Main()
{
    var info = from data in Orders.Select(x => new {x.OrderDate, x.RequiredDate }).ToList()
    where data.RequiredDate.HasValue
    select new
    {
        data.OrderDate,
        data.RequiredDate,
        Span = (data.RequiredDate - data.OrderDate).Value.Days,
        DayOfWeek = data.OrderDate.Value.DayOfWeek
    };
    var num = (int)(DayOfWeek.Sunday);
    num.Dump();
    info.Count(x => x.DayOfWeek == DayOfWeek.Sunday).Dump("Sunday");
    info.Count(x => x.DayOfWeek == DayOfWeek.Monday).Dump("Monday");
    info.Count(x => x.DayOfWeek == DayOfWeek.Tuesday).Dump("Tuesday");
    info.Count(x => x.DayOfWeek == DayOfWeek.Wednesday).Dump("Wednesday");
    info.Count(x => x.DayOfWeek == DayOfWeek.Thursday).Dump("Thursday");
    info.Count(x => x.DayOfWeek == DayOfWeek.Friday).Dump("Friday");
    info.Count(x => x.DayOfWeek == DayOfWeek.Saturday).Dump("Saturday");
}

// Define other methods and classes here
