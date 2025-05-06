import 'dart:async';

import 'package:restaurant_app/presentation/common/state_renderer/state_renderer_impl.dart';
abstract class BaseViewModel implements BaseViewModelInputs, BaseViewModelOutPuts {
  final StreamController<FlowState> _inputStreamController = StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStreamController.close();
  }
}
// Any view model has inputs and outputs to manage the data stream between the view and the view model.
abstract class BaseViewModelInputs {
  void
      start(); // Called by the view to notify the ViewModel to begin data streaming

  void
      dispose(); // Called by the view to notify the ViewModel to clean up resources

  Sink get inputState;
}

abstract class BaseViewModelOutPuts {
  Stream<FlowState> get outputState;
}