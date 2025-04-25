import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/strings.dart';

/// Extension method to get localized strings easier

/// Utility methods for localization
class Localization {
  Localization._();

  /// Get all available locales
  static List<Locale> get supportedLocales => Strings.supportedLocales;

  /// Get all localization delegates
  static List<LocalizationsDelegate<dynamic>> get localizationDelegates =>
      Strings.localizationsDelegates;

  /// Get a friendly display name for a locale
  static String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'es':
        return 'Español';
      case 'en':
      default:
        return 'English';
    }
  }

  /// Get a display name for the current locale
  static String getCurrentLanguageName(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return getLanguageName(locale.languageCode);
  }

  /// Get a flag emoji for a language
  static String getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'es':
        return '🇪🇸';
      case 'en':
      default:
        return '🇬🇧';
    }
  }
}

// 1. Define Locale State
class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState(this.locale);

  @override
  List<Object> get props => [locale];
}

// 2. Define Locale Events
@immutable
abstract class LocaleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeLocaleEvent extends LocaleEvent {
  final String languageCode;

  ChangeLocaleEvent(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}

class LoadLocaleEvent extends LocaleEvent {}

// 3. Implement the LocaleBloc
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  static const String LOCALE_KEY = 'app_locale';

  LocaleBloc() : super(const LocaleState(Locale('en'))) {
    on<ChangeLocaleEvent>(_onChangeLocale);
    on<LoadLocaleEvent>(_onLoadLocale);
  }

  Future<void> _onChangeLocale(
      ChangeLocaleEvent event, Emitter<LocaleState> emit) async {
    final locale = Locale(event.languageCode);
    emit(LocaleState(locale));

    // Save the selected locale
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LOCALE_KEY, event.languageCode);
  }

  Future<void> _onLoadLocale(
      LoadLocaleEvent event, Emitter<LocaleState> emit) async {
    // Load saved locale
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString(LOCALE_KEY);

    if (languageCode != null) {
      emit(LocaleState(Locale(languageCode)));
    }
  }
}

// 4. Extend your existing Localization class with BLoC helpers
extension LocaleBlocExtension on Localization {
  static void changeLocale(BuildContext context, String languageCode) {
    context.read<LocaleBloc>().add(ChangeLocaleEvent(languageCode));
  }

  static Locale getCurrentLocale(BuildContext context) {
    return context.select((LocaleBloc bloc) => bloc.state.locale);
  }

  static bool isCurrentLocale(BuildContext context, String languageCode) {
    final currentLocale = getCurrentLocale(context);
    return currentLocale.languageCode == languageCode;
  }
}

// 5. Update your BuildContext extension
extension LocalizationExtension on BuildContext {
  Strings get strings => Strings.of(this)!;

  Locale get currentLocale => read<LocaleBloc>().state.locale;

  void changeLocale(String languageCode) {
    read<LocaleBloc>().add(ChangeLocaleEvent(languageCode));
  }
}
