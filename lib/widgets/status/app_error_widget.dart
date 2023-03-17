import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';

class AppErrorWidget extends StatelessWidget {
  final Function()? onRefresh;
  final String errorMsg;
  final Error? error;
  const AppErrorWidget(
      {this.errorMsg = "", this.onRefresh, this.error, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          onRefresh?.call();
        },
        child: Padding(
          padding: AppStyle.edgeInsetsA12,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(
                'assets/lotties/error.json',
                width: 260,
                repeat: false,
              ),
              Text(
                "$errorMsg\r\n点击刷新",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Visibility(
                visible: error != null,
                child: Padding(
                  padding: AppStyle.edgeInsetsT12,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      textStyle: Get.textTheme.bodySmall,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      Utils.copyText(
                          "$errorMsg\n${error?.stackTrace?.toString()}");
                      SmartDialog.showToast("已复制详细信息");
                    },
                    child: const Text("复制详细信息"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
