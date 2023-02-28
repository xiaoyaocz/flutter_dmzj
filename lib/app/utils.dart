import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Utils {
  static late PackageInfo packageInfo;
  static DateFormat dateFormat = DateFormat("MM-dd HH:mm");
  static DateFormat dateFormatWithYear = DateFormat("yyyy-MM-dd HH:mm");
  static void checkUpdate({bool showMsg = true}) {}

  /// 版本号解析
  static int parseVersion(String version) {
    var sp = version.split('.');
    var num = "";
    for (var item in sp) {
      num = num + item.padLeft(2, '0');
    }
    return int.parse(num);
  }

  /// 时间戳格式化-秒
  static String formatTimestamp(int ts) {
    return formatTimestampMS(ts * 1000);
  }

  /// 时间戳格式化-毫秒
  static String formatTimestampMS(int ts) {
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);

    var dtNow = DateTime.now();
    if (dt.year == dtNow.year &&
        dt.month == dtNow.month &&
        dt.day == dtNow.day) {
      return "今天${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    }
    if (dt.year == dtNow.year &&
        dt.month == dtNow.month &&
        dt.day == dtNow.day - 1) {
      return "昨天${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    }

    if (dt.year == dtNow.year) {
      return dateFormat.format(dt);
    }

    return dateFormatWithYear.format(dt);
  }
}
