/*
 * File: one_app_bar.dart
 * File Created: Wednesday, 20th January 2021 10:46:31 am
 * Author: Chien Nguyen
 * -----
 * Last Modified: Wednesday, 20th January 2021 11:00:02 am
 * Modified By: Chien Nguyen
 */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marquee/marquee.dart';
import 'package:myapp/constant/app_icons.dart';
import 'package:myapp/theme/app_theme.dart';

class OneAppBar extends StatelessWidget {
  const OneAppBar({
    Key? key,
    this.title,
    this.onTapBack,
  }) : super(key: key);

  final String? title;
  final VoidCallback? onTapBack;

  @override
  Widget build(BuildContext context) {
    final appBar = _appBar(context);
    return SafeArea(
      top: false,
      bottom: false,
      child: Stack(
        children: [
          Container(
            child: appBar,
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    final style = AppTheme.of(context).header.copyWith(color: Colors.blue);
    return AppBar(
      title: title?.isNotEmpty ?? false
          ? AutoSizeText(
              title!,
              style: style,
              maxLines: 1,
              minFontSize: 16,
              overflowReplacement: Container(
                height: 50,
                child: Marquee(
                  text: title!,
                  style: style,
                  blankSpace: 30,
                  startAfter: const Duration(seconds: 2),
                  pauseAfterRound: const Duration(seconds: 2),
                ),
              ),
            )
          : null,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: onTapBack ?? () => Navigator.of(context).pop(),
        child: Center(
          child: SvgPicture.asset(AppIcons.icBack,
              color: Colors.blue, cacheColorFilter: true),
        ),
      ),
    );
  }
}
