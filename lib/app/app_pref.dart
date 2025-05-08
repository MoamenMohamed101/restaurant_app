import 'package:restaurant_app/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String pressKeyLanguage = "PRESS_KEY_LANGUAGE";
const String pressKeyOnBoardingScreenView = "PRESS_KEY_ON_BOARDING_SCREEN";
const String pressKeyIsUserLoggedIn = "PRESS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(pressKeyLanguage);

    if (language != null && language.isNotEmpty) {
      return language;
    }
    return LanguageType.ENGLISH.getValue();
  }

  Future<void> setOnBoardingScreenView() async {
    _sharedPreferences.setBool(pressKeyOnBoardingScreenView, true);
  }

  Future<bool> isOnBoardingScreenView() async {
    return _sharedPreferences.getBool(pressKeyOnBoardingScreenView) ?? false;
  }

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(pressKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(pressKeyIsUserLoggedIn) ?? false;
  }
}
