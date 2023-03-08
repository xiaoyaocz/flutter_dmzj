import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/modules/novel/reader/novel_reader_controller.dart';
import 'package:get/get.dart';

class NovelReaderPage extends GetView<NovelReaderController> {
  const NovelReaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: PageView.builder(
            itemCount: controller.pages.length,
            itemBuilder: (_, i) {
              return Padding(
                padding: AppStyle.edgeInsetsA12,
                child: Text(
                  controller.pages[i],
                  style: TextStyle(
                    fontSize: controller.fontSize.toDouble(),
                    height: controller.lineHeight,
                  ),
                  locale: WidgetsBinding.instance.window.locale,
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.ltr,
                ),
              );
            },
          ),
          // child: ListView(
          //   padding: AppStyle.edgeInsetsA12,
          //   children: [
          //     RichText(
          //       text: TextSpan(
          //         children: controller.spanList.toList(),
          //         style: TextStyle(
          //           fontSize: controller.fontSize.toDouble(),
          //           height: controller.fontHeight,
          //         ),
          //       ),
          //       textAlign: TextAlign.justify,
          //       textWidthBasis: TextWidthBasis.longestLine,
          //     ),
          //     // child: Text(
          //     //   controller.text.value,
          //     //   style: TextStyle(
          //     //     fontSize: controller.fontSize.toDouble(),
          //     //     height: controller.fontHeight,
          //     //   ),
          //     //   locale: WidgetsBinding.instance.window.locale,
          //     //   textAlign: TextAlign.justify,
          //     //   textDirection: TextDirection.ltr,
          //     // ),
          //   ],
          // ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.test();
        },
      ),
    );
  }
}
