import 'package:flutter_dmzj/modules/user/login/user_login_dialog.dart';
import 'package:get/get.dart';

class UserHomeController extends GetxController {
  void testLogin() {
    Get.dialog(UserLoginDialog());
  }
}
