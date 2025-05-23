import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/app/dependency_injection.dart';
import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:restaurant_app/presentation/main/home/viewmodel/home_viewmodel.dart';
import 'package:restaurant_app/presentation/resources/color_manager.dart';
import 'package:restaurant_app/presentation/resources/routes_manager.dart';
import 'package:restaurant_app/presentation/resources/strings_manager.dart';
import 'package:restaurant_app/presentation/resources/values_manager.dart';
import 'package:restaurant_app/presentation/store_details/view/store_details_view.dart';
import 'package:restaurant_app/presentation/test_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewmodel _viewModel = instance<HomeViewmodel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getStateWidget(
                    context, _getContentWidget(), () => _viewModel.start()) ??
                _getContentWidget();
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeViewObject>(
      stream: _viewModel.outputHomeObject,
      builder: (context, snapshot) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getBannerWidget(snapshot.data?.banners),
          _getSection(AppStrings.services.tr()),
          _getServicesWidget(snapshot.data?.services),
          _getSection(AppStrings.stores.tr()),
          _getStoresWidget(snapshot.data?.stores),
        ],
      ),
    );
  }

  Widget _getBannerWidget(List<BannerAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
        items: banners
            .map(
              (banner) => SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: AppSize.s1_5,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                        color: ColorManager.primaryColor, width: AppSize.s1),
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppSize.s12)),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppSize.s12)),
                    child: Image.network(
                      banner.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: AppSize.s190,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      );
    }
    return Container();
  }

  Padding _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p2,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  Widget _getStoresWidget(List<Store>? stores) {
    if (stores != null && stores.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: AppSize.s2,
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                stores.length,
                (index) => InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.storeDetailsRoute,
                      arguments: stores[index].image,
                    );
                  },
                  child: Card(
                    elevation: AppSize.s4,
                    child: Image.network(
                      stores[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  Widget _getServicesWidget(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
        child: Container(
          height: AppSize.s140,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map(
                  (service) => Card(
                    elevation: AppSize.s4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      side: const BorderSide(
                        color: ColorManager.primaryColor,
                        width: AppSize.s1,
                      ),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          child: Image.network(
                            service.image,
                            fit: BoxFit.cover,
                            width: AppSize.s100,
                            height: AppSize.s100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: AppPadding.p8),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              service.name,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    }
    return Container();
  }
}
