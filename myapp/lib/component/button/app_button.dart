import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/constant/app_colors.dart';
import 'package:myapp/constant/constant.dart';
import 'package:tuple/tuple.dart';

part 'app_button_controller.dart';
part 'app_button_icon.dart';
part 'app_button_value.dart';

enum AppButtonState {
  primary,
  outline,
  disable,
}

enum AppButtonSize {
  small,
  middle,
  large,
  largest,
}

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    this.label,
    this.size = AppButtonSize.middle,
    this.isFullWidth = true,
    this.onPressed,
    this.state = AppButtonState.primary,
    this.controller,
    this.title,
    this.enable,
    this.prefixIconAssetPath,
    this.suffixIconAssetPath,
    this.color,
    this.gradient,
    this.background,
    this.textColor,
    this.padding,
    this.textStyle,
    this.maxLines,
    this.height,
  }) : assert(title != null || label != null);

  final String? label;
  final String? prefixIconAssetPath;
  final String? suffixIconAssetPath;
  final VoidCallback? onPressed;
  final AppButtonState state;
  final AppButtonSize size;
  final bool isFullWidth;
  final Widget? title;
  final bool? enable;
  final AppButtonController? controller;
  final Color? color;
  final bool? gradient;
  final Color? background;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final int? maxLines;
  final double? height;

  @override
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<AppButton> {
  late AppButtonController _controller;
  AppButtonController get _effectiveController =>
      widget.controller ?? _controller;

  bool? _enable;

  bool get enable => _enable ?? _effectiveController.enable;

  AppButtonState? _state;

  AppButtonState get state => _state ?? _effectiveController.state;

  AppVisibility? _visibility;

  AppVisibility get visibility =>
      _visibility ?? _effectiveController.visibility;

  Color get _color => widget.color ?? AppColors.mainColor;

  Color get _background => widget.background ?? AppColors.mainColor;

  BoxDecoration get _decoration {
    return BoxDecoration(
      color: enable
          ? (state == AppButtonState.primary
              ? _background
              : (state == AppButtonState.outline
                  ? AppColors.background
                  : Colors.grey))
          : Colors.grey,
      gradient: widget.gradient == true ? AppColors.gradient : null,
      borderRadius: BorderRadius.circular(_height / 2),
      border: state == AppButtonState.outline && enable
          ? Border.all(width: 1.0, color: _color)
          : null,
    );
  }

  Color get _textColor {
    if (!enable) {
      return Colors.grey;
    }
    switch (state) {
      case AppButtonState.primary:
        return widget.textColor ?? Colors.white;
      case AppButtonState.outline:
        return widget.textColor ?? _color;
      case AppButtonState.disable:
        return Colors.grey;
      default:
        return widget.textColor ?? Colors.white;
    }
  }

  Tuple3<double, TextStyle, int> get _sizeConfiguration {
    switch (widget.size) {
      case AppButtonSize.small:
        return Tuple3(
            widget.height ?? 36,
            widget.textStyle ??
                TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: _textColor),
            widget.maxLines ?? 1);
      case AppButtonSize.middle:
        return Tuple3(
            widget.height ?? 40,
            widget.textStyle ??
                TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: _textColor),
            widget.maxLines ?? 1);
      case AppButtonSize.large:
        return Tuple3(
            widget.height ?? 48,
            widget.textStyle ??
                TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: _textColor),
            widget.maxLines ?? 2);
      case AppButtonSize.largest:
        return Tuple3(
            widget.height ?? 50,
            widget.textStyle ??
                TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: _textColor),
            widget.maxLines ?? 2);
    }
  }

  double get _height => _sizeConfiguration.item1;
  TextStyle get _textStyle => _sizeConfiguration.item2;
  int get _maxLines => _sizeConfiguration.item3;

  @override
  void initState() {
    super.initState();
    _enable = widget.enable;
    if (widget.controller == null) {
      _controller = AppButtonController(
        label: widget.label,
        state: widget.state,
        enable: widget.enable ?? true,
      );
    } else {
      if (widget.enable != null) widget.controller!.enable = widget.enable!;
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(AppButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller =
            AppButtonController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        if (oldWidget.controller == null) {
          _controller = AppButtonController(
            label: widget.label,
            state: widget.state,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: widget.isFullWidth ? double.infinity : null,
      decoration: _decoration,
      child: ElevatedButton(
        onPressed: enable ? widget.onPressed : null,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
              (states) => _textColor.withOpacity(0.3)),
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.transparent),
          foregroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          padding:
              MaterialStateProperty.resolveWith((states) => widget.padding),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        ),
        child: widget.title ?? _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.prefixIconAssetPath != null) ...[
          SvgPicture.asset(widget.prefixIconAssetPath!,
              colorFilter: ColorFilter.mode(_textColor, BlendMode.srcIn),
              width: 16.0,
              height: 16.0),
          const SizedBox(width: 5.0),
        ],
        Flexible(
          child: Text(
            widget.label!,
            textAlign: TextAlign.center,
            maxLines: _maxLines,
            overflow: TextOverflow.ellipsis,
            style: _textStyle,
          ),
        ),
        if (widget.suffixIconAssetPath != null) ...[
          const SizedBox(width: 5.0),
          SvgPicture.asset(widget.suffixIconAssetPath!,
              colorFilter: ColorFilter.mode(_textColor, BlendMode.srcIn),
              width: 16.0,
              height: 16.0),
        ],
      ],
    );
  }

  void _handleControllerChanged() {
    setState(() {
      _enable = _effectiveController.enable;
      _state = _effectiveController.state;
      _visibility = _effectiveController.visibility;
    });
  }
}
