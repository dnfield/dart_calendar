import 'package:test/test.dart';

import 'package:date_calendar/date_calendar.dart';

void main() {
  test('addDays', () {
    final GregorianCalendar endOfJan = new GregorianCalendar(2018, 1, 31);
    expect(endOfJan.addDays(1), equals(new GregorianCalendar(2018, 2, 1)));

    expect(endOfJan.addDays(10), equals(new GregorianCalendar(2018, 2, 10)));
    expect(endOfJan.addDays(28), equals(new GregorianCalendar(2018, 2, 28)));
    expect(endOfJan.addDays(29), equals(new GregorianCalendar(2018, 3, 1)));

    final GregorianCalendar startOfSept = new GregorianCalendar(2019, 9, 2);
    expect(startOfSept.addDays(-1), equals(new GregorianCalendar(2019, 9, 1)));
    expect(startOfSept.addDays(-2), equals(new GregorianCalendar(2019, 8, 31)));
    expect(startOfSept.addDays(-3), equals(new GregorianCalendar(2019, 8, 30)));
  });

  test('getWeekdaysFromWeek', () {
    final WeekdayMask weekdaysList =
        new WeekdayMask.fromIterable(const <int>[7, 2, 4, 5]);
    final List<GregorianCalendar> days = GregorianCalendar.getWeekdaysFromWeek(
        new GregorianCalendar(2018, 2, 24), weekdaysList)!;
    expect(days.length, equals(weekdaysList.numberOfDaysSelected));
    expect(
        days,
        unorderedEquals(<GregorianCalendar>[
          new GregorianCalendar(2018, 2, 20),
          new GregorianCalendar(2018, 2, 22),
          new GregorianCalendar(2018, 2, 23),
          new GregorianCalendar(2018, 2, 25)
        ]));
  });

  test('leap year tests', () {
    GregorianCalendar nonLeap = new GregorianCalendar(2018, 3, 3);
    expect(nonLeap.isLeapYear, isFalse);
    expect(nonLeap.yearLength, equals(365));
    expect(nonLeap.dayOfYear, equals(62));

    nonLeap = nonLeap.addMonths(-1);
    expect(nonLeap.month, equals(2));
    expect(nonLeap.monthLength, equals(28));

    GregorianCalendar leap = new GregorianCalendar(2020, 3, 3);
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
    GregorianCalendar d = new GregorianCalendar(2011, 10, 6);
    expect(DateTime.thursday, equals(d.weekday));
    d = new GregorianCalendar(2011, 10, 5);
    expect(DateTime.wednesday, equals(d.weekday));

    // 1970-01-01 is Wintertime.
    d = new GregorianCalendar(1970, 1, 1);
    expect(DateTime.thursday, equals(d.weekday));

    d = new GregorianCalendar(1969, 12, 31);
    expect(DateTime.wednesday, equals(d.weekday));

    d = new GregorianCalendar(2011, 10, 4);
    expect(DateTime.tuesday, equals(d.weekday));
    d = new GregorianCalendar(2011, 10, 3);
    expect(DateTime.monday, equals(d.weekday));
    d = new GregorianCalendar(2011, 10, 2);
    expect(DateTime.sunday, equals(d.weekday));
    d = new GregorianCalendar(2011, 10, 1);
    expect(DateTime.saturday, equals(d.weekday));
    d = new GregorianCalendar(2011, 9, 30);
    expect(DateTime.friday, equals(d.weekday));
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
