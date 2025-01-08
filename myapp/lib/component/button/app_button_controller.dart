part of 'app_button.dart';

class AppButtonController extends ValueNotifier<AppButtonValue> {
  AppButtonController(
      {bool enable = true,
      AppButtonState state = AppButtonState.primary,
      String? label,
      AppVisibility visibility = AppVisibility.visible})
      : super(AppButtonValue(
          enable: enable,
          state: state,
          label: label,
          visibility: visibility,
        ));

  AppButtonController.fromValue(super.value);

  bool get enable => value.enable;
  AppButtonState get state => value.state;
  String? get label => value.label;
  AppVisibility get visibility => value.visibility;

  set enable(bool enable) => value = value.copyWith(enable: enable);
  set state(AppButtonState state) => value = value.copyWith(state: state);
  set label(String? label) => value = value.copyWith(label: label);
  set visibility(AppVisibility visibility) =>
      value = value.copyWith(visibility: visibility);
}
