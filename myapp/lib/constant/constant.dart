import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppVisibility { gone, visible, invisible }

enum AppOrientation { horizontal, vertical }

enum AppTextState {
  normal,
  bold,
}

enum AppTextSize {
  small,
  middle,
  large,
}

enum AppLanguage { vi, en }

extension AppLanguageExt on AppLanguage {
  String toShortString() {
    return toString().split('.').last;
  }
}

class ResponseStatus {
  static int success = 0;
}

class GlobalManager {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // var userInfo = AuthResponse();
  // var configurations = PolicyResponse();
}

const String host = 'http://217.160.204.113';
// const String tokenDev = 'Gb19afYr1tpSu3AWJ117NBh95Q4h1Wewr0gq9Un2iQKn91a23dcvd';
const int defaultLimit = 20;


class EnvConfig {
  static const env = String.fromEnvironment('ENV');
  static const proxy = String.fromEnvironment('PROXY');
}

extension StringExtension on String {
  String toUrl() {
    if (contains(host) || isEmpty || contains('http')) {
      return this;
    }
    return '$host/$this';
  }

  String toChatUrl() {
    if (contains(host) || isEmpty || contains('http')) {
      return this;
    }
    return '$host/$this';
  }


  int toInt() {
    return int.tryParse(this) ?? 0;
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove non-digit characters from the new value
    String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Insert "." as a thousands separator
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i > 0 && (newText.length - i) % 3 == 0) {
        formattedText += '.';
      }
      formattedText += newText[i];
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
