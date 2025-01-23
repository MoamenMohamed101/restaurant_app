import 'package:flutter/material.dart';
import 'package:restaurant_app/presentation/resources/routes_manager.dart';
import 'package:restaurant_app/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  // Named constructors: allows the creation of multiple constructors for the same class with different parameters or different implementations
  MyApp._internal();

  static final MyApp _instance = MyApp._internal();

  // Factory constructor is used to return an instance of a class
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: getApplicationTheme(),
    );
  }
}