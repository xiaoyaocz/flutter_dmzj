import 'package:flutter_dmzj/app/http_util.dart';
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

  String baseUrl = "https://v4api.dmzj1.com";
  Future<List<ComicUpdateListItemResponse>> getUpdateList(String type,
      {int page = 0}) async {
    var path = "$baseUrl/comic/update/list/$type/$page";
    var result = await HttpUtil.instance.httpGet(
      path,
      queryParameters: ApiUtil.defaultParameter(),
    );
    var resultBytes = ApiUtil.decrypt(result);

    var data = ComicUpdateListResponse.fromBuffer(resultBytes);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }
    return data.data;
  }
}
