import 'dart:async';
import 'package:restaurant_app/app/functions.dart';
import 'package:restaurant_app/domain/usecase/forget_password_usecase.dart';
import 'package:restaurant_app/presentation/base/base_view_model.dart';
import 'package:restaurant_app/presentation/common/freezed_data_classes.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgetPasswordViewmodel extends BaseViewModel
    implements ForgetPasswordViewmodelInputs, ForgetPasswordViewmodelOutputs {
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();

  final ForgetPasswordUsecase _forgetPasswordUsecase;

  ForgetPasswordViewmodel(this._forgetPasswordUsecase);

  var email = "";

  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();

  @override
  void start() => inputState.add(ContentState());

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputValidStreamController.stream
          .map((isAllInputValid) => _isAllInputsValid());

   _isAllInputsValid() {
     return isEmailValid(email);
   }

  @override
  void setUserEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  resetPassWord() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    (await _forgetPasswordUsecase.execute(email)).fold(
        (failure) {
      inputState
          .add(ErrorState(StateRendererType.popUpErrorState, failure.message));
    }, (success) {
      inputState.add(ContentState());
    });
  }

  void _validate() => inputIsAllInputValid.add(null);
}

abstract class ForgetPasswordViewmodelInputs {
  void setUserEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;

  resetPassWord();
}

abstract class ForgetPasswordViewmodelOutputs {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputsValid;
}
