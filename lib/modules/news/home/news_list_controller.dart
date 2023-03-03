import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/news/news_banner_model.dart';
import 'package:flutter_dmzj/models/news/news_tag_model.dart';
import 'package:flutter_dmzj/models/proto/news.pb.dart';
import 'package:flutter_dmzj/requests/news_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class NewsListController extends BasePageController<NewsListInfoProto> {
  final NewsRequest request = NewsRequest();
  final NewsTagModel tag;
  NewsListController(this.tag);

  RxList<NewsBannerModel> banners = RxList<NewsBannerModel>();

  @override
  Future<List<NewsListInfoProto>> getData(int page, int pageSize) async {
    if (tag.tagId == 0 && page == 1) {
      loadBanner();
    }
    return await request.getNewsList(tag.tagId, page);
  }

  void loadBanner() async {
    try {
      banners.value = await request.banner();
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }

  void openBanner(NewsBannerModel item) {
    AppNavigator.toNewsDetail(
      url: item.objectUrl ?? "",
      newsId: item.objectId ?? 0,
      title: item.title,
    );
  }
}
