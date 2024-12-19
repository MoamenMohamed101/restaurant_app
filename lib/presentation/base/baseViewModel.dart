abstract class BaseViewModel implements BaseViewModelInputs, BaseViewModelOutPuts {}

abstract class BaseViewModelInputs {
  void start(); // start data stream
  void dispose(); // dispose data stream
}

abstract class BaseViewModelOutPuts {}