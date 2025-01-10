import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/component/button/shadow_button.dart';
import 'package:myapp/constant/app_colors.dart';
import 'package:myapp/theme/app_theme.dart';

class AppDialog extends StatefulWidget {
  const AppDialog({
    super.key,
    this.title,
    this.logoTitle,
    this.msg,
    this.okText = 'Ok',
    this.cancelText,
    this.okHandler,
    this.cancelHandler,
    this.closeHandler,
    this.content,
  });

  final String? title;
  final bool? logoTitle;
  final String? msg;
  final String okText;
  final String? cancelText;
  final VoidCallback? okHandler;
  final VoidCallback? cancelHandler;
  final VoidCallback? closeHandler;
  final Widget? content;

  static var isShowing = false;

  @override
  AppDialogState createState() => AppDialogState();

  static void show(
    BuildContext context, {
    String? title,
    String? msg,
    String okText = 'Ok',
    String? cancelText,
    VoidCallback? okHandler,
    VoidCallback? cancelHandler,
    VoidCallback? closeHandler,
    Widget? content,
  }) {
    if (Get.isDialogOpen == true && isShowing) {
      Get.back();
    }
    Get.dialog(
      PopScope(
        canPop: false,
        child: AppDialog(
          title: title,
          msg: msg,
          okText: okText,
          cancelText: cancelText,
          okHandler: okHandler,
          cancelHandler: cancelHandler,
          closeHandler: closeHandler,
          content: content,
        ),
      ),
      barrierDismissible: false,
    );
    isShowing = true;
  }
}

class AppDialogState extends State<AppDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              if (widget.title != null) _buildTitle(context),
              _buildBody(),
              const SizedBox(height: 14),
              _buildButtons(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitle(context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title!,
          style: AppTheme.of(context).text_16_700.copyWith(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Flexible(
      child: Container(
        padding: (widget.title == null && widget.logoTitle == null)
            ? const EdgeInsets.all(20)
            : const EdgeInsets.only(left: 30, right: 30, top: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.msg != null)
              Text(
                widget.msg!,
                style: AppTheme.of(context)
                    .text_16_500
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            widget.content ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Row(
        children: [
          if (widget.cancelText != null || widget.cancelHandler != null)
            Expanded(
              flex: 1,
              child: ShadowButton(
                title: widget.cancelText,
                titleColor: Colors.black,
                backgroundColor: AppColors.background,
                onTap: () {
                  Navigator.pop(context, false);
                  AppDialog.isShowing = false;
                  if (widget.cancelHandler != null) {
                    widget.cancelHandler!();
                  }
                },
              ),
            ),
          if (widget.cancelText != null || widget.cancelHandler != null)
            const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: ShadowButton(
              title: widget.okText,
              titleColor: Colors.white,
              backgroundColor: AppColors.mainColor,
              onTap: () {
                Navigator.pop(context, true);
                AppDialog.isShowing = false;
                if (widget.okHandler != null) {
                  widget.okHandler!();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
