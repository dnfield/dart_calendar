import 'dart:core';

/// A helper class to deal with sets of weekdays
class WeekdayMask {
  const WeekdayMask(this.mask);

  /// Initialize the bitmask from an iterable.  If null is passed, will initialize it to 0.
  WeekdayMask.fromIterable(Iterable<int>? weekdays)
      : mask = weekdays?.fold(
                0,
                (int? prev, int? el) => el != null
                    ? prev! | WeekdayMask.weekdayToMaskVal[el == 0 ? 7 : el > 7 ? 0 : el]!
                    : prev) ??
            0;

  static const int mondayMask = 1 << 0;
  static const int tuesdayMask = 1 << 1;
  static const int wednesdayMask = 1 << 2;
  static const int thursdayMask = 1 << 3;
  static const int fridayMask = 1 << 4;
  static const int saturdayMask = 1 << 5;
  static const int sundayMask = 1 << 6;

  static const int weekdayMask =
      mondayMask | tuesdayMask | wednesdayMask | thursdayMask | fridayMask;
  static const int weekendMask = saturdayMask | sundayMask;

  /// Get the appropriate bitmask value based on the `DateTime.weekday` value
  static const Map<int, int> weekdayToMaskVal = const <int, int>{
    DateTime.monday: mondayMask,
    DateTime.tuesday: tuesdayMask,
    DateTime.wednesday: wednesdayMask,
    DateTime.thursday: thursdayMask,
    DateTime.friday: fridayMask,
    DateTime.saturday: saturdayMask,
    DateTime.sunday: sundayMask,
  };

  /// Get the `DateTime.weekday` value from a mask value
  static const Map<int, int> maskToWeekdayVal = const <int, int>{
    mondayMask: DateTime.monday,
    tuesdayMask: DateTime.tuesday,
    wednesdayMask: DateTime.wednesday,
    thursdayMask: DateTime.thursday,
    fridayMask: DateTime.friday,
    saturdayMask: DateTime.saturday,
    sundayMask: DateTime.sunday,
  };

  /// Get the mask value from the EN US weekday string in UPPERCASE
  static const Map<String, int> dayNameToMaskVal = const <String, int>{
    'MONDAY': mondayMask,
    'TUESDAY': tuesdayMask,
    'WEDNESDAY': wednesdayMask,
    'THURSDAY': thursdayMask,
    'FRIDAY': fridayMask,
    'SATURDAY': saturdayMask,
    'SUNDAY': sundayMask,
  };

  /// The bitmasked set.  Most callers should use the helper methods to get/set/toggle/etc.
  final int mask;

  /// Whether or not this mask contains Monday
  bool get monday => isWeekdaySelected(1);

  /// Whether or not this mask contains Tuesday
  bool get tuesday => isWeekdaySelected(2);

  /// Whether or not this mask contains Wednesday
  bool get wednesday => isWeekdaySelected(3);

  /// Whether or not this mask contains Thursday
  bool get thursday => isWeekdaySelected(4);

  /// Whether or nto this mask contains Friday
  bool get friday => isWeekdaySelected(5);

  /// Whether or not this mask contains Saturday
  bool get saturday => isWeekdaySelected(6);

  /// Whether or not this mask contains Sunday
  bool get sunday => isWeekdaySelected(7);

  /// Whether or not this mask contains any weekdays (i.e. Mon-Fri)
  bool get hasAnyWeekday => mask & weekdayMask != 0;

  /// Whether or not this mask contains any weekend days
  bool get hasAnyWeekend => mask & weekendMask != 0;

  /// Get the number of days in stored in this mask, e.g. it's length if it were an array
  int get numberOfDaysSelected {
    int c = 0;
    for (int maskTest = 0; maskTest < 7; maskTest++) {
      if (mask & (1 << maskTest) != 0) {
        c++;
      }
    }
    return c;
  }

  /// Get whether any days are stored in this mask
  bool get hasAny {
    if (mask == 0) {
      return false;
    }
    for (int maskTest = 0; maskTest < 7; maskTest++) {
      if (mask & (1 << maskTest) != 0) {
        return true;
      }
    }
    return false;
  }

  /// Create a new mask with the 1 based weekday set to the value.
  ///
  /// Passing null for a value will return a copy of this mask.
  WeekdayMask setDay(int? weekday, bool? value) {
    if (weekday == null || value == null) {
      return new WeekdayMask(mask);
    }
    if (weekday == 0) {
      weekday = 7;
    }

    return new WeekdayMask(
        value == true ? mask & weekdayToMaskVal[weekday]! : mask & ~weekdayToMaskVal[weekday]!);
  }

  /// See [setDay].  You may pass a custom map of weekday names, where US EN Monday should be 1 and Sunday 7.
  WeekdayMask setDayName(String? weekdayName, bool value,
      {Map<String, int> dayMap = dayNameToMaskVal}) {
    if (weekdayName == null) {
      return new WeekdayMask(mask);
    }

    return new WeekdayMask(value == true
        ? mask & dayMap[weekdayName.toUpperCase()]!
        : mask & ~dayMap[weekdayName.toUpperCase()]!);
  }

  /// Creates a new mask with the specified weekday's value toggled from true to false or false to true.
  WeekdayMask toggleDay(int? weekday) {
    if (weekday == null) {
      return new WeekdayMask(mask);
    }
    if (weekday == 0) {
      weekday = 7;
    }

    return new WeekdayMask(mask ^ weekdayToMaskVal[weekday]!);
  }

  /// See [toggleDay] and [setDayName].  You may pass a custom map of days if desired.
  WeekdayMask toggleDayName(String? weekdayName, {Map<String, int> dayMap = dayNameToMaskVal}) {
    if (weekdayName == null) {
      return new WeekdayMask(mask);
    }

    return new WeekdayMask(mask ^ dayMap[weekdayName.toUpperCase()]!);
  }

  /// Check whether a particular `DateTime.weekday` is set to true in this mask
  bool isWeekdaySelected(int weekday) {
    return mask & weekdayToMaskVal[weekday]! != 0;
  }

  bool isDayNameSelected(String day, {Map<String, int> dayMap = dayNameToMaskVal}) {
    return mask & dayMap[day.toUpperCase()]! != 0;
  }

  /// Create an `Iterable<int>` from this mask
  Iterable<int> toIterable() sync* {
    for (int maskTest = 0; maskTest < 7; maskTest++) {
      if (mask & (1 << maskTest) != 0) {
        yield maskTest + 1;
      }
    }
  }

  /// Create a list of integers from this mask
  List<int> toList() {
    return toIterable().toList(growable: false);
  }
}
