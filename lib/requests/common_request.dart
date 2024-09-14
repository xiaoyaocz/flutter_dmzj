import 'package:dio/dio.dart';
import 'package:flutter_dmzj/models/version_model.dart';

/// 通用的请求
class CommonRequest {
  Future<VersionModel> checkUpdate() async {
    try {
      return await checkUpdateGitMirror();
    } catch (e) {
      return await checkUpdateJsDelivr();
    }
  }

  /// 检查更新
  Future<VersionModel> checkUpdateGitMirror() async {
    var result = await Dio().get(
      "https://raw.gitmirror.com/xiaoyaocz/flutter_dmzj/zaimanhua/document/app_version.json",
      queryParameters: {
        "ts": DateTime.now().millisecondsSinceEpoch,
      },
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    return VersionModel.fromJson(result.data);
  }

  /// 检查更新
  Future<VersionModel> checkUpdateJsDelivr() async {
    var result = await Dio().get(
      "https://cdn.jsdelivr.net/gh/xiaoyaocz/flutter_dmzj@zaimanhua/document/app_version.json",
      queryParameters: {
        "ts": DateTime.now().millisecondsSinceEpoch,
      },
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    return VersionModel.fromJson(result.data);
  }
}
