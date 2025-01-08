part of 'app_textfield.dart';

class AppTextFieldValue extends Equatable {
  const AppTextFieldValue({
    this.text = '',
    this.enable = true,
    this.visibility = AppVisibility.visible,
    this.errorText,
    this.isRequired = false,
    this.prefixIconAssetPath,
  });

  final String text;
  final bool enable;
  final AppVisibility visibility;
  final String? errorText;
  final bool isRequired;
  final String? prefixIconAssetPath;

  /// A value that corresponds to the empty string with no selection and no composing range.
  static const AppTextFieldValue empty = AppTextFieldValue();

  /// Creates a copy of this value but with the given fields replaced with the new values.
  AppTextFieldValue copyWith({
    String? text,
    bool? enable,
    AppVisibility? visibility,
    String? errorText,
    bool? isRequired,
  }) {
    return AppTextFieldValue(
      text: text?.trim() ?? this.text,
      enable: enable ?? this.enable,
      visibility: visibility ?? this.visibility,
      errorText: errorText?.trim(),
      isRequired: isRequired ?? this.isRequired,
    );
  }

  @override
  String toString() => 'AppTextFieldValue {text: $text}';

  @override
  List<Object?> get props => [
        text,
        enable,
        visibility,
        errorText,
        isRequired,
        prefixIconAssetPath,
      ];
}
