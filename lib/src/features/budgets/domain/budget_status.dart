enum BudgetStatus {
  healthy,
  onTrack,
  atLimit,
  overLimit,
}

extension BudgetStatusX on BudgetStatus {
  String get label => switch (this) {
    BudgetStatus.healthy => 'HEALTHY',
    BudgetStatus.onTrack => 'ON TRACK',
    BudgetStatus.atLimit => 'AT LIMIT',
    BudgetStatus.overLimit => 'OVER LIMIT',
  };
}
