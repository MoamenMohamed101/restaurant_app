import 'dart:async';
import 'dart:io';
import 'package:restaurant_app/app/functions.dart';
import 'package:restaurant_app/domain/usecase/register_usecase.dart';
import 'package:restaurant_app/presentation/base/base_view_model.dart';
import 'package:restaurant_app/presentation/common/freezed_data_classes.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:restaurant_app/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel
    implements RegisterViewModelInputs, RegisterViewModelOutPuts {
  final StreamController<String> _userNameStreamController =
          StreamController<String>.broadcast(),
      _emailStreamController = StreamController<String>.broadcast(),
      _passwordStreamController = StreamController<String>.broadcast(),
      _mobileNumberStreamController = StreamController<String>.broadcast();
  final StreamController<bool> isUserRegisteredInSuccessfullyStreamController = StreamController<bool>();


  final StreamController<File> _profilePictureStreamController =
      StreamController<File>.broadcast();

  final StreamController _areAllFieldsValidStreamController =
      StreamController<void>.broadcast();
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  var registerObject = RegisterObject("", "", "", "", "", "");

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _mobileNumberStreamController.close();
    _profilePictureStreamController.close();
    _areAllFieldsValidStreamController.close();
    isUserRegisteredInSuccessfullyStreamController.close();
  }

  // inputs
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAllFieldsValid => _areAllFieldsValidStreamController.sink;

  // outputs
  @override
  Stream<bool> get outputAreAllFieldsValid =>
      _areAllFieldsValidStreamController.stream
          .map((_) => _areAllFieldsValid());

  @override
  Stream<File> get outputProfilePicture =>
      _profilePictureStreamController.stream
          .map((profilePicture) => profilePicture);

  @override
  Stream<bool> get outputIsEmail =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmail
      .map((isEmailValid) => isEmailValid ? null : AppStrings.emailError);

  @override
  Stream<bool> get outputIsMobileNumber => _mobileNumberStreamController.stream
      .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumber.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : AppStrings.mobileNumberError);

  @override
  Stream<bool> get outputIsPassword => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPassword.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.passwordValid);

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid.map(
      (isUserNameValid) => isUserNameValid ? null : AppStrings.userNameError);

  // Setters
  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
        email: registerObject.email,
        password: registerObject.password,
        userName: registerObject.userName,
        mobileNumber: registerObject.mobileNumber,
        countryMobileCode: registerObject.countryMobileCode,
        profilePicture: registerObject.profilePicture,
      ),
    ))
        .fold(
      (failure) {
        inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message));
      },
      (success) {
        inputState.add(ContentState());
        isUserRegisteredInSuccessfullyStreamController.add(true);
      },
    );
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      // reset profilePicture value in register view object
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      // reset countryCode value in register view object
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }

  // Private functions
  bool _isUserNameValid(String userName) => userName.length >= 8;

  bool _isMobileNumberValid(String phoneNumber) => phoneNumber.length >= 10;

  bool _isPasswordValid(String password) => password.length >= 6;

  bool _areAllFieldsValid() {
    return registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.userName.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty &&
        registerObject.countryMobileCode.isNotEmpty;
  }

  validate() => inputAllFieldsValid.add(
      null); // why we add null? because we don't need to send any data to the stream
}

abstract class RegisterViewModelInputs {
  Sink get inputUserName;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputMobileNumber;

  Sink get inputProfilePicture;

  Sink get inputAllFieldsValid;

  setUserName(String userName);

  setEmail(String email);

  setPassword(String password);

  setMobileNumber(String mobileNumber);

  setProfilePicture(File profilePicture);

  setCountryCode(String countryCode);

  register();
}

abstract class RegisterViewModelOutPuts {
  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsEmail;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPassword;

  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputIsMobileNumber;

  Stream<String?> get outputErrorMobileNumber;

  Stream<File> get outputProfilePicture;

  Stream<bool> get outputAreAllFieldsValid;
}
