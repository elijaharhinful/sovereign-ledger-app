import 'transaction_category.dart';
import 'transaction_type.dart';

class Transaction {
  final String id;
  final double amount;
  final int typeIndex;
  final int categoryIndex;
  final DateTime date;
  final String? note;
  final bool isRecurring;
  final String? recurringId;

  Transaction({
    required this.id,
    required this.amount,
    required this.typeIndex,
    required this.categoryIndex,
    required this.date,
    this.note,
    this.isRecurring = false,
    this.recurringId,
  });

  TransactionType get type => TransactionType.values[typeIndex];
  TransactionCategory get category => TransactionCategory.values[categoryIndex];

  Transaction copyWith({
    String? id,
    double? amount,
    int? typeIndex,
    int? categoryIndex,
    DateTime? date,
    String? note,
    bool? isRecurring,
    String? recurringId,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      typeIndex: typeIndex ?? this.typeIndex,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      date: date ?? this.date,
      note: note ?? this.note,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringId: recurringId ?? this.recurringId,
    );
  }
}
