import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:restaurant_app/app/dependency_injection.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:restaurant_app/presentation/forget_password/viewmodel/forget_password_viewmodel.dart';
import 'package:restaurant_app/presentation/resources/assets_manager.dart';
import 'package:restaurant_app/presentation/resources/color_manager.dart';
import 'package:restaurant_app/presentation/resources/routes_manager.dart' show Routes;
import 'package:restaurant_app/presentation/resources/strings_manager.dart';
import 'package:restaurant_app/presentation/resources/values_manager.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final _forgetPasswordViewmodel = instance<ForgetPasswordViewmodel>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  void _bind() {
    _forgetPasswordViewmodel.start();
    updatingEmailValues();
  }

  void updatingEmailValues() => _emailController.addListener(
      () => _forgetPasswordViewmodel.setUserEmail(_emailController.text));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _forgetPasswordViewmodel.outputState,
        builder: (context, snapshot) =>
            snapshot.data?.getStateWidget(context, _getContentWidget(),
                () => _forgetPasswordViewmodel.resetPassWord()) ??
            _getContentWidget(),
      ),
    );
  }

  Widget _getContentWidget() => Container(
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
                resetPasswordButton(),
              ],
            ),
          ),
        ),
      );

  Center applicationLogo() {
    return const Center(
      child: Image(
        image: AssetImage(ImageAssets.splashLogo),
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
        stream: _forgetPasswordViewmodel.outputIsEmailValid,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: AppStrings.userEmail.tr(),
              errorText:
                  (snapshot.data ?? true) ? null : AppStrings.userEmailError.tr(),
              hintText: AppStrings.userEmail.tr(),
            ),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          );
        },
      ),
    );
  }

  Padding resetPasswordButton() {
    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
      child: StreamBuilder<bool>(
        stream: _forgetPasswordViewmodel.outputIsAllInputsValid,
        builder: (context, snapshot) {
          return SizedBox(
            height: AppSize.s40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (snapshot.data ?? false)
                  ? () => _forgetPasswordViewmodel.resetPassWord()
                  : null,
              child: Text(AppStrings.resetPassword.tr()),
            ),
          );
        },
      ),
    );
  }
}
