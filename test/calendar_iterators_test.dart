import 'package:test/test.dart';
import 'package:date_calendar/date_calendar.dart';

void main() {
  test('Day iterator tests', () {
    final GregorianCalendar start = new GregorianCalendar(2018, 1, 1);
    final GregorianCalendar end = new GregorianCalendar(2019, 1, 1);
    final DayRange<GregorianCalendar> iter =
        new DayRange<GregorianCalendar>(start, end, increment: 1);
    expect(iter.length, equals(366));
  });

  test('Weekday Iterator Tests', () {
    final GregorianCalendar start = new GregorianCalendar(2018, 1, 1);
    final GregorianCalendar end = new GregorianCalendar(2019, 1, 1);
    final WeekRange<GregorianCalendar> iter =
        new WeekRange<GregorianCalendar>(start, end, increment: 1);

    expect(iter.length, equals(53));
  });

  test('Month day iterator tests', () {
    final GregorianCalendar start = new GregorianCalendar(2018, 1, 1);
    final GregorianCalendar end = new GregorianCalendar(2019, 1, 1);
    final MonthRange<GregorianCalendar> iter =
        new MonthRange<GregorianCalendar>(start, end, increment: 1);

    expect(iter.length, equals(13));
  });
  test('Year day iterator tests', () {
    final GregorianCalendar start = new GregorianCalendar(2018, 1, 1);
    final GregorianCalendar end = new GregorianCalendar(2019, 1, 1);
    final YearRange<GregorianCalendar> iter =
        new YearRange<GregorianCalendar>(start, end, increment: 1);

    expect(iter.length, equals(2));
  });
}
