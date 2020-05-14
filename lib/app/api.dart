import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

class Api {
  static final String apiHost = "https://v3api.dmzj.com";
  static final String version = "2.7.017";
  static get timeStamp => (DateTime.now().millisecondsSinceEpoch/1000).toStringAsFixed(0);

  static get newsCategory =>
      "$apiHost/article/category.json?${defaultParameter()}";
  static get newsBanner =>
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
    return "https://interface.dmzj.com/api/news/subscribe/check";
  }
  /// 点赞新闻
  static String addNewsLike(int id) {
     return "$apiHost/article/mood/$id?${defaultParameter()}";
  }

  /// 添加新闻收藏
  static String addNewsSub() {
    return "https://interface.dmzj.com/api/news/subscribe/add";
  }
  /// 取消新闻收藏
  static String cancelNewsSub() {
    return "https://interface.dmzj.com/api/news/subscribe/del";
  }

  //用户相关
  static get loginV2 => "https://user.dmzj.com/loginV2/m_confirm";
  static String userProfile(String uid, String token) {
    return "$apiHost/UCenter/comicsv2/$uid.json?dmzj_token=$token&${defaultParameter()}";
  }

  //漫画
  static get comicRecommend =>
      "$apiHost/recommend_new.json?${defaultParameter()}";
  /// 轻小说首页
  static get novelRecommend =>
      "$apiHost/novel/recommend.json?${defaultParameter()}";
  //猜你喜欢
  static get comicLike =>
      "$apiHost/recommend/batchUpdate?category_id=50&${defaultParameter()}";
  //刷新国漫
  static get comicGuoman =>
      "$apiHost/recommend/batchUpdate?category_id=52&${defaultParameter()}";
  //刷新热门
  static get comicHot =>
      "$apiHost/recommend/batchUpdate?category_id=54&${defaultParameter()}";
  //首页我的订阅
  static String comicMySub(String uid) {
    return "$apiHost/recommend/batchUpdate?uid=$uid&category_id=49&${defaultParameter()}";
  }

  //漫画详情
  static String comicDetail(int comic_id) {
    return "$apiHost/comic/comic_$comic_id.json?${defaultParameter()}";
  }
  /// 轻小说详情
  static String novelDetail(int novel_id) {
    return "$apiHost/novel/$novel_id.json";
  }
  /// 轻小说章节详情
  static String novelVolumeDetail(int novel_id) {
    return "$apiHost/novel/chapter/$novel_id.json";
  }

  /// 轻小说阅读
  static String novelRead(int novel_id,int volume_id,int chapter_id) {
    return "$apiHost/novel/download/${novel_id}_${volume_id}_${chapter_id}.txt";
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
  static get novelRankFilter=>"$apiHost/novel/tag.json?${defaultParameter()}";
  

  /// 漫画排行榜详情
  static String comicRank( {String tag_id="0",String rank="0",String sort="0",int page = 0}) {
    return "$apiHost/rank/$tag_id/$rank/$sort/$page.json?${defaultParameter()}";
  }

  /// 轻小说排行榜详情
  static String novelRank( {String tag_id="0",String sort="0",int page = 0}) {
    return "$apiHost/novel/rank/$sort/$tag_id/$page.json?${defaultParameter()}";
  }


  /// 漫画专题详情
  static String comicSpeciaDetail(int specia_id) {
    return "$apiHost/subject/$specia_id.json?${defaultParameter()}";
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
  static get novelCategory  => "$apiHost/1/category.json?${defaultParameter()}";


  /// 漫画作者
  static String comicAuthorDetail(int author_id) {
    return "$apiHost/UCenter/author/$author_id.json?${defaultParameter()}";
  }

  /// 漫画章节详情
  static String comicChapterDetail(int comic_id, int chapter_id) {
    return "$apiHost/chapter/$comic_id/$chapter_id.json?${defaultParameter()}";
  }

  /// 漫画章节详情(手机网页)
  static String comicWebChapterDetail(int comic_id, int chapter_id) {
    return "http://m.dmzj.com/chapinfo/$comic_id/$chapter_id.html";
  }

  /// 漫画吐槽
  static String comicChapterViewPoint(int comic_id, int chapter_id) {
    return "$apiHost/viewPoint/0/$comic_id/$chapter_id.json?${defaultParameter()}";
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
  static String comicCheckSubscribe(int comic_id, String uid) {
    return "$apiHost/subscribe/0/$uid/$comic_id?${defaultParameter()}";
  }
  /// 查询是否订阅小说
  static String novelCheckSubscribe(int novel_id, String uid) {
    return "$apiHost/subscribe/1/$uid/$novel_id?${defaultParameter()}";
  }

  /// 漫画筛选条件
  static String comicCategoryFilter() {
    return "$apiHost/classify/filter.json?${defaultParameter()}";
  }
  /// 轻小说筛选条件
  static get novelCategoryFilter=>"$apiHost/novel/filter.json?${defaultParameter()}";
  

  //漫画类目详情
  static String comicCategoryDetail(List<int> ids,
      {int sort = 0, int page = 0}) {
    var path = "classify/";
    for (var item in ids) {
      if (item != 0) {
        path += "$item-";
      }
    }
    if(path=="classify/"){
      path="classify/0";
    }else{
      path=path.substring(0,path.length-1);
    }
    return "$apiHost/$path/$sort/$page.json?${defaultParameter()}";
  }

 /// 轻小说类目详情
  static String novelCategoryDetail(
      {int cate_id=0,int status=0,int sort = 0, int page = 0}) {
    
    return "$apiHost/novel/$cate_id/$status/$sort/$page.json?${defaultParameter()}";
  }





  //漫画相关内容
  static String comicRelated(int comic_id) {
    return "$apiHost/v3/comic/related/$comic_id.json?${defaultParameter()}";
  }

  //添加漫画订阅
  static get addComicSubscribe => "http://v3api.dmzj.com/subscribe/add";

  //取消漫画订阅
  static String cancelComicSubscribe(int comic_id, String uid) {
    return "$apiHost/subscribe/cancel?obj_ids=$comic_id&uid=$uid&type=mh";
  }

   //添加小说订阅
  static get addNovelSubscribe => "http://v3api.dmzj.com/subscribe/add";

  //取消小说订阅
  static String cancelNovelSubscribe(int novel_id, String uid) {
    return "$apiHost/subscribe/cancel?obj_ids=$novel_id&uid=$uid&type=xs";
  }


  //用户订阅,type 0=漫画,1=轻小说,sub_type 全部=1，未读=2，已读=3，完结=4
  static String userSubscribe(int type, int sub_type, String uid, String token,
      {int page = 0, String letter = "all"}) {
    return "$apiHost/UCenter/subscribe?uid=$uid&sub_type=$sub_type&letter=$letter&dmzj_token=$token&page=$page&type=$type&${defaultParameter()}";
  }

  /// 用户漫画记录
  static String userComicHistory(String uid,{int page = 0}) {
    return "https://interface.dmzj.com/api/getReInfo/comic/$uid/$page?${defaultParameter()}";
  }
  /// 用户小说记录
  static String userNovelHistory(String uid,{int page = 0}) {
    return "https://interface.dmzj.com/api/getReInfo/novel/$uid/$page?${defaultParameter()}";
  }

  /// 上传观看记录
  static String addUserComicHistory(int comic_id,int chapter_id,String uid,{int page = 1}) {
    Map map={
      comic_id.toString():chapter_id.toString(),
      "comicId":comic_id.toString(),
      "chapterId":chapter_id.toString(),
      "page":page,
      "time":timeStamp
    };
    var json= Uri.encodeComponent(jsonEncode(map));
    return "https://interface.dmzj.com/api/record/getRe?st=comic&uid=$uid&callback=record_jsonpCallback&json=[$json]&type=3";
  }
  /// 上传小说观看记录
  static String addUserNovelHistory(int novel_id,int volume_id,int chapter_id,String uid,{int page = 1}) {
    Map map={
      novel_id.toString():chapter_id.toString(),
      "lnovel_id":novel_id.toString(),
      "volume_id":volume_id.toString(),
      "chapterId":chapter_id.toString(),
      "total_num":0,
      "page":page,
      "time":timeStamp
    };
    var json= Uri.encodeComponent(jsonEncode(map));
    return "https://interface.dmzj.com/api/record/getRe?st=novel&uid=$uid&callback=record_jsonpCallback&json=[$json]&type=3";
  }


  /// 评论
  static String commentV2(int id, int type,
      {int page = 1, bool ishot = false}) {
    return "https://interface.dmzj.com/api/NewComment2/list?type=$type&obj_id=$id&hot=${ishot ? 1 : 0}&page_index=$page&_=${DateTime.now().millisecondsSinceEpoch}";
  }

  /// 添加评论
  static String addCommentV3(int type) {
    return "http://v3comment.dmzj.com/v1/$type/add/app";
  }
  /// 检查是否可以评论
  static String checkCommentV3(String uid) {
    return "http://v3api.dmzj.com/comment2/gagcheckv2/$uid.json?${defaultParameter()}";
  }

   /// 点赞评论
  static String likeCommentV3(int obj_id,String comment_id,int type) {
    return "http://v3comment.dmzj.com/v1/$type/like/$comment_id?obj_id=$obj_id&comment_id=$comment_id&${defaultParameter()}";
  }

  /// 评论数量
  static String commentCountV2(int id, int type) {
    return "https://interface.dmzj.com/api/NewComment2/total?type=$type&obj_id=$id&countType=1&authorId=&_=${DateTime.now().millisecondsSinceEpoch}";
  }


  ///  用户评论
  /// [type] 0=漫画，1=轻小说，2=新闻
  static String userComment(int uid,{int page = 1, int type=0}) {
    var url="$apiHost/v3/old/comment/owner/$type/$uid/$page.json";
    if(type==1){
      url="$apiHost/comment/owner/$type/$uid/$page.json";
    }
    return "$url?${defaultParameter()}";
  }

  /// 漫画搜索热词
  static get comicSearchHotWord=>"$apiHost/search/hot/0.json?${defaultParameter()}";

   /// 轻小说搜索热词
  static get novelSearchHotWord=>"$apiHost/search/hot/1.json?${defaultParameter()}";

  static String cmoicNSSearch(String keyword) {
    return "https://dmzj.nsapps.cn/api/dmzj/search?keyword=${Uri.encodeComponent(keyword)}";
  }

  static String novelSearch(String keyword,{int page=0}) {
    return "$apiHost/search/show/1/${Uri.encodeComponent(keyword)}/$page.json?${defaultParameter()}";
  }

  static String defaultParameter() {
    return "channel=${Platform.operatingSystem}&version$version&timestamp=$timeStamp";
  }

  static String sign(String content,String mode){
     var _content = new Utf8Encoder().convert(mode+content);
    return  hex.encode(md5.convert(_content).bytes);
  }

}
