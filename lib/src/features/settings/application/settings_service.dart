import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import '../../../database/database.dart';
import '../data/settings_repository.dart';
import '../domain/app_settings.dart';
import '../../transactions/application/transactions_service.dart';
import '../../transactions/domain/transaction_type.dart';
import '../../transactions/domain/transaction_category.dart';

// Repository Provider
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(databaseProvider));
});

// Stream Provider — auto-reactive settings
final settingsStreamProvider = StreamProvider<AppSettings>((ref) {
  return ref.watch(settingsRepositoryProvider).watchSettings();
});

// AsyncNotifier — mutations only
final settingsProvider = AsyncNotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);

class SettingsNotifier extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() {
    return ref.watch(settingsStreamProvider.future);
  }

  SettingsRepository get _repo => ref.read(settingsRepositoryProvider);

  Future<void> updateSettings(AppSettings settings) async {
    await _repo.saveSettings(settings);
  }

  Future<void> toggleBiometrics() async {
    final current = state.value ?? AppSettings();
    await _repo.saveSettings(
      current.copyWith(biometricsEnabled: !current.biometricsEnabled),
    );
  }
}

// Export Service
final exportServiceProvider = Provider<ExportService>((ref) {
  return ExportService(ref);
});

class ExportService {
  final Ref _ref;
  ExportService(this._ref);

  Future<String> exportCsv() async {
    final transactions = _ref.read(transactionsProvider).value ?? [];
    final rows = <List<dynamic>>[
      ['ID', 'Date', 'Type', 'Category', 'Amount', 'Note'],
      ...transactions.map((t) => [
            t.id,
            t.date.toIso8601String(),
            t.type.label,
            t.category.label,
            t.amount.toStringAsFixed(2),
            t.note ?? '',
          ]),
    ];

    final csvString = csv.encode(rows);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/sovereign_ledger_export.csv');
    await file.writeAsString(csvString);
    return file.path;
  }
}
