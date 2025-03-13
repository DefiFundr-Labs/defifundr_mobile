// // ignore_for_file: public_member_api_docs

// // 🐦 Flutter imports:
// import 'package:defiraiser_mobile/core/global/themes/theme_state.dart';
// import 'package:defiraiser_mobile/core/global/themes/themes.dart';
// import 'package:flutter/material.dart';

// // 📦 Package imports:

// class ThemeNotifier extends StateNotifier<ThemeState> {
//   // final appCache = sl<AppCache>();
//   ThemeNotifier()
//       : super(
//           ThemeState.theme(
//             themeData: AppTheme.themeOptions[ThemeOptions.light]!,
//           ),
//         );

//   Future<void> setTheme(ThemeState theme) async {
//     // await appCache.saveThemeMode(theme.toString());
//     state = ThemeState.theme(themeData: AppTheme.themeOptions[theme]!);
//   }

//   ThemeData getTheme() {
//     // final themes = appCache.getThemeMode();
//     //   if (themes.isEmpty) {
//     //     state = ThemeState.theme(
//     //         themeData: AppTheme.themeOptions[ThemeOptions.Dark]!);
//     //     return AppTheme.themeOptions[ThemeOptions.Dark]!;
//     //   } else {
//     //     state = ThemeState.theme(themeData: AppTheme.themeOptions[themes]!);
//     return AppTheme.themeOptions[ThemeOptions.light]!;
//     //   }
//   }
// }

// final themeNotifierProvider =
//     StateNotifierProvider<ThemeNotifier, ThemeState>((ref) => ThemeNotifier());
