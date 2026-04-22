enum TransactionType {
  expense,
  income,
}

extension TransactionTypeX on TransactionType {
  String get label => switch (this) {
        TransactionType.expense => 'Expense',
        TransactionType.income => 'Income',
      };
}
