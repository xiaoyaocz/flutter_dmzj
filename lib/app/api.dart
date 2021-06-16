import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

class Api {
  static final String apiHost = "https://nnv3api.muwai.com";
  static final String version = "3.0.0";
  static String get timeStamp =>
      (DateTime.now().millisecondsSinceEpoch / 1000).toStringAsFixed(0);

  static String get newsCategory =>
      "$apiHost/article/category.json?${defaultParameter()}";
  static String get newsBanner =>
      "$apiHost/v3/article/recommend/header.json?${defaultParameter()}";
  static String newsList(int id, {int page = 0}) {
    return "$apiHost/v3/article/list/$id/${id == 0 ? 2 : 3}/$page.json";
  }

  /// 新闻数据
  static String newsStat(int id) {
    return "$apiHost/v3/article/total/$id.json?${defaultParameter()}";
  }

  /// 检查新闻收藏
  static String checkNewsSub() {
    return "https://interface.muwai.com/api/news/subscribe/check";
  }

  /// 点赞新闻
  static String addNewsLike(int id) {
    return "$apiHost/article/mood/$id?${defaultParameter()}";
  }

  /// 添加新闻收藏
  static String addNewsSub() {
    return "https://interface.muwai.com/api/news/subscribe/add";
  }

  /// 取消新闻收藏
  static String cancelNewsSub() {
    return "https://interface.muwai.com/api/news/subscribe/del";
  }

  //用户相关
  static String get loginV2 => "https://user.muwai.com/loginV2/m_confirm";
  static String userProfile(String uid, String token) {
    return "$apiHost/UCenter/comicsv2/$uid.json?dmzj_token=$token&${defaultParameter()}";
  }

  //漫画
  static String get comicRecommend =>
      "$apiHost/recommend_new.json?${defaultParameter()}";

  /// 轻小说首页
  static String get novelRecommend =>
      "$apiHost/novel/recommend.json?${defaultParameter()}";
  //猜你喜欢
  static String get comicLike =>
      "$apiHost/recommend/batchUpdate?category_id=50&${defaultParameter()}";
  //刷新国漫
  static String get comicGuoman =>
      "$apiHost/recommend/batchUpdate?category_id=52&${defaultParameter()}";
  //刷新热门
  static String get comicHot =>
      "$apiHost/recommend/batchUpdate?category_id=54&${defaultParameter()}";
  //首页我的订阅
  static String comicMySub(String uid) {
    return "$apiHost/recommend/batchUpdate?uid=$uid&category_id=49&${defaultParameter()}";
  }

  //漫画详情
  static String comicDetail(int comicId) {
    return "$apiHost/comic/comic_$comicId.json?${defaultParameter()}";
  }

  /// 轻小说详情
  static String novelDetail(int novelId) {
    return "$apiHost/novel/$novelId.json";
  }

  /// 轻小说章节详情
  static String novelVolumeDetail(int novelId) {
    return "$apiHost/novel/chapter/$novelId.json";
  }

  /// 轻小说阅读
  static String novelRead(int novelId, int volumeId, int chapterId) {
    return "$apiHost/novel/download/${novelId}_${volumeId}_$chapterId.txt";
  }

  /// 漫画专题
  static String comicSpecial({int page = 0}) {
    return "$apiHost/subject/0/$page.json?${defaultParameter()}";
  }

  /// 漫画排行榜筛选
  static String comicRankFilter() {
    return "$apiHost/rank/type_filter.json?${defaultParameter()}";
  }

  /// 轻小说排行榜筛选
  static String get novelRankFilter =>
      "$apiHost/novel/tag.json?${defaultParameter()}";

  /// 漫画排行榜详情
  static String comicRank(
      {String tagId = "0",
      String rank = "0",
      String sort = "0",
      int page = 0}) {
    return "$apiHost/rank/$tagId/$rank/$sort/$page.json?${defaultParameter()}";
  }

  /// 轻小说排行榜详情
  static String novelRank(
      {String tagId = "0", String sort = "0", int page = 0}) {
    return "$apiHost/novel/rank/$sort/$tagId/$page.json?${defaultParameter()}";
  }

  /// 漫画专题详情
  static String comicSpeciaDetail(int speciaId) {
    return "$apiHost/subject/$speciaId.json?${defaultParameter()}";
  }

