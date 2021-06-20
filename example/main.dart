import 'package:date_calendar/date_calendar.dart';

void main() {
  //  var d = new GregorianCalendar(2018, 14, 31);
  // var d2 = GregorianCalendar.fromInt(1210332);

  final List<GregorianCalendar> days = GregorianCalendar.getWeekdaysFromWeek(
      new GregorianCalendar(2018, 2, 24),
      new WeekdayMask.fromIterable(<int>[7, 2, 4, 5]))!;
  print(days);
  // print(d);
  // for (var day in new MonthIterable(
  //   new GregorianCalendar(2018, 1, 31),
  //   new GregorianCalendar(2019, 2, 25),
  //   increment: 1,
  // )) {
  //   print(day);
  // }
}
