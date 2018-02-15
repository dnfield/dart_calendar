import 'dart:collection';
import 'calendar.dart';
/// Method signature used by calendar iterators to advance the date
typedef TCal CalendarIteratorIncrementer<TCal extends Calendar>(TCal current, int increment);

/// Base class for calendar iterables
abstract class CalendarIterableBase<TCal extends Calendar> extends IterableBase<TCal> {
  final TCal start;
  final TCal end;
  final int increment;
  CalendarIterableBase(this.start, this.end, {this.increment = 1});
}

/// Generic iterator for advancing a date
class CalendarIterator<TCal extends Calendar> implements Iterator<TCal> {
  final TCal _start;
  final TCal _end;
  final int _increment;
  TCal _current;
  TCal _nextDate;
  TCal get current => _current;
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
class DayRange<TCal extends Calendar> extends CalendarIterableBase<TCal> {
  DayRange(Calendar start, Calendar end, {int increment = 1})
      : super(start, end, increment: increment);
  @override
  Iterator<TCal> get iterator => new CalendarIterator(
      start, end, increment, (curr, inc) => curr.addDays(inc));
}

/// An iterable range of weeks
class WeekRange<TCal extends Calendar> extends CalendarIterableBase<TCal> {
  WeekRange(Calendar start, Calendar end, {int increment = 1})
      : super(start, end, increment: increment);
  @override
  Iterator<TCal> get iterator => new CalendarIterator(
      start, end, increment, (curr, inc) => curr.addWeeks(inc));
}

/// An iterable range of months
class MonthRange<TCal extends Calendar> extends CalendarIterableBase<TCal> {
  MonthRange(Calendar start, Calendar end, {int increment = 1})
      : super(start, end, increment: increment);
  @override
  Iterator<TCal> get iterator => new CalendarIterator(
      start, end, increment, (curr, inc) => curr.addMonths(inc));
}

/// An iterable range of years
class YearRange<TCal extends Calendar> extends CalendarIterableBase<TCal> {
  YearRange(Calendar start, Calendar end, {int increment = 1})
      : super(start, end, increment: increment);
  @override
  Iterator<TCal> get iterator => new CalendarIterator(
      start, end, increment, (curr, inc) => curr.addYears(inc));
}
