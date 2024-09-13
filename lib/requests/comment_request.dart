import 'package:flutter_dmzj/app/app_error.dart';
import 'package:flutter_dmzj/models/comment/comment_item.dart';
import 'package:flutter_dmzj/models/comment/user_comment_item.dart';
import 'package:flutter_dmzj/requests/common/api.dart';
import 'package:flutter_dmzj/requests/common/http_client.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';

class CommentRequest {
  var unescape = HtmlUnescape();

  /// 读取最新的评论
  /// - [type] 类型
  /// - [objId] ID
  /// - [page] 页数
  /// - [pageSize] 每页数量
  Future<List<CommentItem>> getComment({
    required int type,
    required int objId,
    int sort = 1,
    int page = 1,
    int pageSize = 30,
  }) async {
    List<CommentItem> ls = [];
    Map result = await HttpClient.instance.getJson(
      '/comment/list',
      baseUrl: Api.BASE_URL,
      queryParameters: {
        "type": type,
        "objId": objId,
        "sort": sort,
        "page": page - 1,
        "size": pageSize,
      },
    );
    if (result["errno"] != 0) {
      throw AppError(result["errmsg"].toString());
    }
    if (result["data"]["commentIdList"] == null) {
      return [];
    }
    var ids = result["data"]["commentIdList"];
    var comments = result["data"]["commentList"];
    for (String id in ids) {
      var idSplit = id.split(",");
      var item = _parseLatestCommentItem(comments, idSplit.first, type);
      if (idSplit.length > 1) {
        item.parents = [];
        for (var id2 in idSplit.skip(1)) {
          item.parents.insert(0, _parseLatestCommentItem(comments, id2, type));
        }
      }
      if (item.id != 0) {
        ls.add(item);
      }
    }
    return ls;
  }

  CommentItem _parseLatestCommentItem(Map comments, String id, int type) {
    if (!comments.containsKey(id)) {
      return CommentItem.createEmpty();
    }
    var item = comments[id];
    //返回的类型非常随机，有时候是int，有时候是string，所以使用int.tryParse
    return CommentItem(
      type: type,
      id: int.tryParse(item["id"].toString()) ?? 0,
      objId: int.tryParse(item["obj_id"].toString()) ?? 0,
      content: unescape.convert(item["content"].toString()),
      photo: item["photo"].toString(),
      createTime: int.tryParse(item["create_time"].toString()) ?? 0,
      images: item["upload_images"]
          .toString()
          .split(",")
          .where((x) => x.isNotEmpty)
          .toList(),
      likeAmount: (int.tryParse(item["like_amount"].toString()) ?? 0).obs,
      nickname: item["nickname"].toString(),
      replyAmount: int.tryParse(item["reply_amount"].toString()) ?? 0,
      gender: int.tryParse(item["sex"].toString()) ?? 0,
      userId: int.tryParse(item["sender_uid"].toString()) ?? 0,
      originId: int.tryParse(item["origin_comment_id"].toString()) ?? 0,
    );
  }

  /// 发表评论
  /// - [objId] ID
  /// - [type] 类型 ,见AppConstant
  /// - [content] 内容
  /// - [toCommentId] 回复评论ID
  /// - [originCommentId] 原始评论ID
  /// - [toUid] 回复用户
  Future<bool> sendComment({
    required int objId,
    required int type,
    required String content,
    String toCommentId = "0",
    String originCommentId = "0",
    String toUid = "0",
  }) async {
    var result = await HttpClient.instance.postJson(
      "/v1/$type/new/add/app",
      baseUrl: Api.BASE_URL,
      data: {
        "obj_id": objId,
        "to_comment_id": toCommentId,
        "origin_comment_id": originCommentId,
        "to_uid": toUid,
        "sender_terminal": 1,
        "content": content,
        "dmzj_token": UserService.instance.dmzjToken,
        "_debug": 0
      },
    );
    if (result["code"] != 0) {
      throw AppError(result["msg"].toString());
    }
    return true;
  }

  /// 评论点赞
  Future<bool> likeComment({
    required int commentId,
    required int objId,
    required int type,
  }) async {
    await HttpClient.instance.getJson(
      "/v1/$type/like/$commentId",
      baseUrl: Api.BASE_URL,
      queryParameters: {
        "comment_id": commentId,
        "obj_id": objId,
        "type": type,
      },
      needLogin: true,
      withDefaultParameter: true,
      checkCode: true,
    );

    return true;
  }

  /// 读取用户的评论
  /// - [type] 类型 0=漫画，1=轻小说，2=新闻
  /// - [uid] 用户ID
  /// - [page] 页数,从0开始
  Future<List<UserCommentItem>> getUserComment({
    required int type,
    required int uid,
    int page = 0,
  }) async {
    List<UserCommentItem> ls = [];
    var result = await HttpClient.instance.getJson(
      type == 1
          ? '/comment/owner/1/$uid/$page.json'
          : '/v3/old/comment/owner/$type/$uid/$page.json',
      baseUrl: Api.BASE_URL,
      withDefaultParameter: true,
      needLogin: true,
    );
    for (var item in result) {
      ls.add(UserCommentItem.fromJson(item));
    }

    return ls;
  }
}
