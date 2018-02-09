import 'dart:collection';

/// A day of year object
abstract class Calendar implements Comparable<Calendar> {
  Calendar(int year, int month, int day);
  Calendar.fromInt(int dt);
  Calendar.fromDateTime(DateTime dt);
  Calendar.now();
  Calendar.utc();

  /// The 1 based month
  int get month;

  /// The 1 based day
  int get day;

  /// The implementation defined year
  int get year;

  /// The number of days per year
  int get yearLength;

  /// The day of the week (1 = Monday, 7 = Sunday)
  int get weekday;

  /// The day of the year
  int get dayOfYear;

  /// Add a week-long period
  Calendar addWeeks(int weeks);

  /// Add a day-long period
  Calendar addDays(int days);

  /// Add a month-long period
  Calendar addMonths(int months);

  /// Add a year-long period
  Calendar addYears(int years);

  // /// Compare this to another calendar object
  // int compareTo(Calendar other);

  /// Produce a ISO8061 formatted date string
  String toDateTimeString();

  /// Produce a unique integer representation of this date
  int toInt();

  /// Get a UTC date time
  DateTime toDateTimeUtc();

  /// Get a Local date time
  DateTime toDateTimeLocal();

  Calendar copy();
}

/// Method signature used by calendar iterators to advance the date
typedef Calendar CalendarIteratorIncrementer(Calendar current, int increment);

/// Base class for calendar iterables
abstract class CalendarIterableBase extends IterableBase<Calendar> {
  final Calendar start;
  final Calendar end;
  final int increment;
  CalendarIterableBase(this.start, this.end, {this.increment = 1});
}

/// Generic iterator for advancing a date
class CalendarIterator implements Iterator<Calendar> {
  final Calendar _start;
  final Calendar _end;
  final int _increment;
  Calendar _current;
  Calendar _nextDate;
  Calendar get current => _current;
  CalendarIteratorIncrementer _incrementer;

  CalendarIterator(this._start, this._end, this._increment, this._incrementer) {
    if (_incrementer == null) {
      throw new ArgumentError.notNull('_incrementer');
    }

    if (_increment == null) {
      throw new ArgumentError.notNull('_increment');
    }
    if (_increment == 0) {
      throw new ArgumentError.value(
          _increment, 'CalendarIterator', 'Increment must not be 0');
    }
    _current = _start;
    _nextDate = _start;
  }

  @override
  bool moveNext() {
    if (_current == null || _start == null) {
      return false;
    }
    _current = _nextDate.copy();
    _nextDate = _incrementer(_current, _increment);

    return _end == null || _current.compareTo(_end) <= 0;
  }
}

/// An iterable range of days
class DayRange extends CalendarIterableBase {
  DayRange(Calendar start, Calendar end, {int increment = 1})
      : super(start, end, increment: increment);
  @override
  Iterator<Calendar> get iterator => new CalendarIterator(
      start, end, increment, (curr, inc) => curr.addDays(inc));
}

/// An iterable range of weeks
class WeekRange extends CalendarIterableBase {
  WeekRange(Calendar start, Calendar end, {int increment = 1})
      : super(start, end, increment: increment);
  @override
  Iterator<Calendar> get iterator => new CalendarIterator(
      start, end, increment, (curr, inc) => curr.addWeeks(inc));
}

/// An iterable range of months
class MonthRange extends CalendarIterableBase {
  MonthRange(Calendar start, Calendar end, {int increment = 1})
      : super(start, end, increment: increment);
  @override
  Iterator<Calendar> get iterator => new CalendarIterator(
      start, end, increment, (curr, inc) => curr.addMonths(inc));
}

/// An iterable range of years
class YearRange extends CalendarIterableBase {
  YearRange(Calendar start, Calendar end, {int increment = 1})
      : super(start, end, increment: increment);
  @override
  Iterator<Calendar> get iterator => new CalendarIterator(
      start, end, increment, (curr, inc) => curr.addYears(inc));
}
