import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app/app/app_pref.dart';
import 'package:restaurant_app/app/dependency_injection.dart';
import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/presentation/onBoarding/viewmodel/onboarding_view_model.dart';
import 'package:restaurant_app/presentation/resources/assets_manager.dart';
import 'package:restaurant_app/presentation/resources/color_manager.dart';
import 'package:restaurant_app/presentation/resources/constants_manager.dart';
import 'package:restaurant_app/presentation/resources/routes_manager.dart';
import 'package:restaurant_app/presentation/resources/strings_manager.dart';
import 'package:restaurant_app/presentation/resources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final OnboardingViewmodel _onboardingViewmodel = OnboardingViewmodel();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  _bind() => _onboardingViewmodel.start();
  // Bind ربط the viewmodel to the view and start the viewmodel to get the data from the repository and update the view

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OnBoardingSlidersViewObject>(
      stream: _onboardingViewmodel.outputSliderViewObject,
      // Stream to listen to the data from the viewmodel and update the view
      builder: (BuildContext context, snapshot) =>
          getContentWidget(snapshot.data),
    );
  }

  Widget getContentWidget(OnBoardingSlidersViewObject? data) {
    if (data == null) {
      return Container();
    }
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
      ),
      body: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          _onboardingViewmodel.onPageChanged(index);
        },
        itemBuilder: (BuildContext context, int index) =>
            OnboardingPage(data.onBoardingModel),
        itemCount: data.numberOfSlides,
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _appPreferences.setOnBoardingScreenView();
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
                child: Text(
                  AppStrings.skip.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            _getBottomSheet(data),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheet(OnBoardingSlidersViewObject? data) {
    return Container(
      width: double.infinity,
      color: ColorManager.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  _onboardingViewmodel.goToPreviousPage(),
                  duration: const Duration(
                    milliseconds: AppConstants.sliderAnimationTime,
                  ),
                  curve: Curves.linear,
                );
              },
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrow),
              ),
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < data!.numberOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppSize.s8),
                  child: _getProperCircle(i, data.currentIndex),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  _onboardingViewmodel.goToNextPage(),
                  duration: const Duration(
                    milliseconds: AppConstants.sliderAnimationTime,
                  ),
                  curve: Curves.linear,
                );
              },
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrow),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) => index == currentIndex
      ? SvgPicture.asset(ImageAssets.hollowCircle)
      : SvgPicture.asset(ImageAssets.solidCircle);

  @override
  void dispose() {
    _onboardingViewmodel.dispose();
    super.dispose();
  }
}

class OnboardingPage extends StatelessWidget {
  final OnBoardingModel _onBoardingModel;

  const OnboardingPage(this._onBoardingModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Column(
        children: [
          Text(
            _onBoardingModel.title!,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(
            height: AppSize.s8,
          ),
          Text(
            _onBoardingModel.description!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: AppSize.s60,
          ),
          SvgPicture.asset(_onBoardingModel.image!),
        ],
      ),
    );
  }
}