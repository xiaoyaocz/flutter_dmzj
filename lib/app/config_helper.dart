import 'dart:convert';

import 'package:flutter_dmzj/models/user/user_model.dart';
import 'package:flutter_dmzj/models/user/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigHelper {
  static SharedPreferences prefs;

  /// APP夜间模式
  static bool getOpenDarkMode() {
    return prefs.getBool("isDark") ?? false;
  }

  static void setOpenDarkMode(bool value) {
    prefs.setBool("isDark", value);
  }

  /// APP夜间模式跟随系统
  static bool getSysDarkMode() {
    return prefs.getBool("sysDark") ?? false;
  }

  static void setSysDarkMode(bool value) {
    prefs.setBool("sysDark", value);
  }

  /// APP夜间模式
  static int getAppTheme() {
    return prefs.getInt("themeColor") ?? 0;
  }

  static void setAppTheme(int value) {
    prefs.setInt("themeColor", value);
  }

  /// 用户是否已经登录
  static bool getUserIsLogined() {
    return prefs.getBool("isLogin") ?? false;
  }

  static void setUserIsLogined(bool value) {
    prefs.setBool("isLogin", value);
  }

  /// 用户是否绑定手机号
  static bool getUserIsBindTel() {
    return prefs.getBool("isBindTel") ?? false;
  }

  static void setUserIsBindTel(bool value) {
    prefs.setBool("isBindTel", value);
  }

  /// 读取用户信息
  static UserInfo getUserInfo() {
    var userInfoString = prefs.getString("userInfo");
    return (userInfoString != null && userInfoString.length != 0)
        ? UserInfo.fromJson(jsonDecode(userInfoString))
        : null;
  }

  static void setUserInfo(UserInfo value) {
    prefs.setString("userInfo", jsonEncode(value));
  }

  /// 读取用户资料
  static UserProfileModel getUserProfile() {
    var userInfoString = prefs.getString("userProfile");
    return (userInfoString != null && userInfoString.length != 0)
        ? UserProfileModel.fromJson(jsonDecode(userInfoString))
        : null;
  }

  static void setUserProfile(UserProfileModel value) {
    prefs.setString("userProfile", jsonEncode(value));
  }

  /// 漫画阅读使用网页API
  static bool getComicWebApi() {
    return prefs.getBool("ComicWebAPI") ?? true;
  }

  static void setComicWebApi(bool value) {
    prefs.setBool("ComicWebAPI", value);
  }


  /// 漫画阅读方向
  static bool getComicVertical() {
    return prefs.getBool("ComicVertical") ?? false;
  }

  static void setComicVertical(bool value) {
    prefs.setBool("ComicVertical", value);
  }

  /// 漫画阅读屏幕常亮
  static bool getComicWakelock() {
    return prefs.getBool("ComicWakelock") ?? false;
  }

  static void setComicWakelock(bool value) {
    prefs.setBool("ComicWakelock", value);
  }

  /// 漫画反向阅读
  static bool getComicReadReverse() {
    return prefs.getBool("ComicReadReverse") ?? false;
  }

  static void setComicReadReverse(bool value) {
    prefs.setBool("ComicReadReverse", value);
  }

  /// 漫画阅读显示状态
  static bool getComicReadShowState() {
    return prefs.getBool("ComicReadShowState") ?? true;
  }

  static void setComicReadShowState(bool value) {
    prefs.setBool("ComicReadShowState", value);
  }

  /// 漫画阅读显示状态栏
  static bool getComicShowStatusBar() {
    return prefs.getBool("ComicShowStatusBar") ?? true;
  }

  static void setComicShowStatusBar(bool value) {
    prefs.setBool("ComicShowStatusBar", value);
  }

  /// 漫画阅读亮度
  static double getComicBrightness() {
    return prefs.getDouble("ComicBrightness") ?? 1.0;
  }

  static void setComicBrightness(double value) {
    prefs.setDouble("ComicBrightness", value);
  }

  /// 漫画阅读使用系统亮度
  static bool getComicSystemBrightness() {
    return prefs.getBool("ComicSystemBrightness") ?? true;
  }

  static void setComicSystemBrightness(bool value) {
    prefs.setBool("ComicSystemBrightness", value);
  }

  /// 小说阅读记录
  static int getNovelHistory(int novelId) {
    return prefs.getInt("novel$novelId") ?? 0;
  }

  static void setNovelHistory(int novelId, int value) {
    prefs.setInt("novel$novelId", value);
  }

  /// 小说阅读主题
  static int getNovelTheme() {
    return prefs.getInt("NovelTheme") ?? 0;
  }

  static void setNovelTheme(int value) {
    prefs.setInt("NovelTheme", value);
  }

  /// 小说字体大小
  static double getNovelFontSize() {
    return prefs.getDouble("NovelFontSize") ?? 16.0;
  }

  static void setNovelFontSize(double value) {
    prefs.setDouble("NovelFontSize", value);
  }

  /// 小说行高
  static double getNovelLineHeight() {
    return prefs.getDouble("NovelLineHeight") ?? 1.6;
  }

  static void setNovelLineHeight(double value) {
    prefs.setDouble("NovelLineHeight", value);
  }

  /// 小说阅读方向 0=左到右,1=右到左,2=上到下
  static int getNovelReadDirection() {
    return prefs.getInt("NovelReadDirection") ?? 0;
  }

  static void setNovelReadDirection(int value) {
    prefs.setInt("NovelReadDirection", value);
  }
}
