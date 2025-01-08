
import 'package:get/get.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/shared/app_manager.dart';

void provideDependencies() {
  Get.put(AppManager());
  Get.lazyPut(() => GlobalManager(), fenix: true);
}
