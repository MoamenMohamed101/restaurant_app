import 'dart:async';
import 'dart:ffi';
import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/domain/usecase/home_usecase.dart';
import 'package:restaurant_app/presentation/base/base_view_model.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/subjects.dart';

class HomeViewmodel extends BaseViewModel
    implements HomeViewmodelInput, HomeViewmodelOutput {
  final HomeUsecase _homeUsecase;

  HomeViewmodel(this._homeUsecase);

  final StreamController<HomeViewObject> _homeObjectController =
      BehaviorSubject<HomeViewObject>();

  @override
  void start() => _getHomeData();

  @override
  void dispose() {
    super.dispose();
    _homeObjectController.close();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUsecase.execute(Void)).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (homeObject) {
      inputHomeObject.add(
        HomeViewObject(
          homeObject.data.services,
          homeObject.data.bannerAds,
          homeObject.data.stores,
        ),
      );
      inputState.add(ContentState());
    });
  }

  @override
  Sink get inputHomeObject => _homeObjectController.sink;

  @override
  Stream<HomeViewObject> get outputHomeObject =>
      _homeObjectController.stream.map((homeObject) => homeObject);
}

abstract class HomeViewmodelInput {
  Sink get inputHomeObject;
}

abstract class HomeViewmodelOutput {
  Stream<HomeViewObject> get outputHomeObject;
}

class HomeViewObject {
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;

  HomeViewObject(this.services, this.banners, this.stores);
}