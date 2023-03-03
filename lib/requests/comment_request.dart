import 'package:flutter_dmzj/app/app_error.dart';
import 'package:flutter_dmzj/models/comment/comment_item.dart';
import 'package:flutter_dmzj/requests/common/api.dart';
import 'package:flutter_dmzj/requests/common/http_client.dart';
import 'package:html_unescape/html_unescape.dart';

class CommentRequest {
  var unescape = HtmlUnescape();

  /// 读取最新的评论
  /// - [type] 类型
  /// - [objId] ID
  /// - [page] 页数
  /// - [pageSize] 每页数量
  Future<List<CommentItem>> getLatestComment({
    required int type,
    required int objId,
    int page = 1,
    int pageSize = 30,
  }) async {
    List<CommentItem> ls = [];
    Map result = await HttpClient.instance.getJson(
      '/v1/$type/latest/$objId',
      baseUrl: Api.BASE_URL_V3_COMMENT,
      queryParameters: {"page_index": page, "limit": pageSize},
    );
    if (result.containsKey("code")) {
      throw AppError(result["msg"].toString());
    }
    var ids = result["commentIds"];
    var comments = result["comments"];
    for (String id in ids) {
      var idSplit = id.split(",");
      var item = _parseLatestCommentItem(comments, idSplit.first);
      if (idSplit.length > 1) {
        item.parents = [];
        for (var id2 in idSplit.skip(1)) {
          item.parents.add(_parseLatestCommentItem(comments, id2));
        }
      }
      if (item.id != 0) {
        ls.add(item);
      }
    }
    return ls;
  }

  CommentItem _parseLatestCommentItem(Map comments, String id) {
    if (!comments.containsKey(id)) {
      return CommentItem.createEmpty();
    }
    var item = comments[id];
    //返回的类型非常随机，有时候是int，有时候是string，所以使用int.tryParse
    return CommentItem(
      id: int.tryParse(item["id"].toString()) ?? 0,
      objId: int.tryParse(item["obj_id"].toString()) ?? 0,
      content: unescape.convert(item["content"].toString()),
      avatarUrl: item["avatar_url"].toString(),
      createTime: int.tryParse(item["create_time"].toString()) ?? 0,
      images: item["upload_images"]
          .toString()
          .split(",")
          .where((x) => x.isNotEmpty)
          .toList(),
      likeAmount: int.tryParse(item["like_amount"].toString()) ?? 0,
      nickname: item["nickname"].toString(),
      replyAmount: int.tryParse(item["reply_amount"].toString()) ?? 0,
      gender: int.tryParse(item["sex"].toString()) ?? 0,
      userId: int.tryParse(item["sender_uid"].toString()) ?? 0,
    );
  }

  /// 读取热门评论
  /// - [type] 类型
  /// - [objId] ID
  /// - [page] 页数
  /// - [pageSize] 每页数量
  Future<List<CommentItem>> getHotComment({
    required int type,
    required int objId,
    int page = 1,
    int pageSize = 30,
  }) async {
    List<CommentItem> ls = [];
    var result = await HttpClient.instance.getJson(
      '/comment2/$type/1/$objId/3/$page.json',
      baseUrl: Api.BASE_URL_V3_API,
      queryParameters: {"page_index": page, "limit": pageSize},
    );

    if (result is Map && result.containsKey("code")) {
      throw AppError(result["msg"].toString());
    }
    // DMZJ神奇的后端，啥类型都有可能会返回

    for (var item in result) {
      if (item is Map) {
        var model = _parseHotCommentItem(item);
        if (model.id != 0) {
          ls.add(model);
        }
      }
    }
    return ls;
  }

  CommentItem _parseHotCommentItem(Map item) {
    List<CommentItem> parents = [];
    if (item.containsKey("masterComment") && item["masterComment"] is List) {
      for (var masterItem in item["masterComment"]) {
        parents.add(_parseHotCommentItem(masterItem));
      }
    }

    return CommentItem(
      id: int.tryParse(item["id"].toString()) ?? 0,
      objId: int.tryParse(item["obj_id"].toString()) ?? 0,
      content: unescape.convert(item["content"].toString()),
      avatarUrl: item["cover"].toString(),
      createTime: int.tryParse(item["create_time"].toString()) ?? 0,
      images: item["upload_images"]
          .toString()
          .split(",")
          .where((x) => x.isNotEmpty)
          .toList(),
      likeAmount: int.tryParse(item["like_amount"].toString()) ?? 0,
      nickname: item["nickname"].toString(),
      replyAmount: int.tryParse(item["reply_amount"].toString()) ?? 0,
      userId: int.tryParse(item["sender_uid"].toString()) ?? 0,
      gender: int.tryParse(item["sex"].toString()) ?? 0,
    )..parents.addAll(parents);
  }
}
