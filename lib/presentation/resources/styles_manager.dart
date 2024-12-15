import 'package:flutter/material.dart';
import 'package:restaurant_app/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
    fontFamily: FontConstants.fontFamily,
  );
}

TextStyle getLightTextStyle({
  double fontSize = FontSizeManager.s12,
  required Color color,
}) =>
    _getTextStyle(
      fontSize,
      FontWeightManager.light,
      color,
    );

TextStyle getRegularTextStyle({
  double fontSize = FontSizeManager.s12,
  required Color color,
}) =>
    _getTextStyle(
      fontSize,
      FontWeightManager.regular,
      color,
    );

TextStyle getMediumTextStyle({
  double fontSize = FontSizeManager.s12,
  required Color color,
}) =>
    _getTextStyle(
      fontSize,
      FontWeightManager.medium,
      color,
    );

TextStyle getSemiBoldTextStyle({
  double fontSize = FontSizeManager.s12,
  required Color color,
}) =>
    _getTextStyle(
      fontSize,
      FontWeightManager.semiBold,
      color,
    );

TextStyle getBoldTextStyle({
  double fontSize = FontSizeManager.s12,
  required Color color,
}) =>
    _getTextStyle(
      fontSize,
      FontWeightManager.bold,
      color,
    );