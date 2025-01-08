import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppThemeData with Diagnosticable {
  AppThemeData();

  late TextStyle text_24_700;
  late TextStyle text_22_500;
  late TextStyle text_21_700;
  late TextStyle text_20_600;
  late TextStyle text_20_700;
  late TextStyle text_20_500;
  late TextStyle text_16_700;
  late TextStyle text_16_500;
  late TextStyle text_16_400;
  late TextStyle text_16_300;
  late TextStyle text_16_600;
  late TextStyle text_18_700;
  late TextStyle text_18_500;
  late TextStyle text_14_500;
  late TextStyle text_14_600;
  late TextStyle text_14_400;
  late TextStyle text_14_700;
  late TextStyle text_14_900;
  late TextStyle text_12_700;
  late TextStyle text_12_600;
  late TextStyle text_12_400;
  late TextStyle text_12_500;
  late TextStyle text_10_400;
  late TextStyle text_10_500;

  late TextStyle textLink;
  late TextStyle textFieldLabelHoriz;
  late TextStyle textFieldLabelHorizDisabled;
  late TextStyle textFieldLabelHorizFocused;
  late TextStyle textFieldLabel;
  late TextStyle textFieldLabelDisabled;
  late TextStyle textFieldLabelFocused;
  late TextStyle textFieldText;
  late TextStyle textFieldTextDisabled;
  late TextStyle textFieldHint;
  late TextStyle textFieldHintDisabled;
  late TextStyle textFieldError;
  late TextStyle textFieldErrorDisabled;

  late double defaultPadding = 20;

  // Builds the Custom Themes, EFd on the currently defined EF Themes
  // ignore: avoid_unused_constructor_parameters
  factory AppThemeData.fromContext(BuildContext context) {
    // final ThemeData themeData = Theme.of(context);
    final AppThemeData theme = AppThemeData();

    theme.text_20_600 = const TextStyle(
      fontFamily: 'SVN-Gilroy',
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      color: Colors.black,
    );

    theme.text_24_700 =
        theme.text_20_600.copyWith(fontWeight: FontWeight.w700, fontSize: 24);
    theme.text_18_700 =
        theme.text_20_600.copyWith(fontWeight: FontWeight.w700, fontSize: 18);
    theme.text_18_500 =
        theme.text_20_600.copyWith(fontWeight: FontWeight.w500, fontSize: 18);
    theme.text_21_700 =
        theme.text_20_600.copyWith(fontWeight: FontWeight.w700, fontSize: 21);
    theme.text_20_500 = theme.text_20_600.copyWith(fontWeight: FontWeight.w500);
    theme.text_20_700 = theme.text_20_600.copyWith(fontWeight: FontWeight.w700);
    theme.text_16_500 = theme.text_20_600.copyWith(fontSize: 16.0);
    theme.text_22_500 = theme.text_16_500.copyWith(fontSize: 22.0);
    theme.text_16_400 = theme.text_16_500.copyWith(fontWeight: FontWeight.w400);
    theme.text_16_300 = theme.text_16_500.copyWith(fontWeight: FontWeight.w300);
    theme.text_16_600 = theme.text_16_500.copyWith(fontWeight: FontWeight.w600);
    theme.text_16_700 = theme.text_16_500.copyWith(fontWeight: FontWeight.w700);
    theme.text_10_400 = theme.text_16_400.copyWith(fontSize: 10.0);
    theme.text_10_500 = theme.text_16_500.copyWith(fontSize: 10.0);
    theme.text_14_400 = theme.text_16_400.copyWith(fontSize: 14.0);
    theme.text_14_500 = theme.text_14_400.copyWith(fontWeight: FontWeight.w500);
    theme.text_14_600 = theme.text_14_400.copyWith(fontWeight: FontWeight.w600);
    theme.text_14_700 = theme.text_14_400.copyWith(fontWeight: FontWeight.w700);
    theme.text_14_900 = theme.text_14_400.copyWith(fontWeight: FontWeight.w900);
    theme.text_12_700 =
        theme.text_16_400.copyWith(fontSize: 12.0, fontWeight: FontWeight.w700);
    theme.text_12_600 = theme.text_12_700.copyWith(fontWeight: FontWeight.w600);
    theme.text_12_400 = theme.text_12_700.copyWith(fontWeight: FontWeight.w400);
    theme.text_12_500 = theme.text_12_700.copyWith(fontWeight: FontWeight.w500);

    theme.textFieldLabelHoriz =
        theme.text_12_700.copyWith(fontWeight: FontWeight.w600);
    theme.textFieldLabelHorizDisabled =
        theme.text_12_700.copyWith(fontWeight: FontWeight.w400);
    theme.textFieldLabelHorizFocused =
        theme.text_12_700.copyWith(fontWeight: FontWeight.w500);
    theme.textFieldLabel =
        theme.text_12_700.copyWith(fontWeight: FontWeight.w600);
    theme.textFieldLabelDisabled =
        theme.text_12_700.copyWith(fontWeight: FontWeight.w400);
    theme.textFieldLabelFocused =
        theme.text_12_700.copyWith(fontWeight: FontWeight.w500);

    theme.textFieldText =
        theme.text_12_700.copyWith(fontWeight: FontWeight.w600);
    theme.textFieldTextDisabled =
        theme.text_12_700.copyWith(fontWeight: FontWeight.w400);
    theme.textFieldHint =
        theme.text_12_700.copyWith(fontWeight: FontWeight.w500);
    theme.textFieldHintDisabled =
        theme.text_12_700.copyWith(fontWeight: FontWeight.w600);
    theme.textFieldError =
        theme.text_12_700.copyWith(fontWeight: FontWeight.w400);

    theme.textLink = theme.text_20_600.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
      color: Colors.black,
      decoration: TextDecoration.underline,
    );

    return theme;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is AppThemeData &&
        other.text_20_600 == text_20_600 &&
        other.text_16_500 == text_16_500 &&
        other.text_16_400 == text_16_400 &&
        other.textLink == textLink &&
        other.textFieldLabelHoriz == textFieldLabelHoriz &&
        other.textFieldLabelHorizDisabled == textFieldLabelHoriz &&
        other.textFieldLabelHorizFocused == textFieldLabelHoriz &&
        other.textFieldLabel == textFieldLabelHoriz &&
        other.textFieldLabelDisabled == textFieldLabelHoriz &&
        other.textFieldLabelFocused == textFieldLabelHoriz &&
        other.textFieldText == textFieldLabelHoriz &&
        other.textFieldTextDisabled == textFieldLabelHoriz &&
        other.textFieldHint == textFieldLabelHoriz &&
        other.textFieldHintDisabled == textFieldLabelHoriz &&
        other.textFieldError == textFieldLabelHoriz &&
        other.textFieldErrorDisabled == textFieldLabelHoriz;
  }

  @override
  int get hashCode => Object.hashAll([
        text_20_600,
        text_16_500,
        text_16_400,
        textLink,
        textFieldLabelHoriz,
        textFieldLabelHorizDisabled,
        textFieldLabelHorizFocused,
        textFieldLabel,
        textFieldLabelDisabled,
        textFieldLabelFocused,
        textFieldText,
        textFieldTextDisabled,
        textFieldHint,
        textFieldHintDisabled,
        textFieldError,
        textFieldErrorDisabled,
      ]);
}
