import 'dart:core';

class WeekdayMask {
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

  static const Map<int, int> weekdayToMaskVal = const {
    DateTime.MONDAY: mondayMask,
    DateTime.TUESDAY: tuesdayMask,
    DateTime.WEDNESDAY: wednesdayMask,
    DateTime.THURSDAY: thursdayMask,
    DateTime.FRIDAY: fridayMask,
    DateTime.SATURDAY: saturdayMask,
    DateTime.SUNDAY: sundayMask,
  };

  static const Map<int, int> maskToWeekdayVal = const {
    mondayMask: DateTime.MONDAY,
    tuesdayMask: DateTime.TUESDAY,
    wednesdayMask: DateTime.WEDNESDAY,
    thursdayMask: DateTime.THURSDAY,
    fridayMask: DateTime.FRIDAY,
    saturdayMask: DateTime.SATURDAY,
    sundayMask: DateTime.SUNDAY,
  };

  static const Map<String, int> dayNameToMaskVal = const {
    "MONDAY": mondayMask,
    "TUESDAY": tuesdayMask,
    "WEDNESDAY": wednesdayMask,
    "THURSDAY": thursdayMask,
    "FRIDAY": fridayMask,
    "SATURDAY": saturdayMask,
    "SUNDAY": sundayMask,
  };

  final int mask;
  const WeekdayMask(this.mask);

  WeekdayMask.fromIterable(Iterable<int> weekdays)
      : mask = weekdays.fold(
            0,
            (prev, el) =>
                prev | WeekdayMask.weekdayToMaskVal[el == 0 ? 7 : el]);
  bool get monday => isWeekdaySelected(1);
  bool get tuesday => isWeekdaySelected(2);
  bool get wednesday => isWeekdaySelected(3);
  bool get thursday => isWeekdaySelected(4);
  bool get friday => isWeekdaySelected(5);
  bool get saturday => isWeekdaySelected(6);
  bool get sunday => isWeekdaySelected(7);

  bool get hasAnyWeekday => mask & weekdayMask != 0;
  bool get hasAnyWeekend => mask & weekendMask != 0;

  int get numberOfDaysSelected {
    int c = 0;
    for (int maskTest = 0; maskTest < 7; maskTest++) {
      if (mask & (1 << maskTest) != 0) c++;
    }
    return c;
  }

  bool get hasAny {
    for (int maskTest = 0; maskTest < 7; maskTest++) {
      if (mask & (1 << maskTest) != 0) return true;
    }
    return false;
  }

  WeekdayMask setDay(int weekday, bool value) {
    if (weekday == null || value == null) return new WeekdayMask(mask);
    if (weekday == 0) weekday = 7;

    return new WeekdayMask(value == true
        ? mask & weekdayToMaskVal[weekday]
        : mask & ~weekdayToMaskVal[weekday]);
  }

  WeekdayMask setDayName(String weekdayName, bool value,
      {Map<String, int> dayMap = dayNameToMaskVal}) {
    if (weekdayName == null) return new WeekdayMask(mask);

    return new WeekdayMask(value == true
        ? mask & dayMap[weekdayName.toUpperCase()]
        : mask & ~dayMap[weekdayName.toUpperCase()]);
  }

  WeekdayMask toggleDay(int weekday) {
    if (weekday == null) return new WeekdayMask(mask);
    if (weekday == 0) weekday = 7;

    return new WeekdayMask(mask ^ weekdayToMaskVal[weekday]);
  }

  WeekdayMask toggleDayName(String weekdayName,
      {Map<String, int> dayMap = dayNameToMaskVal}) {
    if (weekdayName == null) return new WeekdayMask(mask);

    return new WeekdayMask(mask ^ dayMap[weekdayName.toUpperCase()]);
  }

  bool isWeekdaySelected(int weekday) {
    return mask & weekdayToMaskVal[weekday] != 0;
  }

  bool isDayNameSelected(String day,
      {Map<String, int> dayMap = dayNameToMaskVal}) {
    return mask & dayMap[day.toUpperCase()] != 0;
  }

  Iterable<int> toIterable() sync* {
    for (int maskTest = 0; maskTest < 7; maskTest++) {
      if (mask & (1 << maskTest) != 0) yield maskTest + 1;
    }
  }

  List<int> toList() {
    return toIterable().toList(growable: false);
  }
}
