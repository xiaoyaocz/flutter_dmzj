import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/user/user_home_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/routes/route_path.dart';
import 'package:get/get.dart';

class UserHomePage extends GetView<UserHomeController> {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("用户中心"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("test"),
          onPressed: () {
            AppNavigator.toContentPage(RoutePath.kTestSubRoute);
          },
        ),
      ),
    );
  }
}
