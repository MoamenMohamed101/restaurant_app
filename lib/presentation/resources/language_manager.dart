enum LanguageType {
  ENGLISH,
  ARABIC,
}

const String english = "en";
const String arabic = "ar";

extension LanguageTypeExtension on LanguageType {
  String getValue() => this == LanguageType.ENGLISH ? english : arabic;
}