# ── Localization helpers ────────────────────────────────────────────────────
# Wraps scripts/l10n.py for quick CLI access.
#
# Usage examples:
#   make l10n-adopt                                  ← interactive scan for all of lib/
#   make l10n-adopt path=lib/modules/more/           ← interactive scan for a folder/file
#   make l10n-gen
#   make l10n-scan
#   make l10n-scan path=lib/modules/more/
#   make l10n-list
#   make l10n-list filter=password
#   make l10n-add key=submitButton en="Submit" es="Enviar"
#   make l10n-add-param key=assetSentTo en="{assetName} was successfully sent to" es="{assetName} se envió correctamente a"

L10N = python3 scripts/l10n.py

# Interactive: scan → accept/edit/skip each string → batch add to ARBs + gen
# Optional: path=lib/modules/foo/  or  path=lib/modules/foo/screen.dart
.PHONY: l10n-adopt
l10n-adopt:
	$(L10N) adopt $(path)

# Run flutter gen-l10n
.PHONY: l10n-gen
l10n-gen:
	$(L10N) gen

# Scan for hardcoded UI strings (optional: path=lib/modules/foo/)
.PHONY: l10n-scan
l10n-scan:
	$(L10N) scan $(path)

# List all ARB keys (optional: filter=someword)
.PHONY: l10n-list
l10n-list:
	$(L10N) list $(filter)

# Add a simple key to both ARBs and regenerate
# Required: key=camelCaseKey en="English text"
# Optional: es="Spanish text"
.PHONY: l10n-add
l10n-add:
	$(L10N) add $(key) "$(en)" $(if $(es),--es "$(es)",)

# Add a parameterized key (use {placeholder} in en/es values)
# Required: key=camelCaseKey en="Hello {name}"
# Optional: es="Hola {name}"
.PHONY: l10n-add-param
l10n-add-param:
	$(L10N) add-param $(key) "$(en)" $(if $(es),--es "$(es)",)

# ── Flutter shortcuts ────────────────────────────────────────────────────────

.PHONY: run-dev
run-dev:
	flutter run --flavor dev -t lib/main.dart --dart-define-from-file=config/dev.json

.PHONY: run-staging
run-staging:
	flutter run --flavor staging -t lib/main.dart --dart-define-from-file=config/staging.json

.PHONY: run-prod
run-prod:
	flutter run --flavor prod -t lib/main.dart --dart-define-from-file=config/prod.json

.PHONY: build-ios-dev
build-ios-dev:
	flutter build ipa --flavor dev -t lib/main.dart --dart-define-from-file=config/dev.json

.PHONY: build-ios-staging
build-ios-staging:
	flutter build ipa --flavor staging -t lib/main.dart --dart-define-from-file=config/staging.json

.PHONY: build-ios-prod
build-ios-prod:
	flutter build ipa --flavor prod -t lib/main.dart --dart-define-from-file=config/prod.json

.PHONY: build-apk-dev
build-apk-dev:
	flutter build apk --flavor dev --dart-define-from-file=config/dev.json

.PHONY: build-apk-staging
build-apk-staging:
	flutter build apk --flavor staging --dart-define-from-file=config/staging.json

.PHONY: build-apk-prod
build-apk-prod:
	flutter build apk --flavor prod --dart-define-from-file=config/prod.json

.PHONY: test
test:
	flutter test

.PHONY: clean
clean:
	flutter clean && flutter pub get
