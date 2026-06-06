import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class OnboardingService {
  OnboardingService(this._prefs);

  final SharedPreferences _prefs;

  static const _langShownKey = 'onboarding_language_shown';

  bool get isLanguageSelectionShown => _prefs.getBool(_langShownKey) ?? false;

  Future<void> markLanguageSelectionShown() =>
      _prefs.setBool(_langShownKey, true);
}
