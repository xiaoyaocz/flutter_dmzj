import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/app/utils.dart';

class AppSetting with ChangeNotifier {
  AppSetting() {
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
  }


  bool _comic_vertical_mode;
  get comic_vertical_mode => _comic_vertical_mode;
  void changeComicVertical(bool value) {
    _comic_vertical_mode = value;

    notifyListeners();
    ConfigHelper.setComicVertical(value);
    if (value) {
      changeReadReverse(false);
    }
  }

  bool _comic_web_api;
  get comic_web_api => _comic_web_api;
  void changeComicWebApi(bool value) {
    _comic_web_api = value;
    notifyListeners();
    ConfigHelper.setComicWebApi(value);
  }


  bool _comic_wakelock;
  get comic_wakelock => _comic_wakelock;
  void changeComicWakelock(bool value) {
    _comic_wakelock = value;
    notifyListeners();
    ConfigHelper.setComicWakelock(value);
  }

  bool _comic_read_reverse;
  get comic_read_reverse => _comic_read_reverse;
  void changeReadReverse(bool value) {
    _comic_read_reverse = value;
    notifyListeners();
    ConfigHelper.setComicReadReverse(value);
    if (value) {
      changeComicVertical(false);
    }
  }

  bool _comic_read_showstate;
  get comic_read_showstate => _comic_read_showstate;
  void changeComicReadShowState(bool value) {
    _comic_read_showstate = value;
    notifyListeners();
    ConfigHelper.setComicReadShowState( value);
  }

  bool _comic_read_showStatusBar;
  get comic_read_showStatusBar => _comic_read_showStatusBar;
  void changeComicReadShowStatusBar(bool value) {
    _comic_read_showStatusBar = value;
    notifyListeners();
    ConfigHelper.setComicShowStatusBar(value);
  }

  bool _comic_system_brightness;
  get comic_system_brightness => _comic_system_brightness;
  void changeComicSystemBrightness(bool value) {
    _comic_system_brightness = value;
    notifyListeners();
    ConfigHelper.setComicSystemBrightness(value);
  }

  double _comic_brightness;
  get comic_brightness => _comic_brightness;
  void changeBrightness(double value) {
    _comic_brightness = value;
    notifyListeners();
    ConfigHelper.setComicBrightness(value);
  }


  double _novel_font_size;
  get novel_font_size => _novel_font_size;
  void changeNovelFontSize(double value) {
    _novel_font_size = value;
    notifyListeners();
    ConfigHelper.setNovelFontSize(value);
  }

  double _novel_line_height;
  get novel_line_height => _novel_line_height;
  void changeNovelLineHeight(double value) {
    _novel_line_height = value;
    notifyListeners();
    ConfigHelper.setNovelLineHeight(value);
  }


  int _novel_read_direction;
  get novel_read_direction => _novel_read_direction;
  void changeNovelReadDirection(int value) {
    _novel_read_direction = value;
    notifyListeners();
    ConfigHelper.setNovelReadDirection(value);
  }

  static List<Color> bgColors=[
    Color.fromRGBO(245,239,217, 1),
    Color.fromRGBO(248,247,252, 1),
    Color.fromRGBO(192,237,198, 1),
     Colors.black
  ];
  static List<Color> fontColors=[
    Colors.black,
    Colors.black,
    Colors.black,
    Color.fromRGBO(200,200,200, 1),
  ];

  int _novel_read_theme;
  get novel_read_theme => _novel_read_theme;
  void changeNovelReadTheme(int value) {
    _novel_read_theme = value;
    notifyListeners();
    ConfigHelper.setNovelTheme(value);
  }


}
