import 'package:flutter/material.dart';
import 'package:restaurant_app/presentation/resources/color_manager.dart';
import 'package:restaurant_app/presentation/resources/font_manager.dart';
import 'package:restaurant_app/presentation/resources/styles_manager.dart';
import 'package:restaurant_app/presentation/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primaryColor,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    // card theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.darkGrey,
      elevation: AppSize.s4,
    ),
    // appBar theme
    appBarTheme: AppBarTheme(
      color: ColorManager.primaryColor,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: ColorManager.white,
      ),
      titleTextStyle: getRegularTextStyle(
        color: ColorManager.white,
        fontSize: AppSize.s16,
      ),
      elevation: AppSize.s4,
      shadowColor: ColorManager.darkGrey,
    ),
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: ColorManager.primaryColor,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.lightPrimary,
    ),
    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12)),
        elevation: AppSize.s4,
        shadowColor: ColorManager.darkGrey,
        textStyle: getRegularTextStyle(
          color: ColorManager.white,
          fontSize: AppSize.s17,
        ) as TextStyle?,
      ),
    ),
    // text Theme
    textTheme: TextTheme(
      headlineLarge: getSemiBoldTextStyle(
        color: ColorManager.white,
        fontSize: FontSizeManager.s22,
      ),
      displayLarge: getLightTextStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSizeManager.s22,
      ),
      titleMedium: getMediumTextStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSizeManager.s14,
      ),
      bodyLarge: getRegularTextStyle(color: ColorManager.grey1),
      bodySmall: getRegularTextStyle(color: ColorManager.grey),
    ),
    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle:
          getRegularTextStyle(color: ColorManager.grey, fontSize: AppSize.s14)
              as TextStyle?,
      labelStyle:
          getMediumTextStyle(color: ColorManager.grey, fontSize: AppSize.s14)
              as TextStyle?,
      errorStyle: getRegularTextStyle(color: ColorManager.error) as TextStyle?,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.primaryColor,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.primaryColor,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
  );
}
