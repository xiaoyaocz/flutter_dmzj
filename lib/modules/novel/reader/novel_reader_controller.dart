import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/novel/novel_detail_model.dart';
import 'package:flutter_dmzj/requests/novel_request.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';

class NovelReaderController extends BaseController {
  final int novelId;
  final String novelTitle;
  final String novelCover;
  final List<NovelDetailVolume> volumes;
  final NovelDetailVolume volume;
  final NovelDetailChapter chapter;
  NovelReaderController({
    required this.novelId,
    required this.novelTitle,
    required this.novelCover,
    required this.volumes,
    required this.volume,
    required this.chapter,
  });
  final NovelRequest request = NovelRequest();

  int fontSize = 16;
  double lineHeight = 1.5;

  RxList<String> pages = RxList<String>();

  @override
  void onInit() {
    test();
    super.onInit();
  }

  void test() async {
    var height =
        Get.size.height - AppStyle.bottomBarHeight - AppStyle.statusBarHeight;
    var textHieght = getTextHeight();
    var maxLine = ((height - 24) / textHieght).floor();
    Log.d("height：$height textHieght:$textHieght maxLine:$maxLine");
    loadContent(maxLine, textHieght);
  }

  double getTextHeight() {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: "测试文本gxp",
        style: TextStyle(fontSize: fontSize.toDouble(), height: lineHeight),
      ),
      maxLines: 2,
      locale: WidgetsBinding.instance.window.locale,
      textAlign: TextAlign.justify,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    return textPainter.height;
  }

  Future loadContent(int maxLine, double textHieght) async {
    SmartDialog.showLoading();

    pages.clear();
    var content = await request.novelContent(
        volumeId: volume.volumeId, chapterId: chapter.chapterId);
    var startTime = DateTime.now().millisecondsSinceEpoch;

    var ls = computeContent(
      ComputeParameter(
        content: content,
        fontSize: fontSize.toDouble(),
        maxLine: maxLine,
        lineHeight: lineHeight,
        width: Get.width - 24,
      ),
    );
    pages.value = ls;
    Log.d("耗时:${DateTime.now().millisecondsSinceEpoch - startTime}ms");
    Log.d("页数:${ls.length}");

    SmartDialog.dismiss(status: SmartStatus.loading);
  }

  List<String> computeContent(ComputeParameter parameter) {
    var content = HtmlUnescape().convert(parameter.content);
    content = content
        .replaceAll('\r\n', '\n')
        .replaceAll("<br/>", "\n")
        .replaceAll('<br />', "\n")
        .replaceAll('\n\n\n', "\n")
        .replaceAll('\n\n', "\n")
        .replaceAll('\n', "\n　　");

    Log.w("字数:${content.length}");
    List<String> strs = [];

    while (true) {
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: content,
          style: TextStyle(
            fontSize: parameter.fontSize,
            height: parameter.lineHeight,
          ),
        ),
        maxLines: parameter.maxLine,
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr,
        textWidthBasis: TextWidthBasis.longestLine,
        ellipsis: "",
      );
      textPainter.layout(maxWidth: parameter.width);

      TextPosition pos = textPainter.getPositionForOffset(
        Offset(max(textPainter.size.width, 0), textPainter.size.height),
      );

      var txt = content.substring(0, pos.offset);

      strs.add(txt);
      content = content.substring(txt.length, content.length);
      if (!textPainter.didExceedMaxLines) {
        break;
      }
    }

    return strs;
  }
}

class ComputeParameter {
  String content;
  double width;
  double fontSize;
  int maxLine;
  double lineHeight;
  ComputeParameter({
    required this.content,
    required this.fontSize,
    required this.width,
    required this.maxLine,
    required this.lineHeight,
  });
}
