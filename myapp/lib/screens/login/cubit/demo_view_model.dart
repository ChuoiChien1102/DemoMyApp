// import 'package:aplus_mobile/network/model/demo_user.dart';
// import 'package:aplus_mobile/network/repository/app_repository.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';

// class DemoViewModel extends GetxController {
//   final AppRepository _userRepository = AppRepository();

//   var users = <DemoUser>[].obs;

//   void fetchUsers() async {
//     try {
//       EasyLoading.show(status: 'Loading...');
//       final fetchedUsers = await _userRepository.fetchUsers();
//       users.value = fetchedUsers;
//     } catch (e) {
//       Get.snackbar("Error", "Failed to fetch users: $e");
//     } finally {
//       EasyLoading.dismiss();
//     }
//   }
// }
