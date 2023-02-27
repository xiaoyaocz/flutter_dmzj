import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/modules/user/login/user_login_controller.dart';
import 'package:get/get.dart';

class UserLoginDialog extends StatelessWidget {
  final UserLoginController controller = Get.put(UserLoginController());
  UserLoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: AppStyle.radius12,
      ),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: AppStyle.edgeInsetsL12,
              title: const Text("登录"),
              trailing: IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.close),
              ),
            ),
            AppStyle.vGap12,
            Padding(
              padding: AppStyle.edgeInsetsH24,
              child: TextField(
                controller: controller.userNameController,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: "请输入用户名",
                  labelText: "用户名",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: AppStyle.edgeInsetsH8,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            AppStyle.vGap24,
            Padding(
              padding: AppStyle.edgeInsetsH24,
              child: TextField(
                controller: controller.passwordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: "请输入密码",
                  labelText: "密码",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: AppStyle.edgeInsetsH8,
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (e) {
                  controller.login();
                },
              ),
            ),
            AppStyle.vGap12,
            Container(
              width: double.infinity,
              padding: AppStyle.edgeInsetsA12.copyWith(left: 24, right: 24),
              child: SizedBox(
                height: 40,
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppStyle.radius24,
                      ),
                    ),
                    onPressed:
                        controller.loadding.value ? null : controller.login,
                    child: controller.loadding.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text("登录"),
                  ),
                ),
              ),
            ),
            AppStyle.vGap12,
          ],
        ),
      ),
    );
  }
}
