abstract class SettingsRepository {
  Future<bool> isFirstRun();
  Future<void> setFirstRunCompleted();
}
