import 'package:flutter_dmzj/app/http_util.dart';
import 'package:flutter_dmzj/protobuf/comic/detail_response.pb.dart';
import 'package:flutter_dmzj/protobuf/comic/rank_list_response.pb.dart';
import 'package:flutter_dmzj/protobuf/comic/update_list_response.pb.dart';

import 'api_util.dart';

class ComicApi {
  static ComicApi _comicApi;
  static ComicApi get instance {
    if (_comicApi == null) {
      _comicApi = ComicApi();
    }
    return _comicApi;
  }

  /// 首页-更新
  Future<List<ComicUpdateListItemResponse>> getUpdateList(String type,
      {int page = 1}) async {
    var path = "${ApiUtil.BASE_URL_V4}/comic/update/list/$type/$page";
    var result = await HttpUtil.instance.httpGet(
      path,
      queryParameters: ApiUtil.defaultParameter(needLogined: true),
    );
    var resultBytes = ApiUtil.decrypt(result);

    var data = ComicUpdateListResponse.fromBuffer(resultBytes);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }
    return data.data;
  }

  /// 漫画详情
  Future<ComicDetailInfoResponse> getDetail(int comicId) async {
    var path = "${ApiUtil.BASE_URL_V4}/comic/detail/$comicId";
    var result = await HttpUtil.instance.httpGet(
      path,
      queryParameters: ApiUtil.defaultParameter(needLogined: true),
    );
    var resultBytes = ApiUtil.decrypt(result);

    var data = ComicDetailResponse.fromBuffer(resultBytes);

  
    //patch start
    if (data.errno == 0) {
    return data.data;
    }
    //fallback
    try{
    path = "https://api.dmzj.com/dynamic/comicinfo/$comicId.json";
    var info = await HttpUtil.instance.httpGet(
      path,
      queryParameters: ApiUtil.defaultParameter(needLogined: true),
    );
    var ret = {
      "Data": {
        "Id": info['data']['info']['id'],
        "Title": info['data']['info']['title'],
        "Direction": info['data']['info']['direction'],
        "Islong": info['data']['info']['islong'],
        "Cover": info['data']['info']['cover'],
        "Description": info['data']['info']['description'],
        "LastUpdatetime": info['data']['info']['last_updatetime'],
        "LastUpdateChapterName": info['data']['info']['last_update_chapter_name'],
        "FirstLetter": info['data']['info']['first_letter'],
        "ComicPy": info['data']['info']['first_letter'],
        "HotNum": 0,//N/A
        "HitNum": 0,//N/A
        "LastUpdateChapterId": info['data']['list'][0]['id'],
        "Types": [
          {
            "TagId": 0,//WIP
            "TagName": info['data']['info']['types'],
          }
        ],
        "Status": [
          {
            "TagId": info['data']['info']['status']=="连载中"?2309:2310,
            "TagName": info['data']['info']['status']
          }
        ],
        "Authors": [
          {
            "TagId": 0,//WIP
            "TagName": info['data']['info']['status']
          }
        ],
        "SubscribeNum": 0,//N/A
        "Chapters": [
          {
            "Title": "连载",//N/A
            "Data": info['data']['list'].map((e){
              return {
                "ChapterId": e['id'],
                "ChapterTitle": e['chapter_name'],
                "Updatetime": e['updatetime'],
                "Filesize": e['filesize'],
                "ChapterOrder": e['chapter_order']
              };
            }),
          }
        ],
        "IsNeedLogin": 1//N/A
      }
    };
    }catch(e){
      throw AppError(data.errmsg, code: data.errno);//if v1 fails, return v4 error
    }
    //patch end
  }

  
  
  /// 首页-排行榜
  Future<List<ComicRankListItemResponse>> getRankList(
      {int tagId = 0, int byTime = 0, int rankType, int page = 0}) async {
    var path = "${ApiUtil.BASE_URL_V4}/comic/rank/list";
    var par = ApiUtil.defaultParameter(needLogined: true);
    par.addAll({
      'tag_id': tagId,
      'by_time': byTime,
      'rank_type': rankType,
      'page': page
    });
    var result = await HttpUtil.instance.httpGet(
      path,
      queryParameters: par,
    );
    var resultBytes = ApiUtil.decrypt(result);

    var data = ComicRankListResponse.fromBuffer(resultBytes);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }
    return data.data;
  }
}
