import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/app/utils.dart';

class AppTheme with ChangeNotifier {

  AppTheme(){
    changeDark(ConfigHelper.getOpenDarkMode());
    changeThemeColor(ConfigHelper.getAppTheme());
  }


  static Map<String, Color> themeColors = {
    "胖次蓝": Colors.blue,
    "姨妈红": Colors.red,
    "咸蛋黄": Colors.yellow,
    "早苗绿": Colors.green,
    "少女粉": Colors.pink,
    "基佬紫": Colors.purple,
    "朴素灰": Colors.blueGrey
  };

  void showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('切换主题'),
          children: _createThemeWidget(context),
        );
      },
    );
  }

  List<Widget> _createThemeWidget(BuildContext context) {
    List<Widget> widgets = List<Widget>();
    for (var item in AppTheme.themeColors.keys) {
      widgets.add(RadioListTile(
        groupValue: item,
        value: _themeColorName,
        title: new Text(item,style: TextStyle(color: AppTheme.themeColors[item]),),
        onChanged: (value) {
          changeThemeColor(AppTheme.themeColors.keys.toList().indexOf(item));
          Navigator.of(context).pop();
        },
      ));
    }
    return widgets;
  }

  bool _isDark;
  Color _themeColor;
  String _themeColorName;
  void changeDark(bool value) {
    _isDark = value;

    notifyListeners();
    ConfigHelper.setOpenDarkMode(value);
  }

  get isDark => _isDark;

  void changeThemeColor(int index) {
    _themeColor = AppTheme.themeColors.values.toList()[index];
    _themeColorName = AppTheme.themeColors.keys.toList()[index];
    notifyListeners();
    ConfigHelper.setAppTheme(index);
  }

  get themeColor => _themeColor;
  get themeColorName => _themeColorName;
}
