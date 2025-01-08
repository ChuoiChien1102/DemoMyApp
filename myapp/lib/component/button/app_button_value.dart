part of 'app_button.dart';

class AppButtonValue extends Equatable {
  const AppButtonValue(
      {this.enable = true,
      this.state = AppButtonState.primary,
      this.label,
      this.visibility = AppVisibility.visible});

  final bool enable;
  final AppButtonState state;
  final String? label;
  final AppVisibility visibility;

  /// A value that corresponds to the empty string with no selection and no composing range.
  static const AppButtonValue empty = AppButtonValue();

  /// Creates a copy of this value but with the given fields replaced with the new values.
  AppButtonValue copyWith({
    bool? enable,
    AppButtonState? state,
    String? label,
    AppVisibility? visibility,
  }) {
    return AppButtonValue(
      enable: enable ?? this.enable,
      state: state ?? this.state,
      label: label ?? this.label,
      visibility: visibility ?? this.visibility,
    );
  }

  @override
  String toString() =>
      'EFButtonValue {label: $label, state: $state, enable: $enable}';

  @override
  List<Object?> get props => [
        enable,
        state,
        label,
        visibility,
      ];
}
