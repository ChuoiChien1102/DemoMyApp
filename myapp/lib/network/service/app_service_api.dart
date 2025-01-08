
import 'package:myapp/models/user.dart';
import 'package:myapp/network/base/base_response.dart';
import 'package:myapp/network/repository/app_repository.dart';
import 'package:myapp/network/service/app_service.dart';

class AppServiceApi implements AppRepository {
  final AppService service;

  AppServiceApi({required this.service});
  
  @override
  Future<BaseResponse<User>> login({required String p_email, required String p_password}) {
    // TODO: implement login
    final param = <String, dynamic>{
      'email': p_email,
      'password': p_password,
    };
    final response = service.login(param).then((httpReponse) {
      return httpReponse.data;
    });
    return response;
  }
  
}
