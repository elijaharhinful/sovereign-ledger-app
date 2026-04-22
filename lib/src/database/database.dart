import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tables.dart';
import '../features/transactions/domain/transaction.dart' as domain;
import '../features/budgets/domain/budget.dart' as domain;
import '../features/recurring/domain/recurring_transaction.dart' as domain;
import '../features/settings/domain/app_settings.dart' as domain;

part 'database.g.dart';

// Database
@DriftDatabase(tables: [
  TransactionsTable,
  BudgetsTable,
  RecurringTransactionsTable,
  AppSettingsTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Transactions ──────────────────────────────

  /// Emits the full sorted list whenever the table changes.
  Stream<List<domain.Transaction>> watchAllTransactions() {
    return (select(transactionsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch()
        .map((rows) => rows.map(_rowToTransaction).toList());
  }

  Future<List<domain.Transaction>> getAllTransactions() async {
    final rows = await (select(transactionsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
    return rows.map(_rowToTransaction).toList();
  }

  Future<void> insertTransaction(domain.Transaction tx) {
    return into(transactionsTable).insertOnConflictUpdate(
      TransactionsTableCompanion.insert(
        id: tx.id,
        amount: tx.amount,
        typeIndex: tx.typeIndex,
        categoryIndex: tx.categoryIndex,
        date: tx.date,
        note: Value(tx.note),
        isRecurring: Value(tx.isRecurring),
        recurringId: Value(tx.recurringId),
      ),
    );
  }

  Future<void> updateTransaction(domain.Transaction tx) {
    return (update(transactionsTable)..where((t) => t.id.equals(tx.id))).write(
      TransactionsTableCompanion(
        amount: Value(tx.amount),
        typeIndex: Value(tx.typeIndex),
        categoryIndex: Value(tx.categoryIndex),
        date: Value(tx.date),
        note: Value(tx.note),
        isRecurring: Value(tx.isRecurring),
        recurringId: Value(tx.recurringId),
      ),
    );
  }

  Future<void> deleteTransaction(String id) {
    return (delete(transactionsTable)..where((t) => t.id.equals(id))).go();
  }

  domain.Transaction _rowToTransaction(TransactionsTableData r) {
    return domain.Transaction(
      id: r.id,
      amount: r.amount,
      typeIndex: r.typeIndex,
      categoryIndex: r.categoryIndex,
      date: r.date,
      note: r.note,
      isRecurring: r.isRecurring,
      recurringId: r.recurringId,
    );
  }

  // Budgets ───────────────────────────────────

  Stream<List<domain.Budget>> watchAllBudgets() {
    return select(budgetsTable).watch().map(
          (rows) => rows.map(_rowToBudget).toList(),
        );
  }

  Future<List<domain.Budget>> getAllBudgets() async {
    final rows = await select(budgetsTable).get();
    return rows.map(_rowToBudget).toList();
  }

  Future<void> insertBudget(domain.Budget budget) {
    return into(budgetsTable).insertOnConflictUpdate(
      BudgetsTableCompanion.insert(
        id: budget.id,
        categoryIndex: budget.categoryIndex,
        budgetLimit: budget.limit,
        startDate: budget.startDate,
        endDate: budget.endDate,
      ),
    );
  }

  Future<void> updateBudget(domain.Budget budget) {
    return (update(budgetsTable)..where((t) => t.id.equals(budget.id))).write(
      BudgetsTableCompanion(
        categoryIndex: Value(budget.categoryIndex),
        budgetLimit: Value(budget.limit),
        startDate: Value(budget.startDate),
        endDate: Value(budget.endDate),
      ),
    );
  }

  Future<void> deleteBudget(String id) {
    return (delete(budgetsTable)..where((t) => t.id.equals(id))).go();
  }

  domain.Budget _rowToBudget(BudgetsTableData r) {
    return domain.Budget(
      id: r.id,
      categoryIndex: r.categoryIndex,
      limit: r.budgetLimit,
      startDate: r.startDate,
      endDate: r.endDate,
    );
  }

  // Recurring Transactions ─────────────────────

  Stream<List<domain.RecurringTransaction>> watchAllRecurring() {
    return select(recurringTransactionsTable).watch().map(
          (rows) => rows.map(_rowToRecurring).toList(),
        );
  }

  Future<List<domain.RecurringTransaction>> getAllRecurring() async {
    final rows = await select(recurringTransactionsTable).get();
    return rows.map(_rowToRecurring).toList();
  }

  Future<void> insertRecurring(domain.RecurringTransaction rt) {
    return into(recurringTransactionsTable).insertOnConflictUpdate(
      RecurringTransactionsTableCompanion.insert(
        id: rt.id,
        amount: rt.amount,
        typeIndex: rt.typeIndex,
        categoryIndex: rt.categoryIndex,
        intervalIndex: rt.intervalIndex,
        startDate: rt.startDate,
        lastPosted: Value(rt.lastPosted),
        note: Value(rt.note),
        isActive: Value(rt.isActive),
      ),
    );
  }

  Future<void> updateRecurring(domain.RecurringTransaction rt) {
    return (update(recurringTransactionsTable)
          ..where((t) => t.id.equals(rt.id)))
        .write(
      RecurringTransactionsTableCompanion(
        amount: Value(rt.amount),
        typeIndex: Value(rt.typeIndex),
        categoryIndex: Value(rt.categoryIndex),
        intervalIndex: Value(rt.intervalIndex),
        startDate: Value(rt.startDate),
        lastPosted: Value(rt.lastPosted),
        note: Value(rt.note),
        isActive: Value(rt.isActive),
      ),
    );
  }

  Future<void> deleteRecurring(String id) {
    return (delete(recurringTransactionsTable)..where((t) => t.id.equals(id)))
        .go();
  }

  domain.RecurringTransaction _rowToRecurring(
      RecurringTransactionsTableData r) {
    return domain.RecurringTransaction(
      id: r.id,
      amount: r.amount,
      typeIndex: r.typeIndex,
      categoryIndex: r.categoryIndex,
      intervalIndex: r.intervalIndex,
      startDate: r.startDate,
      lastPosted: r.lastPosted,
      note: r.note,
      isActive: r.isActive,
    );
  }

  // App Settings ──────────────────────────────

  static const _settingsId = 1;

  /// Emits whenever settings change. Inserts default row if not present.
  Stream<domain.AppSettings> watchSettings() {
    return (select(appSettingsTable)..where((t) => t.id.equals(_settingsId)))
        .watchSingle()
        .map(_rowToSettings);
  }

  Future<domain.AppSettings> getSettings() async {
    final row = await (select(appSettingsTable)
          ..where((t) => t.id.equals(_settingsId)))
        .getSingleOrNull();
    if (row == null) {
      await _insertDefaultSettings();
      return domain.AppSettings();
    }
    return _rowToSettings(row);
  }

  Future<void> saveSettings(domain.AppSettings s) async {
    await into(appSettingsTable).insertOnConflictUpdate(
      AppSettingsTableCompanion.insert(
        id: const Value(_settingsId),
        currencyCode: Value(s.currencyCode),
        currencySymbol: Value(s.currencySymbol),
        language: Value(s.language),
        biometricsEnabled: Value(s.biometricsEnabled),
        userName: Value(s.userName),
        monthlyBudgetLimit: Value(s.monthlyBudgetLimit),
      ),
    );
  }

  Future<void> _insertDefaultSettings() {
    return into(appSettingsTable).insertOnConflictUpdate(
      AppSettingsTableCompanion.insert(id: const Value(_settingsId)),
    );
  }

  domain.AppSettings _rowToSettings(AppSettingsTableData r) {
    return domain.AppSettings(
      currencyCode: r.currencyCode,
      currencySymbol: r.currencySymbol,
      language: r.language,
      biometricsEnabled: r.biometricsEnabled,
      userName: r.userName,
      monthlyBudgetLimit: r.monthlyBudgetLimit,
    );
  }
}

// Connection
QueryExecutor _openConnection() {
  return driftDatabase(name: 'sovereign_ledger');
}

// Riverpod Provider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
