class AppSettings {
  final String currencyCode;
  final String currencySymbol;
  final String language;
  final bool biometricsEnabled;
  final String userName;
  final double monthlyBudgetLimit;

  AppSettings({
    this.currencyCode = 'USD',
    this.currencySymbol = '\$',
    this.language = 'English (US)',
    this.biometricsEnabled = true,
    this.userName = 'Alexander Sterling',
    this.monthlyBudgetLimit = 6850.0,
  });

  AppSettings copyWith({
    String? currencyCode,
    String? currencySymbol,
    String? language,
    bool? biometricsEnabled,
    String? userName,
    double? monthlyBudgetLimit,
  }) {
    return AppSettings(
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      language: language ?? this.language,
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      userName: userName ?? this.userName,
      monthlyBudgetLimit: monthlyBudgetLimit ?? this.monthlyBudgetLimit,
    );
  }
}
