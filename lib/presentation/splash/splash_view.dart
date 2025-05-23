import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/app/app_pref.dart';
import 'package:restaurant_app/app/dependency_injection.dart';
import 'package:restaurant_app/presentation/resources/assets_manager.dart';
import 'package:restaurant_app/presentation/resources/color_manager.dart';
import 'package:restaurant_app/presentation/resources/constants_manager.dart';
import 'package:restaurant_app/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final _appPreferences = instance<AppPreferences>();

  void _goNext() async {
    final isLoggedIn = await _appPreferences.isUserLoggedIn();
    final isOnBoardingScreenView = await _appPreferences.isOnBoardingScreenView();
    if (isLoggedIn) {
      goToMainScreen();
    } else {
      if (isOnBoardingScreenView) {
        goToLoginScreen();
      } else {
        goToOnBoardingScreen();
      }
    }
  }

  Future<Object?> goToOnBoardingScreen() => Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);

  Future<Object?> goToLoginScreen() => Navigator.pushReplacementNamed(context, Routes.loginRoute);

  Future<Object?> goToMainScreen() => Navigator.pushReplacementNamed(context, Routes.mainRoute);

  _startDelay() {
    _timer =
        Timer(const Duration(seconds: AppConstants.timerDuration), _goNext);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }

  @override
  // why use dispose method? The dispose method is called when the state object is removed, which is when the widget is removed from the tree. This is the place to clean up resources, unsubscribe from streams, etc.
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }
}
