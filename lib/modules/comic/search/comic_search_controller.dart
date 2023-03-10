import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/controller/app_settings_controller.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/comic/search_item.dart';
import 'package:flutter_dmzj/models/comic/search_model.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:get/get.dart';

class ComicSearchController extends BasePageController<SearchComicItem> {
  final String keyword;
  ComicSearchController(this.keyword) {
    searchController = TextEditingController(text: keyword);
    showHotWord.value = keyword.isEmpty;
  }
  late TextEditingController searchController;
  final ComicRequest request = ComicRequest();

  String _keyword = "";

  RxMap<int, String> hotWords = <int, String>{}.obs;

  var showHotWord = true.obs;

  @override
  void onInit() {
    loadHotWord();
    if (keyword.isNotEmpty) {
      submit();
    }
    super.onInit();
  }

  void submit() async {
    if (searchController.text.isEmpty) {
      list.clear();
      showHotWord.value = true;
      return;
    }

    if (searchController.text.startsWith("id:\\") && await handelJumpComic()) {
      return;
    }

    showHotWord.value = false;
    _keyword = searchController.text;
    refreshData();
  }

  Future handelJumpComic() async {
    var id = int.tryParse(searchController.text.replaceAll("id:\\", "")) ?? 0;
    if (id != 0) {
      AppNavigator.toComicDetail(id);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<SearchComicItem>> getData(int page, int pageSize) async {
    if (searchController.text.isEmpty) {
      return [];
    }
    if (Get.find<AppSettingsController>().comicSearchUseWebApi.value) {
      //WEB接口不能分页
      if (page > 1) {
        return [];
      }
      return await request.searchWeb(keyword: _keyword);
    } else {
      return await request.search(keyword: _keyword, page: page - 1);
    }
  }

  void loadHotWord() async {
    try {
      hotWords.value = await request.searchHotWord();
    } catch (e) {
      Log.logPrint(e);
    }
  }
}
