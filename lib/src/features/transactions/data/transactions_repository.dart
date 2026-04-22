import '../../../database/database.dart';
import '../domain/transaction.dart';
import '../domain/transaction_type.dart';
import '../domain/transaction_category.dart';

class TransactionsRepository {
  final AppDatabase _db;

  TransactionsRepository(this._db);

  Stream<List<Transaction>> watchAll() => _db.watchAllTransactions();

  Future<List<Transaction>> getAll() => _db.getAllTransactions();

  Future<List<Transaction>> getByCategory(TransactionCategory category) async {
    final all = await _db.getAllTransactions();
    return all.where((t) => t.category == category).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<List<Transaction>> getByDateRange(DateTime from, DateTime to) async {
    final all = await _db.getAllTransactions();
    return all
        .where((t) => t.date.isAfter(from) && t.date.isBefore(to))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  // ── Mutations ────────────────────────────────

  Future<void> add(Transaction transaction) =>
      _db.insertTransaction(transaction);

  Future<void> update(Transaction transaction) =>
      _db.updateTransaction(transaction);

  Future<void> delete(String id) => _db.deleteTransaction(id);

  // ── Aggregates ───────────────────────────────

  Future<double> getTotalIncome() async {
    final all = await _db.getAllTransactions();
    return all
        .where((t) => t.type == TransactionType.income)
        .fold<double>(0.0, (sum, t) => sum + t.amount);
  }

  Future<double> getTotalExpenses() async {
    final all = await _db.getAllTransactions();
    return all
        .where((t) => t.type == TransactionType.expense)
        .fold<double>(0.0, (sum, t) => sum + t.amount);
  }

  Future<double> getBalance() async {
    final income = await getTotalIncome();
    final expenses = await getTotalExpenses();
    return income - expenses;
  }
}
