
import 'package:flutter/material.dart';
import 'package:myapp/constant/app_colors.dart';
import 'package:myapp/theme/app_theme.dart';

class ShadowButton extends StatefulWidget {
  const ShadowButton({
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
  State<ShadowButton> createState() => _ShadowButtonState();
}

class _ShadowButtonState extends State<ShadowButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withAlpha(30),
            blurRadius: 4,
          ),
        ],
      ),
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12.0),
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
            style: AppTheme.of(context).text_14_600.copyWith(
                color: widget.titleColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
