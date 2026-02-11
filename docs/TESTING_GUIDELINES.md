# DefiFundr Mobile Testing Guidelines

## Table of Contents
1. [Testing Philosophy](#testing-philosophy)
2. [Test Pyramid](#test-pyramid)
3. [What to Test](#what-to-test)
4. [What NOT to Test](#what-not-to-test)
5. [Test Structure](#test-structure)
6. [Naming Conventions](#naming-conventions)
7. [Layer-Specific Guidelines](#layer-specific-guidelines)
8. [Mocking Strategy](#mocking-strategy)
9. [Test Utilities](#test-utilities)
10. [Integration Testing with Patrol](#integration-testing-with-patrol)
11. [CI/CD Integration](#cicd-integration)

---

## Testing Philosophy

### Core Principles

1. **Test behavior, not implementation** - Focus on what code does, not how it does it
2. **Quality over quantity** - 100 meaningful tests > 1000 shallow tests
3. **Fast feedback** - Tests should run quickly to encourage frequent execution
4. **Maintainable tests** - Tests are code too; keep them clean and readable
5. **Test the contract** - Verify inputs and outputs, not internal state

### The Golden Rule

> **If a bug here would cause financial loss or wake you up at 2am, write a test for it.**

---

## Test Pyramid

```
                    ┌─────────────┐
                    │     E2E     │  ← Few, slow, expensive
                    │    Tests    │     (Critical user journeys)
                    ├─────────────┤
                    │ Integration │  ← Some, medium speed
                    │    Tests    │     (Component interactions)
                    ├─────────────┤
                    │             │
                    │    Unit     │  ← Many, fast, cheap
                    │    Tests    │     (Business logic)
                    │             │
                    └─────────────┘
```

### Target Distribution

| Test Type   | Coverage | Speed    | Count      |
|-------------|----------|----------|------------|
| Unit        | 70-80%   | < 1s     | Hundreds   |
| Integration | 15-20%   | < 10s    | Dozens     |
| E2E/Widget  | 5-10%    | < 60s    | Few        |

---

## What to Test

### Priority 1: MUST TEST (Critical)

These are non-negotiable. Bugs here = financial loss or security issues.

#### Business Logic (BLoCs/Cubits)
```
lib/modules/*/presentation/bloc/
lib/modules/*/presentation/cubit/
```

| Test Case | Example |
|-----------|---------|
| Initial state | BLoC starts with correct default state |
| State transitions | Events trigger expected state changes |
| Error handling | Failures produce error states |
| Edge cases | Empty data, null values, boundaries |
| Loading states | Async operations show loading |

#### Domain Layer (Use Cases)
```
lib/modules/*/domain/usecases/
```

| Test Case | Example |
|-----------|---------|
| Success scenarios | Use case returns expected result |
| Failure scenarios | Use case handles repository errors |
| Business rules | Validation logic, calculations |
| Input validation | Reject invalid parameters |

#### Financial Calculations
```
lib/modules/finance/
lib/modules/payment/
lib/modules/quickpay/
```

| Test Case | Example |
|-----------|---------|
| Amount calculations | Fees, totals, conversions |
| Currency handling | Precision, rounding |
| Transaction validation | Limits, balance checks |
| Crypto operations | Address validation, signing |

#### Authentication & Security
```
lib/modules/authentication/
lib/modules/web3auth/
lib/core/routers/guards/
```

| Test Case | Example |
|-----------|---------|
| Login flows | Success, failure, validation |
| Token management | Storage, refresh, expiration |
| Route guards | Protected routes redirect correctly |
| Biometric auth | Face ID, fingerprint flows |
| PIN validation | Correct/incorrect PIN handling |

---

### Priority 2: SHOULD TEST (Important)

Bugs here = broken features, bad UX.

#### Data Layer (Repositories)
```
lib/modules/*/data/repositories/
```

| Test Case | Example |
|-----------|---------|
| API success | Repository returns mapped data |
| API failure | Repository throws/returns error |
| Caching logic | Cache hit/miss behavior |
| Data transformation | DTO to Entity mapping |

#### Models & Mappers
```
lib/modules/*/data/models/
lib/modules/*/domain/entities/
```

| Test Case | Example |
|-----------|---------|
| JSON parsing | fromJson handles valid JSON |
| JSON edge cases | Missing fields, null values |
| Serialization | toJson produces valid output |
| Equality | == operator works correctly |

#### Utilities & Helpers
```
lib/core/utils/
lib/shared/utils/
```

| Test Case | Example |
|-----------|---------|
| Formatters | Currency, date, number formatting |
| Validators | Email, phone, address validation |
| Extensions | String, DateTime extensions |
| Converters | Type conversions |

---

### Priority 3: COULD TEST (Nice to Have)

Test if time permits or if particularly complex.

#### Widget Tests (Critical Flows Only)
```
lib/modules/*/presentation/screens/
lib/modules/*/presentation/widgets/
```

| Test Case | Example |
|-----------|---------|
| Form submission | Login form validates and submits |
| Error display | Errors shown to user |
| Navigation | Buttons navigate correctly |
| Loading states | Spinners appear during async |

#### Interceptors & Middleware
```
lib/core/network/interceptors/
```

| Test Case | Example |
|-----------|---------|
| Auth header injection | Token added to requests |
| Error transformation | API errors mapped correctly |
| Retry logic | Failed requests retried |

---

## What NOT to Test

### Never Test These

| Category | Reason | Examples |
|----------|--------|----------|
| **Generated code** | Tested by package authors | `*.freezed.dart`, `*.g.dart`, `*.gr.dart` |
| **Flutter framework** | Already tested by Google | `setState`, `Navigator`, `MediaQuery` |
| **Third-party packages** | Their responsibility | `dio`, `shared_preferences`, `bloc` |
| **Simple getters/setters** | No logic to test | `get name => _name` |
| **Constants** | Can't break | `static const timeout = 30` |
| **Pure UI styling** | No logic, brittle tests | Colors, padding, fonts |
| **Platform code** | Requires device testing | iOS/Android native code |

### Avoid Testing These Directly

| Category | Instead Do |
|----------|------------|
| Private methods | Test through public interface |
| Implementation details | Test behavior/output |
| Database schemas | Test repository layer |
| API response structure | Test model parsing |

---

## Test Structure

### Directory Layout

```
test/
├── unit/
│   ├── modules/
│   │   ├── authentication/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── user_model_test.dart
│   │   │   │   └── repositories/
│   │   │   │       └── auth_repository_test.dart
│   │   │   ├── domain/
│   │   │   │   └── usecases/
│   │   │   │       └── login_usecase_test.dart
│   │   │   └── presentation/
│   │   │       └── bloc/
│   │   │           └── auth_bloc_test.dart
│   │   ├── finance/
│   │   ├── payment/
│   │   └── ...
│   └── core/
│       ├── utils/
│       │   └── validators_test.dart
│       └── network/
│           └── interceptors_test.dart
│
├── integration/
│   ├── auth_flow_test.dart
│   ├── payment_flow_test.dart
│   └── ...
│
├── widget/
│   ├── login_screen_test.dart
│   ├── payment_screen_test.dart
│   └── ...
│
├── fixtures/
│   ├���─ json/
│   │   ├── user_response.json
│   │   └── transaction_response.json
│   └── ...
│
├── mocks/
│   ├── mock_repositories.dart
│   ├── mock_services.dart
│   └── ...
│
└── helpers/
    ├── test_helpers.dart
    ├── pump_app.dart
    └── ...
```

### File Naming

```
# Pattern: {source_file_name}_test.dart

# Examples:
auth_bloc.dart          → auth_bloc_test.dart
user_model.dart         → user_model_test.dart
login_usecase.dart      → login_usecase_test.dart
validators.dart         → validators_test.dart
```

---

## Naming Conventions

### Test Groups

Use `group()` to organize related tests:

```dart
void main() {
  group('AuthBloc', () {
    group('LoginSubmitted', () {
      test('emits [loading, success] when login succeeds', () {});
      test('emits [loading, failure] when login fails', () {});
    });

    group('LogoutRequested', () {
      test('emits [unauthenticated] and clears storage', () {});
    });
  });
}
```

### Test Names

Follow the pattern: **`action` + `condition` + `expected result`**

```dart
// ✅ Good - Clear and descriptive
test('emits [loading, success] when login credentials are valid', () {});
test('throws InvalidEmailException when email format is invalid', () {});
test('returns cached user when cache is not expired', () {});
test('formats currency with 2 decimal places for USD', () {});

// ❌ Bad - Vague or implementation-focused
test('test login', () {});
test('should work', () {});
test('calls repository method', () {});
```

---

## Layer-Specific Guidelines

### BLoC Tests

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthBloc bloc;
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    bloc = AuthBloc(repository: repository);
  });

  tearDown(() {
    bloc.close();
  });

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      expect(bloc.state, equals(AuthInitial()));
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when login succeeds',
      build: () {
        when(() => repository.login(any(), any()))
            .thenAnswer((_) async => User(id: '1', name: 'Test'));
        return bloc;
      },
      act: (bloc) => bloc.add(LoginSubmitted(
        email: 'test@test.com',
        password: 'password123',
      )),
      expect: () => [
        AuthLoading(),
        isA<AuthSuccess>(),
      ],
      verify: (_) {
        verify(() => repository.login('test@test.com', 'password123')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when login fails',
      build: () {
        when(() => repository.login(any(), any()))
            .thenThrow(InvalidCredentialsException());
        return bloc;
      },
      act: (bloc) => bloc.add(LoginSubmitted(
        email: 'test@test.com',
        password: 'wrong',
      )),
      expect: () => [
        AuthLoading(),
        AuthFailure(message: 'Invalid credentials'),
      ],
    );
  });
}
```

### Repository Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}
class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late AuthRepositoryImpl repository;
  late MockApiClient apiClient;
  late MockLocalStorage localStorage;

  setUp(() {
    apiClient = MockApiClient();
    localStorage = MockLocalStorage();
    repository = AuthRepositoryImpl(
      apiClient: apiClient,
      localStorage: localStorage,
    );
  });

  group('AuthRepository', () {
    group('login', () {
      test('returns User when API call succeeds', () async {
        // Arrange
        when(() => apiClient.login(any()))
            .thenAnswer((_) async => UserDto(id: '1', name: 'Test'));
        when(() => localStorage.saveToken(any()))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.login('test@test.com', 'password');

        // Assert
        expect(result, isA<User>());
        expect(result.id, '1');
        verify(() => localStorage.saveToken(any())).called(1);
      });

      test('throws AuthException when API returns 401', () async {
        when(() => apiClient.login(any()))
            .thenThrow(DioException(
              response: Response(statusCode: 401, requestOptions: RequestOptions()),
              requestOptions: RequestOptions(),
            ));

        expect(
          () => repository.login('test@test.com', 'wrong'),
          throwsA(isA<InvalidCredentialsException>()),
        );
      });
    });
  });
}
```

### Model Tests

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    group('fromJson', () {
      test('parses valid JSON correctly', () {
        final json = {
          'id': '123',
          'email': 'test@test.com',
          'name': 'John Doe',
          'created_at': '2024-01-01T00:00:00Z',
        };

        final user = UserModel.fromJson(json);

        expect(user.id, '123');
        expect(user.email, 'test@test.com');
        expect(user.name, 'John Doe');
        expect(user.createdAt, DateTime.utc(2024, 1, 1));
      });

      test('handles missing optional fields', () {
        final json = {
          'id': '123',
          'email': 'test@test.com',
        };

        final user = UserModel.fromJson(json);

        expect(user.name, isNull);
        expect(user.createdAt, isNull);
      });

      test('throws FormatException for invalid date', () {
        final json = {
          'id': '123',
          'email': 'test@test.com',
          'created_at': 'invalid-date',
        };

        expect(
          () => UserModel.fromJson(json),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('toJson', () {
      test('serializes to valid JSON', () {
        final user = UserModel(
          id: '123',
          email: 'test@test.com',
          name: 'John Doe',
        );

        final json = user.toJson();

        expect(json['id'], '123');
        expect(json['email'], 'test@test.com');
        expect(json['name'], 'John Doe');
      });
    });

    group('equality', () {
      test('two users with same id are equal', () {
        final user1 = UserModel(id: '123', email: 'test@test.com');
        final user2 = UserModel(id: '123', email: 'test@test.com');

        expect(user1, equals(user2));
      });
    });
  });
}
```

### Utility Tests

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyFormatter', () {
    test('formats USD with 2 decimal places', () {
      expect(CurrencyFormatter.format(1234.5, 'USD'), '\$1,234.50');
    });

    test('formats large numbers with commas', () {
      expect(CurrencyFormatter.format(1000000, 'USD'), '\$1,000,000.00');
    });

    test('handles zero correctly', () {
      expect(CurrencyFormatter.format(0, 'USD'), '\$0.00');
    });

    test('handles negative amounts', () {
      expect(CurrencyFormatter.format(-100, 'USD'), '-\$100.00');
    });
  });

  group('EmailValidator', () {
    test('returns true for valid email', () {
      expect(EmailValidator.isValid('test@example.com'), isTrue);
    });

    test('returns false for email without @', () {
      expect(EmailValidator.isValid('testexample.com'), isFalse);
    });

    test('returns false for email without domain', () {
      expect(EmailValidator.isValid('test@'), isFalse);
    });

    test('returns false for empty string', () {
      expect(EmailValidator.isValid(''), isFalse);
    });
  });
}
```

---

## Mocking Strategy

### Use Mocktail (Recommended)

```yaml
# pubspec.yaml
dev_dependencies:
  mocktail: ^1.0.0
  bloc_test: ^9.1.0
```

### Mock Classes

```dart
// test/mocks/mock_repositories.dart
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockUserRepository extends Mock implements UserRepository {}
class MockPaymentRepository extends Mock implements PaymentRepository {}

// test/mocks/mock_services.dart
class MockApiClient extends Mock implements ApiClient {}
class MockLocalStorage extends Mock implements LocalStorage {}
class MockSecureStorage extends Mock implements SecureStorage {}
```

### Register Fallback Values

```dart
// test/helpers/test_helpers.dart
void setUpTestDependencies() {
  registerFallbackValue(LoginRequest(email: '', password: ''));
  registerFallbackValue(User(id: '', name: ''));
  registerFallbackValue(Uri.parse('https://example.com'));
}

// In test file
void main() {
  setUpAll(() {
    setUpTestDependencies();
  });
}
```

---

## Test Utilities

### Fixture Loading

```dart
// test/helpers/fixture_reader.dart
import 'dart:io';

String fixture(String name) {
  return File('test/fixtures/json/$name').readAsStringSync();
}

// Usage
final json = jsonDecode(fixture('user_response.json'));
```

### Pump App Helper

```dart
// test/helpers/pump_app.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    AuthBloc? authBloc,
    ThemeBloc? themeBloc,
  }) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          if (authBloc != null) BlocProvider.value(value: authBloc),
          if (themeBloc != null) BlocProvider.value(value: themeBloc),
        ],
        child: MaterialApp(
          home: widget,
        ),
      ),
    );
  }
}
```

### Common Test Matchers

```dart
// test/helpers/matchers.dart
import 'package:flutter_test/flutter_test.dart';

Matcher isAuthSuccess() => isA<AuthSuccess>();
Matcher isAuthFailure() => isA<AuthFailure>();
Matcher hasMessage(String message) => predicate<AuthFailure>(
  (state) => state.message == message,
  'has message "$message"',
);
```

---

## Integration Testing with Patrol

Patrol is our integration/E2E testing framework that provides native automation capabilities.

### Why Patrol?

| Feature | Standard integration_test | Patrol |
|---------|--------------------------|--------|
| Native dialogs | ❌ Can't interact | ✅ Full access |
| Permissions | ❌ Manual setup | ✅ Grant/deny in test |
| Biometrics | ❌ Can't test | ✅ Can simulate |
| System UI | ❌ No access | ✅ Full access |
| WebViews | ❌ Limited | ✅ Can interact |
| Finder syntax | Verbose | Clean (`$('Button')`) |

### Project Structure

```
integration_test/
├── patrol_base.dart      # Configuration & helpers
├── auth_test.dart        # Authentication flow tests
├── payment_test.dart     # Payment flow tests
├── smoke_test.dart       # Critical path smoke tests
└── ...
```

### Writing Patrol Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'patrol_base.dart';

void main() {
  patrol(
    'User can complete login flow',
    tags: [TestTags.smoke, TestTags.auth],
    ($) async {
      // Start the app
      await $.pumpApp();

      // Interact with UI
      await $.enterTextField('Email', 'test@example.com');
      await $.enterTextField('Password', 'password123');
      await $.tapButton('Login');

      // Handle native biometric prompt
      await $.handleBiometricPrompt(authenticate: true);

      // Verify success
      await $.waitForText('Dashboard');
    },
  );
}
```

### Available Helpers

Our `patrol_base.dart` provides these helper methods:

| Method | Description |
|--------|-------------|
| `$.pumpApp()` | Launches the DefiFundr app |
| `$.waitForText(text)` | Waits for text to appear |
| `$.waitForKey(key)` | Waits for widget with key |
| `$.tapButton(text)` | Taps button and settles |
| `$.enterTextField(hint, text)` | Enters text in field |
| `$.scrollToText(text)` | Scrolls until text visible |
| `$.handleBiometricPrompt()` | Handles Face ID/Fingerprint |
| `$.grantLocationPermission()` | Grants location access |
| `$.grantCameraPermission()` | Grants camera access |
| `$.dismissSystemDialog()` | Dismisses system dialogs |

### Test Tags

Use tags to categorize and filter tests:

```dart
patrol(
  'Test description',
  tags: [TestTags.smoke, TestTags.auth],
  ($) async { ... },
);
```

Available tags:
- `TestTags.smoke` - Critical path tests (run before every release)
- `TestTags.regression` - Full regression suite
- `TestTags.auth` - Authentication tests
- `TestTags.payment` - Payment/transaction tests
- `TestTags.wallet` - Wallet tests
- `TestTags.kyc` - KYC verification tests

### Running Patrol Tests

```bash
# Run all integration tests
patrol test

# Run with specific tag
patrol test --tags smoke

# Run on specific device
patrol test -d <device_id>

# Run specific test file
patrol test integration_test/auth_test.dart

# Run with verbose output
patrol test --verbose
```

### Best Practices for Patrol Tests

1. **Keep tests independent** - Each test should be able to run in isolation
2. **Use descriptive names** - Test names should describe the user journey
3. **Handle async properly** - Use `waitFor*` methods instead of fixed delays
4. **Tag appropriately** - Use tags for filtering in CI
5. **Clean up state** - Reset app state between tests when needed
6. **Test on real devices** - Native features require real device testing

### Native Interactions

```dart
// Grant permissions
await $.native.grantPermissionWhenInUse();
await $.native.grantPermissionOnlyThisTime();
await $.native.denyPermission();

// System navigation
await $.native.pressBack();
await $.native.pressHome();
await $.native.openNotifications();

// Native taps (for system dialogs)
await $.native.tap(Selector(text: 'Allow'));
await $.native.tap(Selector(textContains: 'OK'));
```

---

## CI/CD Integration

### GitHub Actions Example

```yaml
# .github/workflows/test.yml
name: Tests

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          channel: 'stable'
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Run tests with coverage
        run: flutter test --coverage

      - name: Check coverage threshold
        run: |
          COVERAGE=$(lcov --summary coverage/lcov.info | grep "lines" | grep -oP '\d+\.\d+')
          if (( $(echo "$COVERAGE < 70" | bc -l) )); then
            echo "Coverage $COVERAGE% is below 70% threshold"
            exit 1
          fi
```

### Pre-commit Hook

```bash
#!/bin/sh
# .git/hooks/pre-commit

echo "Running tests..."
flutter test --coverage

if [ $? -ne 0 ]; then
  echo "Tests failed. Commit aborted."
  exit 1
fi
```

---

## Quick Reference

### Test Checklist

Before merging any PR, ensure:

- [ ] All new business logic has unit tests
- [ ] BLoC state transitions are tested
- [ ] Model parsing is tested with valid/invalid JSON
- [ ] Error cases are tested
- [ ] Edge cases are considered
- [ ] Tests are named descriptively
- [ ] No flaky tests
- [ ] Coverage hasn't decreased

### Testing Commands

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/modules/auth/auth_bloc_test.dart

# Run tests matching pattern
flutter test --name "login"

# Run tests with verbose output
flutter test --reporter expanded

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## Summary

| Layer | Test? | Priority | Coverage Target |
|-------|-------|----------|-----------------|
| BLoCs/Cubits | YES | Critical | 90%+ |
| Use Cases | YES | Critical | 90%+ |
| Repositories | YES | High | 80%+ |
| Models | YES | High | 80%+ |
| Utils/Helpers | YES | Medium | 80%+ |
| Widgets | Partial | Low | 30-50% |
| Generated Code | NO | - | 0% |
| Third-party | NO | - | 0% |

**Remember: Tests are an investment. Write them for code that matters.**
