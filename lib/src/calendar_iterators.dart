import 'dart:collection';
import 'calendar.dart';

/// Method signature used by calendar iterators to advance the date
typedef TCal CalendarIteratorIncrementer<TCal extends Calendar>(
    TCal current, int increment);

/// Base class for calendar iterables
abstract class CalendarIterableBase<TCal extends Calendar>
    extends IterableBase<TCal> {
  CalendarIterableBase(this.start, this.end, {this.increment = 1});

  final TCal start;
  final TCal end;
  final int increment;
}

/// Generic iterator for advancing a date
class CalendarIterator<TCal extends Calendar> implements Iterator<TCal> {
  CalendarIterator(this._start, this._end, this._increment, this._incrementer) {
    if (_increment == 0) {
      throw new ArgumentError.value(
          _increment, 'CalendarIterator', 'Increment must not be 0');
    }
    _current = _start;
    _nextDate = _start;
  }

  final TCal? _start;
  final TCal? _end;
  final int _increment;
  TCal? _current;
  TCal? _nextDate;
  final CalendarIteratorIncrementer<TCal> _incrementer;

  // Iterator contract for current allows us to do a null check because clients
  // must first check moveNext and get true before calling current.
  @override
  TCal get current => _current!;

  @override
  bool moveNext() {
    if (_current == null || _start == null) {
      return false;
    }
    _current = _nextDate!.copy() as TCal?;
    _nextDate = _incrementer(_current!, _increment);

    return _end == null || _current!.compareTo(_end!) <= 0;
  }
}

/// An iterable range of days
class DayRange<TCal extends Calendar> extends CalendarIterableBase<TCal> {
  DayRange(TCal start, TCal end, {int increment = 1})
      : super(start, end, increment: increment);
  @override
  Iterator<TCal> get iterator => new CalendarIterator<TCal>(
      start, end, increment, (TCal curr, int inc) => curr.addDays(inc) as TCal);
}

/// An iterable range of weeks
class WeekRange<TCal extends Calendar> extends CalendarIterableBase<TCal> {
  WeekRange(TCal start, TCal end, {int increment = 1})
      : super(start, end, increment: increment);
  @override
  Iterator<TCal> get iterator => new CalendarIterator<TCal>(
      start, end, increment, (TCal curr, int inc) => curr.addWeeks(inc) as TCal);
}

/// An iterable range of months
class MonthRange<TCal extends Calendar> extends CalendarIterableBase<TCal> {
  MonthRange(TCal start, TCal end, {int increment = 1})
      : super(start, end, increment: increment);
  @override
  Iterator<TCal> get iterator => new CalendarIterator<TCal>(
      start, end, increment, (TCal curr, int inc) => curr.addMonths(inc) as TCal);
}

/// An iterable range of years
class YearRange<TCal extends Calendar> extends CalendarIterableBase<TCal> {
  YearRange(TCal start, TCal end, {int increment = 1})
      : super(start, end, increment: increment);
  @override
  Iterator<TCal> get iterator => new CalendarIterator<TCal>(
      start, end, increment, (TCal curr, int inc) => curr.addYears(inc) as TCal);
}
