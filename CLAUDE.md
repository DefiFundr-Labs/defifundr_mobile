# DeFiFundr Mobile — Claude Code Guidelines

## Project Overview

DeFiFundr is a Flutter mobile app for decentralized finance (payroll, invoicing, wallets). It uses:
- **State management**: flutter_bloc (BLoC pattern)
- **Navigation**: auto_route
- **DI**: get_it
- **Code generation**: freezed, flutter_gen, build_runner
- **Theming**: Custom ThemeExtension (colors + fonts)
- **Responsive layout**: flutter_screenutil

---

## Architecture

### Layer Structure (Feature-First)
```
lib/
  modules/
    <feature>/
      data/
        datasource/      # Remote/local data sources
        repository/      # Repository implementations
      domain/
        entity/          # Pure Dart models (Freezed)
        repository/      # Repository interfaces (abstract)
        usecase/         # Single-responsibility use cases
      presentation/
        <sub-feature>/
          screens/       # @RoutePage() widgets
          widgets/       # Feature-specific widgets
          bloc/          # BLoC, events, states
  core/
    design_system/       # Colors, fonts, theme
    shared/common/       # Reusable UI components
    routers/             # auto_route setup
    extensions/          # Dart extensions
    enums/               # App-wide enums
    constants/           # App constants
    utils/               # Pure utility functions
```

### Rules
- **Never skip layers.** Screens talk to BLoCs, BLoCs call UseCases, UseCases call Repositories.
- **Domain layer is pure Dart.** No Flutter imports in `domain/`.
- **One UseCase per file, one responsibility.** `LoginUseCase`, not `AuthUseCase`.
- **Repository interfaces live in `domain/repository/`.** Implementations live in `data/repository/`.

---

## State Management (BLoC)

### File Structure per BLoC
```
bloc/
  <feature>_bloc.dart
  <feature>_event.dart
  <feature>_state.dart
```

### Rules
- Use `freezed` for events and states — all states/events must be immutable.
- Prefer `BlocConsumer` when both listening and building. Use `BlocBuilder` for build-only, `BlocListener` for side effects only.
- Always handle all states: `initial`, `loading`, `success`, `failure`.
- Use `bloc_concurrency` transformers (`droppable()`, `restartable()`) on events that trigger async work.
- Never put business logic in widgets. Widgets dispatch events; BLoCs handle logic.
- Emit `loading` state before any async operation.

### Pattern
```dart
// event
@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.submitted({
    required String email,
    required String password,
  }) = _Submitted;
}

// state
@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(UserEntity user) = _Success;
  const factory LoginState.failure(String message) = _Failure;
}
```

---

## Widgets & Screens

### Screen Rules
- Every route screen must be annotated with `@RoutePage()`.
- Screens are `StatefulWidget` only when local UI state is needed (toggle, scroll controller, text controllers). Otherwise use `StatelessWidget`.
- Always `dispose()` controllers in `StatefulWidget`.
- Screens should not contain complex widget trees inline — extract into named widget methods or separate widget files.

### Widget Rules
- Prefer `StatelessWidget` over `StatefulWidget`.
- Reusable widgets go in `core/shared/common/`. Feature-specific widgets go in the feature's `widgets/` folder.
- Never hardcode strings in widgets — use `context.l10n.<key>`.
- Never hardcode colors inline — always use `context.theme.colors.<token>`.
- Never hardcode text styles inline — always use `context.theme.fonts.<token>`.
- Use `Assets.icons.<name>` and `Assets.images.<name>` from flutter_gen — never raw string paths.

### Spacing & Layout
- Use `flutter_screenutil` for all sizes: `.w`, `.h`, `.r`, `.sp`.
- Standard horizontal page padding: `20.w`.
- Use `SizedBox` for spacing gaps, not `Padding` with only one side.
- Do not mix `.w` and `.h` for symmetric dimensions — pick one (prefer `.w` for square containers).

---

## Design System

### Import
```dart
// Single barrel import for all design system needs
import 'package:defifundr_mobile/core/design_system/design_system.dart';
```

### File locations
```
lib/core/design_system/
  design_system.dart           ← barrel export (import this)
  app_colors/app_colors.dart   ← raw color palette (AppColors / AppColorDark)
  color_extension/             ← AppColorExtension (ThemeExtension)
  font_extension/              ← AppFontThemeExtension (ThemeExtension)
  theme_extension/
    app_theme_extension.dart   ← AppTheme + ThemeGetter + AppThemeExtension
    theme_cubit.dart
    theme_enum.dart
    theme_manager.dart
```

### Access Pattern
```dart
// Colors — always via semantic token
context.theme.colors.textPrimary
context.theme.colors.brandDefault
context.theme.colors.bgB0          // card/surface white (light) / darkest (dark)
context.theme.colors.bgB1          // page background

// Fonts — always via font token
context.theme.fonts.heading2Bold
context.theme.fonts.textMdRegular

// Dark mode check — only when semantic tokens are insufficient (e.g. asset switching)
context.isDarkMode

// Scaffold background (already theme-aware)
context.theme.scaffoldBackgroundColor
```

