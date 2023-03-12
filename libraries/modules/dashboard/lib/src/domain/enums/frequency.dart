enum Frequency {
  today(displayName: "Hoje", value: "today"),
  week(displayName: "7d", value: "this_week"),
  month(displayName: "30d", value: "this_month");

  final String displayName;
  final String value;

  const Frequency({required this.displayName, required this.value});
}
