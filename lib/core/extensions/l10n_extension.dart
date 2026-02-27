import 'package:defifundr_mobile/core/localization/generated/strings.dart';
import 'package:flutter/widgets.dart';

export 'package:defifundr_mobile/core/localization/generated/strings.dart';

extension L10nExtension on BuildContext {
  Strings get l10n => Strings.of(this);
}
