// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:crypton/crypton.dart';
import 'package:flutter_dmzj/app/app_error.dart';
import 'package:flutter_dmzj/services/user_service.dart';

class Api {
  static const String DMZJ_DOMAIN_NAME = "dmzj.com";
  static const String IDMZJ_DOMAIN_NAME = "idmzj.com";
  static const String MUWAI_DOMAIN_NAME = "muwai.com";

  /// V3接口，无加密
  static const String BASE_URL_V3 = "https://nnv3api.$IDMZJ_DOMAIN_NAME";

  /// V4接口,返回加密数据的
  static const String BASE_URL_V4 = "https://nnv4api.$IDMZJ_DOMAIN_NAME";

  /// V3 API
  static const String BASE_URL_V3_API = "https://v3api.$IDMZJ_DOMAIN_NAME";

  /// V3 评论
  static const String BASE_URL_V3_COMMENT =
      "http://v3comment.$IDMZJ_DOMAIN_NAME";

  /// 用户
  static const String BASE_URL_USER = "http://nnuser.$IDMZJ_DOMAIN_NAME";

  /// Interface
  static const String BASE_URL_INTERFACE =
      "http://nninterface.$IDMZJ_DOMAIN_NAME";

  /// V4 API key in 3.9.1 apk, the block size is 256.
  static const V4_PRIVATE_KEY_NEW =
      "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCdZs58QzMFomC+04F8R/yIzLmEwCHto93zAMG+KYSTaidVCkVvnNBE6g5xXAQgnGjwDDsJUV0m2jNtLiVTG7yNv5c1PvRm/9XH9uo91z/X//s03n1px/sOqmCYk2ezkbojUADY74pBrVfgIMu71mXtKK640/hyQLZIrRfpTjiHHfykulL8v5BTY99llwTMC8oIPVXmUIYKMZORRYhC0bgOpJeOq6PI+3qpf/gWigVcH2+qMR+6Bi0HLg3s5rYdYxxP+kaZmMmTRO7NxCfYlNri8NwX2Lgk9IE0he5i0OQCgGjqQ5vxAv52XwJB3jCxmEeVJmiMbrrs+ggAp7rNLzv/AgMBAAECggEAKcGeQaTqIjKDi9w8W6YVPo1hIfB+j7aLKO4od7Q38YuVx5+j8AofzkhxcG1Cwwv7YsM73irxlV8JiYtWZ4fSK6CKEpwS5kg0hInidmlmDH1iPRJRHwDof2l/mrpwJlkgkkGlF+fkO6wqxdCte7VS8Ol8AJhrLpQwR3N0Bnaz1FQboaxy28MJ53kJBkM8u0J3hHIx+0s57qdh/MuHnd0Q8lcxnXM9JYhSCwOHmcGdR/G29l1S8JF9w1O8RPprPjYGBTh2JhqaQ4zBx/2Q/Uk7/l0X7BcpFzzpyuc0q2OCOOhAIyJKITvxiEsrt/OoNxoCUXMoEtQ63tXtrBMN+aNNgQKBgQDP43C/f/p1CaKOzmH9gl+rIKHpWbRZowolFKjN5u9T/Yep/fOqYufVXFzKfuoBPj2k/MbFUhHkO/WE3Oqcis4/pdt+7H1tooK2kptZNJZGaK1w4wJ5Gm3b28sQsUtG1QtJhBcj4j2fuRiCbOAV43OdWKrsse5efmd0pZLqth+4IQKBgQDB1DjP00Nb+uB+c/t4c/GFQYTjpgG5lUf+IuNmQvXfym7xrb4mU5czV/OUWa0L9OdfqJxtOb4QW4c6oRll+8Et5V1POLajYaaqTjFr2y21fu4DNGEUsAd4UmI7GMwAtYE9gUo5KWRLgXRDTD2fqvpTbbqSDuqHcPI36qnxF5nwHwKBgE+L0tej670e67HDLOGpIlxDx1CX/5eQ+E/KAPGQnSFBUMjuIG+hGt6cUfE18Op623GnO5PDXI89liu5sJgn0NWv7DY73Z624Vdk78aJhbr5UOxyIL8gKstG5gPEI26+FGyT+5rCdhwI4mT9rh0SBGo/xF9/khtcOM/8jyP6flahAoGBAIq/YL+cCi7Qglzip1NNI8lw4jCXR8rSCovn64HrUtgUr6A+78u9sJFnVwyNuOrDL9DxALDLUbuh2UZlxamUMm+pLUclYM/JeiWU/ZmodqriJnySxR+q9l3yEzEcigPD6bTeVQRgFdRa4Z++9qnSGYkZFiGxnb7AYhMW3vmfHGmfAoGBAKWhB0e7dgg61ezjMrKkiaIlcrWkKkpNZ/i9B72rDnPr115x56laOaIu3D8Cuh8o+zGqRuyABBK5cDMPy/DagghrI4H6yhfnevUKD94F/XKQIVWXb5in9mwibAiHBrmLQ7fLUDoyhRmERsZYduS4inHzYFEHhjq4jUfQsOV9xKdu";

