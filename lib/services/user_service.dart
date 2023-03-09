import 'dart:async';
import 'dart:convert';

import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/event_bus.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/db/comic_history.dart';
import 'package:flutter_dmzj/models/db/novel_history.dart';
import 'package:flutter_dmzj/models/user/login_result_model.dart';
import 'package:flutter_dmzj/models/user/user_profile_model.dart';
import 'package:flutter_dmzj/modules/user/login/user_login_dialog.dart';
import 'package:flutter_dmzj/requests/user_request.dart';
import 'package:flutter_dmzj/services/db_service.dart';
import 'package:flutter_dmzj/services/local_storage_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  static StreamController loginedStreamController =
      StreamController.broadcast();
  static StreamController logoutStreamController = StreamController.broadcast();

  ///登录事件流
  static Stream get loginedStream => loginedStreamController.stream;

  ///退出登录事件流
  static Stream get logoutStream => logoutStreamController.stream;

  static UserService get instance => Get.find<UserService>();
  final LocalStorageService storage = Get.find<LocalStorageService>();
  final request = UserRequest();
  LoginResultModel? userAuthInfo;

  Rx<UserProfileModel?> userProfile = Rx<UserProfileModel?>(null);

  String get dmzjToken => userAuthInfo?.dmzjToken ?? '';
  String get userId => userAuthInfo?.uid ?? '';
  String get nickname => userAuthInfo?.nickname ?? '';

  /// 是否已经绑定手机号
  var bindTel = true.obs;

  /// 是否已经设置密码
  var setPwd = true.obs;

  /// 是否已经登录
  var logined = false.obs;

  /// 已经订阅的漫画ID
  var subscribedComicIds = RxSet<int>();

  /// 已经订阅的小说ID
  var subscribedNovelIds = RxSet<int>();

  void init() {
    var value = storage.getValue(LocalStorageService.kUserAuthInfo, '');
    if (value.isEmpty) {
      return;
    }
    LoginResultModel info = LoginResultModel.fromJson(json.decode(value));

    userAuthInfo = info;
    logined.value = true;
    if (logined.value) {
      updateUserHistory();
    }
  }

  /// 设置登录信息
  void setAuthInfo(LoginResultModel info) {
    userAuthInfo = info;
    storage.setValue(LocalStorageService.kUserAuthInfo, info.toString());
    logined.value = true;
    UserService.loginedStreamController.add(true);
    refreshProfile();
    updateUserHistory();
  }

  void logout() {
    storage.removeValue(LocalStorageService.kUserAuthInfo);
    userProfile.value = null;
    logined.value = false;
    UserService.logoutStreamController.add(true);
  }

  Future<bool> login() async {
    if (logined.value) {
      return true;
    }
    var result = await Get.dialog(UserLoginDialog());

    return (result != null && result == true);
  }

  /// 刷新个人资料
  Future refreshProfile() async {
    try {
      if (!logined.value) {
        return;
      }
      userProfile.value = await request.userProfile();
      updateBindStatus();
    } catch (e) {
      Log.logPrint(e);
    }
  }

  /// 更新一下用户的历史记录
  void updateUserHistory() {
    if (!logined.value) {
      return;
    }
    request.comicHistory().then((value) => {}, onError: (e) {
      Log.logPrint(e);
    });
    request.novelHistory().then((value) => {}, onError: (e) {
      Log.logPrint(e);
    });
  }

  /// 更新绑定状态
  void updateBindStatus() async {
    try {
      if (!logined.value) {
        return;
      }
      var result = await request.isBindTelPwd();
      bindTel.value = result.isBindTel == 1;
      setPwd.value = result.isBindTel == 1;
    } catch (e) {
      Log.logPrint(e);
    }
  }

  /// 添加订阅
  Future<bool> addSubscribe(List<int> ids, int type) async {
    try {
      if (!await login()) {
        return false;
      }
      await request.addSubscribe(
        ids: ids,
        type: type,
      );
      if (type == AppConstant.kTypeComic) {
        subscribedComicIds.addAll(ids);
      } else if (type == AppConstant.kTypeNovel) {
        subscribedNovelIds.addAll(ids);
      }

      SmartDialog.showToast("订阅成功");
      return true;
    } catch (e) {
      SmartDialog.showToast(e.toString());
      return false;
    }
  }

  /// 取消订阅
  Future<bool> cancelSubscribe(List<int> ids, int type) async {
    try {
      if (!await login()) {
        return false;
      }
      await request.removeSubscribe(
        ids: ids,
        type: type,
      );
      if (type == AppConstant.kTypeComic) {
        subscribedComicIds.removeAll(ids);
      } else if (type == AppConstant.kTypeNovel) {
        subscribedNovelIds.removeAll(ids);
      }
      SmartDialog.showToast("已取消订阅");
      return true;
    } catch (e) {
      SmartDialog.showToast(e.toString());
      return false;
    }
  }

  /// 更新漫画记录
  Future updateComicHistory({
    required int comicId,
    required int chapterId,
    required int page,
    required String comicName,
    required String comicCover,
    required String chapterName,
  }) async {
    try {
      var time = DateTime.now();
      await DBService.instance.updateComicHistory(
        ComicHistory(
          comicId: comicId,
          chapterId: chapterId,
          comicName: comicName,
          comicCover: comicCover,
          chapterName: chapterName,
          updateTime: time,
          page: page,
        ),
      );
      EventBus.instance.emit(EventBus.kUpdatedComicHistory, comicId);
      if (!logined.value) {
        return;
      }
      await request.uploadComicHistory(
        comicId: comicId,
        chapterId: chapterId,
        page: page,
        time: time,
      );
    } catch (e) {
      Log.logPrint(e);
    }
  }

  /// 更新漫画记录
  Future updateNovelHistory({
    required int novelId,
    required int chapterId,
    required int index,
    required int total,
    required String novelName,
    required String novelCover,
    required String chapterName,
    required int volumeId,
    required String volumeName,
  }) async {
    try {
      var time = DateTime.now();
      await DBService.instance.updateNovelHistory(
        NovelHistory(
          novelId: novelId,
          chapterId: chapterId,
          volumeName: volumeName,
          volumeId: volumeId,
          chapterName: chapterName,
          updateTime: time,
          index: index,
          total: total,
          novelCover: novelCover,
          novelName: novelName,
        ),
      );
      EventBus.instance.emit(EventBus.kUpdatedNovelHistory, novelId);
      if (!logined.value) {
        return;
      }
      await request.uploadNovelHistory(
        novelId: novelId,
        volumeId: volumeId,
        chapterId: chapterId,
        page: 1,
        total: total,
        time: time,
      );
    } catch (e) {
      Log.logPrint(e);
    }
  }
}
