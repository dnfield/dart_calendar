// Constants for use in gregorian caledar. Not to be exported.

const int monthsPerYear = 12;
const int daysPerWeek = 7;

const List<int> daysPerMonth = const <int>[
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

const num avgDaysPerMonth = 30.4375;

// approx 365.24, but actually calculating it gets us a better number for math
const num avgDaysPerYear = avgDaysPerMonth * monthsPerYear; 

const List<int> daysInYearPreceedingMonth = const <int>[
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

const List<int> sakamotoHelper = const <int>[
  0,
  3,
  2,
  5,
  0,
  3,
  5,
  1,
  4,
  6,
  2,
  4
];