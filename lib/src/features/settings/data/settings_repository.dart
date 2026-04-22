import '../../../database/database.dart';
import '../domain/app_settings.dart';

class SettingsRepository {
  final AppDatabase _db;

  SettingsRepository(this._db);

  Stream<AppSettings> watchSettings() => _db.watchSettings();

  Future<AppSettings> getSettings() => _db.getSettings();

  Future<void> saveSettings(AppSettings settings) => _db.saveSettings(settings);
}
