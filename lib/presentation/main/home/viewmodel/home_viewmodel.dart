import 'dart:async';
import 'dart:ffi';
import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/domain/usecase/home_usecase.dart';
import 'package:restaurant_app/presentation/base/base_view_model.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/subjects.dart';

class HomeViewmodel extends BaseViewModel implements HomeViewmodelInput, HomeViewmodelOutput {
  final HomeUsecase _homeUsecase;

  HomeViewmodel(this._homeUsecase);

  final StreamController<List<BannerAd>> _bannerAdController =
      BehaviorSubject<List<BannerAd>>();
  final StreamController<List<Store>> _storeController =
      BehaviorSubject<List<Store>>();
  final StreamController<List<Service>> _serviceController =
      BehaviorSubject<List<Service>>();

  @override
  void start() => _getHomeData();

  @override
  void dispose() {
    super.dispose();
    _bannerAdController.close();
    _storeController.close();
    _serviceController.close();
  }

  _getHomeData() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUsecase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (homeObject) {
      inputBannerAd.add(homeObject.data.bannerAds);
      inputService.add(homeObject.data.services);
      inputStore.add(homeObject.data.stores);
      inputState.add(ContentState());
    });
  }

  @override
  Sink get inputBannerAd => _bannerAdController.sink;

  @override
  Sink get inputService => _serviceController.sink;

  @override
  Sink get inputStore => _storeController.sink;

  @override
  Stream<List<BannerAd>> get outputBannerAd =>
      _bannerAdController.stream.map((bannerAd) => bannerAd);

  @override
  Stream<List<Service>> get outputService =>
      _serviceController.stream.map((service) => service);

  @override
  Stream<List<Store>> get outputStore =>
      _storeController.stream.map((store) => store);
}

abstract class HomeViewmodelInput {
  Sink get inputBannerAd;

  Sink get inputStore;

  Sink get inputService;
}

abstract class HomeViewmodelOutput {
  Stream<List<BannerAd>> get outputBannerAd;

  Stream<List<Store>> get outputStore;

  Stream<List<Service>> get outputService;
}
