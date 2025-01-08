import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/component/text_field/shake_widget.dart';
import 'package:myapp/constant/app_colors.dart';
import 'package:myapp/constant/app_icons.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/theme/app_theme.dart';
import 'package:rxdart/rxdart.dart';

part 'app_textfield_controller.dart';
part 'app_textfield_value.dart';

enum AppTextFieldStyle {
  underline,
  outline,
  none,
}

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    this.titleText,
    this.titleStyle,
    this.hintText,
    this.hintStyle,
    this.errorText,
    this.textStyle,
    this.enable,
    this.keyboardType = TextInputType.text,
    this.visibility = AppVisibility.visible,
    this.padding,
    this.controller,
    this.isRequired,
    this.isAlwaysShowTitle = true,
    this.clearable = false,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.onTap,
    this.onTapClear,
    this.suffixIconAssetPath,
    this.suffixIconEnable,
    this.suffixIconOnTap,
    this.suffixIconFocusColor = AppColors.mainColor,
    this.prefixIconAssetPath,
    this.prefixIconEnable,
    this.onEditingCompleted,
    this.onChanged,
    this.onFocusChanged,
    this.onFiltered,
    this.filterDuration,
    this.orientation = AppOrientation.vertical,
    this.labelFlex = 1,
    this.textFlex = 1,
    this.textAlign = TextAlign.start,
    this.style = AppTextFieldStyle.none,
    this.borderColor,
    this.backgroundColor = AppColors.background,
    this.inputFormatters,
    this.maxLength,
    this.borderContent,
    this.enableInteractiveSelection = true,
  })  : assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        super(key: key);

  final String? titleText;
  final TextStyle? titleStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? errorText;
  final TextStyle? textStyle;
  final bool? enable;
  final TextInputType keyboardType;
  final AppVisibility visibility;
  final EdgeInsetsGeometry? padding;
  final AppTextFieldController? controller;
  final bool? isRequired;
  final bool isAlwaysShowTitle;
  final bool clearable;
  final bool readOnly;
  final bool obscureText;
  final int? maxLines;
  final int minLines;
  final VoidCallback? onTap;
  final VoidCallback? onTapClear;
  final String? suffixIconAssetPath;
  final Widget? suffixIconEnable;
  final VoidCallback? suffixIconOnTap;
  final String? prefixIconAssetPath;
  final Widget? prefixIconEnable;
  final ValueChanged<String>? onEditingCompleted;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final ValueChanged<String>? onFiltered;
  final Duration? filterDuration;
  final AppOrientation orientation;
  final int labelFlex;
  final int textFlex;
  final TextAlign textAlign;
  final AppTextFieldStyle style;
  final Color? borderColor;
  final Color? suffixIconFocusColor;
  final Color? backgroundColor;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool enableInteractiveSelection;
  final BorderRadiusGeometry? borderContent;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField>
    with TickerProviderStateMixin {
  late AppTextFieldController _controller;
  AppTextFieldController get _effectiveController =>
      widget.controller ?? _controller;

  late final TextEditingController _txtController;
  late final StreamController<String> _textUpdates;
  late final ValueNotifier<bool> _hasText;
  late final FocusNode _focusNode;

  TextStyle? get _labelStyle {
    if (widget.orientation == AppOrientation.horizontal) {
      if (widget.titleStyle != null) return widget.titleStyle;
      if (!enable) return AppTheme.of(context).textFieldLabelHorizDisabled;
      if (_focusNode.hasFocus) {
        return AppTheme.of(context)
            .text_14_400
            .copyWith(color: AppColors.mainColor);
      }
      return AppTheme.of(context).text_14_400;
    }
    if (widget.titleStyle != null) return widget.titleStyle;
    if (!enable) return AppTheme.of(context).textFieldLabelDisabled;
    if (_focusNode.hasFocus) {
      return AppTheme.of(context)
          .text_14_400
          .copyWith(color: AppColors.mainColor);
    }
    return AppTheme.of(context).text_14_400;
  }

  String? get _hintText {
    return widget.hintText != null
        ? '${widget.hintText} ${isRequired && !isTitleVisible ? '* ' : ''}'
        : '';
  }

  TextStyle? get _hintStyle {
    if (widget.hintStyle != null) return widget.hintStyle;
    if (!enable) return AppTheme.of(context).textFieldHintDisabled;
    return AppTheme.of(context)
        .text_14_400
        .copyWith(color: AppColors.mainColor);
  }

  TextStyle? get _textStyle {
    if (widget.textStyle != null) return widget.textStyle;
    if (!enable) return AppTheme.of(context).textFieldTextDisabled;
    return AppTheme.of(context).text_16_400.copyWith(color: AppColors.icBlack);
  }

  InputBorder? get _enabledBorder {
    switch (widget.style) {
      case AppTextFieldStyle.underline:
        return UnderlineInputBorder(
          borderSide:
              BorderSide(color: widget.borderColor ?? AppColors.mainColor),
        );
      case AppTextFieldStyle.outline:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColors.mainColor),
        );
      case AppTextFieldStyle.none:
        return UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(6));
    }
  }

  InputBorder? get _focusedBorder {
    switch (widget.style) {
      case AppTextFieldStyle.underline:
        return UnderlineInputBorder(
          borderSide:
              BorderSide(color: widget.borderColor ?? AppColors.mainColor),
        );
      case AppTextFieldStyle.outline:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColors.mainColor),
        );
      case AppTextFieldStyle.none:
        return UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(6));
    }
  }

  EdgeInsets? get _contentPadding {
    switch (widget.style) {
      case AppTextFieldStyle.underline:
        return EdgeInsets.fromLTRB(
            hasPrefix ? 34 : 20, 10, hasSuffix ? 24 : 10, 10);
      case AppTextFieldStyle.outline:
        return EdgeInsets.fromLTRB(
            hasPrefix ? 40 : 35, 10, hasSuffix ? 24 : 10, 10);
      case AppTextFieldStyle.none:
        return EdgeInsets.fromLTRB(
            hasPrefix ? 40 : 20, 10, hasSuffix ? 17 : 17, 12);
    }
  }

  Duration get filterDuration =>
      widget.filterDuration ?? const Duration(milliseconds: 500);

  bool? _enable;
  bool get enable => _enable ?? _effectiveController.enable;

  AppVisibility? _visibility;
  AppVisibility get visibility =>
      _visibility ?? _effectiveController.visibility;

  bool get isClearVisible => widget.clearable && enable;
  bool get hasSuffix => isClearVisible || widget.suffixIconAssetPath != null;
  bool get hasTitle => widget.titleText != null;
  bool get isTitleVisible =>
      widget.titleText != null &&
      (widget.isAlwaysShowTitle || _focusNode.hasFocus || _hasText.value);

  String? _errorText;
  String? get errorText => _errorText?.trim();
  bool get hasError => errorText != null && errorText!.isNotEmpty;

  bool? _isRequired;
  bool get isRequired => _isRequired ?? _effectiveController.isRequired;

  late final ShakeController _shakeController;

  String? get prefixIconAssetPath => widget.prefixIconAssetPath;
  bool get hasPrefix => prefixIconAssetPath != null;

  @override
  void initState() {
    super.initState();
    _shakeController = ShakeController(vsync: this);
    _txtController = TextEditingController();
    _txtController.addListener(_handleTxtControllerChanged);
    _textUpdates = StreamController<String>();
    _textUpdates.stream
        .distinct()
        .debounceTime(filterDuration)
        .forEach(_onFiltered);
    _hasText = ValueNotifier(false);
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChanged);
    _enable = widget.enable;
    _isRequired = widget.isRequired;
    _errorText = widget.errorText;

    if (widget.controller == null) {
      _controller = AppTextFieldController(
        text: _txtController.text,
        visibility: widget.visibility,
        enable: widget.enable ?? true,
        isRequired: widget.isRequired ?? false,
      );
    } else {
      widget.controller!.shake = _shake;
      widget.controller!.hasFocus = _hasFocus;
      widget.controller!.setSelection = _setSelection;
      widget.controller!.addListener(_handleControllerChanged);
      _txtController.text = widget.controller!.text;
      _visibility = widget.visibility;
      if (widget.isRequired != null) {
        widget.controller!.isRequired = widget.isRequired!;
      }
      if (widget.enable != null) widget.controller!.enable = widget.enable!;
    }
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller =
            AppTextFieldController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        _txtController.text = widget.controller!.text;
        if (oldWidget.controller == null) {
          _controller = AppTextFieldController(
            enable: widget.enable ?? true,
            text: _txtController.text,
            visibility: widget.visibility,
          );
        }
      }
    }
    _errorText = widget.errorText ?? _effectiveController.errorText;
  }

  @override
  Widget build(BuildContext context) {
    return ShakeWidget(
      controller: _shakeController,
      child: widget.orientation == AppOrientation.horizontal
          ? _buildHorizontal(context)
          : _buildVertical(context),
    );
  }

  Widget _buildVertical(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasTitle) ...[_buildLabel()],
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            _buildTextfield(context),
            if (hasPrefix) _buildPrefix(),
            _buildSuffix(),
          ],
        ),
      ],
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasTitle) ...[
          Expanded(
            flex: widget.labelFlex,
            child: _buildLabel(AppOrientation.horizontal),
          ),
          const SizedBox(width: 7)
        ],
        Expanded(
          flex: widget.textFlex,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildTextfield(context),
              if (hasPrefix) _buildPrefix(),
              _buildSuffix(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildLabel([AppOrientation orientation = AppOrientation.vertical]) {
    return ValueListenableBuilder(
      valueListenable: _hasText,
      builder: (context, value, child) {
        return !isTitleVisible
            ? const SizedBox(height: 15)
            : Text.rich(
                TextSpan(
                  style: _labelStyle,
                  children: [
                    TextSpan(text: widget.titleText),
                    if (isRequired && isTitleVisible)
                      TextSpan(
                          text: ' *',
                          style: _labelStyle!.copyWith(color: AppColors.error)),
                  ],
                ),
                maxLines: widget.maxLines,
                overflow: TextOverflow.fade,
              );
      },
    );
  }

  Widget _buildTextfield(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      controller: _txtController,
      focusNode: _focusNode,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onTap: widget.onTap,
      // showCursor: _focusNode.hasFocus,
      showCursor: widget.readOnly ? false : true,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: _hintText,
        labelStyle: _labelStyle,
        hintStyle: _hintStyle,
        hintMaxLines: widget.maxLines,
        errorText: errorText,
        errorStyle: AppTheme.of(context).textFieldError,
        errorMaxLines: 1,
        focusColor: AppColors.mainColor,
        focusedBorder: _focusedBorder,
        enabledBorder: _enabledBorder,
        isDense: true,
        contentPadding: _contentPadding,
        enabled: enable,
        filled: true,
        fillColor: widget.backgroundColor,
      ),
      inputFormatters: widget.inputFormatters,
      textAlign: widget.textAlign,
      style: _textStyle,
      cursorColor: AppColors.mainColor,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.done,
      obscureText: widget.obscureText,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        if (widget.onEditingCompleted != null) {
          widget.onEditingCompleted!(_txtController.text);
        }
      },
    );
  }

  Widget _buildSuffix() {
    final suffixIcon = widget.suffixIconAssetPath != null
        ? Container(
            width: 30,
            height: 50,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              widget.suffixIconAssetPath!,
              width: 20,
              height: 16,
              color: _hasFocus() ? widget.suffixIconFocusColor : null,
            ))
        : const SizedBox();
    final suffixIconWidget = InkWell(
        onTap: () {
          if (widget.suffixIconOnTap != null) widget.suffixIconOnTap!();
          _focusNode.requestFocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: suffixIcon,
        ));

    return Positioned.fill(
      right: -3.0,
      child: Align(
        alignment: Alignment.topRight,
        child: isClearVisible
            ? ValueListenableBuilder<bool>(
                valueListenable: _hasText,
                builder: (context, value, child) {
                  return value
                      ? InkWell(
                          onTap: widget.onTapClear ??
                              (!widget.readOnly
                                  ? () => _txtController.clear()
                                  : null),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            child: SvgPicture.asset(AppIcons.icCancel),
                          ),
                        )
                      : suffixIconWidget;
                },
              )
            : suffixIconWidget,
      ),
    );
  }

  Widget _buildPrefix() {
    final prefixIcon = SvgPicture.asset(
      prefixIconAssetPath!,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            prefixIcon,
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _txtController.removeListener(_handleTxtControllerChanged);
    _textUpdates.close();
    _focusNode.removeListener(_handleFocusChanged);
    _focusNode.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _handleTxtControllerChanged() {
    final _txtTrim = _txtController.text.trim();
    _hasText.value = _txtTrim.isNotEmpty;
    if (_effectiveController.text.trim() != _txtTrim) {
      _effectiveController.text = _txtTrim;
    }
    _textUpdates.add(_txtTrim);
    if (widget.onChanged != null) {
      widget.onChanged!(_txtTrim);
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController.text.trim() != _txtController.text.trim()) {
      _txtController.text = _effectiveController.text.trim();
    }

    setState(() {
      _enable = _effectiveController.enable;
      _errorText = _effectiveController.errorText?.trim();
      _visibility = _effectiveController.visibility;
      _isRequired = _effectiveController.isRequired;
    });
  }

  void _onFiltered(String s) {
    if (!mounted) return;
    if (widget.onFiltered != null) {
      widget.onFiltered!(s.trim());
    }
  }

  void _handleFocusChanged() {
    final _txtTrim = _txtController.text.trim();
    if (!_focusNode.hasFocus) {
      if (_txtController.text != _txtTrim) {
        _txtController.text = _txtTrim;
      }
    }
    if (widget.onFocusChanged != null) {
      widget.onFocusChanged!(_focusNode.hasFocus);
    }
    setState(() {});
  }

  void _shake({String? errorText}) {
    setState(() {
      _errorText = errorText?.trim();
      _effectiveController.errorText = errorText?.trim();
      _shakeController.shake();
    });
  }

  bool _hasFocus() => _focusNode.hasFocus;
  void _setSelection(TextSelection selection) =>
      _txtController.selection = selection;
}
