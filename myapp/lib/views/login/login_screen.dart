import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myapp/component/app_dialog/app_dialog.dart';
import 'package:myapp/component/button/app_button.dart';
import 'package:myapp/component/text_field/app_textfield.dart';
import 'package:myapp/constant/app_colors.dart';
import 'package:myapp/constant/app_icons.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/theme/app_theme.dart';
import 'package:myapp/view_models/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalManager globalManager = Get.find();
  final AppTextFieldController _emailController = AppTextFieldController();
  final AppTextFieldController _passwordController = AppTextFieldController();
  bool _showPass = false;
  String? _errorEmail;
  String? _errorPass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildLayoutInput(context), _buildLoginSuccess(context)],
          ),
        ),
      ),
    );
  }

  Widget _buildLayoutInput(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          const SizedBox(height: 60),
          AppTextField(
            controller: _emailController,
            prefixIconAssetPath: AppIcons.icEmail,
            hintText: 'Email',
            style: AppTextFieldStyle.outline,
            errorText: _errorEmail,
            // errorColor: AppColors.textRed,
            hintStyle: AppTheme.of(context)
                .text_16_400
                .copyWith(color: AppColors.mainGreyColor),
            textStyle: AppTheme.of(context)
                .text_16_400
                .copyWith(color: AppColors.textGray),
            onChanged: (value) {},
          ),
          const SizedBox(height: 18),
          AppTextField(
            obscureText: !_showPass,
            controller: _passwordController,
            prefixIconAssetPath: AppIcons.icLock,
            suffixIconAssetPath:
                _showPass ? AppIcons.icEye : AppIcons.icEyeClose,
            hintText: 'Password',
            style: AppTextFieldStyle.outline,
            errorText: _errorPass,
            // errorColor: AppColors.textRed,
            hintStyle: AppTheme.of(context)
                .text_16_400
                .copyWith(color: AppColors.mainGreyColor),
            textStyle: AppTheme.of(context)
                .text_16_400
                .copyWith(color: AppColors.textGray),
            suffixIconOnTap: () {
              setState(() {
                _showPass = !_showPass;
              });
            },
            onChanged: (value) {},
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Forgot password ?",
                style: AppTheme.of(context)
                    .text_16_500
                    .copyWith(color: AppColors.textFlag2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            label: 'LOGIN',
            textStyle: AppTheme.of(context)
                .text_16_600
                .copyWith(color: AppColors.textWhite),
            size: AppButtonSize.middle,
            // controller: _loginController,
            background: AppColors.bgPick,
            onPressed: () {
              if (_emailController.text.isEmpty) {
                setState(() {
                  _errorEmail = "Email is required";
                });
                return;
              }
              if (_passwordController.text.isEmpty) {
                setState(() {
                  _errorPass = "Password is required";
                });
                return;
              }
              Get.find<LoginCubit>().login(
                  p_email: _emailController.text,
                  p_password: _passwordController.text);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have account?',
                  style: AppTheme.of(context)
                      .text_12_700
                      .copyWith(color: AppColors.mainColor),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Register',
                    style: AppTheme.of(context)
                        .text_12_700
                        .copyWith(color: AppColors.bgPick),
                  ),
                )
              ],
            ),
          ),
        ]),
      )
    ]);
  }

  Widget _buildLoginSuccess(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      bloc: Get.find<LoginCubit>(),
      listener: (context, state) {
        if (state is LoginInProgress) {
          EasyLoading.show(status: 'Loading...');
          return;
        }

        EasyLoading.dismiss();

        if (state is LoginFailure) {
          Get.snackbar("Error", state.error.toString());
          return;
        }

        if (state is LoginSuccess) {
          final response = state.dataResponse;
          if (response!.error_code == ResponseStatus.success) {
            AppDialog.show(
              globalManager.navigatorKey.currentContext!,
              msg: 'Login success!',
              okHandler: () async {},
            );
          } else {
            Get.snackbar("Error", response.message.toString());
          }
        }
      },
      builder: (context, state) {
        return Container();
      },
    );
  }
}
