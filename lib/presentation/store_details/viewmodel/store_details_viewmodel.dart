import 'dart:async';
import 'dart:ffi';

import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/domain/usecase/store_details_usecase.dart';
import 'package:restaurant_app/presentation/base/base_view_model.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewmodel extends BaseViewModel
    implements StoreDetailsViewmodelInputs, StoreDetailsViewmodelOutputs {
  final StoreDetailsUsecase _storeDetailsUsecase;

  StoreDetailsViewmodel(this._storeDetailsUsecase);

  final StreamController<StoreDetails> _storeDetailsController =
      BehaviorSubject<StoreDetails>();

  @override
  void start() => _getStoreDetails();

  @override
  Sink get inputStoreDetails => _storeDetailsController.sink;

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsController.stream
          .map((storeDetails) => storeDetails);

  _getStoreDetails() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _storeDetailsUsecase.execute(Void)).fold(
        (failure) => inputState.add(
              ErrorState(
                StateRendererType.fullScreenErrorState,
                failure.message,
              ),
            ), (storeDetails) {
      if (!_storeDetailsController.isClosed) {
        inputStoreDetails.add(storeDetails);
        inputState.add(ContentState());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _storeDetailsController.close();
  }
}

abstract class StoreDetailsViewmodelInputs {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewmodelOutputs {
  Stream<StoreDetails> get outputStoreDetails;
}