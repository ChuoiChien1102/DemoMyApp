
import 'package:get/get.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/network/repository/app_repository.dart';
import 'package:myapp/network/repository/app_repository_impl.dart';
import 'package:myapp/network/service/app_service.dart';
import 'package:myapp/network/service/app_service_api.dart';
import 'package:myapp/shared/app_manager.dart';

void provideDependencies() {
  Get.put(AppManager());
  Get.lazyPut(() => GlobalManager(), fenix: true);
  Get.lazyPut<AppRepository>(
    () => AppStorageRepository(
      webApi: AppServiceApi(service: AppService.create()),
    ),
    fenix: true,
  );
}
