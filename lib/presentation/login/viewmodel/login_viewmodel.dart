import 'dart:async';
import 'package:restaurant_app/domain/usecase/login_usecase.dart';
import 'package:restaurant_app/presentation/base/base_view_model.dart';
import 'package:restaurant_app/presentation/common/freezed_data_classes.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewmodelInputs, LoginViewmodelOutputs {
  final StreamController<String> _userEmailController =
          StreamController<String>.broadcast(),
      _passwordEmailController = StreamController<String>.broadcast();
  final StreamController<void> _areAllInputsValidController =
      StreamController<void>.broadcast();
  final StreamController<bool> isUserLoggedInSuccessfullyStreamController = StreamController<bool>();

  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    super.dispose();
    _userEmailController.close();
    _passwordEmailController.close();
    _areAllInputsValidController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view model should tell view please show content state at first
    inputState.add(ContentState());
  }

  @override
  setUserEmail(String email) {
    inputEmail.add(email);
    loginObject = loginObject.copyWith(email: email);
    _areAllInputsValidController.add(null);
    // The copyWith method allows creating a new instance with modified values without altering the original object.
  }

  @override
  setUserPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _areAllInputsValidController.add(null);
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
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    // we need here to make add async because we need to call the execute method which is async
    (await _loginUseCase.execute(
      LoginUseCaseInput(
        loginObject.email,
        loginObject.password,
      ),
    ))
        .fold(
      (failure) {
        inputState.add(
          ErrorState(
            StateRendererType.popUpErrorState,
            failure.message,
          ),
        );
        // debugPrint("The Failure code is ${failure.code} and The Failure message is ${failure.message}");
      },
      (success) {
        inputState.add(
          ContentState(),
        );
        isUserLoggedInSuccessfullyStreamController.add(true);
      },
    );
    // The fold method is used to handle the result of an Either type. It takes two functions as arguments: one for the left side (failure) and one for the right side (success). In this case, it handles the failure and success cases of the login use case execution.
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidController.sink;

  @override
  Stream<bool> get outAreAllDataValid =>
      _areAllInputsValidController.stream.map((_) => _areAllInputsValid());

  bool _areAllInputsValid() =>
      _isEmailValid(loginObject.email) &&
      _isPasswordValid(loginObject.password);
}

abstract class LoginViewmodelInputs {
  setUserEmail(String email);

  setUserPassword(String password);

  login();

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;
}

abstract class LoginViewmodelOutputs {
  // We return bool to indicate if the user write his email and password then the button will be valid to click
  Stream<bool> get outIsEmailValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreAllDataValid;
}