  /// 漫画更新
  static String comicUpdate(String mode, {int page = 0}) {
    return "$apiHost/latest/$mode/$page.json?${defaultParameter()}";
  }

  /// 轻小说更新
  static String novelUpdate({int page = 0}) {
    return "$apiHost/novel/recentUpdate/$page.json?${defaultParameter()}";
  }

  /// 漫画分类
  static String comicCategory() {
    return "$apiHost/0/category.json?${defaultParameter()}";
  }

  /// 轻小说分类
  static String get novelCategory =>
      "$apiHost/1/category.json?${defaultParameter()}";

  /// 漫画作者
  static String comicAuthorDetail(int authorId) {
    return "$apiHost/UCenter/author/$authorId.json?${defaultParameter()}";
  }

  /// 漫画章节详情
  static String comicChapterDetail(int comicId, int chapterId) {
    return "$apiHost/chapter/$comicId/$chapterId.json?${defaultParameter()}";
  }

  /// 漫画章节详情(手机网页)
  static String comicWebChapterDetail(int comicId, int chapterId) {
    return "http://m.muwai.com/chapinfo/$comicId/$chapterId.html";
  }

  /// 漫画吐槽
  static String comicChapterViewPoint(int comicId, int chapterId) {
    return "$apiHost/viewPoint/0/$comicId/$chapterId.json?${defaultParameter()}";
  }

  /// 发表吐槽
  static String comicAddViewPoint() {
    return "$apiHost/viewPoint/add";
  }

  /// 点赞吐槽
  static String comicLikeViewPoint() {
    return "$apiHost/viewPoint/praise";
  }

  /// 查询是否订阅漫画
  static String comicCheckSubscribe(int comicId, String uid) {
    return "$apiHost/subscribe/0/$uid/$comicId?${defaultParameter()}";
  }

  /// 查询是否订阅小说
  static String novelCheckSubscribe(int novelId, String uid) {
    return "$apiHost/subscribe/1/$uid/$novelId?${defaultParameter()}";
  }

  /// 漫画筛选条件
  static String comicCategoryFilter() {
    return "$apiHost/classify/filter.json?${defaultParameter()}";
  }

  /// 轻小说筛选条件
  static String get novelCategoryFilter =>
      "$apiHost/novel/filter.json?${defaultParameter()}";

  //漫画类目详情
  static String comicCategoryDetail(List<int> ids,
      {int sort = 0, int page = 0}) {
    var path = "classify/";
    for (var item in ids) {
      if (item != 0) {
        path += "$item-";
      }
    }
    if (path == "classify/") {
      path = "classify/0";
    } else {
      path = path.substring(0, path.length - 1);
    }
    return "$apiHost/$path/$sort/$page.json?${defaultParameter()}";
  }

  /// 轻小说类目详情
  static String novelCategoryDetail(
      {int cateId = 0, int status = 0, int sort = 0, int page = 0}) {
    return "$apiHost/novel/$cateId/$status/$sort/$page.json?${defaultParameter()}";
  }

  //漫画相关内容
  static String comicRelated(int comicId) {
    return "$apiHost/v3/comic/related/$comicId.json?${defaultParameter()}";
  }

  //添加漫画订阅
  static String get addComicSubscribe => "http://v3api.muwai.com/subscribe/add";

  //取消漫画订阅
  static String cancelComicSubscribe(int comicId, String uid) {
    return "$apiHost/subscribe/cancel?obj_ids=$comicId&uid=$uid&type=mh";
  }

  //添加小说订阅
  static String get addNovelSubscribe => "http://v3api.muwai.com/subscribe/add";

  //取消小说订阅
  static String cancelNovelSubscribe(int novelId, String uid) {
    return "$apiHost/subscribe/cancel?obj_ids=$novelId&uid=$uid&type=xs";
  }

  //用户订阅,type 0=漫画,1=轻小说,sub_type 全部=1，未读=2，已读=3，完结=4
  static String userSubscribe(int type, int subType, String uid, String token,
      {int page = 0, String letter = "all"}) {
    return "$apiHost/UCenter/subscribe?uid=$uid&sub_type=$subType&letter=$letter&dmzj_token=$token&page=$page&type=$type&${defaultParameter()}";
  }

