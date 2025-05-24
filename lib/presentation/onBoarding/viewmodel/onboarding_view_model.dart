import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/presentation/base/base_view_model.dart';
import 'package:restaurant_app/presentation/resources/assets_manager.dart';
import 'package:restaurant_app/presentation/resources/strings_manager.dart';

class OnboardingViewmodel extends BaseViewModel implements OnboardingViewmodelInputs, OnboardingViewmodelOutputs {
  // stream controller outputs
  final StreamController<OnBoardingSlidersViewObject> _streamController =
      StreamController<OnBoardingSlidersViewObject>();

  late final List<OnBoardingModel> _pages;
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _pages = _onBoardingPages();
    _postDataToView();
  }

  @override
  int goToNextPage() {
    if (_currentPageIndex == _pages.length - 1) return _currentPageIndex = 0;
    return ++_currentPageIndex;
  }

  @override
  int goToPreviousPage() {
    int prev = --_currentPageIndex;
    if (prev == -1) return prev = _pages.length - 1;
    return prev;
  }

  @override
  onPageChanged(int index) {
    _currentPageIndex = index;
    _postDataToView();
  }

  // onBoarding view model inputs
  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // onBoarding view model outputs
  @override
  Stream<OnBoardingSlidersViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // private methods

  List<OnBoardingModel> _onBoardingPages() => [
        OnBoardingModel(
          AppStrings.onBoardingTitle1.tr(),
          AppStrings.onBoardingSubTitle1.tr(),
          ImageAssets.onBoardingLogo1,
        ),
        OnBoardingModel(
          AppStrings.onBoardingTitle2.tr(),
          AppStrings.onBoardingSubTitle2.tr(),
          ImageAssets.onBoardingLogo2,
        ),
        OnBoardingModel(
          AppStrings.onBoardingTitle3.tr(),
          AppStrings.onBoardingSubTitle3.tr(),
          ImageAssets.onBoardingLogo3,
        ),
        OnBoardingModel(
          AppStrings.onBoardingTitle4.tr(),
          AppStrings.onBoardingSubTitle4.tr(),
          ImageAssets.onBoardingLogo4,
        ),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(
      OnBoardingSlidersViewObject(
        _pages[_currentPageIndex],
        _pages.length,
        _currentPageIndex,
      ),
    );
  }
}

// inputs means the instructions that our view model will receive from view
abstract class OnboardingViewmodelInputs {
  int goToNextPage(); // When user click on right arrow or swipe left
  int goToPreviousPage(); // When user click on left arrow or swipe right
  onPageChanged(int index);

  Sink
      get inputSliderViewObject; // make getter to override in OnboardingViewmodel
}

// outputs means the instructions that our view model will send to view
abstract class OnboardingViewmodelOutputs {
  Stream<OnBoardingSlidersViewObject>
      get outputSliderViewObject; // make getter to override in OnboardingViewmodel
}