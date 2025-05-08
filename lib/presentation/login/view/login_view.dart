import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:restaurant_app/app/app_pref.dart';
import 'package:restaurant_app/app/dependency_injection.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:restaurant_app/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:restaurant_app/presentation/resources/assets_manager.dart';
import 'package:restaurant_app/presentation/resources/color_manager.dart';
import 'package:restaurant_app/presentation/resources/routes_manager.dart';
import 'package:restaurant_app/presentation/resources/strings_manager.dart';
import 'package:restaurant_app/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  // final _loginViewmodel = instance<LoginViewModel>();
  final LoginViewModel _loginViewmodel = instance<LoginViewModel>();
  final _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _loginViewmodel.start();
    _loginViewmodel.outputState.listen((state) => debugPrint("State emitted: $state"));
    // The addListener method is used to "listen" for changes to the text in these controllers. When the text changes, the listener will be triggered and the view model will be updated accordingly.
    updatingEmailAndPasswordValues();
    isCredentialsCorrect();
  }

  void updatingEmailAndPasswordValues() {
    _emailController.addListener(() => _loginViewmodel.setUserEmail(_emailController.text));
    _passwordController.addListener(() => _loginViewmodel.setUserPassword(_passwordController.text));
  }

  void isCredentialsCorrect() {
    _loginViewmodel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isUserLoggedInSuccessfully) {
      if (isUserLoggedInSuccessfully) {
        navigateToMainScreenAndSaveInCacheMemory();
      }
    });
  }

  // SchedulerBinding: This is a class that provides access to the current scheduler, which is responsible for managing the frame rendering and scheduling tasks in Flutter.
  void navigateToMainScreenAndSaveInCacheMemory() {
    SchedulerBinding.instance.addPostFrameCallback((_) => Navigator.of(context).pushReplacementNamed(Routes.mainRoute));
    _appPreferences.setUserLoggedIn();
  }

  @override
  void dispose() {
    super.dispose();
    _loginViewmodel.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    // The dispose method is called when the widget is removed from the widget tree. It's a good place to clean up resources, such as closing streams or disposing of controllers.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _loginViewmodel.outputState,
        builder: (context, snapshot) =>
            snapshot.data?.getStateWidget(
                context, getContentWidget(), () => _loginViewmodel.login()) ??
            getContentWidget(),
      ),
    );
  }

  Widget getContentWidget() => Container(
        padding: const EdgeInsetsDirectional.only(
          top: AppPadding.p100,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                applicationLogo(),
                heightSize28(),
                emailFiled(),
                heightSize28(),
                passwordField(),
                heightSize28(),
                loginButton(),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: AppPadding.p8,
                    // start: AppPadding.p28,
                    // end: AppPadding.p28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, Routes.forgetPasswordRoute),
                        child: Text(
                          AppStrings.forgetPassword,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, Routes.registerRoute),
                        child: Text(
                          AppStrings.registerText,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Padding loginButton() {
    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
      child: StreamBuilder<bool>(
        stream: _loginViewmodel.outAreAllDataValid,
        builder: (context, snapshot) {
          return SizedBox(
            height: AppSize.s40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (snapshot.data ?? false)
                  ? () => _loginViewmodel.login()
                  : null, // if snapshot.data is true, call the login method
              child: const Text(AppStrings.login),
            ),
          );
        },
      ),
    );
  }

  Padding passwordField() {
    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
      child: StreamBuilder<bool>(
        stream: _loginViewmodel.outIsPasswordValid,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: AppStrings.password,
              errorText:
                  (snapshot.data ?? true) ? null : AppStrings.passwordError,
              hintText: AppStrings.password,
              icon: const Icon(Icons.password),
            ),
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
          );
        },
      ),
    );
  }

  SizedBox heightSize28() {
    return const SizedBox(
      height: AppSize.s28,
    );
  }

  Padding emailFiled() {
    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
      child: StreamBuilder<bool>(
        stream: _loginViewmodel.outIsEmailValid,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: AppStrings.userEmail,
              errorText:
                  (snapshot.data ?? true) ? null : AppStrings.userEmailError,
              // if snapshot.data is true, return null to hide the error, if not return AppStrings.userNameError
              hintText: AppStrings.userEmail,
              icon: const Icon(Icons.email),
            ),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          );
        },
      ),
    );
  }

  Center applicationLogo() {
    return const Center(
      child: Image(
        image: AssetImage(ImageAssets.splashLogo),
      ),
    );
  }
}
