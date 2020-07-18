import 'dart:convert' show json;

class VersionInfo {
  String version;
  String version_code;
  String message;
  String android_url;
  String ios_url;

  VersionInfo({
    this.version,
    this.version_code,
    this.message,
    this.android_url,
    this.ios_url,
  });

  factory VersionInfo.fromJson(jsonRes) => jsonRes == null
      ? null
      : VersionInfo(
          version: jsonRes['version'],
          version_code: jsonRes['version_code'],
          message: jsonRes['message'],
          android_url: jsonRes['android_url'],
          ios_url: jsonRes['ios_url'],
        );
  Map<String, dynamic> toJson() => {
        'version': version,
        'version_code': version_code,
        'message': message,
        'android_url': android_url,
        'ios_url': ios_url,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
