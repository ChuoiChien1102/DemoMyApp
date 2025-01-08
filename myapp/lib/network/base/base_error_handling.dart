part of 'base_error.dart';

class BaseErrorHandling {
  onError(Object obj) {
    if (obj is DioException) {
      final res = obj.response;
      if (res != null) {
        final resError = res.data is Map<String, dynamic>
            ? ErrorResponse.fromJson(res.data)
            : null;
        final error = BaseError(dioError: obj, resError: resError);
        throw assureError(error);
      } else {
        final error = BaseError(dioError: obj);
        throw assureError(error);
      }
    } else {
      throw assureError(obj);
    }
  }

  static BaseError assureError(err) {
    BaseError error;
    if (err is BaseError) {
      error = err;
    } else {
      error = BaseError(error: err);
    }
    log(error.toString());
    return error;
  }
}
