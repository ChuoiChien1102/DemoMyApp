
import 'package:dio/dio.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/network/base/base_response.dart';
import 'package:myapp/network/core/network_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'app_service.g.dart';

@RestApi()
abstract class AppService {
  factory AppService(Dio dio, {String? baseUrl}) = _AppService;

  //login
  @POST('/api/admin/auth/public/login')
  Future<HttpResponse<BaseResponse<User>>> login(@Body() Map<String, dynamic> map);
  static AppService create() {
    final dio = NetworkManager().createDio()
      ..interceptors
          .add(PrettyDioLogger(requestBody: true, requestHeader: true))
      ..addInterceptors();
    final client = AppService(dio);
    return client;
  }
}
