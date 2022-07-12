// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:crypton/crypton.dart';
import 'package:flutter_dmzj/app/app_error.dart';

class Api {
  /// V3接口，无加密
  static const String BASE_URL_V3 = "https://nnv3api.muwai.com";

  /// V4接口,返回加密数据的
  static const String BASE_URL_V4 = "https://nnv4api.muwai.com";

  /// V3 API
  static const String BASE_URL_V3_API = "https://v3api.muwai.com";

  /// V4 API的密钥
  static const V4_PRIVATE_KEY =
      "MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAK8nNR1lTnIfIes6oRWJNj3mB6OssDGx0uGMpgpbVCpf6+VwnuI2stmhZNoQcM417Iz7WqlPzbUmu9R4dEKmLGEEqOhOdVaeh9Xk2IPPjqIu5TbkLZRxkY3dJM1htbz57d/roesJLkZXqssfG5EJauNc+RcABTfLb4IiFjSMlTsnAgMBAAECgYEAiz/pi2hKOJKlvcTL4jpHJGjn8+lL3wZX+LeAHkXDoTjHa47g0knYYQteCbv+YwMeAGupBWiLy5RyyhXFoGNKbbnvftMYK56hH+iqxjtDLnjSDKWnhcB7089sNKaEM9Ilil6uxWMrMMBH9v2PLdYsqMBHqPutKu/SigeGPeiB7VECQQDizVlNv67go99QAIv2n/ga4e0wLizVuaNBXE88AdOnaZ0LOTeniVEqvPtgUk63zbjl0P/pzQzyjitwe6HoCAIpAkEAxbOtnCm1uKEp5HsNaXEJTwE7WQf7PrLD4+BpGtNKkgja6f6F4ld4QZ2TQ6qvsCizSGJrjOpNdjVGJ7bgYMcczwJBALvJWPLmDi7ToFfGTB0EsNHZVKE66kZ/8Stx+ezueke4S556XplqOflQBjbnj2PigwBN/0afT+QZUOBOjWzoDJkCQClzo+oDQMvGVs9GEajS/32mJ3hiWQZrWvEzgzYRqSf3XVcEe7PaXSd8z3y3lACeeACsShqQoc8wGlaHXIJOHTcCQQCZw5127ZGs8ZDTSrogrH73Kw/HvX55wGAeirKYcv28eauveCG7iyFR0PFB/P/EDZnyb+ifvyEFlucPUI0+Y87F";
  static Uint8List decryptV4(String text) {
    try {
      RSAKeypair rsaKeypair =
          RSAKeypair(RSAPrivateKey.fromString(V4_PRIVATE_KEY));
      var decrypted = rsaKeypair.privateKey.decryptData(base64.decode(text));
      return decrypted;
    } catch (e) {
      throw AppError('返回数据解密失败');
    }
  }

  /// 签名
  static String sign(String content, String mode) {
    var utf8Content = utf8.encode(mode + content);

    return md5.convert(utf8Content).toString();
  }

  static const String VERSION = "3.0.0";
  static String get timeStamp =>
      (DateTime.now().millisecondsSinceEpoch / 1000).toStringAsFixed(0);

  /// 默认的参数
  static Map<String, dynamic> getDefaultParameter({bool withUid = false}) {
    var map = {
      "channel": "android",
      "version": VERSION,
      "timestamp": timeStamp
    };
    if (withUid) {
      //TODO 读取用户ID
      map.addAll({"uid": ""});
    }
    return map;
  }
}
