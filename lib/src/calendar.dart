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
