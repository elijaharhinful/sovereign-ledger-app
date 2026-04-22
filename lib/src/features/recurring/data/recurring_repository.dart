import '../../../database/database.dart';
import '../domain/recurring_transaction.dart';

class RecurringRepository {
  final AppDatabase _db;

  RecurringRepository(this._db);

  Stream<List<RecurringTransaction>> watchAll() => _db.watchAllRecurring();

  Future<List<RecurringTransaction>> getAll() => _db.getAllRecurring();

  Future<void> add(RecurringTransaction rt) => _db.insertRecurring(rt);

  Future<void> update(RecurringTransaction rt) => _db.updateRecurring(rt);

  Future<void> delete(String id) => _db.deleteRecurring(id);
}
