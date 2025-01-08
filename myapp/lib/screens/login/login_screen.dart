
import 'package:flutter/material.dart';
import 'package:myapp/component/button/app_button.dart';
import 'package:myapp/component/text_field/app_textfield.dart';
import 'package:myapp/constant/app_colors.dart';
import 'package:myapp/constant/app_icons.dart';
import 'package:myapp/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AppTextFieldController _phoneNumberController =
      AppTextFieldController();
  final AppTextFieldController _passwordController = AppTextFieldController();
  final bool _showPass = false;
  String? _errorPhone;
  String? _errorPass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLayoutInput(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bạn chưa có tài khoản?',
                style: AppTheme.of(context)
                    .text_12_700
                    .copyWith(color: AppColors.mainColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Đăng ký',
                  style: AppTheme.of(context)
                      .text_12_700
                      .copyWith(color: AppColors.textPrimary),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLayoutInput(BuildContext context) {
    return Stack(children: [
      // Image.asset(
      //   AppImages.imgBgLogin,
      //   fit: BoxFit.fill,
      //   height: 340,
      //   width: double.infinity,
      // ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          const SizedBox(height: 60),
          AppTextField(
            controller: _phoneNumberController,
            prefixIconAssetPath: AppIcons.icPhone,
            hintText: 'Số điện thoại',
            errorText: _errorPhone,
            hintStyle: AppTheme.of(context)
                .text_16_400
                .copyWith(color: AppColors.mainGreyColor),
            textStyle: AppTheme.of(context)
                .text_16_400
                .copyWith(color: AppColors.textGray),
            // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            // keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 18),
          AppTextField(
            obscureText: !_showPass,
            controller: _passwordController,
            prefixIconAssetPath: AppIcons.icLock,
            suffixIconAssetPath:
                _showPass ? AppIcons.icEye : AppIcons.icEyeClose,
            hintText: 'Mật khẩu',
            errorText: _errorPass,
            hintStyle: AppTheme.of(context)
                .text_16_400
                .copyWith(color: AppColors.mainGreyColor),
            textStyle: AppTheme.of(context)
                .text_16_400
                .copyWith(color: AppColors.textGray),
            suffixIconOnTap: () {},
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Quên mật khẩu ?",
                style: AppTheme.of(context)
                    .text_16_400
                    .copyWith(color: AppColors.textGrey12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            label: 'ĐĂNG NHẬP',
            textStyle: AppTheme.of(context)
                .text_16_600
                .copyWith(color: AppColors.textWhite),
            size: AppButtonSize.middle,
            isFullWidth: true,
            background: AppColors.mainColor,
            onPressed: () {},
          ),
        ]),
      )
    ]);
  }
}
