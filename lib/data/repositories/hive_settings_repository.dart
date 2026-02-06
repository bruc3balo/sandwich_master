import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';
import 'package:sandwich_master/domain/repositories/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class HiveSettingsRepository implements SettingsRepository {
  final Box _settingsBox;

  HiveSettingsRepository(this._settingsBox);

  static const String _firstRunKey = 'is_first_run';

  @override
  Future<bool> isFirstRun() async {
    return _settingsBox.get(_firstRunKey, defaultValue: true);
  }

  @override
  Future<void> setFirstRunCompleted() async {
    await _settingsBox.put(_firstRunKey, false);
  }
}
