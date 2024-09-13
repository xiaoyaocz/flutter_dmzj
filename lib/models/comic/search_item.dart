import 'package:flutter_dmzj/models/comic/search_model.dart';
import 'package:flutter_dmzj/models/comic/web_search_model.dart';

class SearchComicItem {
  final int comicId;
  final String title;
  final String cover;
  final String author;
  final String lastChapterName;
  final String tags;
  SearchComicItem({
    required this.author,
    required this.comicId,
    required this.cover,
    required this.lastChapterName,
    required this.tags,
    required this.title,
  });

  factory SearchComicItem.fromApi(ComicSearchModel item) => SearchComicItem(
        author: item.authors ?? "",
        comicId: item.id,
        cover: item.cover ?? "",
        lastChapterName: item.lastName ?? "",
        tags: item.types ?? "",
        title: item.title,
      );
  factory SearchComicItem.fromWeb(ComicWebSearchModel item) => SearchComicItem(
        author: item.comicAuthor,
        comicId: item.id,
        cover: item.cover,
        lastChapterName: item.lastUpdateChapterName,
        tags: "/",
        title: item.comicName,
      );
}
