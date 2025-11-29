class DateTimeUtils {
  DateTimeUtils._();

  static List<List<DateTime>> generateWeeks(
    DateTime startDate,
    int totalWeeks,
  ) {
    List<List<DateTime>> weeks = [];

    DateTime current = startDate;

    for (int w = 0; w < totalWeeks; w++) {
      List<DateTime> week = [];

      for (int d = 0; d < 7; d++) {
        week.add(current);
        current = current.add(Duration(days: 1));
      }

      weeks.add(week);
    }

    return weeks;
  }

  static String formatFullDate(DateTime date) {
    const weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];

    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    String weekday = weekdays[date.weekday - 1];
    String month = months[date.month - 1];

    return "$weekday, $month ${date.day}, ${date.year}";
  }
}
