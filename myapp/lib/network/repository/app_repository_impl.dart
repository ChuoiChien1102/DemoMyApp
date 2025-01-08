

import 'package:myapp/models/user.dart';
import 'package:myapp/network/base/base_error.dart';
import 'package:myapp/network/base/base_response.dart';
import 'package:myapp/network/repository/app_repository.dart';

class AppStorageRepository implements AppRepository {
  final AppRepository webApi;

  const AppStorageRepository({
    required this.webApi,
  });

  @override
  Future<BaseResponse<User>> getUsers() {
    return webApi.getUsers().catchError(BaseErrorHandling().onError);
  }
}
