import 'package:restaurant_app/app/constants.dart';

extension NotNullString on String? {
  String orEmpty() => this ?? Constants.empty;
}

extension NotNullInt on int? {
  int orZero() => this ?? Constants.zero;
}

extension NotNullDouble on double? {
  double orZero() => this ?? Constants.decimalZero;
}