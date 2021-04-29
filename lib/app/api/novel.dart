import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_dmzj/app/http_util.dart';
import 'package:flutter_dmzj/protobuf/novel/novel_chapter_response.pb.dart';
import 'package:flutter_dmzj/protobuf/novel/novel_detail_response.pb.dart';
import 'api_util.dart';

class NovelApi {
  static NovelApi _novelApi;
  static NovelApi get instance {
    if (_novelApi == null) {
      _novelApi = NovelApi();
    }
    return _novelApi;
  }

  /// 轻小说详情
  Future<NovelDetailInfoResponse> getDetail(int novelId) async {
    var path = "${ApiUtil.BASE_URL_V4}/novel/detail/$novelId";
    var result = await HttpUtil.instance.httpGet(
      path,
      queryParameters: ApiUtil.defaultParameter(needLogined: true),
    );
    var resultBytes = ApiUtil.decrypt(result);

    var data = NovelDetailResponse.fromBuffer(resultBytes);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }
    return data.data;
  }

  /// 小说章节
  Future<List<NovelChapterVolumeResponse>> getChapter(int novelId) async {
    var path = "${ApiUtil.BASE_URL_V4}/novel/chapter/$novelId";
    var result = await HttpUtil.instance.httpGet(
      path,
      queryParameters: ApiUtil.defaultParameter(needLogined: true),
    );
    var resultBytes = ApiUtil.decrypt(result);

    var data = NovelChapterResponse.fromBuffer(resultBytes);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }
    return data.data;
  }

  /// 小说正文
  String getNovelContentUrl(int volumeId, int chapterId) {
    var path = "/lnovel/${volumeId}_$chapterId.txt";
    var ts = (DateTime.now().millisecondsSinceEpoch / 1000).toStringAsFixed(0);
    var key =
        "IBAAKCAQEAsUAdKtXNt8cdrcTXLsaFKj9bSK1nEOAROGn2KJXlEVekcPssKUxSN8dsfba51kmHM";
    key += path;
    key += ts;
    key = md5.convert(utf8.encode(key)).toString().toLowerCase();
    // var result = await HttpUtil.instance.httpGet(
    //   "http://jurisdiction.dmzj1.com" + path,
    //   queryParameters: {"t": ts, "k": key},
    // );

    return "http://jurisdiction.dmzj1.com" + path + "?t=$ts&k=$key";
  }
}
