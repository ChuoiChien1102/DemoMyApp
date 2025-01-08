import 'package:myapp/models/user.dart';
import 'package:myapp/network/base/base_response.dart';

abstract class AppRepository {
  Future<BaseResponse<User>> getUsers();
}
