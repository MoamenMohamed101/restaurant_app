import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:restaurant_app/app/app.dart';
import 'package:restaurant_app/app/dependency_injection.dart';
import 'package:restaurant_app/presentation/resources/language_manager.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // This line ensures that the Flutter framework is fully initialized before running the app.
  EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
      supportedLocales: const [englishLocal, arabicLocal],
      path: assetPathLocalisation,
      child: Phoenix(child: MyApp()), // what phoenix does is to restart the app
    ),
  );
}
// runApp() is a function that takes a widget and makes it the root of the widget tree

// in dart private attribute can access if it is in the same file
