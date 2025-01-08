
import 'package:myapp/models/user.dart';
import 'package:myapp/network/base/base_response.dart';
import 'package:myapp/network/repository/app_repository.dart';
import 'package:myapp/network/service/app_service.dart';

class AppServiceApi implements AppRepository {
  final AppService service;

  AppServiceApi({required this.service});

  @override
  Future<BaseResponse<User>> getUsers() {
    final response = service.getUsers().then((httpReponse) {
      return httpReponse.data;
    });
    return response;
  }
}
