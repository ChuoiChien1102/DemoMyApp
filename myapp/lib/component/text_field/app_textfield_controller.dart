part of 'app_textfield.dart';

class AppTextFieldController extends ValueNotifier<AppTextFieldValue> {
  AppTextFieldController({
    String text = '',
    bool enable = true,
    AppVisibility visibility = AppVisibility.visible,
    bool isRequired = false,
  }) : super(AppTextFieldValue(
          text: text,
          enable: enable,
          visibility: visibility,
          isRequired: isRequired,
        ));

  AppTextFieldController.fromValue(AppTextFieldValue value) : super(value);

  String get text => value.text.trim();
  bool get enable => value.enable;
  AppVisibility get visibility => value.visibility;
  String? get errorText => value.errorText?.trim();
  bool get isRequired => value.isRequired;

  late Function({String? errorText}) shake;
  late bool Function() hasFocus;
  late Function(TextSelection selection) setSelection;

  set text(String text) => value = value.copyWith(text: text.trim());
  set enable(bool enable) => value = value.copyWith(enable: enable);
  set visibility(AppVisibility visibility) =>
      value = value.copyWith(visibility: visibility);
  set errorText(String? errorText) =>
      value = value.copyWith(errorText: errorText?.trim());
  set isRequired(bool isRequired) =>
      value = value.copyWith(isRequired: isRequired);
}
