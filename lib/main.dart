import 'package:flutter/material.dart';
import 'package:restaurant_app/app/app.dart';
import 'package:restaurant_app/app/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // This line ensures that the Flutter framework is fully initialized before running the app.
  await initAppModule();
  runApp(MyApp());
}
// runApp() is a function that takes a widget and makes it the root of the widget tree

// in dart private attribute can access if it is in the same file