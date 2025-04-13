import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/domain/usecase/login_usecase.dart';
import 'package:restaurant_app/presentation/base/base_view_model.dart';
import 'package:restaurant_app/presentation/common/freezed_data_classes.dart';

//
class LoginViewmodel
    implements BaseViewModel, LoginViewmodelInputs, LoginViewmodelOutputs {
  final StreamController<String> _userEmailController =
          StreamController<String>.broadcast(),
      _passwordEmailController = StreamController<String>.broadcast();

  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;

  LoginViewmodel(this._loginUseCase);

  @override
  void dispose() {
    _userEmailController.close();
    _passwordEmailController.close();
  }

  @override
  void start() {}

  @override
  setUserEmail(String email) {
    inputEmail.add(email);
    loginObject = loginObject.copyWith(email: email);
    // The copyWith method allows creating a new instance with modified values without altering the original object.
  }

  @override
  setUserPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
  }

  @override
  Sink get inputEmail => _userEmailController.sink;

  @override
  Sink get inputPassword => _passwordEmailController.sink;

  @override
  Stream<bool> get outIsEmailValid => _userEmailController.stream.map(
        (email) => _isEmailValid(email),
      );

  @override
  Stream<bool> get outIsPasswordValid => _passwordEmailController.stream.map(
        (password) => _isPasswordValid(password),
      );

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  @override
  login() async {
    // we need here to make add async because we need to call the execute method which is async
    (await _loginUseCase.execute(
      LoginUseCaseInput(
        loginObject.email,
        loginObject.password,
      ),
    ))
        .fold(
      (failure) => debugPrint(
          "The Failure code is ${failure.code} and The Failure message is ${failure.message}"),
      (right) {
        debugPrint(right.customer!.name);
      },
    );
    // The fold method is used to handle the result of an Either type. It takes two functions as arguments: one for the left side (failure) and one for the right side (success). In this case, it handles the failure and success cases of the login use case execution.
  }
}
abstract class LoginViewmodelInputs {
  setUserEmail(String email);

  setUserPassword(String password);

  login();

  Sink get inputEmail;

  Sink get inputPassword;
}

abstract class LoginViewmodelOutputs {
  // We return bool to indicate if the user write his email and password then the button will be valid to click
  Stream<bool> get outIsEmailValid;

  Stream<bool> get outIsPasswordValid;
}
