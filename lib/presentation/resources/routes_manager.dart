import 'package:flutter/material.dart';
import 'package:restaurant_app/presentation/forget_password/forget_password_view.dart';
import 'package:restaurant_app/presentation/login/login_view.dart';
import 'package:restaurant_app/presentation/main/main_view.dart';
import 'package:restaurant_app/presentation/onBoarding/view/onBoarding_view.dart';
import 'package:restaurant_app/presentation/register/register_view.dart';
import 'package:restaurant_app/presentation/resources/strings_manager.dart';
import 'package:restaurant_app/presentation/splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String onBoardingRoute = "/onBoardingRoute";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashView(),
        );
      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OnBoardingView(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginView(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const RegisterView(),
        );
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgetPasswordView(),
        );
      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const MainView(),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
