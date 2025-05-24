import 'dart:ui';

enum LanguageType {
  ENGLISH,
  ARABIC,
}

const String english = "en";
const String arabic = "ar";
const String assetPathLocalisation = "assets/translations";
const Locale arabicLocal = Locale(arabic, "SA");
const Locale englishLocal = Locale(english, "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() => this == LanguageType.ENGLISH ? english : arabic;
}
