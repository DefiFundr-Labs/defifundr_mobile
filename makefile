# Flutter Project Makefile
# ===========================================
# A comprehensive set of commands for Flutter development workflow

.PHONY: all run_dev_web run_dev_mobile run_stg_mobile run_prd_mobile \
	run_unit test test_coverage clean upgrade lint format format_check \
	build_dev_mobile build_stg_mobile build_prd_mobile help watch gen \
	get commit build_apk_dev build_apk_stg build_apk_prd build_ios_dev \
	build_ios_stg build_ios_prd build purge build_runner ios \
	deploy-android deploy-ios deploy fix localization doctor outdated \
	update_pods firebase_setup install_all update_all setup default_notification \
	bootstrap check_quality

# Define terminal colors
BLUE=\033[0;34m
GREEN=\033[0;32m
YELLOW=\033[0;33m
RED=\033[0;31m
NC=\033[0m # No Color

# Default target when just running 'make'
all: lint format run_dev_mobile

# ===========================================
# Development Workflow
# ===========================================

help: ## Show this help
	@echo "${BLUE}Flutter Project Makefile${NC}"
	@echo "${YELLOW}Available commands:${NC}"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "${GREEN}make %-20s${NC} %s\n", $$1, $$2}'

bootstrap: ## Set up the project from scratch (first-time setup)
	@echo "${BLUE}╔════════════════════════════════════════════╗${NC}"
	@echo "${BLUE}║            Setting up project...           ║${NC}"
	@echo "${BLUE}╚════════════════════════════════════════════╝${NC}"
	@flutter pub get
	@flutter pub run flutter_native_splash:create
	@flutter pub run build_runner build --delete-conflicting-outputs
	@make ios
	@echo "${GREEN}Project setup complete!${NC}"

run_dev_web: ## Run the web application in development mode
	@echo "${BLUE}╠ Running web app (development)${NC}"
	@flutter run -d chrome --dart-define=ENVIRONMENT=dev

run_dev_mobile: ## Run the mobile application in development mode
	@echo "${BLUE}╠ Running mobile app (development)${NC}"
	@flutter run --flavor development -t lib/main_development.dart

run_stg_mobile: ## Run the mobile application in staging mode
	@echo "${BLUE}╠ Running mobile app (staging)${NC}"
	@flutter run --flavor staging -t lib/main_staging.dart

run_prd_mobile: ## Run the mobile application in production mode
	@echo "${BLUE}╠ Running mobile app (production)${NC}"
	@flutter run --flavor production -t lib/main_production.dart

# ===========================================
# Testing Commands
# ===========================================

run_unit: ## Run unit tests
	@echo "${BLUE}╠ Running unit tests${NC}"
	@flutter test || (echo "${RED}Error while running tests${NC}"; exit 1)

test: ## Run all tests
	@echo "${BLUE}╠ Running all tests${NC}"
	@flutter test

test_coverage: ## Run tests with coverage
	@echo "${BLUE}╠ Running tests with coverage${NC}"
	@flutter test --coverage
	@genhtml coverage/lcov.info -o coverage/html
	@echo "${GREEN}Coverage report generated at coverage/html/index.html${NC}"

# ===========================================
# Code Quality Commands
# ===========================================

lint: ## Lint the code
	@echo "${BLUE}╠ Linting code...${NC}"
	@dart analyze . || (echo "${RED}Linting errors found${NC}"; exit 1)

format: ## Format the code
	@echo "${BLUE}╠ Formatting code...${NC}"
	@dart fix --apply
	@flutter format lib .
	@flutter pub run import_sorter:main
	@flutter format lib
	@echo "${GREEN}Code formatting complete${NC}"

format_check: ## Check if code is formatted correctly
	@echo "${BLUE}╠ Checking code format...${NC}"
	@flutter format --set-exit-if-changed lib

fix: ## Apply dart fixes
	@echo "${BLUE}╠ Applying dart fixes...${NC}"
	@dart fix --apply

check_quality: lint format_check ## Check code quality (lint + format check)
	@echo "${GREEN}Code quality check passed${NC}"

# ===========================================
# Build Commands
# ===========================================

build_apk_dev: ## Build APK in development mode
	@echo "${BLUE}╠ Building APK (development)${NC}"
	@flutter clean
	@flutter pub get
	@flutter build apk --flavor development -t lib/main_development.dart
	@echo "${GREEN}Development APK build complete${NC}"

build_apk_stg: ## Build APK in staging mode
	@echo "${BLUE}╠ Building APK (staging)${NC}"
	@flutter clean
	@flutter pub get
	@flutter build apk --flavor staging -t lib/main_staging.dart
	@echo "${GREEN}Staging APK build complete${NC}"

build_apk_prd: ## Build APK in production mode
	@echo "${BLUE}╠ Building APK (production)${NC}"
	@flutter clean
	@flutter pub get
	@flutter build apk --release --flavor production -t lib/main_production.dart
	@echo "${GREEN}Production APK build complete${NC}"

build_ios_dev: ## Build iOS in development mode
	@echo "${BLUE}╠ Building iOS (development)${NC}"
	@flutter clean
	@flutter pub get
	@flutter build ios --flavor development -t lib/main_development.dart --no-codesign
	@echo "${GREEN}Development iOS build complete${NC}"

build_ios_stg: ## Build iOS in staging mode
	@echo "${BLUE}╠ Building iOS (staging)${NC}"
	@flutter clean
	@flutter pub get
	@flutter build ios --flavor staging -t lib/main_staging.dart --no-codesign
	@echo "${GREEN}Staging iOS build complete${NC}"

build_ios_prd: ## Build iOS in production mode
	@echo "${BLUE}╠ Building iOS (production)${NC}"
	@flutter clean
	@flutter pub get
	@flutter build ios --flavor production -t lib/main_production.dart --no-codesign
	@echo "${GREEN}Production iOS build complete${NC}"

# ===========================================
# Code Generation Commands
# ===========================================

watch: ## Watch files and run build_runner when changes detected
	@echo "${BLUE}╠ Watching for changes...${NC}"
	@flutter pub run build_runner watch --delete-conflicting-outputs

gen: ## Generate code once with build_runner
	@echo "${BLUE}╠ Generating code...${NC}"
	@flutter pub run build_runner build --delete-conflicting-outputs
	@echo "${GREEN}Code generation complete${NC}"

build_runner: gen ## Alias for gen

localization: ## Generate localization files
	@echo "${BLUE}╠ Generating localization files...${NC}"
	@flutter gen-l10n
	@echo "${GREEN}Localization files generated${NC}"

# ===========================================
# Dependency Management
# ===========================================

get: ## Get dependencies
	@echo "${BLUE}╠ Getting dependencies...${NC}"
	@flutter pub get
	@echo "${GREEN}Dependencies fetched${NC}"

upgrade: clean ## Upgrade dependencies
	@echo "${BLUE}╠ Upgrading dependencies...${NC}"
	@flutter pub upgrade
	@echo "${GREEN}Dependencies upgraded${NC}"

outdated: ## Check for outdated packages
	@echo "${BLUE}╠ Checking for outdated packages...${NC}"
	@flutter pub outdated

update_pods: ## Update iOS pods
	@echo "${BLUE}╠ Updating iOS pods...${NC}"
	@cd ios && arch -x86_64 pod update
	@echo "${GREEN}iOS pods updated${NC}"

# ===========================================
# Project Maintenance
# ===========================================

clean: ## Clean the project
	@echo "${BLUE}╠ Cleaning project...${NC}"
	@rm -rf pubspec.lock
	@flutter clean
	@flutter pub get
	@echo "${GREEN}Project cleaned${NC}"

purge: ## Deep clean the project, including pods
	@echo "${BLUE}╠ Purging project...${NC}"
	@pod deintegrate || true
	@flutter clean
	@flutter pub get
	@echo "${GREEN}Project purged${NC}"

ios: ## Set up iOS project
	@echo "${BLUE}╠ Setting up iOS project...${NC}"
	@cd ios && arch -x86_64 pod install --repo-update
	@cd ..
	@rm -rf pubspec.lock
	@flutter clean
	@flutter pub get
	@echo "${GREEN}iOS setup complete${NC}"

doctor: ## Run Flutter doctor
	@echo "${BLUE}╠ Running Flutter doctor...${NC}"
	@flutter doctor -v

# ===========================================
# Deployment Commands
# ===========================================

deploy-android: ## Deploy Android app to Google Play
	@echo "${BLUE}╠ Deploying Android app...${NC}"
	@cd android/fastlane && bundle install --path vendor/bundle && bundle exec fastlane deploy
	@echo "${GREEN}Android deployment complete${NC}"

deploy-ios: ## Deploy iOS app to TestFlight
	@echo "${BLUE}╠ Deploying iOS app...${NC}"
	@cd ios/fastlane && bundle install --path vendor/bundle && bundle exec fastlane deploy
	@echo "${GREEN}iOS deployment complete${NC}"

deploy: deploy-android deploy-ios ## Deploy to both platforms

# ===========================================
# Utility Commands
# ===========================================

commit: format lint run_unit ## Format, lint, test, then commit changes
	@echo "${BLUE}╠ Committing changes...${NC}"
	@git add .
	@git commit

default_notification: ## Test notifications on iOS simulator
	@echo "${BLUE}╠ Sending test notification...${NC}"
	@xcrun simctl push booted com.synergyng.synergy pushes/push1.json
	@echo "${GREEN}Test notification sent${NC}"

firebase_setup: ## Set up Firebase
	@echo "${BLUE}╠ Setting up Firebase...${NC}"
	@flutterfire configure
	@echo "${GREEN}Firebase setup complete${NC}"

install_all: ## Install all project dependencies and tools
	@echo "${BLUE}╠ Installing all dependencies and tools...${NC}"
	@flutter pub get
	@cd ios && arch -x86_64 pod install --repo-update
	@cd ..
	@gem install bundler
	@cd android/fastlane && bundle install --path vendor/bundle
	@cd ios/fastlane && bundle install --path vendor/bundle
	@echo "${GREEN}All dependencies and tools installed${NC}"

update_all: upgrade update_pods ## Update all dependencies
	@echo "${GREEN}All dependencies updated${NC}"

setup: bootstrap ## Alias for bootstrap