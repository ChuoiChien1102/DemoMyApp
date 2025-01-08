part of 'app_button.dart';

class AppButtonIcon extends StatefulWidget {
  const AppButtonIcon({
    super.key,
    AppButtonSize? size,
    this.onPressed,
    this.state = AppButtonState.primary,
    this.controller,
    required this.iconAssetPath,
    this.enable,
    this.color,
    this.gradient,
    this.background,
    this.textColor,
    this.isCircle = false,
  }) : size = size ?? (isCircle ? AppButtonSize.largest : AppButtonSize.middle);

  final String iconAssetPath;
  final VoidCallback? onPressed;
  final AppButtonState state;
  final AppButtonSize size;
  final AppButtonController? controller;
  final bool? enable;
  final Color? color;
  final LinearGradient? gradient;
  final Color? background;
  final Color? textColor;
  final bool isCircle;

  @override
  AppButtonIconState createState() => AppButtonIconState();
}

class AppButtonIconState extends State<AppButtonIcon> {
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

  LinearGradient get _gradient {
    if (widget.gradient != null) {
      return widget.gradient!;
    } else if (widget.color != null) {
      return LinearGradient(
        colors: [widget.color!, widget.color!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return AppColors.gradient;
  }

  Color get _background => widget.background ?? AppColors.mainColor;

  BorderRadiusGeometry get _borderRadius {
    return widget.isCircle
        ? BorderRadius.circular(_height / 2)
        : BorderRadius.circular(8.0);
  }

  BoxDecoration get _decoration {
    return BoxDecoration(
      color: enable
          ? (state == AppButtonState.primary
              ? _background
              : (state == AppButtonState.outline
                  ? AppColors.background
                  : Colors.grey))
          : Colors.grey,
      gradient: state != AppButtonState.primary || !enable ? null : _gradient,
      borderRadius: _borderRadius,
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

  double get _height {
    switch (widget.size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.middle:
        return 40;
      case AppButtonSize.large:
        return 48;
      case AppButtonSize.largest:
        return 56;
      default:
        return 40;
    }
  }

  @override
  void initState() {
    super.initState();
    _enable = widget.enable;
    if (widget.controller == null) {
      _controller = AppButtonController(
        state: widget.state,
      );
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(AppButtonIcon oldWidget) {
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
            state: widget.state,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _height,
      child: ElevatedButton(
        onPressed: enable ? widget.onPressed : null,
        style: ButtonStyle(
            padding:
                MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
            overlayColor: MaterialStateProperty.resolveWith(
                (states) => _textColor.withOpacity(0.3)),
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.transparent),
            foregroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.transparent),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: _borderRadius))),
        child: Ink(
          decoration: _decoration,
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(widget.iconAssetPath,
                colorFilter: ColorFilter.mode(_textColor, BlendMode.srcIn)),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _handleControllerChanged() {
    setState(() {
      _enable = _effectiveController.enable;
      _state = _effectiveController.state;
      _visibility = _effectiveController.visibility;
    });
  }
}