  /// 用户漫画记录
  static String userComicHistory(String uid, {int page = 0}) {
    return "https://interface.muwai.com/api/getReInfo/comic/$uid/$page?${defaultParameter()}";
  }

  /// 用户小说记录
  static String userNovelHistory(String uid, {int page = 0}) {
    return "https://interface.muwai.com/api/getReInfo/novel/$uid/$page?${defaultParameter()}";
  }

  /// 上传观看记录
  static String addUserComicHistory(int comicId, int chapterId, String uid,
      {int page = 1}) {
    Map map = {
      comicId.toString(): chapterId.toString(),
      "comicId": comicId.toString(),
      "chapterId": chapterId.toString(),
      "page": page,
      "time": timeStamp
    };
    var json = Uri.encodeComponent(jsonEncode(map));
    return "https://interface.muwai.com/api/record/getRe?st=comic&uid=$uid&callback=record_jsonpCallback&json=[$json]&type=3";
  }

  /// 上传小说观看记录
  static String addUserNovelHistory(
      int novelId, int volumeId, int chapterId, String uid,
      {int page = 1}) {
    Map map = {
      novelId.toString(): chapterId.toString(),
      "lnovel_id": novelId.toString(),
      "volume_id": volumeId.toString(),
      "chapterId": chapterId.toString(),
      "total_num": 0,
      "page": page,
      "time": timeStamp
    };
    var json = Uri.encodeComponent(jsonEncode(map));
    return "https://interface.muwai.com/api/record/getRe?st=novel&uid=$uid&callback=record_jsonpCallback&json=[$json]&type=3";
  }

  /// 评论
  static String commentV2(int id, int type,
      {int page = 1, bool ishot = false}) {
    return "https://interface.muwai.com/api/NewComment2/list?type=$type&obj_id=$id&hot=${ishot ? 1 : 0}&page_index=$page&_=${DateTime.now().millisecondsSinceEpoch}";
  }

  /// 添加评论
  static String addCommentV3(int type) {
    return "http://v3comment.muwai.com/v1/$type/add/app";
  }

  /// 检查是否可以评论
  static String checkCommentV3(String uid) {
    return "http://v3api.muwai.com/comment2/gagcheckv2/$uid.json?${defaultParameter()}";
  }

  /// 点赞评论
  static String likeCommentV3(int objId, String commentId, int type) {
    return "http://v3comment.muwai.com/v1/$type/like/$commentId?obj_id=$objId&comment_id=$commentId&${defaultParameter()}";
  }

  /// 评论数量
  static String commentCountV2(int id, int type) {
    return "https://interface.muwai.com/api/NewComment2/total?type=$type&obj_id=$id&countType=1&authorId=&_=${DateTime.now().millisecondsSinceEpoch}";
  }

  ///  用户评论
  /// [type] 0=漫画，1=轻小说，2=新闻
  static String userComment(int uid, {int page = 1, int type = 0}) {
    var url = "$apiHost/v3/old/comment/owner/$type/$uid/$page.json";
    if (type == 1) {
      url = "$apiHost/comment/owner/$type/$uid/$page.json";
    }
    return "$url?${defaultParameter()}";
  }

  /// 漫画搜索热词
  static String get comicSearchHotWord =>
      "$apiHost/search/hot/0.json?${defaultParameter()}";

  /// 轻小说搜索热词
  static String get novelSearchHotWord =>
      "$apiHost/search/hot/1.json?${defaultParameter()}";

  static String comicNSSearch(String keyword) {
    return "https://dmzj.nsapps.cn/api/dmzj/search?keyword=${Uri.encodeComponent(keyword)}";
  }

  static String comicSacgSearch(String keyword) {
    return "http://s.acg.muwai.com/comicsum/search.php?s=${Uri.encodeComponent(keyword)}";
  }

  static String novelSearch(String keyword, {int page = 0}) {
    return "$apiHost/search/show/1/${Uri.encodeComponent(keyword)}/$page.json?${defaultParameter()}";
  }

  static String defaultParameter() {
    return "channel=${Platform.operatingSystem}&version$version&timestamp=$timeStamp";
  }

  static String sign(String content, String mode) {
    var _content = new Utf8Encoder().convert(mode + content);
    return hex.encode(md5.convert(_content).bytes);
  }
}
