import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myapp/component/app_dialog/app_dialog.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/shared/app_manager.dart';

class NetworkManager {
  BaseOptions opts = BaseOptions(
    baseUrl: host,
    contentType: 'application/json',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  Dio createDio() {
    return Dio(opts);
  }
}

//BaseDioExtension
extension BaseDioExtension on Dio {
  Dio addInterceptors() {
    return this
      ..interceptors.add(
        InterceptorsWrapper(
            onRequest: requestInterceptor,
            onError: (DioException error, ErrorInterceptorHandler handler) {
              EasyLoading.dismiss();
              final GlobalManager globalManager = Get.find();
              if (error.response?.statusCode == 401) {
                AppDialog.show(
                  globalManager.navigatorKey.currentContext!,
                  msg:
                      'Phiên đăng nhập của bạn đã hết hạn, vui lòng đăng nhập lại để tiếp tục!',
                  okHandler: () async {
                    await Get.find<AppManager>().clearToken();
                    // globalManager.userInfo = AuthResponse();
                    // Get.toNamed(AppRoute.signIn.name!);
                  },
                );
              } else {
                AppDialog.show(
                  globalManager.navigatorKey.currentContext!,
                  msg: error.message,
                );
              }
            }),
      );
  }

  Future requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // options.headers.addAll({'tokendev': tokenDev});
      final token = await Get.find<AppManager>().getToken();
      if (token != null) {
        options.headers.addAll({'Authorization': 'Bearer $token'});
        log('token: Bearer $token');
      }

      return handler.next(options);
    } catch (e) {
      return handler.next(options);
    }
  }
}
