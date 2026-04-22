import '../../../database/database.dart';
import '../domain/budget.dart';

class BudgetsRepository {
  final AppDatabase _db;

  BudgetsRepository(this._db);

  // ── Streams (reactive) ──────────────────────

  Stream<List<Budget>> watchAll() => _db.watchAllBudgets();

  // ── Queries ─────────────────────────────────

  Future<List<Budget>> getAll() => _db.getAllBudgets();

  Future<Budget?> getById(String id) async {
    final all = await _db.getAllBudgets();
    try {
      return all.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  // ── Mutations ────────────────────────────────

  Future<void> add(Budget budget) => _db.insertBudget(budget);

  Future<void> update(Budget budget) => _db.updateBudget(budget);

  Future<void> delete(String id) => _db.deleteBudget(id);
}
