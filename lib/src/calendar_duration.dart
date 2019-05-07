import './calendar.dart';

/// Interface which represents a given duration which can be 
/// added/subtracted from a [Calendar] object. Should be 
/// seperately implemented for each calendar size to account 
/// for different month/year sizes.
abstract class CalendarDuration<TCal extends Calendar> extends Comparable<CalendarDuration<TCal>>{

  int get days;
  int get weeks;
  int get months;
  int get years;

  CalendarDuration<TCal> operator +(CalendarDuration<TCal> other);

  CalendarDuration<TCal> operator -(CalendarDuration<TCal> other);

  CalendarDuration<TCal> operator -();

  bool operator <(CalendarDuration<TCal> other);

  bool operator <=(CalendarDuration<TCal> other);

  bool operator >=(CalendarDuration<TCal> other);

  bool operator >(CalendarDuration<TCal> other);

  /// Returns a new instance in which days will
  /// not be longer than the length of a week, and
  /// months will not be larger than the number of months in a year
  CalendarDuration<TCal> normalize();

  /// Returns a new instance in which the duration 
  /// is represented purley as days and months, no 
  /// years or weeks
  CalendarDuration<TCal> denormalize();

  /// Converts to an int, representing the estimated number of days
  /// which would be in this duration (taking into account leap years, 
  /// differing month lengths, etc...) which can be used to compare
  /// durations. Because it is based on averages it's not really useful 
  /// for any other purpose. For higher prescision, choose a reference 
  /// date and use `toDays(referenceDate)`
  int toApproxDays();


  /// Converts this duration to an interger representation of the
  /// number of days it contains, based on a given reference day.
  /// 
  /// Because months and years may differ in size, this may return
  /// slightly different results for different reference dates.
  int toDays(TCal referenceDate);

}