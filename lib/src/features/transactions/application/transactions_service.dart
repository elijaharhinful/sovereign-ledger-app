import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../database/database.dart';
import '../data/transactions_repository.dart';
import '../domain/transaction.dart';
import '../domain/transaction_type.dart';
import '../domain/transaction_category.dart';

final transactionsRepositoryProvider = Provider<TransactionsRepository>((ref) {
  return TransactionsRepository(ref.watch(databaseProvider));
});

final transactionsStreamProvider = StreamProvider<List<Transaction>>((ref) {
  return ref.watch(transactionsRepositoryProvider).watchAll();
});

final transactionsProvider =
    AsyncNotifierProvider<TransactionsNotifier, List<Transaction>>(
  TransactionsNotifier.new,
);

class TransactionsNotifier extends AsyncNotifier<List<Transaction>> {
  final _uuid = const Uuid();

  @override
  Future<List<Transaction>> build() {
    // Delegate to the stream — Riverpod re-runs build() on every emission
    return ref.watch(transactionsStreamProvider.future);
  }

  TransactionsRepository get _repo => ref.read(transactionsRepositoryProvider);

  Future<void> addTransaction({
    required double amount,
    required TransactionType type,
    required TransactionCategory category,
    required DateTime date,
    String? note,
    bool isRecurring = false,
    String? recurringId,
  }) async {
    final tx = Transaction(
      id: _uuid.v4(),
      amount: amount,
      typeIndex: type.index,
      categoryIndex: category.index,
      date: date,
      note: note,
      isRecurring: isRecurring,
      recurringId: recurringId,
    );
    await _repo.add(tx);
    // No manual reload — Drift stream fires automatically
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _repo.update(transaction);
  }

  Future<void> deleteTransaction(String id) async {
    await _repo.delete(id);
  }

  // ── Derived helpers (operate on current state) ──

  List<Transaction> getByCategory(TransactionCategory category) {
    final transactions = state.value ?? [];
    return transactions.where((t) => t.category == category).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  List<Transaction> getThisMonth() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    final transactions = state.value ?? [];
    return transactions
        .where((t) => t.date.isAfter(start) && t.date.isBefore(end))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  double get totalIncome {
    final transactions = state.value ?? [];
    return transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalExpenses {
    final transactions = state.value ?? [];
    return transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get balance => totalIncome - totalExpenses;

  Map<TransactionCategory, double> getMonthlyExpensesByCategory() {
    final monthly =
        getThisMonth().where((t) => t.type == TransactionType.expense);
    final map = <TransactionCategory, double>{};
    for (final tx in monthly) {
      map[tx.category] = (map[tx.category] ?? 0) + tx.amount;
    }
    return map;
  }

  List<double> getWeeklySpending() {
    final now = DateTime.now();
    final weekly = List<double>.filled(7, 0);
    final transactions = state.value ?? [];
    for (final tx in transactions) {
      if (tx.type == TransactionType.expense) {
        final diff = now.difference(tx.date).inDays;
        if (diff >= 0 && diff < 7) {
          weekly[6 - diff] += tx.amount;
        }
      }
    }
    return weekly;
  }
}
