import 'package:test/test.dart';
import '../lib/date_calendar.dart';

void main() {
  test('Day iterator tests', () {
    var start = new GregorianCalendar(2018, 1, 1);
    var end = new GregorianCalendar(2019, 1, 1);
    var iter = new DayRange(start, end, increment: 1);
    expect(iter.length, equals(366));
  });

  test('Weekday Iterator Tests', () {
    var start = new GregorianCalendar(2018, 1, 1);
    var end = new GregorianCalendar(2019, 1, 1);
    var iter = new WeekRange(start, end, increment: 1);

    expect(iter.length, equals(53));
  });

  test('Month day iterator tests', () {
    var start = new GregorianCalendar(2018, 1, 1);
    var end = new GregorianCalendar(2019, 1, 1);
    var iter = new MonthRange(start, end, increment: 1);

    expect(iter.length, equals(13));
  });
  test('Year day iterator tests', () {
    var start = new GregorianCalendar(2018, 1, 1);
    var end = new GregorianCalendar(2019, 1, 1);
    var iter = new YearRange(start, end, increment: 1);

    expect(iter.length, equals(2));
  });
}
