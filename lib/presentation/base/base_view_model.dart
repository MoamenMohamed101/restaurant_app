// Purpose: BaseViewModel class to be extended by all view models. This class is responsible for managing the data stream between the view and the view model.
abstract class BaseViewModel implements BaseViewModelInputs, BaseViewModelOutPuts {}
// Any view model has inputs and outputs to manage the data stream between the view and the view model.
abstract class BaseViewModelInputs {
  void start(); // Called by the view to notify the ViewModel to begin data streaming

  void dispose(); // Called by the view to notify the ViewModel to clean up resources
}

abstract class BaseViewModelOutPuts {}