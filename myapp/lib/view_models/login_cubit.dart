
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/network/base/base_response.dart';
import 'package:myapp/network/repository/app_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.repo) : super(LoginInitial());

  final AppRepository repo;

  Future login({required String p_email, required String p_password}) async {
    try {
      emit(LoginInProgress());
      final dataResponse = await repo.login(p_email: p_email, p_password: p_password);
      emit(LoginSuccess(dataResponse: dataResponse));
    } catch (e) {
      emit(LoginFailure(e));
    }
  }
}

// Trạng thái của Cubit
abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  final BaseResponse? dataResponse;
  const LoginSuccess({this.dataResponse});
}

class LoginFailure extends LoginState {
  final dynamic error;
  const LoginFailure(this.error);
}