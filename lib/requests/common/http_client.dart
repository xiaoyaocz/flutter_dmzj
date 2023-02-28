import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dmzj/app/app_error.dart';
import 'package:flutter_dmzj/requests/common/api.dart';
import 'package:flutter_dmzj/requests/common/custom_interceptor.dart';

class HttpClient {
  static HttpClient? _httpUtil;

  static HttpClient get instance {
    _httpUtil ??= HttpClient();
    return _httpUtil!;
  }

  late Dio dio;
  HttpClient() {
    dio = Dio();
    dio.interceptors.add(CustomInterceptor());
  }

  /// Get请求
  /// * [path] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  /// * [needLogin] 是否需要登录
  /// * [withDefaultParameter] 是否需要带上一些默认参数
  /// * [responseType] 返回的类型
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    String baseUrl = Api.BASE_URL_V3,
    CancelToken? cancel,
    bool withDefaultParameter = true,
    bool needLogin = false,
    ResponseType responseType = ResponseType.json,
    bool checkCode = false,
  }) async {
    Map<String, dynamic> header = {};
    queryParameters ??= <String, dynamic>{};
    var query = Api.getDefaultParameter(withUid: needLogin);
    if (withDefaultParameter) {
      queryParameters.addAll(query);
    }

    try {
      var result = await dio.get(
        baseUrl + path,
        queryParameters: queryParameters,
        options: Options(
          responseType: responseType,
          headers: header,
        ),
        cancelToken: cancel,
      );
      if (checkCode && result.data is Map) {
        var data = result.data as Map;
        if (data['code'] == 0) {
          return result.data['data'];
        } else {
          throw AppError(
            result.data['msg'].toString(),
            code: int.tryParse(result.data['code'].toString()) ?? 0,
          );
        }
      }
      return result.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        return throw AppError("请求失败：${e.response?.statusCode ?? -1}");
      }
      throw AppError("请求失败,请检查网络");
    }
  }

  /// Get 请求,返回JSON
  /// * [path] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  /// * [needLogin] 是否需要登录
  /// * [withDefaultParameter] 是否需要带上一些默认参数
  Future<dynamic> getJson(
    String path, {
    Map<String, dynamic>? queryParameters,
    String baseUrl = Api.BASE_URL_V3,
    CancelToken? cancel,
    bool withDefaultParameter = true,
    bool needLogin = false,
    bool checkCode = false,
  }) async {
    return await get(
      path,
      queryParameters: queryParameters,
      baseUrl: baseUrl,
      cancel: cancel,
      withDefaultParameter: withDefaultParameter,
      needLogin: needLogin,
      responseType: ResponseType.json,
      checkCode: checkCode,
    );
  }

  /// Get 请求,返回Text
  /// * [path] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  /// * [needLogin] 是否需要登录
  /// * [withDefaultParameter] 是否需要带上一些默认参数
  Future<dynamic> getText(
    String path, {
    Map<String, dynamic>? queryParameters,
    String baseUrl = Api.BASE_URL_V3,
    CancelToken? cancel,
    bool withDefaultParameter = true,
    bool needLogin = false,
  }) async {
    return await get(
      path,
      queryParameters: queryParameters,
      baseUrl: baseUrl,
      cancel: cancel,
      withDefaultParameter: withDefaultParameter,
      needLogin: needLogin,
      responseType: ResponseType.plain,
    );
  }

  /// Get 请求,返回解密后Bytes
  /// * [path] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  /// * [needLogin] 是否需要登录
  /// * [withDefaultParameter] 是否需要带上一些默认参数
  Future<Uint8List> getEncryptV4(
    String path, {
    Map<String, dynamic>? queryParameters,
    String baseUrl = Api.BASE_URL_V4,
    CancelToken? cancel,
    bool withDefaultParameter = true,
    bool needLogin = false,
  }) async {
    var result = await get(
      path,
      queryParameters: queryParameters,
      baseUrl: baseUrl,
      cancel: cancel,
      withDefaultParameter: withDefaultParameter,
      needLogin: needLogin,
      responseType: ResponseType.plain,
    );
    var resultBytes = Api.decryptV4(result);
    return resultBytes;
  }

  /// Get 请求,返回byte
  /// * [path] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  /// * [needLogin] 是否需要登录
  /// * [withDefaultParameter] 是否需要带上一些默认参数
  Future<dynamic> getBytes(
    String path, {
    Map<String, dynamic>? queryParameters,
    String baseUrl = Api.BASE_URL_V3,
    CancelToken? cancel,
    bool withDefaultParameter = true,
    bool needLogin = false,
  }) async {
    return await get(
      path,
      queryParameters: queryParameters,
      baseUrl: baseUrl,
      cancel: cancel,
      withDefaultParameter: withDefaultParameter,
      needLogin: needLogin,
      responseType: ResponseType.bytes,
    );
  }

  /// Post请求，返回Map
  /// * [path] 请求链接
  /// * [data] 发送数据
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<dynamic> postJson(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    String baseUrl = Api.BASE_URL_V3,
    CancelToken? cancel,
    bool formUrlEncoded = false,
  }) async {
    Map<String, dynamic> header = {};
    queryParameters ??= {};
    try {
      var result = await dio.post(
        baseUrl + path,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          responseType: ResponseType.json,
          headers: header,
          contentType:
              formUrlEncoded ? Headers.formUrlEncodedContentType : null,
        ),
        cancelToken: cancel,
      );
      return result.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        return throw AppError("请求失败:状态码：${e.response?.statusCode ?? -1}");
      }
      throw AppError("请求失败,请检查网络");
    }
  }
}
