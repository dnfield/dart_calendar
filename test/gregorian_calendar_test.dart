import 'package:test/test.dart';

import '../lib/date_calendar.dart';

void main() {
  test('getWeekdaysFromWeek', () {
    var weekdaysList = new WeekdayMask.fromIterable(const [7, 2, 4, 5]);
    var days = GregorianCalendar.getWeekdaysFromWeek(
        new GregorianCalendar(2018, 2, 24), weekdaysList);
    expect(days.length, equals(weekdaysList.numberOfDaysSelected));
    expect(
        days,
        unorderedEquals([
          new GregorianCalendar(2018, 2, 20),
          new GregorianCalendar(2018, 2, 22),
          new GregorianCalendar(2018, 2, 23),
          new GregorianCalendar(2018, 2, 25)
        ]));
  });

  test('leap year tests', () {
    var nonLeap = new GregorianCalendar(2018, 3, 3);
    expect(nonLeap.isLeapYear, isFalse);
    expect(nonLeap.yearLength, equals(365));
    expect(nonLeap.dayOfYear, equals(62));

    nonLeap = nonLeap.addMonths(-1);
    expect(nonLeap.month, equals(2));
    expect(nonLeap.monthLength, equals(28));

    var leap = new GregorianCalendar(2020, 3, 3);
    expect(leap.isLeapYear, isTrue);
    expect(leap.yearLength, equals(366));
    expect(leap.dayOfYear, equals(63));

    leap = leap.addMonths(-1);
    expect(leap.month, equals(2));
    expect(leap.monthLength, equals(29));
  });

  test('weekdays', () {
    // adapted from https://github.com/dart-lang/sdk/blob/master/tests/corelib/date_time_test.dart
    // 2011-10-06 is Summertime.
    var d = new GregorianCalendar(2011, 10, 6);
    expect(DateTime.THURSDAY, equals(d.weekday));
    d = new GregorianCalendar(2011, 10, 5);
    expect(DateTime.WEDNESDAY, equals(d.weekday));

    // 1970-01-01 is Wintertime.
    d = new GregorianCalendar(1970, 1, 1);
    expect(DateTime.THURSDAY, equals(d.weekday));

    d = new GregorianCalendar(1969, 12, 31);
    expect(DateTime.WEDNESDAY, equals(d.weekday));

    d = new GregorianCalendar(2011, 10, 4);
    expect(DateTime.TUESDAY, equals(d.weekday));
    d = new GregorianCalendar(2011, 10, 3);
    expect(DateTime.MONDAY, equals(d.weekday));
    d = new GregorianCalendar(2011, 10, 2);
    expect(DateTime.SUNDAY, equals(d.weekday));
    d = new GregorianCalendar(2011, 10, 1);
    expect(DateTime.SATURDAY, equals(d.weekday));
    d = new GregorianCalendar(2011, 9, 30);
    expect(DateTime.FRIDAY, equals(d.weekday));
  });
  //  var d = new GregorianCalendar(2018, 14, 31);
  // var d2 = GregorianCalendar.fromInt(1210332);

  // print(d);
  // for (var day in new MonthIterable(
  //   new GregorianCalendar(2018, 1, 31),
  //   new GregorianCalendar(2019, 2, 25),
  //   increment: 1,
  // )) {
  //   print(day);
  // }
}
