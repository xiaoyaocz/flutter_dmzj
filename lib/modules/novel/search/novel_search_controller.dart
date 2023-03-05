import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/novel/search_model.dart';
import 'package:flutter_dmzj/requests/novel_request.dart';

class NovelSearchController extends BasePageController<NovelSearchModel> {
  final String keyword;
  NovelSearchController(this.keyword) {
    searchController = TextEditingController(text: keyword);
  }
  late TextEditingController searchController;
  final NovelRequest request = NovelRequest();

  String _keyword = "";

  void submit() {
    if (searchController.text.isEmpty) {
      return;
    }
    _keyword = searchController.text;
    refreshData();
  }

  @override
  Future<List<NovelSearchModel>> getData(int page, int pageSize) async {
    if (searchController.text.isEmpty) {
      return [];
    }
    return await request.search(keyword: _keyword, page: page - 1);
  }
}
