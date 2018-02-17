import './calendar.dart';
import './weekday_mask.dart';

const List<int> _daysPerMonth = const [
  31,
  28,
  31,
  30,
  31,
  30,
  31,
  31,
  30,
  31,
  30,
  31
];
const List<int> _daysInYearPreceedingMonth = const [
  0,
  31,
  59,
  90,
  120,
  151,
  180,
  212,
  243,
  273,
  304,
  334
];

const List<int> _sakamotoHelper = const [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4];

/// Represents a single day in the Gregorian Calendar
class GregorianCalendar implements Calendar {
  int _month, _day, _year;
  int get month => _month + 1;
  int get day => _day + 1;
  int get year => _year;

  bool get isLeapYear =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  /// The number of days in the year of this date - 366 if leap year
  int get yearLength => isLeapYear ? 366 : 365;

  /// The number of days in the month of this date
  int get monthLength {
    int n = _daysPerMonth[_month];
    if (n != 28) {
      return n;
    }
    return isLeapYear ? 29 : 28;
  }

  /// The integer representation of the day of the week
  ///
  /// Same as DateTime.weekday - 1 = Monday, 7 = Sunday
  int get weekday {
    int y = year - ((month <= 2) ? 1 : 0);

    int zeroBased =
        (y + y ~/ 4 - y ~/ 100 + y ~/ 400 + _sakamotoHelper[month - 1] + day) %
            7;
    return zeroBased == 0 ? 7 : zeroBased;
  }

  /// The day of the year for this date
  int get dayOfYear {
    int yearDay = _daysInYearPreceedingMonth[_month] + day;
    if (month >= 2 && isLeapYear) {
      yearDay += 1;
    }
    return yearDay;
  }

  /// Adds weeks * 7 days to this object
  ///
  /// To add fractional parts of a week, use addDays
  GregorianCalendar addWeeks(int weeks) {
    return addDays(weeks * 7);
  }

  /// Accepts positive or negative numbers.
  ///
  /// Will update month/year depending on number of days.
  GregorianCalendar addDays(int days) {
    return copy().._addDays(days);
  }

  void _addDays(int days) {
    _day += days ?? 0;

    while (_day < 0) {
      _addMonths(-1);
      _day += monthLength - 1;
    }
    while (_day > monthLength - 1) {
      _day -= monthLength;
      _addMonths(1);
    }
    if (_day < 0 || _day > monthLength - 1) {
      _addDays(0);
    }
  }

  /// Adds or subtracts months, will adjust years/days if needed.
  ///
  /// The interpretation of adding a month is as follows:
  ///   If the day is valid for the month you land on, it doesn't change
  ///   If the day is too large for the month you land on, it is clamped to the last day of the month
  ///     e.g. if you try to land on February 31st by adding 1 month to January 31st in a non-leap year, you land on Feb 28th (Feb 29 on a leap year)
  GregorianCalendar addMonths(int months) {
    return copy().._addMonths(months, clamp: true);
  }

  void _addMonths(int months, {bool clamp: false}) {
    bool wasLastDayInMonth = _day == monthLength - 1;

    _month += months ?? 0;
    while (_month < 0) {
      _month += 12;
      _year -= 1;
    }

    while (_month > 11) {
      _month -= 12;
      _year += 1;
    }

    if (clamp && (wasLastDayInMonth || day > monthLength)) {
      _day = monthLength - 1;
    }
  }

  /// Adds or removes years
  GregorianCalendar addYears(int years) {
    return copy().._year += years;
  }

  /// Setting any of these to null treats them as 1 or 0 (year)
  GregorianCalendar(int year, [int month = 1, int day = 1]) {
    if (year < 0) {
      throw new RangeError('Year must be positive');
    }
    if (day == 0) {
      day = 1;
    }
    if (month == 0) {
      month = 1;
    }
    _year = year;
    _month = 0;
    _day = 0;
    _addMonths(month - 1);
    _addDays(day - 1);
  }

  @override
  bool operator ==(Object d) {
    if (identical(this, d)) {
      return true;
    }

    if (d == null) {
      return false;
    }

    return (d is GregorianCalendar &&
        d.year == year &&
        d.month == month &&
        d.day == day);
  }

  @override
  int get hashCode {
    return toInt().hashCode;
  }

  /// determines if this date is before (-1), after (1), or the same (0) as other
  int compareTo(Calendar other) {
    if (other is! GregorianCalendar) {
      throw new UnsupportedError(
          'Comparing Gregorian and non-Gregorian dates not supported at this time');
    }
    return toInt().compareTo(other?.toInt());
  }

  /// ISO8061 compatible string version of this date, e.g. 2018-02-03
  @override
  String toString() {
    return '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

  /// ISO8061 compatible string version with a timestamp of midnight UTC
  String toDateTimeString() {
    return '${toString()}T00:00:00Z';
  }

  /// Integer representation of this date in YYYYMMDD format, e.g. 20180203
  int toInt() {
    return year * 10000 + month * 100 + day;
  }

  /// Parses integer in YYYYMMDD format into Date object
  ///
  /// Currently may not behave well with negative numbers?
  GregorianCalendar.fromInt(int dt)
      : this(dt ~/ 10000, (dt ~/ 100) % 100, dt % 100);

  /// Creates a new [DateTime] in the UTC timezone
  DateTime toDateTimeUtc() {
    return new DateTime.utc(year, month, day);
  }

  /// Creates a new [DateTime] in the Local timezone
  DateTime toDateTimeLocal() {
    return new DateTime(year, month, day);
  }

  /// Creates a new Date object from the [DateTime] passed in.
  GregorianCalendar.fromDateTime(DateTime dt)
      : this(dt?.year, dt?.month, dt?.day);

  static GregorianCalendar parse(String str) {
    return new GregorianCalendar.fromDateTime(DateTime.parse(str));
  }

  /// Produces a new Date object from [DateTime] using `now()`
  GregorianCalendar.now() : this.fromDateTime(new DateTime.now());

  /// Produces a new Date object from [DateTime] using `.now().toUtc()`
  GregorianCalendar.utc() : this.fromDateTime(new DateTime.now().toUtc());

  /// create an identical copy of this object
  GregorianCalendar copy() {
    return new GregorianCalendar.fromInt(toInt());
  }

  /// Will get the nth occurrence of the weekday of month in year
  ///
  /// Returns null if there are not n many weekdays in the month (e.g. the 6th Monday of any month)
  static GregorianCalendar getWeekdayOfMonth(
      int year, int month, int weekday, int nth) {
    if (nth < 0) {
      throw new RangeError('nth $nth invalid must be positive');
    }
    if (weekday < 1 || weekday > 7) {
      throw new RangeError(
          'weekday $weekday invalid: must be between 1 to 7 inclusive');
    }
    if (nth > 5) {
      return null;
    }
    var dt = new GregorianCalendar(year, month, 1);
    if (dt.weekday < weekday) {
      dt.addDays(weekday - dt.weekday);
    } else if (dt.weekday > weekday) {
      dt.addDays(weekday - dt.weekday + 7);
    }
    dt.addWeeks(nth - 1);

    if (dt.month != month) {
      return null;
    }

    return dt;
  }

  static List<GregorianCalendar> getWeekdaysFromWeek(
      GregorianCalendar base, WeekdayMask weekdays) {
    if (weekdays == null || weekdays.hasAny == false) {
      return null;
    }

    return weekdays
        .toIterable()
        .map((weekday) => base.weekday == weekday
            ? base
            : new GregorianCalendar(
                base.year, base.month, base.day - base.weekday + weekday))
        .toList();
  }
}
