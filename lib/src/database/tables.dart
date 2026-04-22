import 'package:drift/drift.dart';

// Transactions
class TransactionsTable extends Table {
  @override
  String get tableName => 'transactions';

  TextColumn get id => text()();
  RealColumn get amount => real()();
  IntColumn get typeIndex => integer()();
  IntColumn get categoryIndex => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().nullable()();
  BoolColumn get isRecurring => boolean().withDefault(const Constant(false))();
  TextColumn get recurringId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Budgets
class BudgetsTable extends Table {
  @override
  String get tableName => 'budgets';

  TextColumn get id => text()();
  IntColumn get categoryIndex => integer()();
  RealColumn get budgetLimit => real()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Recurring Transactions
class RecurringTransactionsTable extends Table {
  @override
  String get tableName => 'recurring_transactions';

  TextColumn get id => text()();
  RealColumn get amount => real()();
  IntColumn get typeIndex => integer()();
  IntColumn get categoryIndex => integer()();
  IntColumn get intervalIndex => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get lastPosted => dateTime().nullable()();
  TextColumn get note => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

// App Settings (single-row table, id always = 1)
class AppSettingsTable extends Table {
  @override
  String get tableName => 'app_settings';

  IntColumn get id => integer()();
  TextColumn get currencyCode => text().withDefault(const Constant('USD'))();
  TextColumn get currencySymbol => text().withDefault(const Constant('\$'))();
  TextColumn get language =>
      text().withDefault(const Constant('English (US)'))();
  BoolColumn get biometricsEnabled =>
      boolean().withDefault(const Constant(true))();
  TextColumn get userName =>
      text().withDefault(const Constant('Alexander Sterling'))();
  RealColumn get monthlyBudgetLimit =>
      real().withDefault(const Constant(6850.0))();

  @override
  Set<Column> get primaryKey => {id};
}
