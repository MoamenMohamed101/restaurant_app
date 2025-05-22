import 'package:flutter/material.dart';
import 'package:restaurant_app/app/dependency_injection.dart';
import 'package:restaurant_app/presentation/forget_password/view/forget_password_view.dart';
import 'package:restaurant_app/presentation/login/view/login_view.dart';
import 'package:restaurant_app/presentation/main/main_view.dart';
import 'package:restaurant_app/presentation/onBoarding/view/onBoarding_view.dart';
import 'package:restaurant_app/presentation/register/view/register_view.dart';
import 'package:restaurant_app/presentation/resources/strings_manager.dart';
import 'package:restaurant_app/presentation/splash/splash_view.dart';
import 'package:restaurant_app/presentation/store_details/view/store_details_view.dart';
import 'package:restaurant_app/presentation/test_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String onBoardingRoute = "/onBoardingRoute";
  static const String storeDetailsRoute = "/storeDetails";
  static const String test = "/test";
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
        initLoginModule();
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginView(),
        );
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(
          builder: (BuildContext context) => const RegisterView(),
        );
      case Routes.forgetPasswordRoute:
        initForgetPasswordModule();
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgetPasswordView(),
        );
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(
          builder: (BuildContext context) => const MainView(),
        );
        case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(
          builder: (BuildContext context) => StoreDetailsView(routeSettings.arguments as String),
        );
        case Routes.test:
        return MaterialPageRoute(
          builder: (BuildContext context) => const TestScreen(),
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