### Color Token Rules
- **Never** use `Theme.of(context).brightness == Brightness.light/dark` for color decisions.
  - Use `context.isDarkMode` ONLY when you cannot express the decision with a semantic token (e.g., choosing between two SVG asset paths).
  - For everything else, pick the right semantic token — it automatically resolves to the correct light/dark value.
- **Never** reference `AppColors.*` or `AppColorDark.*` raw values directly in widget files.
  - Raw static colors are only allowed inside the design system files themselves.
- Add new color tokens to both `AppColors` (light) and `AppColorDark` (dark) as a pair, then expose them in `AppColorExtension`.
- The "Old Colors" block in `AppColors` (e.g., `grey100`, `white100`, `errorColor`) is `@Deprecated` — do not use in new code.

### Font Token Rules
- Font tokens live in `AppFontThemeExtension` — never declare raw `TextStyle` constants outside the design system.
- Never override `color` or `fontFamily` on a font token unless functionally required. Use `.copyWith(color: ...)` only for semantic intent (error state, inverted text, etc.).
- Legacy tokens (`headerLarger`, `headerSmall`, `subHeader`, `bodyMedium`) are kept for backwards compatibility — do not use in new code; use the canonical scale tokens (`heading*`, `textLg*`, `textBase*`, `textMd*`, `textSm*`, `textXs*`).

### Adding a New Color Token
1. Add `static const Color myToken = Color(...)` to `AppColors` (light value).
2. Add `static const Color myToken = Color(...)` to `AppColorDark` (dark value).
3. Add `required this.myToken` to `AppColorExtension` constructor + field.
4. Add `myToken: myToken ?? this.myToken` to `copyWith`.
5. Add `Color.lerp(myToken, other.myToken, t)!` to `lerp`.
6. Pass both values in `AppTheme._lightAppColorss` and `AppTheme._darkAppColorss`.

---

## Navigation (auto_route)

```dart
// Push
context.router.push(const SomeRoute());

// Pop
context.router.maybePop();

// Replace
context.router.replace(const SomeRoute());
```

### Rules
- Always use `maybePop()` instead of `pop()` to avoid exceptions on root routes.
- Route names live in `core/routers/routers.dart` (generated). Never hardcode route path strings.
- Route guards go in `core/routers/guards/`.
- Never navigate inside a BLoC — dispatch a navigation event and handle it via `BlocListener` in the widget.

---

## Dependency Injection (get_it)

- Register all dependencies in `app/` setup (injection file).
- Use constructor injection everywhere — never call `GetIt.instance` inside widgets or BLoCs.
- UseCases, Repositories, and DataSources are always registered as `lazySingleton` unless they hold mutable state.
- BLoCs are registered as `factory` (new instance per page).

---

## Code Generation

Run after modifying freezed models, routes, or assets:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

- Never manually edit `.g.dart` or `.gr.dart` files.
- Freezed models go in `domain/entity/` or alongside their BLoC state files.
- Asset references always via `Assets.*` (flutter_gen). Run build_runner after adding new assets.

---

## Naming Conventions

| Type | Convention | Example |
|------|-----------|---------|
| Files | snake_case | `login_screen.dart` |
| Classes | PascalCase | `LoginScreen`, `LoginBloc` |
| Variables/methods | camelCase | `isLoading`, `onSubmit` |
| Private members | _camelCase | `_emailController` |
| Constants | camelCase in class | `AppColors.textPrimary` |
| Enums | PascalCase, values camelCase | `MoreItemTrailingType.toggle` |
| BLoC files | `<feature>_bloc/event/state.dart` | `login_bloc.dart` |
| Screen files | `<feature>_screen.dart` | `login_screen.dart` |
| Widget files | descriptive snake_case | `more_profile_card.dart` |

---

## Do's and Don'ts

### Do
- Use `const` constructors wherever possible.
- Extract widget helper methods (`_buildIcon`, `_buildSocialIcon`) for repeated widget patterns within the same file.
- Use `Equatable` or `freezed` for all data classes passed to BLoC states.
- Keep `build()` methods readable — if a widget subtree exceeds ~40 lines, extract it.
- Handle empty/null/loading states explicitly in every screen.


### Don't
- Don't use `BuildContext` across async gaps without checking `mounted`.
- Don't call `setState` after `dispose`.
- Don't use `setState` always use `ValueNotifier` or `Cubit` or `Bloc` depending complexity
- Don't put `MediaQuery` calls deep in widget trees — pass values down or use screenutil.
- Don't use `dynamic` — always type explicitly.
- Don't suppress lints with `// ignore:` without a comment explaining why.
- Don't import from another feature's internal layers. Cross-feature access goes through shared domain entities only.
- Don't use `print()` — use the `logger` package (`Logger()`).

---

## Localization

- All user-visible strings must be in the ARB files (`lib/core/localization/`).
- Access via `context.l10n.<key>` (extension defined in `core/extensions/l10n_extension.dart`).
- Never hardcode English strings in widget files.

---

## Testing

- BLoC logic: use `bloc_test` with `mocktail` for mocked dependencies.
- Widget tests: use `flutter_test`.
- Integration tests: use `patrol`.
- Test file mirrors source structure: `test/modules/authentication/...`.
- Every UseCase should have a unit test.
- Every BLoC should have bloc_test coverage for all event → state transitions.
