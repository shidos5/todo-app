extension TimeExtension on DateTime{
  String get toFormatDate{
    return '$day/ $month/ $year';
  }

  
  String get dayName {
    List<String> days = ["mon", "tue", "wed", "thurs", "fri", "sat", "sun"];
    return days[weekday - 1];
  }
}