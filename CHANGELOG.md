# CHANGELOG

## 0.2.1

- Fix cases where adding negative days worked incorrectly.

## 0.2.0

- Change constant names to lower case for compatibility with newer versions of Dart
- Push minimum SDK constraint up

## 0.1.6

- Bug fix in addDays/addMonths
- Add unit tests for iterators, addDays

## 0.1.5

- Add missing export

## 0.1.4

- Make calendar iterators more generic friendly
- Move claendar iterators to their own file

## 0.1.3

- Bugfix for `WeekdayMask.fromInteger()`

## 0.1.2

- Add class to handle weekday masks
- Fix bad file references in test/example

## 0.1.1

- Fix dart analysis issues (remove unused import, fix type issue on compareTo)
- Throw error if `compareTo` is called with a non-Gregorian date

## 0.1.0

- Initial publication
