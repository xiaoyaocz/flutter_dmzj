import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DialogUtils {
  /// 提示弹窗
  /// - `content` 内容
  /// - `title` 弹窗标题
  /// - `confirm` 确认按钮内容，留空为确定
  /// - `cancel` 取消按钮内容，留空为取消
  static Future<bool> showAlertDialog(
    String content, {
    String title = '',
    String confirm = '',
    String cancel = '',
    bool selectable = false,
    List<Widget>? actions,
  }) async {
    var result = await Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Container(
          constraints: const BoxConstraints(
            maxHeight: 400,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: AppStyle.edgeInsetsV12,
              child: selectable ? SelectableText(content) : Text(content),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: (() => Get.back(result: false)),
            child: Text(cancel.isEmpty ? "取消" : cancel),
          ),
          TextButton(
            onPressed: (() => Get.back(result: true)),
            child: Text(confirm.isEmpty ? "确定" : confirm),
          ),
          ...?actions,
        ],
      ),
    );
    return result ?? false;
  }

  /// 提示弹窗
  /// - `content` 内容
  /// - `title` 弹窗标题
  /// - `confirm` 确认按钮内容，留空为确定
  static Future<bool> showMessageDialog(String content,
      {String title = '', String confirm = '', bool selectable = false}) async {
    var result = await Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Padding(
          padding: AppStyle.edgeInsetsV12,
          child: selectable ? SelectableText(content) : Text(content),
        ),
        actions: [
          TextButton(
            onPressed: (() => Get.back(result: true)),
            child: Text(confirm.isEmpty ? "确定" : confirm),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// 文本编辑的弹窗
  /// - `content` 编辑框默认的内容
  /// - `title` 弹窗标题
  /// - `confirm` 确认按钮内容
  /// - `cancel` 取消按钮内容
  static Future<String?> showEditTextDialog(String content,
      {String title = '',
      String? hintText,
      String confirm = '',
      String cancel = ''}) async {
    final TextEditingController textEditingController =
        TextEditingController(text: content);
    var result = await Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Padding(
          padding: AppStyle.edgeInsetsT12,
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              //prefixText: title,
              contentPadding: AppStyle.edgeInsetsA12,
              hintText: hintText ?? title,
            ),
            // style: TextStyle(
            //     height: 1.0,
            //     color: Get.isDarkMode ? Colors.white : Colors.black),
            autofocus: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text("取消"),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: textEditingController.text);
            },
            child: const Text("确定"),
          ),
        ],
      ),
      // barrierColor:
      //     Get.isDarkMode ? Colors.grey.withOpacity(.3) : Colors.black38,
    );
    return result;
  }

  static Future<T?> showOptionDialog<T>(
    List<T> contents,
    T value, {
    String title = '',
  }) async {
    var result = await Get.dialog(
      SimpleDialog(
        title: Text(title),
        children: contents
            .map(
              (e) => RadioListTile<T>(
                title: Text(e.toString()),
                value: e,
                groupValue: value,
                onChanged: (e) {
                  Get.back(result: e);
                },
              ),
            )
            .toList(),
      ),
    );
    return result;
  }

  static void showStatement() async {
    var text = await rootBundle.loadString("assets/statement.txt");

    showAlertDialog(
      text,
      selectable: true,
      title: "免责声明",
      confirm: "已阅读并同意",
      cancel: "退出",
    ).then((value) {
      if (!value) {
        exit(0);
      }
    });
  }

  static Future<T?> showMapOptionDialog<T>(
    Map<T, String> contents,
    T value, {
    String title = '',
  }) async {
    var result = await Get.dialog(
      SimpleDialog(
        title: Text(title),
        children: contents.keys
            .map(
              (e) => RadioListTile<T>(
                title: Text((contents[e] ?? '-').tr),
                value: e,
                groupValue: value,
                onChanged: (e) {
                  Get.back(result: e);
                },
              ),
            )
            .toList(),
      ),
    );
    return result;
  }

  static void showImageViewer(int initIndex, List<String> images) {
    var index = initIndex.obs;
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              itemCount: images.length,
              builder: (_, i) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: ExtendedNetworkImageProvider(
                    images[i],
                    cache: true,
                  ),
                  onTapUp: ((context, details, controllerValue) => Get.back()),
                );
              },
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(),
              ),
              pageController: PageController(
                initialPage: index.value,
              ),
              onPageChanged: ((i) {
                index.value = i;
              }),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: AppStyle.edgeInsetsA24
                  .copyWith(bottom: 24 + AppStyle.bottomBarHeight),
              child: Obx(
                () => Text(
                  "${index.value + 1}/${images.length}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              right: 12 + AppStyle.bottomBarHeight,
              bottom: 12,
              child: TextButton.icon(
                onPressed: () {
                  Utils.saveImage(images[index.value]);
                },
                icon: const Icon(Icons.save),
                label: const Text("保存"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
