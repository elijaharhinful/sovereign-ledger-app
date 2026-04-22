import '../../transactions/domain/transaction_category.dart';
import 'budget_status.dart';

class Budget {
  final String id;
  final int categoryIndex;
  final double limit;
  final DateTime startDate;
  final DateTime endDate;

  Budget({
    required this.id,
    required this.categoryIndex,
    required this.limit,
    required this.startDate,
    required this.endDate,
  });

  TransactionCategory get category => TransactionCategory.values[categoryIndex];

  Budget copyWith({
    String? id,
    int? categoryIndex,
    double? limit,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Budget(
      id: id ?? this.id,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      limit: limit ?? this.limit,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

class BudgetWithSpending {
  final Budget budget;
  final double spent;

  BudgetWithSpending({required this.budget, required this.spent});

  double get remaining => budget.limit - spent;
  double get percentage =>
      budget.limit > 0 ? (spent / budget.limit).clamp(0.0, 1.0) : 0.0;

  BudgetStatus get status {
    if (percentage >= 1.0) return BudgetStatus.overLimit;
    if (percentage >= 0.9) return BudgetStatus.atLimit;
    if (percentage <= 0.5) return BudgetStatus.healthy;
    return BudgetStatus.onTrack;
  }
}
