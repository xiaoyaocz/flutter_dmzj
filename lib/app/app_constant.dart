class AppConstant {
  /// 定义平板宽度，当大于此宽度时APP进入双栏模式
  static const double kTabletWidth = 1000;

  /// 类型ID-漫画
  static const int kTypeComic = 4;

  /// 类型ID-新闻
  static const int kTypeNews = 6;

  /// 类型ID-专题
  static const int kTypeSpecial = 2;

  /// 类型ID-轻小说
  static const int kTypeNovel = 1;
}

class ReaderDirection {
  /// 左右 0
  static const int kLeftToRight = 0;

  /// 上下 1
  static const int kUpToDown = 1;

  /// 右左 2
  static const int kRightToLeft = 2;
}
