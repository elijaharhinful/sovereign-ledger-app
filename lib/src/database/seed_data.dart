import 'package:uuid/uuid.dart';
import 'database.dart';
import '../features/transactions/domain/transaction.dart';
import '../features/transactions/domain/transaction_type.dart';
import '../features/transactions/domain/transaction_category.dart';
import '../features/budgets/domain/budget.dart';

class SeedData {
  static const _uuid = Uuid();

  static Future<void> populate(AppDatabase db) async {
    final existing = await db.getAllTransactions();
    if (existing.isNotEmpty) return;

    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);

    final transactions = [
      _tx('Main Salary Deposit', 45000.0, TransactionType.income, TransactionCategory.salary, now.subtract(const Duration(days: 3)), 'Monthly salary'),
      _tx('Apple Store', 1295.0, TransactionType.expense, TransactionCategory.shop, now.subtract(const Duration(hours: 2)), 'Subscription'),
      _tx('Design Payment', 1291.0, TransactionType.income, TransactionCategory.salary, now.subtract(const Duration(hours: 4)), 'Freelance'),
      _tx('Netflix', 1291.0, TransactionType.expense, TransactionCategory.entertainment, now.subtract(const Duration(days: 1)), 'Subscription'),
      _tx('Amazon Prime', 118.0, TransactionType.expense, TransactionCategory.shop, now.subtract(const Duration(days: 1)), 'Subscription'),
      _tx('Spotify', 5.99, TransactionType.expense, TransactionCategory.entertainment, now.subtract(const Duration(days: 2)), 'Subscription'),
      _tx('Adobe Creative Cloud', 52.99, TransactionType.expense, TransactionCategory.shop, now.subtract(const Duration(days: 2)), 'Subscription'),
      _tx('Google Workspace', 12.0, TransactionType.income, TransactionCategory.salary, now.subtract(const Duration(days: 3)), 'Credit'),
      _tx('Microsoft Office 365', 69.99, TransactionType.expense, TransactionCategory.shop, now.subtract(const Duration(days: 3)), 'Subscription'),
      _tx('Zoom', 14.99, TransactionType.expense, TransactionCategory.other, now.subtract(const Duration(days: 4)), 'Subscription'),
      _tx('Hulu', 5.99, TransactionType.expense, TransactionCategory.entertainment, now.subtract(const Duration(days: 4)), 'Subscription'),
      _tx('Slack', 8.0, TransactionType.expense, TransactionCategory.other, now.subtract(const Duration(days: 5)), 'Subscription'),
      _tx('Dropbox', 11.0, TransactionType.expense, TransactionCategory.other, now.subtract(const Duration(days: 5)), 'Subscription'),
      _tx('Trello', 9.99, TransactionType.expense, TransactionCategory.other, now.subtract(const Duration(days: 6)), 'Subscription'),
    ];

    for (final tx in transactions) {
      await db.insertTransaction(tx);
    }

    final budgets = [
      _budget(TransactionCategory.utilities, 150.0, monthStart),
      _budget(TransactionCategory.entertainment, 200.0, monthStart),
      _budget(TransactionCategory.groceries, 250.0, monthStart),
      _budget(TransactionCategory.transport, 100.0, monthStart),
      _budget(TransactionCategory.health, 120.0, monthStart),
      _budget(TransactionCategory.shop, 180.0, monthStart),
    ];

    for (final b in budgets) {
      await db.insertBudget(b);
    }

    await db.saveSettings(
      (await db.getSettings()).copyWith(
        userName: 'Alexander Sterling',
        monthlyBudgetLimit: 6850.0,
        currencyCode: 'USD',
        currencySymbol: '\$',
      ),
    );
  }

  static Transaction _tx(
    String note,
    double amount,
    TransactionType type,
    TransactionCategory category,
    DateTime date,
    String? extra,
  ) =>
      Transaction(
        id: _uuid.v4(),
        amount: amount,
        typeIndex: type.index,
        categoryIndex: category.index,
        date: date,
        note: note,
        isRecurring: false,
        recurringId: null,
      );

  static Budget _budget(
    TransactionCategory category,
    double limit,
    DateTime start,
  ) =>
      Budget(
        id: _uuid.v4(),
        categoryIndex: category.index,
        limit: limit,
        startDate: start,
        endDate: DateTime(start.year, start.month + 1, 0, 23, 59, 59),
      );
}
