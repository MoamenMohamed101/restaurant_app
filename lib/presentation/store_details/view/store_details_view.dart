import 'package:flutter/material.dart';
import 'package:restaurant_app/app/dependency_injection.dart';
import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:restaurant_app/presentation/resources/color_manager.dart';
import 'package:restaurant_app/presentation/resources/font_manager.dart';
import 'package:restaurant_app/presentation/resources/strings_manager.dart';
import 'package:restaurant_app/presentation/resources/styles_manager.dart';
import 'package:restaurant_app/presentation/resources/values_manager.dart';
import 'package:restaurant_app/presentation/store_details/viewmodel/store_details_viewmodel.dart';

class StoreDetailsView extends StatefulWidget {
  final String image;

  const StoreDetailsView(this.image, {super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewmodel _viewModel = instance<StoreDetailsViewmodel>();

  _bind() => _viewModel.start();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.storeDetails, textAlign: TextAlign.center),
        backgroundColor: ColorManager.primaryColor,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) =>
            snapshot.data?.getStateWidget(
                context, _getContentWidget(), () => _viewModel.start()) ??
            _getContentWidget(),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<StoreDetails>(
      stream: _viewModel.outputStoreDetails,
      builder: (context, snapshot) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getImageWidget(widget.image),
            _getSection(AppStrings.details),
            _getDetailsWidget(snapshot.data?.details),
            _getSection(AppStrings.services),
            _getServicesWidget(snapshot.data?.services),
            _getSection(AppStrings.aboutStore),
            _getAboutWidget(snapshot.data?.about),
          ],
        ),
      ),
    );
  }

  Padding _getImageWidget(String image) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

  Padding _getSection(String services) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Text(
        services,
        style: getRegularTextStyle(
          color: ColorManager.primaryColor,
          fontSize: FontSizeManager.s18,
        ),
      ),
    );
  }

  Padding _getDetailsWidget(String? details) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Text(
        details ?? '',
        style: getRegularTextStyle(
          color: ColorManager.black,
          fontSize: FontSizeManager.s16,
        ),
      ),
    );
  }

  _getServicesWidget(String? services) {
    if (services != null) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          services,
          style: getRegularTextStyle(
            color: ColorManager.black,
            fontSize: FontSizeManager.s16,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _getAboutWidget(String? about) {
    if (about != null) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          about,
          style: getRegularTextStyle(
            color: ColorManager.black,
            fontSize: FontSizeManager.s16,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
