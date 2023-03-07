import 'dart:async';

import 'package:flutter_dmzj/app/log.dart';

/// 全局事件
class EventBus {
  /// 点击了底部导航
  static const String kBottomNavigationBarClicked =
      "BottomNavigationBarClicked";

  /// 更新了漫画记录
  static const String kUpdatedComicHistory = "UpdateComicHistory";

  /// 更新了小说记录
  static const String kUpdatedNovelHistory = "UpdateNovelHistory";
  static EventBus? _instance;

  static EventBus get instance {
    _instance ??= EventBus();
    return _instance!;
  }

  final Map<String, StreamController> _streams = {};

  /// 触发事件
  void emit<T>(String name, T data) {
    if (!_streams.containsKey(name)) {
      _streams.addAll({name: StreamController.broadcast()});
    }
    Log.d("Emit Event：$name\r\n$data");

    _streams[name]!.add(data);
  }

  /// 监听事件
  StreamSubscription<dynamic> listen(String name, Function(dynamic)? onData) {
    if (!_streams.containsKey(name)) {
      _streams.addAll({name: StreamController.broadcast()});
    }
    return _streams[name]!.stream.listen(onData);
  }
}
