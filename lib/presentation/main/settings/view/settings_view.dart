import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app/app/app_pref.dart';
import 'package:restaurant_app/app/dependency_injection.dart';
import 'package:restaurant_app/data/data_source/local_data_source.dart';
import 'package:restaurant_app/presentation/resources/assets_manager.dart';
import 'package:restaurant_app/presentation/resources/color_manager.dart';
import 'package:restaurant_app/presentation/resources/language_manager.dart';
import 'package:restaurant_app/presentation/resources/routes_manager.dart';
import 'package:restaurant_app/presentation/resources/strings_manager.dart';
import 'package:restaurant_app/presentation/resources/values_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _appPreferences = instance<AppPreferences>();
  final _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        children: [
          ListTile(
            title: Text(
              AppStrings.changeLanguage.tr(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            leading: SvgPicture.asset(ImageAssets.changeLang),
            trailing: isRtl()
                ? SvgPicture.asset(
                    ImageAssets.leftArrow,
                    colorFilter: const ColorFilter.mode(
                      ColorManager.primaryColor,
                      BlendMode.srcIn,
                    ),
                  )
                : SvgPicture.asset(
                    ImageAssets.rightArrow,
                    colorFilter: const ColorFilter.mode(
                      ColorManager.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
            onTap: () => _changeLanguage(context),
          ),
          ListTile(
            title: Text(
              AppStrings.contactUs.tr(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            leading: SvgPicture.asset(ImageAssets.contactUs),
            trailing: isRtl()
                ? SvgPicture.asset(
                    ImageAssets.leftArrow,
                    colorFilter: const ColorFilter.mode(
                      ColorManager.primaryColor,
                      BlendMode.srcIn,
                    ),
                  )
                : SvgPicture.asset(
                    ImageAssets.rightArrow,
                    colorFilter: const ColorFilter.mode(
                      ColorManager.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
            onTap: () => _contactUs(context),
          ),
          ListTile(
            title: Text(
              AppStrings.inviteFriends.tr(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            leading: SvgPicture.asset(ImageAssets.inviteFriends),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(
                ImageAssets.rightArrow,
                colorFilter: const ColorFilter.mode(
                  ColorManager.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            onTap: () => _inviteFriends(context),
          ),
          ListTile(
            title: Text(
              AppStrings.logout.tr(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            leading: SvgPicture.asset(ImageAssets.logout),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(
                ImageAssets.rightArrow,
                colorFilter: const ColorFilter.mode(
                  ColorManager.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            onTap: () => _logOut(),
          ),
        ],
      ),
    );
  }

  bool isRtl() => context.locale == arabicLocal;

  void _changeLanguage(BuildContext context) {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  void _contactUs(BuildContext context) {}

  void _inviteFriends(BuildContext context) {}

  void _logOut() {
    _appPreferences.logOut();
    _localDataSource.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