  /// V4 API的密钥 
  static const V4_PRIVATE_KEY =
      "MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAK8nNR1lTnIfIes6oRWJNj3mB6OssDGx0uGMpgpbVCpf6+VwnuI2stmhZNoQcM417Iz7WqlPzbUmu9R4dEKmLGEEqOhOdVaeh9Xk2IPPjqIu5TbkLZRxkY3dJM1htbz57d/roesJLkZXqssfG5EJauNc+RcABTfLb4IiFjSMlTsnAgMBAAECgYEAiz/pi2hKOJKlvcTL4jpHJGjn8+lL3wZX+LeAHkXDoTjHa47g0knYYQteCbv+YwMeAGupBWiLy5RyyhXFoGNKbbnvftMYK56hH+iqxjtDLnjSDKWnhcB7089sNKaEM9Ilil6uxWMrMMBH9v2PLdYsqMBHqPutKu/SigeGPeiB7VECQQDizVlNv67go99QAIv2n/ga4e0wLizVuaNBXE88AdOnaZ0LOTeniVEqvPtgUk63zbjl0P/pzQzyjitwe6HoCAIpAkEAxbOtnCm1uKEp5HsNaXEJTwE7WQf7PrLD4+BpGtNKkgja6f6F4ld4QZ2TQ6qvsCizSGJrjOpNdjVGJ7bgYMcczwJBALvJWPLmDi7ToFfGTB0EsNHZVKE66kZ/8Stx+ezueke4S556XplqOflQBjbnj2PigwBN/0afT+QZUOBOjWzoDJkCQClzo+oDQMvGVs9GEajS/32mJ3hiWQZrWvEzgzYRqSf3XVcEe7PaXSd8z3y3lACeeACsShqQoc8wGlaHXIJOHTcCQQCZw5127ZGs8ZDTSrogrH73Kw/HvX55wGAeirKYcv28eauveCG7iyFR0PFB/P/EDZnyb+ifvyEFlucPUI0+Y87F";
  
  static Uint8List decryptV4(String text) {
    return decryptWithKey(text, V4_PRIVATE_KEY);
  }

  static Uint8List decryptV4New(String text) {
    return decryptWithKey(text, V4_PRIVATE_KEY_NEW);
  }

  static Uint8List decryptWithKey(String text, String key) {
    try {
      RSAKeypair rsaKeypair =
          RSAKeypair(RSAPrivateKey.fromString(key));
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



  static const String VERSION = "3.9.1"; // Requires new key
  // static const String VERSION = "3.8.2"; // Old private key
  static const String APP_CHANNEL = "101_01_01_000"; 
  static const String CORE_TOKEN_STRING_PREFIX = "com.dmzj.manhua63:60:C8:3B:75:31:3F:35:EC:41:1D:85:60:63:EB:25";
  static const String CORE_TOKEN_STRING_SUFFIX = "+bYV5TaOBivUHM";

  static String getCoreToken(String timestamp) {
    final tokenString = '$CORE_TOKEN_STRING_PREFIX$timestamp$CORE_TOKEN_STRING_SUFFIX';
    final digest = md5.convert(utf8.encode(tokenString)).bytes;
    // Convert bytes to hex string, then format with colons
    final hexString = digest.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
    final newHash = hexString.toUpperCase().replaceAllMapped(RegExp(r'(.{2})(?!$)'), (match) => '${match[1]}:');
    return '$timestamp|$newHash';
  }
  static String get timeStamp =>
      (DateTime.now().millisecondsSinceEpoch / 1000).toStringAsFixed(0);

  /// 默认的参数
  static Map<String, dynamic> getDefaultParameter({bool withUid = false, bool useCoreToken = false}) {
    final ts = timeStamp;
    var map = <String, dynamic>{
      "channel": "android",
      "version": VERSION,
      // "app_channel": APP_CHANNEL,
      "_debug": "0", // Match the JS default
      "timestamp": ts
    };
    if (useCoreToken) {
      map["coreToken"] = getCoreToken(ts);
    }
    if (withUid && UserService.instance.logined.value) {
      map.addAll({"uid": UserService.instance.userId});
    }
    return map;
  }

  /// 小说正文链接
  static String getNovelContentUrl(
      {required int volumeId, required int chapterId}) {
    var path = "/lnovel/${volumeId}_$chapterId.txt";
    var ts = (DateTime.now().millisecondsSinceEpoch / 1000).toStringAsFixed(0);
    var key =
        "IBAAKCAQEAsUAdKtXNt8cdrcTXLsaFKj9bSK1nEOAROGn2KJXlEVekcPssKUxSN8dsfba51kmHM";
    key += path;
    key += ts;
    key = md5.convert(utf8.encode(key)).toString().toLowerCase();

    return "http://jurisdiction.idmzj.com$path?t=$ts&k=$key";
  }
}
