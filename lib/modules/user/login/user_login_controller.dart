import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/requests/user_request.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class UserLoginController extends GetxController {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserRequest userRequest = UserRequest();
  var loadding = false.obs;
  void login() async {
    if (userNameController.text.isEmpty) {
      SmartDialog.showToast("请输入用户名");
      return;
    }
    if (passwordController.text.isEmpty) {
      SmartDialog.showToast("请输入密码");
      return;
    }
    try {
      loadding.value = true;
      var data = await userRequest.login(
        nickname: userNameController.text,
        password: passwordController.text,
      );
      UserService.instance.setAuthInfo(data);

      loadding.value = false;
      Get.back(result: true);
    } catch (e) {
      SmartDialog.showToast(e.toString());
      Log.logPrint(e);
    } finally {
      loadding.value = false;
    }
  }
}
