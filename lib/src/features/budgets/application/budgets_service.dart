import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../database/database.dart';
import '../data/budgets_repository.dart';
import '../domain/budget.dart';
import '../../transactions/application/transactions_service.dart';
import '../../transactions/domain/transaction_category.dart';
import '../../transactions/domain/transaction_type.dart';

// Repository Provider
final budgetsRepositoryProvider = Provider<BudgetsRepository>((ref) {
  return BudgetsRepository(ref.watch(databaseProvider));
});

// Stream Provider — auto-reactive list
final budgetsStreamProvider = StreamProvider<List<Budget>>((ref) {
  return ref.watch(budgetsRepositoryProvider).watchAll();
});

// AsyncNotifier — mutations only
final budgetsProvider = AsyncNotifierProvider<BudgetsNotifier, List<Budget>>(
  BudgetsNotifier.new,
);

class BudgetsNotifier extends AsyncNotifier<List<Budget>> {
  final _uuid = const Uuid();

  @override
  Future<List<Budget>> build() {
    return ref.watch(budgetsStreamProvider.future);
  }

  BudgetsRepository get _repo => ref.read(budgetsRepositoryProvider);

  Future<void> addBudget({
    required TransactionCategory category,
    required double limit,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final budget = Budget(
      id: _uuid.v4(),
      categoryIndex: category.index,
      limit: limit,
      startDate: startDate,
      endDate: endDate,
    );
    await _repo.add(budget);
  }

  Future<void> updateBudget(Budget budget) async {
    await _repo.update(budget);
  }

  Future<void> deleteBudget(String id) async {
    await _repo.delete(id);
  }
}

// Derived Providers
final budgetsWithSpendingProvider = Provider<List<BudgetWithSpending>>((ref) {
  final budgetsAsync = ref.watch(budgetsProvider);
  final transactionsAsync = ref.watch(transactionsProvider);

  final budgets = budgetsAsync.value ?? [];
  final transactions = transactionsAsync.value ?? [];

  return budgets.map((budget) {
    final spent = transactions
        .where((t) =>
            t.category == budget.category &&
            t.type == TransactionType.expense &&
            t.date.isAfter(budget.startDate) &&
            t.date.isBefore(budget.endDate.add(const Duration(days: 1))))
        .fold<double>(0.0, (sum, t) => sum + t.amount);

    return BudgetWithSpending(budget: budget, spent: spent);
  }).toList()
    ..sort((a, b) => b.percentage.compareTo(a.percentage));
});

final monthlyBudgetSummaryProvider =
    Provider<({double totalBudget, double totalSpent, double percentage})>(
        (ref) {
  final budgetsWithSpending = ref.watch(budgetsWithSpendingProvider);
  final totalBudget =
      budgetsWithSpending.fold(0.0, (sum, b) => sum + b.budget.limit);
  final totalSpent = budgetsWithSpending.fold(0.0, (sum, b) => sum + b.spent);
  final percentage =
      totalBudget > 0 ? (totalSpent / totalBudget).clamp(0.0, 1.0) : 0.0;
  return (
    totalBudget: totalBudget,
    totalSpent: totalSpent,
    percentage: percentage,
  );
});
