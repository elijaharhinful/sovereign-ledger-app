import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../database/database.dart';
import '../data/recurring_repository.dart';
import '../domain/recurring_transaction.dart';
import '../domain/recurrence_interval.dart';
import '../../transactions/application/transactions_service.dart';
import '../../transactions/domain/transaction_category.dart';
import '../../transactions/domain/transaction_type.dart';

final recurringRepositoryProvider = Provider<RecurringRepository>((ref) {
  return RecurringRepository(ref.watch(databaseProvider));
});

final recurringStreamProvider =
    StreamProvider<List<RecurringTransaction>>((ref) {
  return ref.watch(recurringRepositoryProvider).watchAll();
});

final recurringProvider =
    AsyncNotifierProvider<RecurringNotifier, List<RecurringTransaction>>(
  RecurringNotifier.new,
);

class RecurringNotifier extends AsyncNotifier<List<RecurringTransaction>> {
  final _uuid = const Uuid();

  @override
  Future<List<RecurringTransaction>> build() async {
    final items = await ref.watch(recurringStreamProvider.future);
    // Auto-post any due recurring transactions on first load
    await _processDue(items);
    return items;
  }

  RecurringRepository get _repo => ref.read(recurringRepositoryProvider);

  /// Auto-post any recurring transactions that are due.
  Future<void> _processDue(List<RecurringTransaction> items) async {
    final now = DateTime.now();
    for (final rt in items) {
      if (!rt.isActive) continue;
      final lastPosted =
          rt.lastPosted ?? rt.startDate.subtract(rt.interval.duration);
      final nextDue = lastPosted.add(rt.interval.duration);
      if (now.isAfter(nextDue) || now.isAtSameMomentAs(nextDue)) {
        await ref.read(transactionsProvider.notifier).addTransaction(
              amount: rt.amount,
              type: rt.type,
              category: rt.category,
              date: now,
              note: rt.note ?? 'Recurring: ${rt.interval.label}',
              isRecurring: true,
              recurringId: rt.id,
            );
        final updated = rt.copyWith(lastPosted: now);
        await _repo.update(updated);
      }
    }
  }

  Future<void> addRecurring({
    required double amount,
    required TransactionType type,
    required TransactionCategory category,
    required RecurrenceInterval interval,
    required DateTime startDate,
    String? note,
  }) async {
    final rt = RecurringTransaction(
      id: _uuid.v4(),
      amount: amount,
      typeIndex: type.index,
      categoryIndex: category.index,
      intervalIndex: interval.index,
      startDate: startDate,
      note: note,
    );
    await _repo.add(rt);
  }

  Future<void> toggleActive(String id) async {
    final items = state.value ?? [];
    final rt = items.firstWhere((r) => r.id == id);
    await _repo.update(rt.copyWith(isActive: !rt.isActive));
  }

  Future<void> deleteRecurring(String id) async {
    await _repo.delete(id);
  }
}
