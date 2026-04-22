import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/transactions/application/transactions_service.dart';
import '../../../features/budgets/application/budgets_service.dart';
import '../../../features/settings/application/settings_service.dart';
import '../../../features/settings/domain/app_settings.dart';

final dashboardSummaryProvider = Provider((ref) {
  final txNotifier = ref.watch(transactionsProvider.notifier);
  final settings = ref.watch(settingsProvider).value ?? AppSettings();
  final monthlyBudget = ref.watch(monthlyBudgetSummaryProvider);

  return (
    balance: txNotifier.balance,
    totalIncome: txNotifier.totalIncome,
    totalExpenses: txNotifier.totalExpenses,
    monthlyBudgetLimit: settings.monthlyBudgetLimit,
    monthlySpent: monthlyBudget.totalSpent,
    monthlyBudgetPct: monthlyBudget.percentage,
    currencyCode: settings.currencyCode,
    currencySymbol: settings.currencySymbol,
    userName: settings.userName,
  );
});
