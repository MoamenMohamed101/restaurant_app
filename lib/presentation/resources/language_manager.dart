enum LanguageType { ENGLISH, ARABIC }

const String ENGLISH = "en";
const String ARABIC = "ar";

extension LanguageTypeExtension on LanguageType {
  String getValue() => this == LanguageType.ENGLISH ? ENGLISH : ARABIC;
}