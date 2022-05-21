import 'package:flutter/material.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get screenHeight =>
      mediaQuery.size.height - kToolbarHeight - kToolbarHeight * 1.2;

  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.1;

  double dynamicValue(double value) => height * value;
  double dynamicWidth(double value) => width * value;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension PaddingExtensionSymmeric on BuildContext {
  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);
}

extension RadiusExtension on BuildContext {
  Radius get lowestRadius => Radius.circular(normalValue);
  Radius get lowRadius => Radius.circular(width * 0.02);
  Radius get normalRadius => Radius.circular(width * 0.05);
  Radius get highRadius => Radius.circular(width * 0.1);
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension NavigateExtension on BuildContext {
  NavigationService get navigationService => locator<NavigationService>();
  
  // Future navigate(Widget widget) async =>
  //     Navigator.push(this, MaterialPageRoute(builder: (context) => widget));

  // Future navigateReplacement(Widget widget) async => Navigator.pushReplacement(
  //     this, MaterialPageRoute(builder: (context) => widget));

  // Future navigateRemoveUntil(Widget widget) async =>
  //     Navigator.pushAndRemoveUntil(
  //         this, MaterialPageRoute(builder: (context) => widget), (r) => false);

  // Future navigateNamed(String routeName) async =>
  //     Navigator.pushNamed(this, routeName);

  // Future navigateReplacementName(String routeName) async =>
  //     Navigator.pushReplacementNamed(this, routeName);

  // Future navigateNamedAndRemoveUntil(String routeName) async =>
  //     Navigator.pushNamedAndRemoveUntil(this, routeName, (r) => false);
}
