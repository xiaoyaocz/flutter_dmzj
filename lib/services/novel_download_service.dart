import 'package:get/get.dart';

class NovelDownloadService extends GetxService {
  static NovelDownloadService get instance => Get.find<NovelDownloadService>();
  //小说下载
  //1.如果本地存在缓存则复制本地
  //2.需要特别注意插图的下载
}
