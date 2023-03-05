import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/comic/search_model.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';

class ComicSearchController extends BasePageController<ComicSearchModel> {
  final String keyword;
  ComicSearchController(this.keyword) {
    searchController = TextEditingController(text: keyword);
  }
  late TextEditingController searchController;
  final ComicRequest request = ComicRequest();

  String _keyword = "";

  void submit() {
    if (searchController.text.isEmpty) {
      return;
    }
    _keyword = searchController.text;
    refreshData();
  }

  @override
  Future<List<ComicSearchModel>> getData(int page, int pageSize) async {
    if (searchController.text.isEmpty) {
      return [];
    }
    return await request.search(keyword: _keyword, page: page - 1);
  }
}
