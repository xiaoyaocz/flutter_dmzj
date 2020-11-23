import 'package:flutter/material.dart';
import 'package:flutter_dmzj/helper/config_helper.dart';

class ReaderConfigProvider with ChangeNotifier {
  ReaderConfigProvider() {
    changeComicWebApi(ConfigHelper.getComicWebApi());
    changeComicVertical(ConfigHelper.getComicVertical());
    changeComicWakelock(ConfigHelper.getComicWakelock());
    changeReadReverse(ConfigHelper.getComicReadReverse());
    changeComicReadShowState(ConfigHelper.getComicReadShowState());
    changeComicReadShowStatusBar(ConfigHelper.getComicShowStatusBar());
    changeBrightness(ConfigHelper.getComicBrightness());
    changeComicSystemBrightness(ConfigHelper.getComicSystemBrightness());
    changeNovelFontSize(ConfigHelper.getNovelFontSize());
    changeNovelLineHeight(ConfigHelper.getNovelLineHeight());
    changeNovelReadDirection(ConfigHelper.getNovelReadDirection());
    changeNovelReadTheme(ConfigHelper.getNovelTheme());
    changeVolumekeyListen(ConfigHelper.getVolumeKeyListen());
  }

  bool _comicVerticalMode;
  get comicVerticalMode => _comicVerticalMode;
  void changeComicVertical(bool value) {
    _comicVerticalMode = value;

    notifyListeners();
    ConfigHelper.setComicVertical(value);
    if (value) {
      changeReadReverse(false);
    }
  }

  bool _comicWebApi;
  get comicWebApi => _comicWebApi;
  void changeComicWebApi(bool value) {
    _comicWebApi = value;
    notifyListeners();
    ConfigHelper.setComicWebApi(value);
  }

  bool _comicWakelock;
  get comicWakelock => _comicWakelock;
  void changeComicWakelock(bool value) {
    _comicWakelock = value;
    notifyListeners();
    ConfigHelper.setComicWakelock(value);
  }

  bool _comicReadReverse;
  get comicReadReverse => _comicReadReverse;
  void changeReadReverse(bool value) {
    _comicReadReverse = value;
    notifyListeners();
    ConfigHelper.setComicReadReverse(value);
    if (value) {
      changeComicVertical(false);
    }
  }

  bool _comicReadShowstate;
  get comicReadShowstate => _comicReadShowstate;
  void changeComicReadShowState(bool value) {
    _comicReadShowstate = value;
    notifyListeners();
    ConfigHelper.setComicReadShowState(value);
  }

  bool _comicReadShowStatusBar;
  get comicReadShowStatusBar => _comicReadShowStatusBar;
  void changeComicReadShowStatusBar(bool value) {
    _comicReadShowStatusBar = value;
    notifyListeners();
    ConfigHelper.setComicShowStatusBar(value);
  }

  bool _comicSystemBrightness;
  get comicSystemBrightness => _comicSystemBrightness;
  void changeComicSystemBrightness(bool value) {
    _comicSystemBrightness = value;
    notifyListeners();
    ConfigHelper.setComicSystemBrightness(value);
  }

  double _comicBrightness;
  get comicBrightness => _comicBrightness;
  void changeBrightness(double value) {
    _comicBrightness = value;
    notifyListeners();
    ConfigHelper.setComicBrightness(value);
  }

  double _novelFontSize;
  double get novelFontSize => _novelFontSize;
  void changeNovelFontSize(double value) {
    _novelFontSize = value;
    notifyListeners();
    ConfigHelper.setNovelFontSize(value);
  }

  double _novelLineHeight;
  double get novelLineHeight => _novelLineHeight;
  void changeNovelLineHeight(double value) {
    _novelLineHeight = value;
    notifyListeners();
    ConfigHelper.setNovelLineHeight(value);
  }

  int _novelReadDirection;
  get novelReadDirection => _novelReadDirection;
  void changeNovelReadDirection(int value) {
    _novelReadDirection = value;
    notifyListeners();
    ConfigHelper.setNovelReadDirection(value);
  }

  static List<Color> bgColors = [
    Color.fromRGBO(245, 239, 217, 1),
    Color.fromRGBO(248, 247, 252, 1),
    Color.fromRGBO(192, 237, 198, 1),
    Colors.black
  ];
  static List<Color> fontColors = [
    Colors.black,
    Colors.black,
    Colors.black,
    Color.fromRGBO(200, 200, 200, 1),
  ];

  int _novelReadTheme;
  get novelReadTheme => _novelReadTheme;
  void changeNovelReadTheme(int value) {
    _novelReadTheme = value;
    notifyListeners();
    ConfigHelper.setNovelTheme(value);
  }

  bool _volumeKeyListen;
  get volumekeyListen => _volumeKeyListen;
  void changeVolumekeyListen(bool value) {
    _volumeKeyListen = value;
    notifyListeners();
    ConfigHelper.setVolumeKeyListen(value);
  }
}
