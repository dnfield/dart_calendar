# Dart Calendar

A Calendar interface with a Gregorian Calendar implementation in Dart.

Treats whole days as the smallest unit of time; takes into account leap years.

Not well tested with BC dates (negative dates).

Gregorian implementation does not help you currently with historical dates of when the Gregorian calendar was adapted (e.g. if you want the local date in Denmark before the 1700s, you'll need to switch to Julian, and that's not handled here).