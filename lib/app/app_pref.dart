import 'package:restaurant_app/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PRESS_KEY_LANGUAGE = "PRESS_KEY_LANGUAGE";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage()async {
    String? language = _sharedPreferences.getString(PRESS_KEY_LANGUAGE);

    if(language != null && language.isNotEmpty){
      return language;
    }
    return LanguageType.ENGLISH.getValue();
  }
}