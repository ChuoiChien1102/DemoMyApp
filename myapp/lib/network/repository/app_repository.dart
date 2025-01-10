import 'package:myapp/models/event.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/network/base/base_response.dart';

abstract class AppRepository {
  Future<BaseResponse<User>> login({required String p_email, required String p_password});
  Future<BaseResponse<List<Event>>> getListEvent();
}
