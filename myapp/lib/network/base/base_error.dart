import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myapp/network/base/error_response.dart';

part 'base_error_handling.dart';

class BaseError implements Exception {
  ErrorResponse? resError;
  DioException? dioError;

  /// The original error/exception object
  dynamic error;

  BaseError({this.resError, this.dioError, this.error});

  String get message {
    String msg = '';
    if (resError != null) {
      final message = resError?.msg ?? '';
      if (message.isNotEmpty) {
        msg = message;
      }

      final error = resError?.error ?? '';
      if (msg.isEmpty && error.isNotEmpty) {
        msg = error;
      }
    } else if (dioError != null) {
      msg = dioError.toString();
    } else if (error != null) {
      msg = error.toString();
    }

    return msg.isEmpty ? 'Unexpected Error Exception' : msg;
  }

  @override
  String toString() {
    var msg = message;
    if (error is Error) {
      msg += '\n${error.stackTrace}';
    }
    return msg;
  }
}
