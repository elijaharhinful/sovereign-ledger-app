enum RecurrenceInterval {
  daily,
  weekly,
  monthly,
}

extension RecurrenceIntervalX on RecurrenceInterval {
  String get label => switch (this) {
        RecurrenceInterval.daily => 'Daily',
        RecurrenceInterval.weekly => 'Weekly',
        RecurrenceInterval.monthly => 'Monthly',
      };

  Duration get duration => switch (this) {
        RecurrenceInterval.daily => const Duration(days: 1),
        RecurrenceInterval.weekly => const Duration(days: 7),
        RecurrenceInterval.monthly => const Duration(days: 30),
      };
}
