import 'package:flutter/material.dart';
import 'package:myapp/constant/app_colors.dart';
import 'package:myapp/theme/app_theme.dart';

class CustomTheme {
  CustomTheme();

  ThemeData? oneAppTheme;

  factory CustomTheme.fromContext(BuildContext context) {
    final CustomTheme theme = CustomTheme();

    theme.oneAppTheme = ThemeData(
      primaryColor: AppColors.mainColor,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'SVN-Gilroy',
      textTheme: TextTheme(
        bodyMedium: AppTheme.of(context).text_16_500,
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        height: 56.0,
        buttonColor: AppColors.mainColor,
      ),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Colors.transparent, brightness: Brightness.light)
          .copyWith(background: Colors.white),
    );

    return theme;
  }
}
