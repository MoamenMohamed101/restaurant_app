import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/app/app_pref.dart';
import 'package:restaurant_app/app/dependency_injection.dart';
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
  final _appPreferences = instance<AppPreferences>();

  // This method is called when the widget is inserted into the widget tree
  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) {
      context.setLocale(local); // what setLocale does is to change the language of the app
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: getApplicationTheme(),
    );
  }
}
