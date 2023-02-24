import 'package:flutter/material.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';

class TestSubRoutePage extends StatelessWidget {
  const TestSubRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("测试路由"),
        leading: IconButton(
          onPressed: () {
            AppNavigator.closePage();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Back"),
          onPressed: () {
            AppNavigator.closePage();
          },
        ),
      ),
    );
  }
}
