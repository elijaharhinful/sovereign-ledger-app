import '../../transactions/domain/transaction_category.dart';
import '../../transactions/domain/transaction_type.dart';
import 'recurrence_interval.dart';

class RecurringTransaction {
  final String id;
  final double amount;
  final int typeIndex;
  final int categoryIndex;
  final int intervalIndex;
  final DateTime startDate;
  final DateTime? lastPosted;
  final String? note;
  final bool isActive;

  RecurringTransaction({
    required this.id,
    required this.amount,
    required this.typeIndex,
    required this.categoryIndex,
    required this.intervalIndex,
    required this.startDate,
    this.lastPosted,
    this.note,
    this.isActive = true,
  });

  TransactionType get type => TransactionType.values[typeIndex];
  TransactionCategory get category => TransactionCategory.values[categoryIndex];
  RecurrenceInterval get interval => RecurrenceInterval.values[intervalIndex];

  RecurringTransaction copyWith({
    String? id,
    double? amount,
    int? typeIndex,
    int? categoryIndex,
    int? intervalIndex,
    DateTime? startDate,
    DateTime? lastPosted,
    String? note,
    bool? isActive,
  }) {
    return RecurringTransaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      typeIndex: typeIndex ?? this.typeIndex,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      intervalIndex: intervalIndex ?? this.intervalIndex,
      startDate: startDate ?? this.startDate,
      lastPosted: lastPosted ?? this.lastPosted,
      note: note ?? this.note,
      isActive: isActive ?? this.isActive,
    );
  }
}
