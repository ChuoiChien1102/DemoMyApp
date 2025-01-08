import 'package:flutter/material.dart';
import 'package:myapp/constant/app_colors.dart';
import 'package:myapp/theme/app_theme.dart';

class BorderButton extends StatefulWidget {
  const BorderButton({
    super.key,
    this.title,
    this.titleColor,
    this.backgroundColor,
    this.onTap,
    this.suffixIcon,
    this.padding,
    this.borderRadius,
  });
  final String? title;
  final Color? titleColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  @override
  State<BorderButton> createState() => _BorderButtonState();
}

class _BorderButtonState extends State<BorderButton> {
  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() {
    return OutlinedButton(
      onPressed: widget.onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(6.0),
        ),
        side: const BorderSide(
          color: AppColors.mainColor, // Màu viền
          width: 1.0, // Độ rộng viền
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.suffixIcon != null)
            Row(
              children: [
                widget.suffixIcon!,
                const SizedBox(width: 8),
              ],
            ),
          Text(
            widget.title ?? '',
            style: AppTheme.of(context)
                .text_16_500
                .copyWith(color: widget.titleColor ?? Colors.black),
          ),
        ],
      ),
    );
  }
}
