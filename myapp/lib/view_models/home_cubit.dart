
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/network/base/base_response.dart';
import 'package:myapp/network/repository/app_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo) : super(HomeInitial());

  final AppRepository repo;

  Future getListEvent() async {
    try {
      emit(ListEventInProgress());
      final dataResponse = await repo.getListEvent();
      emit(ListEventSuccess(dataResponse: dataResponse));
    } catch (e) {
      emit(ListEventFailure(e));
    }
  }
}

// Trạng thái của Cubit
abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class ListEventInProgress extends HomeState {}

class ListEventSuccess extends HomeState {
  final BaseResponse? dataResponse;
  const ListEventSuccess({this.dataResponse});
}

class ListEventFailure extends HomeState {
  final dynamic error;
  const ListEventFailure(this.error);
}