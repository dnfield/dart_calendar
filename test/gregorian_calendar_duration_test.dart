import 'package:test/test.dart';

import 'package:date_calendar/date_calendar.dart';

void main() {
  test('normalize', () {
    // Test months to years
    expect(
      new GregorianCalendarDuration.normalized(months: 12), 
      equals(new GregorianCalendarDuration(years: 1))
    );
    expect(
      new GregorianCalendarDuration.normalized(months: 13), 
      equals(new GregorianCalendarDuration(years: 1, months: 1))
    );
    // Test days to weeks
    expect(
      new GregorianCalendarDuration.normalized(days: 7), 
      equals(new GregorianCalendarDuration(weeks: 1))
    );
    expect(
      new GregorianCalendarDuration.normalized(days: 8), 
      equals(new GregorianCalendarDuration(weeks: 1, days: 1))
    );
    // Test everything
    expect(
      new GregorianCalendarDuration.normalized(years: 1, months: 13, days: 19), 
      equals(new GregorianCalendarDuration(years: 2, months: 1, weeks: 2, days: 5))
    );
    expect(
      new GregorianCalendarDuration.normalized(years: 2, months: 1, weeks: 2, days: 5), 
      equals(new GregorianCalendarDuration(years: 2, months: 1, weeks: 2, days: 5))
    );
  });

  test('add and subtract', () {
    expect(
      new GregorianCalendarDuration(years: 2, months: 1, weeks: 2, days: 5) +
      new GregorianCalendarDuration(years: 1, months: 3, weeks: 2, days: 1), 
      equals(new GregorianCalendarDuration(years: 3, months: 4, weeks: 4, days: 6))
    );
    expect(
      new GregorianCalendarDuration(years: 2, months: 11, weeks: 2, days: 5) +
      new GregorianCalendarDuration(years: 1, months: 3, weeks: 2, days: 3), 
      equals(new GregorianCalendarDuration(years: 4, months: 2, weeks: 5, days: 1))
    );
    expect(
      new GregorianCalendarDuration(years: 2, months: 11, weeks: 2, days: 5) -
      new GregorianCalendarDuration(years: 1, months: 3, weeks: 2, days: 3), 
      equals(new GregorianCalendarDuration(years: 1, months: 8, weeks: 0, days: 2))
    );
  });


  test('to days', () {
    final oneMonth = new GregorianCalendarDuration(months: 1);
    final twoMonths = new GregorianCalendarDuration(months: 2);
    final oneYear = new GregorianCalendarDuration(years: 1);
    final twoYears = new GregorianCalendarDuration(years: 2);

    expect(
      oneMonth.toDays(GregorianCalendar(2019, 2, 17)), 
      equals(28),
      reason: 'February has 28 days in 2019 (Not a leap year)'
    );

    expect(
      oneMonth.toDays(GregorianCalendar(2020, 2, 17)), 
      equals(29),
      reason: 'February has 29 days in 2020 (A leap year)'
    );

    expect(
      twoMonths.toDays(GregorianCalendar(2020, 3, 17)), 
      equals(61),
      reason: 'March has 31 days, April has 61'
    );
    
    expect(
      oneYear.toDays(GregorianCalendar(2019, 2, 17)), 
      equals(365),
      reason: '2019 has 365 days (Not a leap year)'
    );

    expect(
      oneYear.toDays(GregorianCalendar(2020, 2, 17)), 
      equals(366),
      reason: '2020 has 366 days (A leap year)'
    );

    expect(
      twoYears.toDays(GregorianCalendar(2018, 2, 17)), 
      equals(365 * 2),
      reason: 'Neither 2018 or 2019 are leap years'
    );
  });


  test('from days', () {
    final oneMonth = new GregorianCalendarDuration(months: 1);
    final twoMonths = new GregorianCalendarDuration(months: 2);
    final oneYear = new GregorianCalendarDuration(years: 1);
    final twoYears = new GregorianCalendarDuration(years: 2);

    expect(
      GregorianCalendarDuration.fromDays(28, GregorianCalendar(2019, 2, 17)), 
      equals(oneMonth),
      reason: 'February has 28 days in 2019 (Not a leap year)'
    );

    expect(
      GregorianCalendarDuration.fromDays(29 , GregorianCalendar(2020, 2, 17)), 
      equals(oneMonth),
      reason: 'February has 29 days in 2020 (A leap year)'
    );

    expect(
      GregorianCalendarDuration.fromDays(61 , GregorianCalendar(2020, 3, 17)), 
      equals(twoMonths),
      reason: 'March has 31 days, April has 61'
    );
    
    expect(
      GregorianCalendarDuration.fromDays(365 , GregorianCalendar(2019, 2, 17)), 
      equals(oneYear),
      reason: '2019 has 365 days (Not a leap year)'
    );

    expect(
      GregorianCalendarDuration.fromDays(366 , GregorianCalendar(2020, 2, 17)), 
      equals(oneYear),
      reason: '2020 has 366 days (A leap year)'
    );

    expect(
      GregorianCalendarDuration.fromDays(365 * 2 , GregorianCalendar(2018, 2, 17)), 
      equals(twoYears),
      reason: 'Neither 2018 or 2019 are leap years'
    );

    expect(
      GregorianCalendarDuration.fromDays(28 + 365, GregorianCalendar(2018, 2, 17)), 
      equals(oneMonth + oneYear),
      reason: 'February has 28 days in 2018 (Not a leap year), then 2019 is also not a leap year'
    );

    expect(
      GregorianCalendarDuration.fromDays(28 + 366, GregorianCalendar(2019, 2, 17)), 
      equals(oneMonth + oneYear),
      reason: 'February has 28 days in 2019 (Not a leap year), then 2020 is a leap year'
    );

    expect(
      GregorianCalendarDuration.fromDays(29 + 365, GregorianCalendar(2020, 2, 17)), 
      equals(oneMonth + oneYear),
      reason: 'February has 29 days in 2020 (A leap year), then 2021 is not a leap year'
    );
  });


  test('comparisons', () {

    expect(
      GregorianCalendarDuration(years: 1), 
      equals(GregorianCalendarDuration(days: 365)),
      reason: 'A year is 365 days'
    );

  expect(
      GregorianCalendarDuration(years: 4), 
      equals(GregorianCalendarDuration(days: 365 * 4 + 1)),
      reason: 'A year is 365 days. Out of 4 years, 1 will be a leap year.'
    );

    expect(
      GregorianCalendarDuration(months: 1), 
      equals(GregorianCalendarDuration(days: 30)),
      reason: 'An average month is about 30 days'
    );


    expect(
        GregorianCalendarDuration(weeks: 1), 
        equals(GregorianCalendarDuration(days: 7)),
        reason: 'A week is 7 days'
    );

    expect(
        GregorianCalendarDuration(weeks: 2), 
        equals(GregorianCalendarDuration(days: 14)),
        reason: 'Two weeks is 14 days'
    );

    expect(
        GregorianCalendarDuration(months: 18), 
        equals(GregorianCalendarDuration(years: 1, months: 6)),
        reason: 'Eighteen months is a year and a half'
    );
  });

}